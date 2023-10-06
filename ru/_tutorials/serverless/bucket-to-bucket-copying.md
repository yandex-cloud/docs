# Автоматическое копирование объектов из одного бакета {{ objstorage-name }} в другой

Настройте автоматическое копирование объектов из одного [бакета](../../storage/concepts/bucket.md) {{ objstorage-name }} в другой. Копирование будет осуществляться с помощью [функции](../../functions/concepts/function.md) {{ sf-name }}, которая запускается по [триггеру](../../functions/concepts/trigger/os-trigger.md) при добавлении нового объекта в бакет.

Чтобы настроить копирование:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисные аккаунты](#create-sa).
1. [Создайте статический ключ](#create-key).
1. [Создайте секрет {{ lockbox-full-name }}](#create-secret).
1. [Создайте бакеты {{ objstorage-full-name }}](#create-buckets).
1. [Подготовьте ZIP-архив с кодом функции](#create-zip).
1. [Создайте функцию {{ sf-full-name }}](#create-function).
1. [Создайте триггер](#create-trigger).
1. [Протестируйте функцию](#test-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входят:

* плата за хранение данных в бакете (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md));
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md));
* плата за хранение секретов (см. [тарифы {{ lockbox-full-name }}](../../lockbox/pricing.md)).


## Создайте сервисные аккаунты {#create-sa}

1. Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `s3-copy-fn`, от имени которого будет работать функция:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
     1. Перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Введите имя сервисного аккаунта: `s3-copy-fn`.
     1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роли `storage.uploader`, `storage.viewer` и `{{ roles-lockbox-payloadviewer }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
    
   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. Создайте сервисный аккаунт `s3-copy-fn`:

        ```bash
        yc iam service-account create --name s3-copy-fn
        ```

        Результат:

        ```
        id: nfersamh4sjq********
        folder_id: b1gc1t4cb638********
        created_at: "2023-03-21T10:36:29.726397755Z"
        name: s3-copy-fn
        ```

        Сохраните идентификатор сервисного аккаунта `s3-copy-fn` (`id`) и каталога, в котором его создали (`folder_id`).

     1. Назначьте сервисному аккаунту роли `storage.uploader`, `storage.viewer` и `{{ roles-lockbox-payloadviewer }}` на каталог:

        ```bash
        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role storage.uploader \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>

        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role storage.viewer \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>

        yc resource-manager folder add-access-binding <идентификатор_каталога> \
          --role lockbox.payloadViewer \
          --subject serviceAccount:<идентификатор_сервисного_аккаунта>
        ```

        Результат:

        ```
        done (1s)
        ```

   - {{ TF }}

     
     Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


     1. Опишите в конфигурационном файле параметры сервисного аккаунта:

        ```hcl
        resource "yandex_iam_service_account" "s3-copy-fn" {
          name        = "s3-copy-fn"
          folder_id   = "<идентификатор_каталога>"
        }

        resource "yandex_resourcemanager_folder_iam_member" "uploader" {
          folder_id = "<идентификатор каталога>"
          role      = "storage.uploader"
          member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn id}"
        }

        resource "yandex_resourcemanager_folder_iam_member" "viewer" {
          folder_id = "<идентификатор каталога>"
          role      = "storage.viewer"
          member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn id}"
        }

        resource "yandex_resourcemanager_folder_iam_member" "payloadViewer" {
          folder_id = "<идентификатор каталога>"
          role      = "lockbox.payloadViewer"
          member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn id}"
        }
        ```

        Где:

        * `name` — имя сервисного аккаунта. Обязательный параметр.
        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
        * `role` — назначаемая роль.

        Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account).

     1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

           ```bash
           terraform plan
           ```

        Если конфигурация описана верно, в терминале отобразится информация о сервисном аккаунте. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

     1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

           ```bash
           terraform apply
           ```

        1. Подтвердите создание сервисного аккаунта: введите в терминал слово `yes` и нажмите **Enter**.

           После этого будет создан сервисный аккаунт. Проверить появление сервисного аккаунта можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

           ```bash
           yc iam service-account list
           ```

   - API

     Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/service_account_service.md#Create).

     Чтобы назначить сервисному аккаунту роли `storage.uploader`, `storage.viewer` и `{{ roles-lockbox-payloadviewer }}` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/service_account_service.md#SetAccessBindings).

   {% endlist %}

1. Таким же образом создайте сервисный аккаунт `s3-copy-trigger` с ролью `{{ roles-functions-invoker }}`, от имени которого будет вызываться функция.

## Создайте статический ключ {#create-key}

Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `s3-copy-fn`.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится сервисный аккаунт.
  1. Перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт и нажмите на строку с его именем.
  1. На верхней панели нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
  1. Задайте описание ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ.

- CLI

  1. Выполните команду:

     ```bash
     yc iam access-key create --service-account-name s3-copy-fn
     ```

     Результат:

     ```text
     access_key:
       id: aje6t3vsbj8l********
       service_account_id: ajepg0mjt06s********
       created_at: "2023-03-21T14:37:51Z"
       key_id: 0n8X6WY6S24********
     secret: JyTRFdqw8t1kh2-OJNz4JX5ZTz9Dj1rI********
     ```

  1. Сохраните идентификатор (`key_id`) и секретный ключ (`secret`). Получить значение ключа снова будет невозможно.

- {{ TF }}

  1. Опишите в конфигурационном файле параметры ключа:

     ```hcl
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = "<идентификатор_сервисного_аккаунта>"
     }
     ```

     Где `service_account_id` — идентификатор сервисного аккаунта `s3-copy-fn`.

     Более подробную информацию о параметрах ресурса `yandex_iam_service_account_static_access_key` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
         
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание статического ключа доступа: введите в терминал слово `yes` и нажмите **Enter**.

        Если при создании ключа возникли ошибки, {{ TF }} на них укажет.
        При успешном создании ключа {{ TF }} запишет его в свою конфигурацию, но не покажет пользователю. В терминал будет выведен только идентификатор созданного ключа.

        Проверить появление ключа у сервисного аккаунта можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):
         
        ```bash
        yc iam access-key list --service-account-name=s3-copy-fn
        ```

- API

  Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../iam/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../iam/api-ref/grpc/access_key_service.md#Create).

{% endlist %}

## Создайте секрет {#create-secret}

Создайте [секрет](../../lockbox/quickstart.md) {{ lockbox-name }} для хранения статического ключа доступа.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать секрет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета: `s3-static-key`.
  1. В блоке **{{ ui-key.yacloud.lockbox.forms.section_version }}**:

     1. Добавьте значение идентификатора ключа:

        * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите `key_id`.
        * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите значение идентификатора ключа, которое [получили ранее](#create-key).
     
     1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}**.
     1. Добавьте значение секретного ключа:

        * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите `secret`.
        * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите значение секретного ключа, которое [получили ранее](#create-key).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

  Чтобы создать секрет, выполните команду:

  ```bash
  yc lockbox secret create --name s3-static-key \
    --payload "[{'key': 'key_id', 'text_value': '<идентификатор_ключа>'},{'key': 'secret', 'text_value': '<значение_секретного_ключа>'}]"
  ```

  Результат:
  
  ```
  id: e6q2ad0j9b55********
  folder_id: b1gktjk2rg49********
  created_at: "2021-11-08T19:23:00.383Z"
  name: s3-static-key
  status: ACTIVE
  current_version:
    id: g6q4fn3b6okj********
    secret_id: e6e2ei4u9b55********
    created_at: "2023-03-21T19:23:00.383Z"
    status: ACTIVE
    payload_entry_keys:
      - key_id
      - secret
  ```

- {{ TF }}

  1. Опишите в конфигурационном файле параметры секрета:
    
     ```hcl
     resource "yandex_lockbox_secret" "my_secret" {
       name = "s3-static-key"
     }

     resource "yandex_lockbox_secret_version" "my_version" {
       secret_id = yandex_lockbox_secret.my_secret.id
       entries {
         key        = "key_id"
         text_value = "<идентификатор_ключа>"
       }
       entries {
         key        = "secret"
         text_value = "<значение_секретного_ключа>"
       }
     }
     ```

     Где:

     * `name` — имя секрета.
     * `key` — название ключа.
     * `text_value` — значение ключа.

     Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

     * [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret);
     * [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version).
    
  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание секрета: введите в терминал слово `yes` и нажмите **Enter**.

- API

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/secret_service.md#Create).

{% endlist %}

## Создайте бакеты {{ objstorage-name }} {#create-buckets}

Создайте два бакета: основной — где будут храниться файлы, резервный — куда будут копироваться файлы из основного бакета.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакеты.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Создайте основной бакет:

     1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
     1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета.
     1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

  1. Таким же образом создайте резервный бакет.

- AWS CLI

  1. Создайте основной бакет:

     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://<имя_основного_бакета>
     ```

     Результат:

     ```
     make_bucket: s3://<имя_основного_бакета>
     ```

  1. Таким же образом создайте резервный бакет.

- {{ TF }}

  1. Опишите в конфигурационном файле параметры основного и резервного бакетов:

     ```
     resource "yandex_storage_bucket" "main-bucket" {
       bucket = "<имя_основного_бакета>"
     }

     resource "yandex_storage_bucket" "reserve-bucket" {
       bucket = "<имя_резервного_бакета>"
     }
     ```

     Подробнее о ресурсе `yandex_storage_bucket` см. в [документации]({{ tf-provider-resources-link }}/storage_bucket) провайдера {{ TF }}.

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание бакетов: введите в терминал слово `yes` и нажмите **Enter**.

- API

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../../storage/s3/api-ref/bucket/create.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create).

