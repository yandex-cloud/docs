# Автоматическое сканирование Docker-образа при загрузке

_Сервис сканирования находится на стадии [Preview](../../overview/concepts/launch-stages.md)._

В этом сценарии описано, как настроить автоматическое [сканирование](../concepts/vulnerability-scanner.md) [Docker-образа](../concepts/docker-image.md) на наличие уязвимостей при загрузке.

## Подготовьте окружение {#prepare}

{% include [cli-install](../../_includes/cli-install.md) %}

1. Создайте [реестр](../concepts/registry.md) для загрузки Docker-образа.

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан реестр.
     1. В списке сервисов выберите **Container Registry**.
     1. Задайте имя реестра.
     1. Нажмите кнопку **Создать реестр**.

   - CLI

     Выполните команду:

     ```bash
     yc container registry create --name my-reg
     ```

     Результат выполнения команды:

     ```bash
     done
     id: crpd50616s9a2t7gr8mi
     folder_id: b1g88tflru0ek1omtsu0
     name: my-reg
     status: ACTIVE
     created_at: "2019-01-09T14:34:06.601Z"
     ```

   - API

     Воспользуйтесь методом [create](../api-ref/Registry/create.md) для ресурса [Registry](../api-ref/Registry/).

   {% endlist %}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с именем `editor` и назначьте ему роль `editor` на каталог, в котором создали реестр.

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать сервисный аккаунт.
     1. Выберите вкладку **Сервисные аккаунты**.
     1. Нажмите кнопку **Создать сервисный аккаунт**.
     1. Введите имя сервисного аккаунта.
     1. Нажмите **Добавить роль** и выберите роль `editor`.
     1. Нажмите кнопку **Создать**.

   - CLI

     1. Создайте сервисный аккаунт:

        ```bash
        yc iam service-account create --name service-acc
        ```

        Результат выполнения команды:

        ```bash
        id: ajelabcde12f33nol1v5
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2021-05-17T14:32:18.900092Z"
        name: service-acc
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор каталога> \
          --role editor \
          --subject serviceAccount:<идентификатор сервисного аккаунта>
        ```

   - API

     Воспользуйтесь методами [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/) и [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/).

   {% endlist %}

1. Аналогичным способом создайте сервисный аккаунт с именем `invoker` и назначьте ему роль `serverless.functions.invoker` на каталог, в котором создали реестр.

## Создайте функцию {#create-function}

Создайте [функцию](../../functions/concepts/function.md) в сервисе {{ sf-full-name }} с именем `scan-on-push`, которая будет запускать сканирование образа:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. Выберите сервис **{{ sf-name }}**
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя `scan-on-push` и описание функции.
  1. Нажмите кнопку **Создать**.
  1. Перейдите в раздел **Редактор** и создайте версию функции:
     1. В блоке **Код функции**:
        * Выберите среду исполнения `Bash`.
        * Выберите способ редактирования функции **Редактор кода**.
        * В окне для редактирования функции нажмите **Создать файл**. В открывшемся окне введите имя файла `handler.sh` и нажмите **Создать**.
        * Скопируйте в файл `handler.sh` следующий код:

          ```bash
          DATA=$(cat | jq -sr '.[0].messages[0].details')
          ID=$(echo $DATA | jq -r '.image_id')
          NAME=$(echo $DATA | jq -r '.repository_name')
          TAG=$(echo $DATA | jq -r '.tag')
          yc container image scan --id ${ID} --async 1>&2
          ```

        * Укажите точку входа — `handler.sh`.
     1. В блоке **Параметры** укажите:
        * Таймаут, с – 60.
        * Память – 128 МБ.
        * Сервисный аккаунт – `editor`.
     1. В верхнем правом углу нажмите **Создать версию**.

