# Запуск {{ GLR }} в {{ serverless-containers-full-name }}


В этом практическом руководстве вы научитесь запускать [{{ GLR }}]({{ gl.docs }}/runner/) в инфраструктуре {{ yandex-cloud }} с использованием [{{ serverless-containers-full-name }}](../../serverless-containers/).

Чтобы запустить {{ GLR }} в {{ serverless-containers-name }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте {{ GLR }} и получите токен](#create-gitlab-runner).
1. [Создайте секрет](#create-secret).
1. [Создайте сервисные аккаунты](#create-sa).
1. [Создайте API-ключ сервисного аккаунта](#create-api-key).
1. [Создайте контейнер](#create-container).
1. [Настройте вебхук в {{ GL }}](#configure-webhook-gitlab).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Принцип работы {#how-it-works}

{{ GL }} отправляет вебхук в созданный контейнер после создания Job. В контейнере запускается {{ GLR }}, который забирает задачу на исполнение и завершает работу после выполнения. Это позволяет избежать постоянных затрат на [виртуальные машины](../../compute/concepts/vm.md) {{ compute-full-name }}, оплачивая только фактическое время работы раннера.

Вы можете ознакомиться с исходным кодом в [репозитории]({{ link-src-main }}/yandex-cloud-examples/serverless-gitlab-runner) {{ src-full-name }}.

* Сервис принимает HTTP-запросы на порту `PORT` (по умолчанию `8080`) и пути `WEBHOOK_PATH` (по умолчанию `/`).
* При необходимости сервис проверяет секрет в заголовке `X-Gitlab-Token` с помощью значения переменной `GITLAB_SECRET`.
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

* При запуске контейнера сервис дополнительно:

    * Монтирует `cgroup v2` (если требуется).
    * Готовит каталоги `/run` и `/var/lib/docker`.
    * Запускает встроенный `dockerd` и ждет его готовности (`DOCKERD_READY_TIMEOUT`).

В сервисе используются следующие переменные окружения:

Переменная              | По умолчанию         | Обязательно | Описание
----------------------- | -------------------- | ----------- | ---
`RUNNER_TOKEN`          | —                    | Да          | Токен {{ GLR }} (Project/Group/Instance).
`CI_SERVER_URL`         | `https://gitlab.com` | Нет         | Адрес {{ GL }} CI.
`PORT`                  | `8080`               | Нет         | HTTP-порт.
`WEBHOOK_PATH`          | `/`                  | Нет         | Путь эндпоинта вебхука.
`GITLAB_SECRET`         | —                    | Нет         | Секрет для проверки заголовка `X-Gitlab-Token`.
`WAIT_TIMEOUT`          | `10`                 | Нет         | Значение для `gitlab-runner --wait-timeout` (в секундах).
`MAX_BUILDS`            | `1`                  | Нет         | Значение для `gitlab-runner --max-builds`.
`DOCKERD_READY_TIMEOUT` | `5s`                 | Нет         | Время ожидания готовности `dockerd` (`time.Duration`).

Ограничения:

* В руководстве используется только Docker executor. Вы можете самостоятельно собрать [контейнер](../../serverless-containers/concepts/container.md) с необходимыми зависимостями и использовать в нем Shell executor.
* Каждый запрос вебхука запускает отдельный, одноразовый (эфемерный) раннер. Состояние между такими раннерами не сохраняется.
* Задания должны иметь теги, соответствующие тегам раннера. Если у `job` в `.gitlab-ci.yml` не указаны подходящие теги, раннер не возьмет задание. Используйте опцию `Run untagged jobs` при создании раннера, чтобы он брал все задачи.

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик (см. [тарифы {{ serverless-containers-name }}](../../serverless-containers/pricing.md)).
* Плата за хранение секретов (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).


## Создайте {{ GLR }} и получите токен {#create-gitlab-runner}

1. В [{{ GL }}](https://gitlab.com) создайте и откройте проект.
1. На панели слева выберите ![image](../../_assets/console-icons/gear.svg) **Settings** → **CI/CD**.
1. Раскройте раздел **Runners** и нажмите **Create project runner**.
1. В поле **Tags** укажите теги задач, которые должен обрабатывать этот раннер.
1. Нажмите **Create runner**.
1. В разделе **Step 1** скопируйте аутентификационный токен раннера (runner authentication token) и сохраните его.


## Создайте секрет {#create-secret}

Создайте секрет [{{ lockbox-full-name }}](../../lockbox/) с аутентификационным токеном раннера.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя [секрета](../../lockbox/concepts/secret.md) `gitlab-runner-token`.
  1. В блоке **{{ ui-key.yacloud.lockbox.forms.title_secret-data-section }}**:

      1. Выберите тип секрета `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
      1. Добавьте значение токена {{ GLR }}:

          * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** укажите `gitlab_runner_token`.
          * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** укажите аутентификационный токен раннера, который вы [получили ранее](#create-gitlab-runner).

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install.md](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

* `gitlab-runner-lockbox-payload-viewer` с [ролью](../../lockbox/security/index.md#lockbox-payloadViewer) `{{ roles-lockbox-payloadviewer }}` для доступа к секрету {{ lockbox-short-name }}.
* `gitlab-runner-caller` с [ролью](../../serverless-containers/security/index.md#serverless-containers-containerinvoker) `{{ roles-serverless-containers-invoker }}` на каталог. Этот сервисный аккаунт будет выполнять две функции:

    * От его имени {{ GL }} будет вызывать контейнер. API-ключ [будет указан](#configure-webhook-gitlab) в заголовке `Authorization`.
    * Его идентификатор будет использоваться {{ GL }} для постановки задачи раннеру на выполнение, чтобы вызов контейнера выполнялся асинхронно. Идентификатор будет передан при [создании](#create-container) ревизии контейнера.

    При необходимости вы можете разделить эти функции между двумя разными сервисными аккаунтами.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Укажите имя сервисного аккаунта `gitlab-runner-caller`.
  1. Нажмите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `{{ roles-serverless-containers-invoker }}`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Аналогичным способом создайте сервисный аккаунт `gitlab-runner-lockbox-payload-viewer` без назначения роли.
  1. Назначьте сервисному аккаунту `gitlab-runner-lockbox-payload-viewer` роль на секрет:

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
      1. Выберите секрет `gitlab-runner-token`.
      1. На панели слева выберите ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Нажмите **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. Найдите и выберите сервисный аккаунт `gitlab-runner-lockbox-payload-viewer`.
      1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и выберите роль `{{ roles-lockbox-payloadviewer }}`.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

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
        --role {{ roles-lockbox-payloadviewer }} \
        --service-account-name gitlab-runner-lockbox-payload-viewer

      yc resource-manager folder add-access-binding \
        --id <идентификатор_каталога> \
        --role {{ roles-serverless-containers-invoker }} \
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
            role_id: {{ roles-serverless-containers-invoker }}
            subject:
              id: ajetqjm00ji8********
              type: serviceAccount
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `{{ roles-lockbox-payloadviewer }}` на секрет, воспользуйтесь методом REST API [updateAccessBindings](../../lockbox/api-ref/Secret/updateAccessBindings.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/UpdateAccessBindings](../../lockbox/api-ref/grpc/Secret/updateAccessBindings.md).

  Чтобы назначить сервисному аккаунту роль `{{ roles-serverless-containers-invoker }}` на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

{% endlist %}


## Создайте API-ключ сервисного аккаунта {#create-api-key}

Создайте [API-ключ](../../iam/concepts/authorization/api-key.md) для сервисного аккаунта, который будет использоваться при вызове контейнера. API-ключ понадобится для настройки вебхука в {{ GL }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Выберите созданный ранее сервисный аккаунт `gitlab-runner-caller`.
  1. На панели сверху нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** выберите [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.serverless.containers.invoke`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.

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

Создайте [контейнер](../../serverless-containers/concepts/container.md) и [ревизию контейнера](../../serverless-containers/concepts/container.md#revision) с Docker-образом для запуска {{ GLR }}.

{% note info %}

В примере эфемерный диск монтируется по пути `/mnt` и расширяет доступное пространство корневой файловой системы на время выполнения контейнера. Docker хранит данные в `/var/lib/docker` — благодаря расширению корневой файловой системы это место становится доступным.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Нажмите **{{ ui-key.yacloud.serverless-containers.button_create-container }}**.
  1. Укажите имя контейнера `serverless-gitlab-runner`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.

      1. В блоке **{{ ui-key.yacloud.serverless-containers.section_resources }}** укажите нужный объем RAM, например `1024 {{ ui-key.yacloud.common.units.label_megabyte }}`.
      1. В блоке **{{ ui-key.yacloud.serverless-containers.section_image }}**:

          1. Нажмите **{{ ui-key.yacloud.component.image-field.button_custom-image }}** и в поле **{{ ui-key.yacloud.serverless-containers.label_image-url }}** укажите `{{ registry }}/yc/serverless/gitlab-runner`.
          1. В поле **{{ ui-key.yacloud.serverless-containers.label_environment }}** добавьте переменные:

              * `CI_SERVER_URL` — `https://gitlab.com`.
              * `WEBHOOK_PATH` — `/webhook`.

          1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** укажите:

              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-env-key }}** — `RUNNER_TOKEN`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-id }}** — `gitlab-runner-token`.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-version-id }}** — идентификатор текущей версии.
              * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret-key }}** — `gitlab_runner_token`.

        1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}**:

            1. В поле **{{ ui-key.yacloud.serverless-containers.label_service-account }}** укажите `gitlab-runner-lockbox-payload-viewer`.
            1. В поле **{{ ui-key.yacloud.serverless-containers.label_timeout }}** укажите нужное значение, например `600 {{ ui-key.yacloud.common.units.label_time-sec_many }}`.

        1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.title_ephemeral-storage }}**:

            1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-ephemeral-storage }}**.
            1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-path }}** укажите `/mnt`.
            1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_ephemeral-storage-size }}** укажите нужное значение, например `10 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

        1. В блоке **{{ ui-key.yacloud.serverless-containers.section_async }}**:

            1. Нажмите **{{ ui-key.yacloud.serverless-containers.label_async-enable }}**.
            1. В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** выберите `gitlab-runner-caller`.

  1. Нажмите **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

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
      url: https://bba83i1mrb5s********.{{ serverless-containers-host }}/
      status: ACTIVE
      ```

  1. Создайте ревизию контейнера:

      ```bash
      yc serverless container revision deploy \
        --container-name serverless-gitlab-runner \
        --runtime=http \
        --cores <количество_ядер> \
        --memory <объем_RAM> \
        --image {{ registry }}/yc/serverless/gitlab-runner \
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

          * `CI_SERVER_URL` — адрес {{ GL }} CI.
          * `WEBHOOK_PATH` — путь эндпоинта вебхука.

      * `--secret` — секрет {{ lockbox-short-name }}.

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


## Настройте вебхук в {{ GL }} {#configure-webhook-gitlab}

1. В [{{ GL }}](https://gitlab.com) откройте проект.
1. На панели слева выберите ![image](../../_assets/console-icons/gear.svg) **Settings** → **Webhooks**.
1. Нажмите **Add new webhook**.
1. В поле **URL** укажите публичный эндпоинт {{ serverless-containers-name }}: `https://<идентификатор_контейнера>.{{ serverless-containers-host }}/webhook`.
1. В разделе **Custom headers** нажмите **Add custom header** и добавьте заголовки:

    Header name | Header value | Описание
    --- | --- | ---
    `Authorization` | `Api-Key <API-ключ>` | API-ключ сервисного аккаунта `gitlab-runner-caller`. Обязательно при закрытом доступе к контейнеру, иначе запрос будет отклонен. Подробнее см. [Аутентифицироваться при вызове приватного контейнера через HTTPS](../../serverless-containers/operations/auth.md).
    `X-Ycf-Container-Integration-Type` | `async` | Асинхронный вызов контейнера. В ответ на вызов платформа сразу вернет `202`.

1. В разделе **Trigger** убедитесь, что опция `Job events` включена.
1. Нажмите **Add webhook**.

После этого вы можете пользоваться Serverless {{ GLR }}s.

{% note tip %}

{{ GLR }} можно дополнительно конфигурировать через переменные окружения и флаги.

Посмотрите доступные опции с помощью команды `gitlab-runner run-single -h`, а также раздел документации [{{ GLR }} commands]({{ gl.docs }}/runner/commands/).

{% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../serverless-containers/operations/delete.md) контейнер.
1. [Удалите](../../lockbox/operations/secret-delete.md) секрет.
