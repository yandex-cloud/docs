# Запуск GitLab Runner в Yandex Serverless Containers


В этом практическом руководстве вы научитесь запускать [GitLab Runner](https://docs.gitlab.com/runner/) в инфраструктуре Yandex Cloud с использованием [Yandex Serverless Containers](../../serverless-containers/index.md).

Чтобы запустить GitLab Runner в Serverless Containers:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте GitLab Runner и получите токен](#create-gitlab-runner).
1. [Создайте секрет](#create-secret).
1. [Создайте сервисные аккаунты](#create-sa).
1. [Создайте API-ключ сервисного аккаунта](#create-api-key).
1. [Создайте контейнер](#create-container).
1. [Настройте вебхук в GitLab](#configure-webhook-gitlab).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Принцип работы {#how-it-works}

![image](../../_assets/tutorials/serverless-gitlab-runner.svg)

После создания задания (Job) GitLab отправляет вебхук-запрос в созданный контейнер Serverless Containers. Контейнер запускается на базе публичного образа из [Yandex Container Registry](../../container-registry/index.md) и получает необходимые секреты из [Yandex Lockbox](../../lockbox/index.md). В контейнере разворачивается GitLab Runner, который подключается к GitLab, забирает задание на исполнение, запускает выполнение в изолированном Docker-контейнере и по итогу завершает свою работу. Такой подход позволяет отказаться от поддержки постоянно работающих [виртуальных машин](../../compute/concepts/vm.md), оплачивая лишь фактическое время выполнения каждого задания.

Вы можете ознакомиться с исходным кодом в [репозитории](https://sourcecraft.dev/yandex-cloud-examples/serverless-gitlab-runner) SourceCraft.

**Ключевые этапы работы**

* Сервис принимает HTTP-запросы на порту `PORT` (по умолчанию `8080`) и пути `WEBHOOK_PATH` (по умолчанию `/`).
* При необходимости сервис проверяет секрет в заголовке `X-Gitlab-Token` через переменную окружения `GITLAB_SECRET`.
* Обрабатываются только запросы с заголовком `X-Gitlab-Event: Job Hook`.
* Из тела запроса извлекается поле `build_status`. Если его значение `pending`, сервис запускает команду:

    ```bash
    gitlab-runner run-single \
      --url CI_SERVER_URL \
      --token RUNNER_TOKEN \
      --wait-timeout WAIT_TIMEOUT \
      --executor docker \
      --docker-privileged \
      --max-builds MAX_BUILDS
    ```

* При запуске контейнера дополнительно:

    * При необходимости монтируется `cgroup v2`.
    * Подготавливаются каталоги `/run` и `/var/lib/docker`.
    * Запускается встроенный `dockerd`, и сервис ждет его готовности (`DOCKERD_READY_TIMEOUT`).

**Принцип работы внутри контейнера**

Внутри контейнера запускается HTTP-сервер и процесс GitLab Runner, который берет новое CI/CD-задание из GitLab и исполняет его в отдельных изолированных docker-контейнерах.

**Переменные окружения**

В сервисе используются следующие переменные окружения:

Переменная              | По умолчанию         | Обязательно | Описание
----------------------- | -------------------- | ----------- | ---
`RUNNER_TOKEN`          | —                    | Да          | Токен GitLab Runner (Project/Group/Instance).
`CI_SERVER_URL`         | `https://gitlab.com` | Нет         | Адрес GitLab CI.
`PORT`                  | `8080`               | Нет         | HTTP-порт.
`WEBHOOK_PATH`          | `/`                  | Нет         | Путь эндпоинта вебхука.
`GITLAB_SECRET`         | —                    | Нет         | Секрет для проверки заголовка `X-Gitlab-Token`.
`WAIT_TIMEOUT`          | `10`                 | Нет         | Значение для `gitlab-runner --wait-timeout` (в секундах).
`MAX_BUILDS`            | `1`                  | Нет         | Значение для `gitlab-runner --max-builds`.
`DOCKERD_READY_TIMEOUT` | `5s`                 | Нет         | Время ожидания готовности `dockerd` (`time.Duration`).

**Ограничения**

* В руководстве используется только Docker executor. Вы можете самостоятельно собрать [контейнер](../../serverless-containers/concepts/container.md) с необходимыми зависимостями и использовать в нем Shell executor.
* Каждый вебхук-запрос запускает новый, одноразовый (эфемерный) раннер. Состояние между раннерами не сохраняется.
* Задания должны иметь теги, соответствующие тегам раннера. Если у `job` в `.gitlab-ci.yml` не указаны подходящие теги, раннер не возьмет задание. Используйте опцию `Run untagged jobs` при создании раннера, чтобы он брал все задачи.


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик ([тарифы Serverless Containers](../../serverless-containers/pricing.md)).
* Плата за хранение секретов (см. [тарифы Yandex Lockbox](../../lockbox/pricing.md)).


## Создайте GitLab Runner и получите токен {#create-gitlab-runner}

1. В [GitLab](https://gitlab.com) создайте и откройте проект.
1. На панели слева выберите ![image](../../_assets/console-icons/gear.svg) **Settings** → **CI/CD**.
1. Раскройте раздел **Runners** и нажмите **Create project runner**.
1. В поле **Tags** укажите теги задач, которые должен обрабатывать этот раннер.
1. Нажмите **Create runner**.
1. В разделе **Step 1** скопируйте аутентификационный токен раннера (runner authentication token) и сохраните его.


## Создайте секрет {#create-secret}

Создайте секрет [Yandex Lockbox](../../lockbox/index.md) с аутентификационным токеном раннера.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
  1. Перейдите в сервис **Lockbox**.
  1. Нажмите **Создать секрет**.
  1. В поле **Имя** укажите имя [секрета](../../lockbox/concepts/secret.md) `gitlab-runner-token`.
  1. В блоке **Данные секрета**:

      1. Выберите тип секрета `Пользовательский`.
      1. Добавьте значение токена GitLab Runner:

          * В поле **Ключ** укажите `gitlab_runner_token`.
          * В поле **Значение** укажите аутентификационный токен раннера, который вы [получили ранее](#create-gitlab-runner).

  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы создать [секрет](../../lockbox/concepts/secret.md), выполните команду:

  ```bash
  yc lockbox secret create \
    --name gitlab-runner-token \
    --payload '[{"key": "gitlab_runner_token", "text_value": "<токен_раннера>"}]'
  ```

  Где:

  * `--name` — имя секрета.
  * `--payload` — содержимое секрета в виде массива YAML или JSON.
  * `<токен_раннера>` — аутентификационный токен раннера, который вы [получили ранее](#create-gitlab-runner).

  Результат:

  ```text
  id: e6qdur7h55vd********
  folder_id: b1g681qpemb4********
  created_at: "2025-09-16T06:04:12.604Z"
  name: gitlab-runner-token
  status: ACTIVE
  current_version:
    id: e6qbaf927irb********
    secret_id: e6qdur7h55vd********
    created_at: "2025-09-16T06:04:12.604Z"
    status: ACTIVE
    payload_entry_keys:
      - gitlab_runner_token
  ```

- API {#api}

  Чтобы создать [секрет](../../lockbox/concepts/secret.md), воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}


## Создайте сервисные аккаунты {#create-sa}

Создайте два сервисных аккаунта:

* `gitlab-runner-lockbox-payload-viewer` с [ролью](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` для доступа к секрету Lockbox.
* `gitlab-runner-caller` с [ролью](../../serverless-containers/security/index.md#serverless-containers-containerinvoker) `serverless-containers.containerInvoker` на каталог. Этот сервисный аккаунт будет выполнять две функции:

    * От его имени GitLab будет вызывать контейнер. API-ключ [будет указан](#configure-webhook-gitlab) в заголовке `Authorization`.
    * Его идентификатор будет использоваться GitLab для постановки задачи раннеру на выполнение, чтобы вызов контейнера выполнялся асинхронно. Идентификатор будет передан при [создании](#create-container) ревизии контейнера.

    При необходимости вы можете разделить эти функции между двумя разными сервисными аккаунтами.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Укажите имя сервисного аккаунта `gitlab-runner-caller`.
  1. Нажмите ![plus](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `serverless-containers.containerInvoker`.
  1. Нажмите **Создать**.
  1. Аналогичным способом создайте сервисный аккаунт `gitlab-runner-lockbox-payload-viewer` без назначения роли.
  1. Назначьте сервисному аккаунту `gitlab-runner-lockbox-payload-viewer` роль на секрет:

      1. Откройте [консоль управления](https://console.yandex.cloud).
      1. Перейдите в сервис **Lockbox**.
      1. Выберите секрет `gitlab-runner-token`.
      1. На панели слева выберите ![image](../../_assets/console-icons/persons.svg) **Права доступа**.
      1. Нажмите **Назначить роли**.
      1. Найдите и выберите сервисный аккаунт `gitlab-runner-lockbox-payload-viewer`.
      1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `lockbox.payloadViewer`.
      1. Нажмите **Сохранить**.

- Yandex Cloud CLI {#cli}

  1. Создайте сервисные аккаунты:

      ```bash
      yc iam service-account create --name gitlab-runner-lockbox-payload-viewer
      yc iam service-account create --name gitlab-runner-caller
      ```

      Результат:

      ```text
      id: ajenprbpf1s3********
      folder_id: b1g681qpemb4********
      created_at: "2025-09-16T06:06:13.092790480Z"
      name: gitlab-runner-lockbox-payload-viewer

      id: ajetqjm00ji8********
      folder_id: b1g681qpemb4********
      created_at: "2025-09-16T06:06:15.661704808Z"
      name: gitlab-runner-caller
      ```

  1. Назначьте роли сервисным аккаунтам:

      ```bash
      yc lockbox secret add-access-binding \
        --name gitlab-runner-token \
        --role lockbox.payloadViewer \
        --service-account-name gitlab-runner-lockbox-payload-viewer

      yc resource-manager folder add-access-binding \
        --id <идентификатор_каталога> \
        --role serverless-containers.containerInvoker \
        --service-account-name gitlab-runner-caller
      ```

      Где:

      * `--name` — имя секрета.
      * `--id` — идентификатор каталога.
      * `--role` — назначаемая роль.
      * `--service-account-name` — имя сервисного аккаунта.

      Результат:

      ```text
      ...1s...done (4s)
      ...1s...done (2s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: serverless-containers.containerInvoker
            subject:
              id: ajetqjm00ji8********
              type: serviceAccount
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `lockbox.payloadViewer` на секрет, воспользуйтесь методом REST API [updateAccessBindings](../../lockbox/api-ref/Secret/updateAccessBindings.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/UpdateAccessBindings](../../lockbox/api-ref/grpc/Secret/updateAccessBindings.md).

  Чтобы назначить сервисному аккаунту роль `serverless-containers.containerInvoker` на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

{% endlist %}


## Создайте API-ключ сервисного аккаунта {#create-api-key}

Создайте [API-ключ](../../iam/concepts/authorization/api-key.md) для сервисного аккаунта, который будет использоваться при вызове контейнера. API-ключ понадобится для настройки вебхука в GitLab.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Identity and Access Management**.
  1. Выберите созданный ранее сервисный аккаунт `gitlab-runner-caller`.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите пункт **Создать API-ключ**.
  1. В поле **Область действия** выберите [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.serverless.containers.invoke`.
  1. Нажмите **Создать**.

- CLI {#cli}

  1. Создайте API-ключ для сервисного аккаунта `gitlab-runner-caller`:

      ```bash
      yc iam api-key create \
        --service-account-name gitlab-runner-caller \
        --scopes yc.serverless.containers.invoke
      ```

      Где:

      * `--service-account-name` — имя сервисного аккаунта.
      * `--scopes` — [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) ключа.

      Результат:

      ```yaml
      api_key:
        id: aje3oa26mt52********
        service_account_id: ajetqjm00ji8********
        created_at: "2025-09-16T06:08:47.018697312Z"
        scope: yc.serverless.containers.invoke
        scopes:
          - yc.serverless.containers.invoke
      secret: AQVNw8KEa3SiA8vlpXEhfl9k-uYT22Ws********
      ```

- API {#api}

  Чтобы создать API-ключ, воспользуйтесь методом REST API [create](../../iam/api-ref/ApiKey/create.md) для ресурса [ApiKey](../../iam/api-ref/ApiKey/index.md) или вызовом gRPC API [ApiKeyService/Create](../../iam/api-ref/grpc/ApiKey/create.md).

{% endlist %}

Сохраните полученный секретный ключ — получить его повторно невозможно.


## Создайте контейнер {#create-container}

Создайте [контейнер](../../serverless-containers/concepts/container.md) и [ревизию контейнера](../../serverless-containers/concepts/container.md#revision) с Docker-образом для запуска GitLab Runner.

{% note info %}

В примере эфемерный диск монтируется по пути `/mnt` и расширяет доступное пространство корневой файловой системы на время выполнения контейнера. Docker хранит данные в `/var/lib/docker` — благодаря расширению корневой файловой системы это место становится доступным.

{% endnote %}

{% note info %}

Если указать сеть в настройках контейнера, в каждой зоне доступности будет создана служебная подсеть из диапазона `198.19.0.0/16`. Такие подсети не отображаются в интерфейсе Yandex Cloud. Учитывайте это при [настройке](../../managed-gitlab/operations/configure-security-group.md) правил групп безопасности. Подробнее читайте в разделе [Сетевое взаимодействие](../../serverless-containers/concepts/networking.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Serverless Containers**.
  1. Нажмите **Создать контейнер**.
  1. Укажите имя контейнера `serverless-gitlab-runner`.
  1. Нажмите **Создать**.
  1. Перейдите на вкладку **Редактор**.

      1. В блоке **Ресурсы** укажите нужный объем RAM, например `1024 МБ`.
      1. В блоке **Параметры образа**:

          1. Нажмите **Укажите ссылку** и в поле **URL образа** укажите `cr.yandex/yc/serverless/gitlab-runner`.
          1. В поле **Переменные окружения** добавьте переменные:

              * `CI_SERVER_URL` — `https://gitlab.com`.
              * `WEBHOOK_PATH` — `/webhook`.

          1. В поле **Секреты Lockbox** укажите:

              * **Переменная окружения** — `RUNNER_TOKEN`.
              * **Идентификатор секрета** — `gitlab-runner-token`.
              * **Идентификатор версии** — идентификатор текущей версии.
              * **Ключ секрета** — `gitlab_runner_token`.

        1. В блоке **Настройки**:

            1. В поле **Сервисный аккаунт** укажите `gitlab-runner-lockbox-payload-viewer`.
            1. (Опционально) В поле **Сеть** укажите или [создайте](../../vpc/operations/network-create.md) сеть, в которой будет размещаться контейнер.
            1. В поле **Таймаут** укажите нужное значение, например `600 секунд`.

        1. В блоке **Смонтированный эфемерный диск**:

            1. Нажмите **Добавить эфемерный диск**.
            1. В поле **Путь монтирования** укажите `/mnt`.
            1. В поле **Размер диска** укажите нужное значение, например `10 ГБ`.

        1. В блоке **Асинхронный вызов**:

            1. Нажмите **Включить**.
            1. В поле **Сервисный аккаунт** выберите `gitlab-runner-caller`.

  1. Нажмите **Создать ревизию**.

- CLI {#cli}

  1. Создайте контейнер:

      ```bash
      yc serverless container create --name serverless-gitlab-runner
      ```

      Результат:

      ```text
      id: bba83i1mrb5s********
      folder_id: b1g681qpemb4********
      created_at: "2025-09-16T06:10:03.153Z"
      name: serverless-gitlab-runner
      url: https://bba83i1mrb5s********.containers.yandexcloud.net/
      status: ACTIVE
      ```

  1. Создайте ревизию контейнера:

      ```bash
      yc serverless container revision deploy \
        --container-name serverless-gitlab-runner \
        --runtime=http \
        --cores <количество_ядер> \
        --memory <объем_RAM> \
        --image cr.yandex/yc/serverless/gitlab-runner \
        --environment CI_SERVER_URL=https://gitlab.com \
        --environment WEBHOOK_PATH=/webhook \
        --secret id=<идентификатор_секрета>,version-id=<идентификатор_версии_секрета>,key=gitlab_runner_token,environment-variable=RUNNER_TOKEN \
        --service-account-id <идентификатор_сервисного_аккаунта_1> \
        --execution-timeout <таймаут> \
        --mount type=ephemeral-disk,mount-point=/mnt,size=<размер_диска>\
        --async-service-account-id <идентификатор_сервисного_аккаунта_2>
      ```

      Где:

      * `--container-name` — имя контейнера.
      * `--runtime` — режим работы.
      * `--cores` — количество ядер, которые доступны контейнеру, например `1`.
      * `--memory` — требуемая память, например `1GB`.
      * `--image` — URL Docker-образа `gitlab-runner`.
      * `--environment` — переменные окружения:

          * `CI_SERVER_URL` — адрес GitLab CI.
          * `WEBHOOK_PATH` — путь эндпоинта вебхука.

      * `--secret` — секрет Lockbox.

      * `--service-account-id` — идентификатор сервисного аккаунта `gitlab-runner-lockbox-payload-viewer`.
      * `--execution-timeout` — таймаут, например `600s`.
      * `--mount` — параметры монтирования эфемерного диска:

          * `type=ephemeral-disk` — тип монтируемой файловой системы.
          * `mount-point` — имя точки монтирования. Директория, к которой смонтируется диск, будет доступна по пути `/mnt`.
          * `size` — размер эфемерного диска в ГБ, например `10GB`.

      * `--async-service-account-id` — идентификатор сервисного аккаунта `gitlab-runner-caller`.

      Результат:

      ```text
      id: bba27hejd69a********
      container_id: bba83i1mrb5s********
      created_at: "2025-09-18T09:38:14.528Z"
      image:
        image_url: cr.yandex/yc/serverless/gitlab-runner
        image_digest: sha256:ac62...
        environment:
          CI_SERVER_URL: https://gitlab.com
          WEBHOOK_PATH: C:/Program Files/Git/webhook
      resources:
        memory: "1073741824"
        cores: "1"
        core_fraction: "100"
      execution_timeout: 600s
      concurrency: "1"
      service_account_id: ajenprbpf1s3********
      status: ACTIVE
      secrets:
        - id: e6qdur7h55vd********
          version_id: e6qbaf927irb********
          key: gitlab_runner_token
          environment_variable: RUNNER_TOKEN
      log_options:
        folder_id: b1g681qpemb4********
      mounts:
        - mount_point_path: /mnt
          ephemeral_disk_spec:
            size: "10737418240"
            block_size: "4096"
      runtime:
        http: {}
      async_invocation_config:
        service_account_id: ajetqjm00ji8********
      ```

      {% note tip %}

      В случае ошибки `mounts[0].mount_point_path: Field does not match the pattern /[-_0-9a-zA-Z/]*/` экранируйте имя точки монтирования:

      ```bash
      mount-point=//mnt
      ```

      {% endnote %}

- API {#api}

  Чтобы создать контейнер, воспользуйтесь методом REST API [create](../../serverless-containers/containers/api-ref/Container/create.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Create](../../serverless-containers/containers/api-ref/grpc/Container/create.md).

  Чтобы создать ревизию контейнера, воспользуйтесь методом REST API [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}


## Настройте вебхук в GitLab {#configure-webhook-gitlab}

1. В [GitLab](https://gitlab.com) откройте проект.
1. На панели слева выберите ![image](../../_assets/console-icons/gear.svg) **Settings** → **Webhooks**.
1. Нажмите **Add new webhook**.
1. В поле **URL** укажите публичный эндпоинт Serverless Containers: `https://<идентификатор_контейнера>.containers.yandexcloud.net/webhook`.
1. В разделе **Custom headers** нажмите **Add custom header** и добавьте заголовки:

    Header name | Header value | Описание
    --- | --- | ---
    `Authorization` | `Api-Key <API-ключ>` | API-ключ сервисного аккаунта `gitlab-runner-caller`. Обязательно при закрытом доступе к контейнеру, иначе запрос будет отклонен. Подробнее см. [Аутентифицироваться при вызове приватного контейнера через HTTPS](../../serverless-containers/operations/auth.md).
    `X-Ycf-Container-Integration-Type` | `async` | Асинхронный вызов контейнера. В ответ на вызов платформа сразу вернет `202`.

1. В разделе **Trigger** убедитесь, что опция `Job events` включена.
1. Нажмите **Add webhook**.

После этого вы можете пользоваться Serverless GitLab Runners.

{% note tip %}

GitLab Runner можно дополнительно конфигурировать через переменные окружения и флаги.

Посмотрите доступные опции с помощью команды `gitlab-runner run-single -h`, а также раздел документации [GitLab Runner commands](https://docs.gitlab.com/runner/commands/).

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../serverless-containers/operations/delete.md) контейнер.
1. [Удалите](../../lockbox/operations/secret-delete.md) секрет.