{% endlist %}

## Подготовьте ZIP-архив с кодом функции {#create-zip}

1. Сохраните следующий код в файл с названием `handler.sh`:

   ```bash
   set -e
   (
     cat | jq -c '.messages[]' | while read message; 
     do
       SRC_BUCKET=$(echo "$message" | jq -r .details.bucket_id)
       SRC_OBJECT=$(echo "$message" | jq -r .details.object_id)
       aws --endpoint-url="$S3_ENDPOINT" s3 cp "s3://$SRC_BUCKET/$SRC_OBJECT" "s3://$DST_BUCKET/$SRC_OBJECT"
     done
   ) 1>&2
   ```

1. Добавьте файл `handler.sh` в ZIP-архив `handler-sh.zip`.

## Создайте функцию {#create-function}

Создайте функцию, которая при добавлении нового [объекта](../../storage/concepts/object.md) в основной бакет будет копировать его в резервный бакет.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**
  1. Создайте функцию:

     1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
     1. Введите имя функции — `copy-function`.
     1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.
  
  1. Создайте версию функции:

     1. Выберите среду выполнения `Bash`, отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. Укажите способ загрузки `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` и выберите архив `handler-sh.zip`, который создали на предыдущем шаге.
     1. Укажите точку входа `handler.sh`.
     1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `600`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `s3-copy-fn`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

          * `S3_ENDPOINT` — `https://storage.yandexcloud.net`.
          * `DST_BUCKET` — имя резервного бакета, в который нужно копировать объекты.

        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:

          * `AWS_ACCESS_KEY_ID` — ключ `key_id` секрета `s3-static-key`.
          * `AWS_SECRET_ACCESS_KEY` — ключ `secret` секрета `s3-static-key`.
      
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI

  1. Создайте функцию `copy-function`:

     ```bash
     yc serverless function create --name=copy-function
     ```

     Результат:

     ```
     id: b09bhaokchn9********
     folder_id: aoek49ghmknn********
     created_at: "2023-03-21T10:03:37.475Z"
     name: copy-function
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
     status: ACTIVE
     ```

  1. Создайте версию функции `copy-function`:

     ```bash
     yc serverless function version create \
       --function-name copy-function \
       --memory=128m \
       --execution-timeout=600s \
       --runtime=bash \
       --entrypoint=handler.sh \
       --service-account-id=<идентификатор_сервисного_аккаунта> \
       --environment DST_BUCKET=<имя_резервного_бакета> \
       --environment S3_ENDPOINT=https://storage.yandexcloud.net \
       --secret name=s3-static-key,key=key_id,environment-variable=AWS_ACCESS_KEY_ID \
       --secret name=s3-static-key,key=secret,environment-variable=AWS_SECRET_ACCESS_KEY \
       --source-path=./handler-sh.zip
       ```

       Где:

       * `--function-name` — имя функции, версия которой создается.
       * `--memory` —  объем RAM.
       * `--execution-timeout` — максимальное время выполнения функции до таймаута.
       * `--runtime` — среда выполнения.
       * `--entrypoint` — точка входа.
       * `--service-account-id` — идентификатор сервисного аккаунта `s3-copy-fn`.
       * `--environment` — переменные окружения.
       * `--secret` — секрет, содержащий части статического ключа доступа.
       * `--source-path` — путь до ZIP-архива `handler-sh.zip`.

       Результат:

       ```
       done (1s)
       id: d4e6qqlh53nu********
       function_id: d4emc80mnp5n********
       created_at: "2023-03-22T16:49:41.800Z"
       runtime: bash
       entrypoint: handler.sh
       resources:
         memory: "134217728"
       execution_timeout: 600s
       service_account_id: aje20nhregkc********
       image_size: "4096"
       status: ACTIVE
       tags:
         - $latest
       log_group_id: ckgmc3l93cl0********
       environment:
         DST_BUCKET: <имя_резервного_бакета>
         S3_ENDPOINT: https://storage.yandexcloud.net
       secrets:
         - id: e6q5qe9a1hgk********
           version_id: e6qrdn2e1acb********
           key: key_id
           environment_variable: AWS_ACCESS_KEY_ID
         - id: e6q5qe9a1hgk********
           version_id: e6qrdn2e1acb********
           key: secret
           environment_variable: AWS_SECRET_ACCESS_KEY
       log_options:
         folder_id: b1g86q4m5vej********
       ```

