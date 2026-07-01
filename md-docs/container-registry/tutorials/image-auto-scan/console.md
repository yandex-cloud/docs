# Автоматическое сканирование Docker-образа при загрузке с помощью консоли управления, CLI и API


{% note info %}

Автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](../../concepts/docker-image.md) на наличие уязвимостей при загрузке в [Yandex Container Registry](../../index.md) можно включить в [настройках сканера уязвимостей](../../operations/scanning-docker-image.md#automatically) без создания [функций](../../../functions/concepts/function.md) и [триггеров](../../../functions/concepts/trigger/index.md) [Yandex Cloud Functions](../../../functions/index.md).

{% endnote %}

Чтобы настроить автоматическое [сканирование](../../concepts/vulnerability-scanner.md) [Docker-образов](index.md) на наличие уязвимостей при загрузке в [Yandex Container Registry](../../index.md), выполните следующие шаги:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте функцию](#create-function).
1. [Создайте триггер](#create-trigger).
1. [Загрузите Docker-образ](#download-image).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* плата за хранение Docker-образа в [реестре](../../concepts/registry.md), сканер уязвимостей и исходящий трафик ([тарифы Yandex Container Registry](../../pricing.md));
* плата за вызовы [функций](../../../functions/concepts/function.md) ([тарифы Yandex Cloud Functions](../../../functions/pricing.md)).

## Подготовьте окружение {#prepare}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

1. [Установите и настройте](../../operations/configure-docker.md) Docker.
1. Создайте реестр для загрузки Docker-образа.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан реестр.
     1. В списке сервисов выберите **Container Registry**.
     1. Нажмите кнопку **Создать реестр**.
     1. Задайте имя реестра.
     1. Нажмите кнопку **Создать реестр**.

   - CLI {#cli}

     Выполните команду:

     ```bash
     yc container registry create --name my-reg
     ```

     Результат:

     ```text
     done
     id: crpd50616s9a********
     folder_id: b1g88tflru0e********
     name: my-reg
     status: ACTIVE
     created_at: "2019-01-09T14:34:06.601Z"
     ```

   - API {#api}

     Воспользуйтесь методом [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md).

   {% endlist %}

1. Создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с именем `scanner` и назначьте ему [роль](../../../iam/concepts/access-control/roles.md) `container-registry.images.scanner` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создали реестр.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
     1. Перейдите в сервис **Identity and Access Management**.
     1. Нажмите **Создать сервисный аккаунт**.
     1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
     1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите `container-registry.images.scanner`.
     1. Нажмите **Создать**.

   - CLI {#cli}

     1. Создайте сервисный аккаунт:

        ```bash
        yc iam service-account create --name service-acc
        ```

        Результат:

        ```text
        id: ajelabcde12f********
        folder_id: b0g12ga82bcv********
        created_at: "2021-05-17T14:32:18.900092Z"
        name: service-acc
        ```

     1. Назначьте роль сервисному аккаунту:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role container-registry.images.scanner \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

   - API {#api}

     Воспользуйтесь методами [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) и [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md).

   {% endlist %}

1. Аналогичным способом создайте сервисный аккаунт с именем `invoker` и назначьте ему роль `functions.functionInvoker` на каталог, в котором создали реестр.

## Создайте функцию {#create-function}

Создайте функцию в сервисе Cloud Functions с именем `scan-on-push`, которая будет запускать сканирование Docker-образа:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать функцию.
  1. Выберите сервис **Cloud Functions**.
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя `scan-on-push` и описание функции.
  1. Нажмите кнопку **Создать**.
  1. Перейдите в раздел **Редактор** и создайте версию функции:
     1. В блоке **Код функции**:
        * Выберите среду исполнения `Bash` и нажмите **Продолжить**.
        * Выберите способ редактирования функции `Редактор кода`.
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
        * **Таймаут** – `60`.
        * **Память** – `128 МБ`.
        * **Сервисный аккаунт** – `scanner`.
     1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  1. Создайте функцию с именем `scan-on-push`:

     ```bash
     yc serverless function create --name=scan-on-push
     ```

     Результат:

     ```text
     id: d4ejb1799eko********
     folder_id: aoek49ghmknn********
     created_at: "2021-17-05T14:07:32.134Z"
     name: scan-on-push
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://functions.yandexcloud.net/d4ejb1799eko********
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
       --function-name=scan-on-push \
       --runtime bash \
       --entrypoint handler.sh \
       --memory 128m \
       --execution-timeout 60s \
       --source-path handler.sh \
       --service-account-id <идентификатор_сервисного_аккаунта>
     ```

     Где:
     * `--function-name` — имя функции, версию которой вы хотите создать.
     * `--runtime` — среда выполнения.
     * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
     * `--memory` — объем RAM.
     * `--execution-timeout` — максимальное время выполнения функции до таймаута.
     * `--source-path` — файл с кодом функции.
     * `--service-account-id` — идентификатор сервисного аккаунта.

     Результат:

     ```text
     done (1s)
     id: d4egi3pmsd1q********
     function_id: d4e275oj7jtp********
     ...
     tags:
     - $latest
     log_group_id: ckg6nb0c7uf1********
     ```

- API {#api}

  Воспользуйтесь методами [create](../../../functions/functions/api-ref/Function/create.md) и [createVersion](../../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../../functions/functions/api-ref/Function/index.md).

{% endlist %}

## Создайте триггер {#create-trigger}

Создайте триггер, который будет вызывать вашу функцию при создании [тега](../../concepts/docker-image.md#version) Docker-образа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать триггер.
  1. Выберите сервис **Cloud Functions**.
  1. Перейдите на вкладку **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В блоке **Базовые параметры**:
     * Введите имя и описание триггера.
     * В поле **Тип** выберите `Container Registry`.
  1. В блоке **Настройки Container Registry**:
     * В поле **Реестр** выберите реестр, в который будете загружать Docker-образ.
     * В поле **Типы событий** выберите [событие](../../../functions/concepts/trigger/cr-trigger.md#event) `Создание тега Docker-образа`.
  1. В блоке **Настройки функции**:
     * Выберите функцию `scan-on-push`.
     * Укажите [тег версии функции](../../../functions/concepts/function.md#tag) `$latest`.
     * Укажите сервисный аккаунт `invoker`, от имени которого будет вызываться функция.
  1. Нажмите кнопку **Создать триггер**.

- CLI {#cli}

  Чтобы создать триггер, выполните команду:

  ```bash
  yc serverless trigger create container-registry \
    --name <имя_триггера> \
    --registry-id <идентификатор_реестра> \
    --events 'create-image-tag' \
    --invoke-function-id <идентификатор_функции> \
    --invoke-function-service-account-id <идентификатор_сервисного_аккаунта>
  ```

  Где:
  * `--name` — имя триггера.
  * `--registry-id` — [идентификатор реестра](../../operations/registry/registry-list.md), в который будете загружать Docker-образ.
  * `--events` — [события](../../../functions/concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается.
  * `--invoke-function-id` — идентификатор функции.
  * `--invoke-function-service-account-id` — идентификатор сервисного аккаунта с правами на вызов функции.

  Результат:

  ```text
  id: a1spt834cjmk********
  folder_id: b1g86q4m5vej********
  created_at: "2021-05-18T20:42:54.898949653Z"
  ...
        function_tag: $latest
        service_account_id: aje1insoe23e********
  status: ACTIVE
  ```

- API {#api}

  Воспользуйтесь методом [create](../../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../../functions/triggers/api-ref/Trigger/index.md).

{% endlist %}

## Загрузите Docker-образ {#download-image}

1. Запустите Docker Desktop.
1. Аутентифицируйтесь в реестре от своего имени с помощью:

   {% list tabs group=registry_auth %}

   - Docker credential helper {#docker}

     1. Сконфигурируйте Docker для использования `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Результат:

        ```text
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```

        Настройки сохраняются в профиле текущего пользователя.

        {% note warning %}
        
        Credential helper работает только при использовании Docker без `sudo`. О том, как настроить запуск Docker от имени текущего пользователя без использования `sudo`, читайте в [официальной документации Docker](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).
        
        {% endnote %}

     1. Проверьте, что Docker сконфигурирован.

        В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

        ```json
        "cr.yandex": "yc"
        ```

     1. Docker готов к использованию, например, для [загрузки Docker-образов](../../operations/docker-image/docker-image-push.md). При этом выполнять команду `docker login` не надо.

   - OAuth-токена {#oauth-token}

     {% note info "Аутентификация по OAuth-токенам устарела" %}
     
     В будущем этот способ аутентификации перестанет поддерживаться. Рассмотрите использование [IAM-токенов](../../../iam/concepts/authorization/iam-token.md) или [API-ключей](../../../iam/concepts/authorization/api-key.md).
     
     {% endnote %}

     1. Если у вас еще нет [OAuth-токена](../../../iam/concepts/authorization/oauth-token.md), получите его по [ссылке](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).
     1. Выполните команду:

        ```bash
        echo <OAuth-токен> | docker login --username oauth --password-stdin cr.yandex
        ```
 
        Результат:

        ```text
        Login Succeeded
        ```

   - IAM-токена {#iam-token}

     {% note info %}

     У IAM-токена короткое [время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) — не более  12 часов. Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

     {% endnote %}

     1. [Получите](../../../iam/operations/iam-token/create.md) [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
     1. Выполните команду:

        ```bash
        yc iam create-token | docker login --username iam --password-stdin cr.yandex
        ```

        Результат:

        ```text
        Login Succeeded
        ```

   {% endlist %}

1. Скачайте Docker-образ с [Docker Hub](https://hub.docker.com/):

   ```bash
   docker pull ubuntu:20.04
   ```

   Результат:

   ```text
   20.04: Pulling from library/ubuntu
   Digest: sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88********
   Status: Image is up to date for ubuntu:20.04
   docker.io/library/ubuntu:20.04
   ```

1. Присвойте тег Docker-образу:

   ```bash
   docker tag ubuntu:20.04 cr.yandex/<идентификатор_реестра>/ubuntu:20.04
   ```

1. Загрузите Docker-образ в Container Registry:

   ```bash
   docker push cr.yandex/<идентификатор_реестра>/ubuntu:20.04
   ```

   Результат:

   ```text
   The push refers to repository [cr.yandex/crpu20rpdc2f********/ubuntu]
   2f140462f3bc: Layer already exists
   63c99163f472: Layer already exists
   ccdbb80308cc: Layer already exists
   20.04: digest: sha256:86ac87f73641c920fb42cc9612d4fb57b5626b56ea2a19b894d0673f******** size: 943
   ```

## Проверьте результат {#check-result}

1. Просмотрите логи функции `scan-on-push` и убедитесь, что она выполнилась.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите сервис **Cloud Functions**.
     1. Перейдите в раздел **Функции** и выберите функцию `scan-on-push`.
     1. В открывшемся окне перейдите в раздел **Логи** и укажите период. По умолчанию задан период за 1 час.

   - CLI {#cli}

     Чтобы узнать имя или уникальный идентификатор функции, [получите](../../../functions/operations/function/function-list.md) список функций в каталоге.

     Посмотрите журнал выполнения функции:

     ```bash
     yc serverless function logs scan-on-push
     ```

     Результат:

     ```text
     2021-05-18 09:27:43  START RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Version: b09i2s85a0c1********
     2021-05-18 09:27:43  END RequestID: 34dc9533-ed6e-4468-b9f2-2aa0********
     2021-05-18 09:27:43  REPORT RequestID: 34dc9533-ed6e-4468-b9f2-2aa0******** Duration: 538.610 ms Billed Duration: 538.700 ms Memory Size: 128 MB Max Memory Used: 13 MB
     2021-05-18 09:29:25  START RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Version: b09i2s85a0c1********
     2021-05-18 09:29:26  END RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f********
     2021-05-18 09:29:26  REPORT RequestID: 5b6a3779-dcc8-44ec-8ee2-2e7f******** Duration: 554.904 ms Billed Duration: 555.000 ms Memory Size: 128 MB Max Memory Used: 13 MB
     ...
     ```

   {% endlist %}

1. Проверьте, что при загрузке Docker-образа запустилось новое сканирование.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит реестр, содержащий Docker-образ.
     1. Выберите сервис **Container Registry**.
     1. Выберите реестр, в который загрузили Docker-образ.
     1. Откройте репозиторий, в котором находится Docker-образ.
     1. Выберите нужный Docker-образ и проверьте значение параметра **Дата последнего сканирования**.

   - CLI {#cli}

     Чтобы посмотреть запуски сканирования по Docker-образу, выполните команду:

     ```bash
     yc container image list-scan-results --repository-name=<идентификатор_реестра>/<имя_Docker-образа>
     ```

     Результат:

     ```text
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | crpu20rpdc2f******** | crpqmsqp5mtb******** | 2021-05-18 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

   {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите Docker-образ](../../operations/docker-image/docker-image-delete.md), который хранится в [Yandex Container Solution](../../../cos/index.md) и [реестр](../../operations/registry/registry-delete.md).
1. [Удалите](../../../functions/operations/function/function-delete.md) функцию Cloud Functions.
1. [Удалите](../../../functions/operations/function/function-delete.md) триггер Cloud Functions.

#### Полезные ссылки {#see-also}

* [Автоматическое сканирование Docker-образа при загрузке с помощью Terraform](terraform.md)