- CLI

  1. Создайте функцию с именем `scan-on-push`:

     ```bash
     yc serverless function create --name=scan-on-push
     ```

     Результат выполнения команды:

     ```bash
     id: d4ejb1799eko6re4omb1
     folder_id: aoek49ghmknnpj1ll45e
     created_at: "2021-17-05T14:07:32.134Z"
     name: scan-on-push
     log_group_id: eolm8aoq9vcppsieej6h
     http_invoke_url: https://functions.yandexcloud.net/d4ejb1799eko6re4omb1
     status: ACTIVE
     ```

  1. Создайте файл `handler.sh` и скопируйте в него следующий код:

     ```bash
     DATA=$(cat | jq -sr '.[0].messages[0].details')
     ID=$(echo $DATA | jq -r '.image_id')
     NAME=$(echo $DATA | jq -r '.repository_name')
     TAG=$(echo $DATA | jq -r '.tag')
     yc container image scan --id ${ID} --async 1>&2
     ```

  1. Создайте версию функции `scan-on-push`:

     ```bash
     yc serverless function version create \
       --function-name=<scan-on-push> \
       --runtime bash \
       --entrypoint handler.sh \
       --memory 128m \
       --execution-timeout 60s \
       --source-path handler.sh \
       --service-account-id <идентификатор сервисного аккаунта>
     ```

     Где:
     * `function-name` — имя функции, версию которой вы хотите создать.
     * `runtime` — среда выполнения.
     * `entrypoint` — точка входа, указывается в формате `<имя файла с функцией>.<имя обработчика>`.
     * `memory` — объем RAM.
     * `execution-timeout` — максимальное время выполнения функции до таймаута.
     * `source-path` — файл c кодом функции.
     * `service-account-id` — идентификатор сервисного аккаунта.

     Результат выполнения команды:

     ```bash
     done (1s)
     id: d4egi3pmsd1qcdmsqt5n
     function_id: d4e275oj7jtp2o6kdmim
     created_at: "2021-05-18T20:19:09.605Z"
     runtime: bash
     entrypoint: handler.sh
     resources:
       memory: "134217728"
     execution_timeout: 60s
     service_account_id: aje2stn6id9k43qk7n7l
     image_size: "4096"
     status: ACTIVE
     tags:
     - $latest
     log_group_id: ckg6nb0c7uf19oo8pvjj
     ```

- API

  Воспользуйтесь методами [create](../../functions/functions/api-ref/Function/create) и [createVersion](../../functions/functions/api-ref/Function/createVersion) для ресурса [Function](../../functions/functions/api-ref/Function/).

{% endlist %}

## Создайте триггер {#create-trigger}