- {{ TF }}

  1. Опишите в конфигурационном файле параметры функции:

     ```   
     resource "yandex_function" "copy-function" {
       name               = "copy-functionn"
       user_hash          = "first function"
       runtime            = "bash"
       entrypoint         = "handler.sh"
       memory             = "128"
       execution_timeout  = "600"
       service_account_id = "aje20nhregkcvu******"
       environment = {
         DST_BUCKET  = "<имя_резервного_бакета>"
         S3_ENDPOINT = "https://storage.yandexcloud.net"
       }
       secrets = {
         id = "e6q5qe9a1hgk1a******"
         version_id = "e6qrdn2e1acb7e******"
         key = "key_id"
         environment_variable = "AWS_ACCESS_KEY_ID"
       }
       secrets = {
         id = "e6q5qe9a1hgk1a******"
         version_id = "e6qrdn2e1acb7e******"
         key = "secret"
         environment_variable = "AWS_SECRET_ACCESS_KEY"
       }
       content {
         zip_filename = "./handler-sh.zip"
       }
     }
     ```

     Где:

     * `name` — имя функции.
     * `user_hash` — произвольная строка, определяющая версию функции.
     * `runtime` — [среда выполнения](../../functions/concepts/runtime/index.md) функции.
     * `entrypoint` — точка входа.
     * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
     * `execution_timeout` — таймаут выполнения функции.
     * `service_account_id` — идентификатор сервисного аккаунта `s3-copy-fn`.
     * `environment` — переменные окружения.
     * `secrets` — секрет, содержащий части статического ключа доступа.
     * `content` — путь до ZIP-архива `handler-sh.zip` c исходным кодом функции.

     Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание функции: введите в терминал слово `yes` и нажмите **Enter**.

- API

  Чтобы создать функцию, воспользуйтесь методом [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/function_service.md#Create).

  Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}

## Создайте триггер {#create-trigger}

Создайте триггер для {{ objstorage-name }}, который будет вызывать функцию `copy-function` при создании нового объекта в основном бакете.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**
  1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

     * Введите имя триггера: `bucket-to-bucket-copying`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_storage }}**.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_storage }}**:

     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_bucket }}** выберите основной бакет.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.value_event-type-create-object}}`.

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:

     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** выберите функцию `copy-function`.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** выберите сервисный аккаунт `s3-copy-trigger`.

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

  Выполните команду:

  ```bash
  yc serverless trigger create object-storage \
    --name bucket-to-bucket-copying \
    --bucket-id <идентификатор_бакета> \
    --events 'create-object' \
    --invoke-function-name copy-function \
    --invoke-function-service-account-name s3-copy-trigger
  ```

  Где:

  * `--name` — имя триггера.
  * `--bucket-id` — идентификатор основного бакета.
  * `--events` — [события](../../functions/concepts/trigger/os-trigger.md#event), после наступления которых триггер запускается.
  * `--invoke-function-name` — имя вызываемой функции.
  * `--invoke-function-service-account-name` — имя сервисного аккаунта, от имени которого будет вызываться функция.

  Результат:

  ```text
  id: a1s92agr8mpg********
  folder_id: b1g88tflru0e********
  created_at: "2023-03-22T09:47:50.079103Z"
  name: bucket-to-bucket-copying
  rule:
    object_storage:
      event_type:
      - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
      bucket_id: <имя_основного_бакета>
      invoke_function:
        function_id: d4eofc7n0m03********
        function_tag: $latest
        service_account_id: aje3932acd0c********
  status: ACTIVE
  ```

- {{ TF }}

  1. Опишите в конфигурационном файле параметры триггера:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name        = "bucket-to-bucket-copying"
       object_storage {
          bucket_id = "<идентификатор_бакета>"
          create    = true
       }
       function {
         id                 = "<идентификатор_функции>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
     }
     ```

     Где:

     * `name` — имя триггера.
     * `object_storage` — параметры хранилища:
        * `bucket_id` — идентификатор бакета.
        * `create` — триггер вызовет функцию при создании нового объекта в хранилище.
     * `function` — настройки функции, которую будет запускать триггер:
        * `id` — идентификатор функции `copy-function`.
        * `service_account_id` — идентификатор сервисного аккаунта `s3-copy-trigger`.

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание триггера: введите в терминал слово `yes` и нажмите **Enter**.

- API

  Чтобы создать триггер для {{ objstorage-name }}, воспользуйтесь методом [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Протестируйте функцию {#test-function}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где находится основной бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя основного бакета.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. В появившемся окне выберите необходимые файлы и нажмите кнопку **Открыть**.
  1. Консоль управления отобразит все объекты, выбранные для загрузки. Нажмите кнопку **{{ ui-key.yacloud.storage.button_upload }}**.
  1. Обновите страницу.
  1. Перейдите в резервный бакет и убедитесь, что в нем появились добавленные файлы.

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/objects/delete-all.md) объекты из бакетов.
1. [Удалите](../../storage/operations/buckets/delete.md) бакеты.
1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер `bucket-to-bucket-copying`.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию `copy-function`.