Создайте [триггер](../../functions/concepts/trigger/cr-trigger.md), который будет вызывать вашу функцию при создании тега образа.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.
  1. Откройте сервис **{{ sf-name }}**.
  1. Перейдите на вкладку **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В блоке **Базовые параметры**:
     * Введите имя и описание триггера.
     * В поле **Тип** выберите **Container Registry**.
  1. В блоке **Настройки Container Registry**:
     * В поле **Реестр** выберите реестр, в который будете загружать образ.
     * В поле **Типы событий** выберите [событие](../../functions/concepts/trigger/cr-trigger.md#event) **Создание тега Docker-образа**.
  1. В блоке **Настройки функции**:
     * Выберите функцию `scan-on-push`.
     * Укажите [тег версии функции](../../functions/concepts/function.md#tag) `$latest`.
     * Укажите сервисный аккаунт `invoker`, от имени которого будет вызываться функция.
  1. Нажмите кнопку **Создать триггер**.

- CLI

  Чтобы создать триггер, выполните команду:

  ```bash
  yc serverless trigger create container-registry \
    --name <имя триггера> \
    --registry-id <идентификатор реестра> \
    --events 'create-image-tag' \
    --invoke-function-id <идентификатор функции> \
    --invoke-function-service-account-id <идентификатор сервисного аккаунта>
  ```

  Где:
  * `name` — имя триггера.
  * `registry-id` — [идентификатор реестра](../operations/registry/registry-list.md), в который будете загружать образ.
  * `events` — [события](../../functions/concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается.
  * `invoke-function-id` — идентификатор функции.
  * `invoke-function-service-account-id` — идентификатор сервисного аккаунта с правами на вызов функции.

  Результат выполнения команды:

  ```bash
  id: a1spt834cjmk40si80sp
  folder_id: b1g86q4m5vej8lkljme5
  created_at: "2021-05-18T20:42:54.898949653Z"
  name: trig
  rule:
    container_registry:
      event_type:
      - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
      registry_id: crpu20rpdc2foid8p8b0
      invoke_function:
        function_id: d4e275oj7jtp2o6kdmim
        function_tag: $latest
        service_account_id: aje1insoe23e82t9mem2
  status: ACTIVE
  ```

- API

  Воспользуйтесь методом [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/).

{% endlist %}

## Загрузите образ {#download-image}

1. Аутентифицируйтесь в реестре от своего имени:

   {% list tabs %}

   - С помощью Docker Credential helper

     1. Если у вас еще нет профиля для YC CLI, [создайте его](../../cli/quickstart.md#initialize).
     1. Сконфигурируйте Docker для использования `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Результат выполнения команды:

        ```bash
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```

        Настройки сохраняются в профиле текущего пользователя.

        {% note warning %}

        Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo` читайте в [официальной документации Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

        {% endnote %}

     1. Проверьте, что Docker сконфигурирован.

        В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

        ```json
        "cr.yandex": "yc"
        ```

     1. Docker готов к использованию, например, для [загрузки Docker-образов](../operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

   - С помощью OAuth-токена

     1. Если у вас еще нет OAuth-токена, получите его по [ссылке]({{ link-cloud-oauth }}).
     1. Выполните команду:

        ```bash
        echo <oauth-токен> | docker login --username oauth --password-stdin cr.yandex
        ```

        Результат выполнения команды:

        ```bash
        Login Succeeded
        ```

   - С помощью IAM-токена

     {% note info %}

     {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

     {% endnote %}

     1. [Получите](../../iam/operations/iam-token/create.md) IAM-токен.
     1. Выполните команду:

        ```bash
        yc iam create-token | docker login --username iam --password-stdin cr.yandex
        ```

        Результат выполнения команды:

        ```bash
        Login Succeeded
        ```

   {% endlist %}

1. Скачайте Docker-образ с [Docker Hub](https://hub.docker.com/):

   ```bash
   docker pull ubuntu:20.04
   ```

   Результат выполнения команды:

   ```bash
   20.04: Pulling from library/ubuntu
   Digest: sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88eb681d93
   Status: Image is up to date for ubuntu:20.04
   docker.io/library/ubuntu:20.04
   ```

1. Присвойте тег Docker-образу:

   ```bash
   docker tag ubuntu:20.04 cr.yandex/<идентификатор реестра>/ubuntu:20.04
   ```

1. Загрузите Docker-образ в {{ container-registry-name }}:

   ```bash
   docker push cr.yandex/<идентификатор реестра>/ubuntu:20.04
   ```

   Результат выполнения команды:

   ```bash
   The push refers to repository [cr.yandex/crpu20rpdc2foid8p8b0/ubuntu]
   2f140462f3bc: Layer already exists
   63c99163f472: Layer already exists
   ccdbb80308cc: Layer already exists
   20.04: digest: sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673fd5b4f2e9 size: 943
   ```

## Проверьте результат {#check-result}

1. Просмотрите логи функции `scan-on-push` и убедитесь, что она выполнилась.

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ sf-name }}**.
     1. Перейдите в раздел **Функции** и выберите функцию `scan-on-push`.
     1. В открывшемся окне перейдите в раздел **Логи** и укажите период. По умолчанию задан период за 1 час.

   - CLI

     {% include [function-list-note](../../_includes/functions/function-list-note.md) %}

     Посмотрите журнал выполнения функции:

     ```bash
     yc serverless function logs scan-on-push
     ```

     Результат выполнения команды:

     ```bash
     2021-05-18 09:27:43     START RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad Version: b09i2s85a0c1fisjboft
     2021-05-18 09:27:43     END RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad
     2021-05-18 09:27:43     REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa082266fad Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
     2021-05-18 09:29:25     START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef Version: b09i2s85a0c1fisjboft
     2021-05-18 09:29:26     END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef
     2021-05-18 09:29:26     REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f279394ef Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
     ...
     ```

   {% endlist %}

1. Проверьте, что при загрузке Docker-образа запустилось новое сканирование.

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит реестр, содержащий Docker-образ.
     1. Выберите сервис **{{ container-registry-name }}**.
     1. Выберите реестр, в который загрузили Docker-образ.
     1. Откройте репозиторий, в котором находится Docker-образ.
     1. Выберите нужный образ и перейдите на вкладку **История сканирований**.

   - CLI

     Чтобы посмотреть запуски сканирования по Docker-образу, выполните команду:

     ```bash
     yc container image list-scan-results --repository-name=<идентификатор реестра>/<имя Docker-образа>
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | crpu20rpdc2foid8p8b0 | crpqmsqp5mtbh627i7qs | 2021-05-18 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

   {% endlist %}