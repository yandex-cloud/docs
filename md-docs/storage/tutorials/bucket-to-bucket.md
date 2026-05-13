# Автоматическое копирование объектов из одного бакета Object Storage в другой

# Автоматическое копирование объектов из одного бакета Yandex Object Storage в другой


Настройте автоматическое копирование объектов из одного [бакета](../concepts/bucket.md) Object Storage в другой. Копирование будет осуществляться с помощью [функции](../../functions/concepts/function.md) Cloud Functions, которая запускается по [триггеру](../../functions/concepts/trigger/os-trigger.md) при добавлении нового объекта в бакет.

Чтобы настроить копирование:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисные аккаунты](#create-sa).
1. [Создайте статический ключ](#create-key).
1. [Создайте секрет Yandex Lockbox](#create-secret).
1. [Создайте бакеты Yandex Object Storage](#create-buckets).
1. [Подготовьте ZIP-архив с кодом функции](#create-zip).
1. [Создайте функцию Yandex Cloud Functions](#create-function).
1. [Создайте триггер](#create-trigger).
1. [Протестируйте функцию](#test-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входят:

* плата за хранение данных в бакете (см. [тарифы Yandex Object Storage](../pricing.md));
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы Yandex Cloud Functions](../../functions/pricing.md));
* плата за хранение секретов (см. [тарифы Yandex Lockbox](../../lockbox/pricing.md)).



## Создайте сервисные аккаунты {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) `s3-copy-fn` с ролями `storage.uploader`, `storage.viewer` и `lockbox.payloadViewer`, от имени которого будет работать функция, и `s3-copy-trigger` с ролью `functions.functionInvoker` для вызова функции.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Укажите имя сервисного аккаунта: `s3-copy-fn`.
  1. Нажмите **Добавить роль** и выберите роли `storage.uploader`, `storage.viewer` и `lockbox.payloadViewer`.
  1. Нажмите кнопку **Создать**.
  1. Повторите предыдущие шаги и создайте сервисный аккаунт `s3-copy-trigger` с ролью `functions.functionInvoker`, от имени которого будет вызываться функция.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт `s3-copy-fn`:

      ```bash
      yc iam service-account create --name s3-copy-fn
      ```

      Результат:

      ```text
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-03-21T10:36:29.726397755Z"
      name: s3-copy-fn
      ```

      Сохраните идентификатор сервисного аккаунта `s3-copy-fn` (`id`) и каталога, в котором его создали (`folder_id`).

  1. Назначьте сервисному аккаунту роли `storage.uploader`, `storage.viewer` и `lockbox.payloadViewer` на каталог:

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

      ```text
      done (1s)
      ```

  1. Создайте сервисный аккаунт `s3-copy-trigger`:

      ```bash
      yc iam service-account create --name s3-copy-trigger
      ```

      Сохраните идентификаторы сервисного аккаунта `s3-copy-trigger` (`id`) и каталога, в котором он был создан (`folder_id`).

  1. Назначьте сервисному аккаунту роль `functions.functionInvoker` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role storage.uploader \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

- Terraform {#tf}

  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  1. Опишите в конфигурационном файле параметры сервисных аккаунтов:

      ```hcl
      // Сервисный аккаунт для работы функции
      resource "yandex_iam_service_account" "s3-copy-fn" {
        name        = "s3-copy-fn"
        folder_id   = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "uploader" {
        folder_id = "<идентификатор_каталога>"
        role      = "storage.uploader"
        member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn.id}"
      }

      resource "yandex_resourcemanager_folder_iam_member" "viewer" {
        folder_id = "<идентификатор_каталога>"
        role      = "storage.viewer"
        member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn.id}"
      }

      resource "yandex_resourcemanager_folder_iam_member" "payloadViewer" {
        folder_id = "<идентификатор_каталога>"
        role      = "lockbox.payloadViewer"
        member    = "serviceAccount:${yandex_iam_service_account.s3-copy-fn.id}"
      }

      // Сервисный аккаунт для вызова функции
      resource "yandex_iam_service_account" "s3-copy-trigger" {
        name        = "s3-copy-trigger"
        folder_id   = "<идентификатор_каталога>"
      }

      resource "yandex_resourcemanager_folder_iam_member" "functionInvoker" {
        folder_id = "<идентификатор_каталога>"
        role      = "functions.functionInvoker"
        member    = "serviceAccount:${yandex_iam_service_account.s3-copy-trigger.id}"
      }
      ```

      Где:

      * `name` — имя сервисного аккаунта. Обязательный параметр.
      * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
      * `role` — назначаемая роль.

      Более подробную информацию о параметрах ресурса `yandex_iam_service_account` в Terraform, см. в [документации провайдера](../../terraform/resources/iam_service_account.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится информация о сервисном аккаунте. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание сервисных аккаунтов: введите в терминал слово `yes` и нажмите **Enter**.

          После этого будут созданы сервисные аккаунты. Проверить появление сервисных аккаунтов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

          ```bash
          yc iam service-account list
          ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роли на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}


## Создайте статический ключ {#create-key}

Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `s3-copy-fn`.


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится сервисный аккаунт.
  1.  [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты** и выберите сервисный аккаунт `s3-copy-fn`.
  1. На верхней панели нажмите кнопку **Создать новый ключ**.
  1. Выберите **Создать статический ключ доступа**.
  1. Задайте описание ключа и нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ.

- Yandex Cloud CLI {#cli}

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

- Terraform {#tf}

  1. Опишите в конфигурационном файле параметры ключа:

      ```hcl
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
      }
      ```

      Где `service_account_id` — идентификатор сервисного аккаунта `s3-copy-fn`.

      Более подробную информацию о параметрах ресурса `yandex_iam_service_account_static_access_key` в Terraform, см. в [документации провайдера](../../terraform/resources/iam_service_account_static_access_key.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание статического ключа доступа: введите в терминал слово `yes` и нажмите **Enter**.

          Если при создании ключа возникли ошибки, Terraform на них укажет.
          При успешном создании ключа Terraform запишет его в свою конфигурацию, но не покажет пользователю. В терминал будет выведен только идентификатор созданного ключа.

          Проверить появление ключа у сервисного аккаунта можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

          ```bash
          yc iam access-key list --service-account-name=s3-copy-fn
          ```

- API {#api}

  Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md).

{% endlist %}


## Создайте секрет {#create-secret}

Создайте [секрет](../../lockbox/quickstart.md) Yandex Lockbox для хранения статического ключа доступа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать секрет.
  1.  [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Lockbox**.
  1. Нажмите кнопку **Создать секрет**.
  1. В поле **Имя** укажите имя секрета: `s3-static-key`.

  1. В блоке **Данные секрета**:

      1. Выберите тип секрета **Пользовательский**.
      1. Добавьте значение идентификатора ключа:

          * В поле **Ключ** укажите: `key_id`.
          * В поле **Значение** укажите значение идентификатора ключа, которое [получили ранее](#create-key).

      1. Нажмите кнопку **Добавить ключ/значение**.
      1. Добавьте значение секретного ключа:

          * В поле **Ключ** укажите: `secret`.
          * В поле **Значение** укажите значение секретного ключа, которое [получили ранее](#create-key).

  1. Нажмите кнопку **Создать**.

- Yandex Cloud CLI {#cli}

  Чтобы создать секрет, выполните команду:

  ```bash
  yc lockbox secret create --name s3-static-key \
    --payload "[{'key': 'key_id', 'text_value': '<идентификатор_ключа>'},{'key': 'secret', 'text_value': '<значение_секретного_ключа>'}]"
  ```

  Результат:

  ```text
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

- Terraform {#tf}

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

      {% note info %}
      
      Рекомендуется использовать ресурс `yandex_lockbox_secret_version_hashed`, он хранит в состоянии Terraform значения в хешированном виде. Поддержка ресурса `yandex_lockbox_secret_version` остается.
      
      Более подробную информацию о ресурсе `yandex_lockbox_secret_version_hashed` см. в [документации провайдера](../../terraform/resources/lockbox_secret_version_hashed.md).
      
      {% endnote %}

      Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

      * [yandex_lockbox_secret](../../terraform/resources/lockbox_secret.md);
      * [yandex_lockbox_secret_version](../../terraform/resources/lockbox_secret_version.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание секрета: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}


## Создайте бакеты Object Storage {#create-buckets}

Создайте два бакета: основной — где будут храниться файлы, и резервный — куда будут копироваться файлы из основного бакета.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакеты.
  1.  [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Создайте основной бакет:

      1. Нажмите кнопку **Создать бакет**.
      1. В поле **Имя** укажите имя для основного бакета.
      1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите `С авторизацией`.
      1. Нажмите кнопку **Создать бакет**.

  1. Таким же образом создайте резервный бакет.

- AWS CLI {#cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

  Создайте основной и резервный бакеты:

  ```bash
  aws --endpoint-url https://storage.yandexcloud.net \
    s3 mb s3://<имя_основного_бакета>

  aws --endpoint-url https://storage.yandexcloud.net \
    s3 mb s3://<имя_резервного_бакета>
  ```

  Результат:

  ```text
  make_bucket: <имя_основного_бакета>
  make_bucket: <имя_резервного_бакета>
  ```

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  1. Опишите в конфигурационном файле параметры для создания сервисного аккаунта и ключа доступа:

      ```hcl
      ...
      // Создание сервисного аккаунта
      resource "yandex_iam_service_account" "sa" {
        name = "<имя_сервисного_аккаунта>"
      }
      
      // Назначение роли сервисному аккаунту
      resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
        folder_id = "<идентификатор_каталога>"
        role      = "storage.admin"
        member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
      }
      
      // Создание статического ключа доступа
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = yandex_iam_service_account.sa.id
        description        = "static access key for object storage"
      }
      ```

  1. Опишите в конфигурационном файле параметры основного и резервного бакетов:

      ```hcl
      resource "yandex_storage_bucket" "main-bucket" {
        access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket     = "<имя_основного_бакета>"
      }

      resource "yandex_storage_bucket" "reserve-bucket" {
        access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket     = "<имя_резервного_бакета>"
      }
      ```

      Подробнее о ресурсе `yandex_storage_bucket` см. в [документации](../../terraform/resources/storage_bucket.md) провайдера Terraform.

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание бакетов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать бакет, воспользуйтесь методом REST API [create](../s3/api-ref/bucket/create.md) для ресурса [Bucket](../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Create](../api-ref/grpc/Bucket/create.md).

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
      done;
    ) 1>&2
    ```

1. Добавьте файл `handler.sh` в ZIP-архив `handler-sh.zip`.


## Создайте функцию {#create-function}

Создайте функцию, которая при добавлении нового [объекта](../concepts/object.md) в основной бакет будет копировать его в резервный бакет.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать функцию.
  1.  [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**
  1. Создайте функцию:

      1. Нажмите кнопку **Создать функцию**.
      1. Укажите имя функции — `copy-function`.
      1. Нажмите кнопку **Создать**.

  1. Создайте версию функции:

      1. Выберите среду выполнения `Bash`, отключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
      1. Укажите способ загрузки `ZIP-архив` и выберите архив `handler-sh.zip`, который создали на предыдущем шаге.
      1. Укажите точку входа `handler.sh`.
      1. В блоке **Параметры** укажите:

          * **Таймаут** — `600`.
          * **Память** — `128 МБ`.
          * **Сервисный аккаунт** — `s3-copy-fn`.
          * **Переменные окружения**:

              * `S3_ENDPOINT` — `https://storage.yandexcloud.net`.
              * `DST_BUCKET` — имя резервного бакета, в который нужно копировать объекты.

          * **Секреты Lockbox**:

              * `AWS_ACCESS_KEY_ID` — идентификатор секрета `s3-static-key`, идентификатор версии `latest`, ключ секрета `key_id`.
              * `AWS_SECRET_ACCESS_KEY` — идентификатор секрета `s3-static-key`, идентификатор версии `latest`, ключ секрета `secret`.

      1. Нажмите кнопку **Сохранить изменения**.

- Yandex Cloud CLI {#cli}

  1. Создайте функцию `copy-function`:

      ```bash
      yc serverless function create --name=copy-function
      ```

      Результат:

      ```text
      id: b09bhaokchn9********
      folder_id: <идентификатор_каталога>
      created_at: "2024-10-21T20:40:03.451Z"
      name: copy-function
      http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9********
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

        ```text
        done (1s)
        id: d4e394pt4nhf********
        function_id: d4efnkn79m7n********
        created_at: "2024-10-21T20:41:01.345Z"
        runtime: bash
        entrypoint: handler.sh
        resources:
          memory: "134217728"
        execution_timeout: 600s
        service_account_id: ajelprpohp7r********
        image_size: "4096"
        status: ACTIVE
        tags:
          - $latest
        environment:
          DST_BUCKET: <имя_резервного_бакета>
          S3_ENDPOINT: https://storage.yandexcloud.net
        secrets:
          - id: e6qo2oprlmgn********
            version_id: e6q6i1qt0ae8********
            key: key_id
            environment_variable: AWS_ACCESS_KEY_ID
          - id: e6qo2oprlmgn********
            version_id: e6q6i1qt0ae8********
            key: secret
            environment_variable: AWS_SECRET_ACCESS_KEY
        log_options:
          folder_id: b1g681qpemb4********
        concurrency: "1"
        ```

- Terraform {#tf}

  1. Опишите в конфигурационном файле параметры функции:

      ```hcl
      resource "yandex_function" "copy-function" {
        name               = "copy-functionn"
        user_hash          = "first function"
        runtime            = "bash"
        entrypoint         = "handler.sh"
        memory             = "128"
        execution_timeout  = "600"
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        environment = {
          DST_BUCKET  = "<имя_резервного_бакета>"
          S3_ENDPOINT = "https://storage.yandexcloud.net"
        }
        secrets {
          id                   = "<идентификатор_секрета>"
          version_id           = "<идентификатор_версии_секрета>"
          key                  = "key_id"
          environment_variable = "AWS_ACCESS_KEY_ID"
        }
        secrets {
          id                   = "<идентификатор_секрета>"
          version_id           = "<идентификатор_версии_секрета>"
          key                  = "secret"
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

      Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера](../../terraform/resources/function.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание функции: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать функцию, воспользуйтесь методом [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md).

  Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}


## Создайте триггер {#create-trigger}

Создайте триггер для Object Storage, который будет вызывать функцию `copy-function` при создании нового объекта в основном бакете.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать триггер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В блоке **Базовые параметры**:

      * Укажите имя триггера: `bucket-to-bucket-copying`.
      * В поле **Тип** выберите `Object Storage`.
      * В поле **Запускаемый ресурс** выберите `Функция`.

  1. В блоке **Настройки Object Storage**:

      * В поле **Бакет** выберите основной бакет.
      * В поле **Типы событий** выберите `Создание объекта`.

  1. В блоке **Настройки функции**:

      * В поле **Функция** выберите функцию `copy-function`.
      * В поле **Сервисный аккаунт** выберите сервисный аккаунт `s3-copy-trigger`.

  1. Нажмите кнопку **Создать триггер**.

- Yandex Cloud CLI {#cli}

  Выполните команду:

  ```bash
  yc serverless trigger create object-storage \
    --name bucket-to-bucket-copying \
    --bucket-id <имя_основного_бакета> \
    --events 'create-object' \
    --invoke-function-name copy-function \
    --invoke-function-service-account-name s3-copy-trigger
  ```

  Где:

  * `--name` — имя триггера.
  * `--bucket-id` — имя основного бакета.
  * `--events` — [события](../../functions/concepts/trigger/os-trigger.md#event), после наступления которых триггер запускается.
  * `--invoke-function-name` — имя вызываемой функции.
  * `--invoke-function-service-account-name` — имя сервисного аккаунта, от имени которого будет вызываться функция.

  Результат:

  ```text
  id: a1s92agr8mpg********
  folder_id: b1g88tflru0e********
  created_at: "2024-10-21T21:04:01.866959640Z"
  name: bucket-to-bucket-copying
  rule:
    object_storage:
      event_type:
        - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
      bucket_id: <имя_основного_бакета>
      batch_settings:
        size: "1"
        cutoff: 1s
      invoke_function:
        function_id: d4eofc7n0m03********
        function_tag: $latest
        service_account_id: aje3932acd0c********
  status: ACTIVE
  ```

- Terraform {#tf}

  1. Опишите в конфигурационном файле параметры триггера:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "bucket-to-bucket-copying"
        object_storage {
            bucket_id = "<имя_основного_бакета>"
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
          * `bucket_id` — имя основного бакета.
          * `create` — триггер вызовет функцию при создании нового объекта в хранилище.
      * `function` — настройки функции, которую будет запускать триггер:
          * `id` — идентификатор функции `copy-function`.
          * `service_account_id` — идентификатор сервисного аккаунта `s3-copy-trigger`.

      Более подробную информацию о параметрах ресурсов в Terraform см. в [документации провайдера](../../terraform/resources/function_trigger.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание триггера: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать триггер для Object Storage, воспользуйтесь методом [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}


## Протестируйте функцию {#test-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, где находится основной бакет.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Нажмите на имя основного бакета.
  1. В правом верхнем углу нажмите кнопку **Загрузить**.
  1. В появившемся окне выберите необходимые файлы и нажмите кнопку **Открыть**.
  1. Консоль управления отобразит все объекты, выбранные для загрузки. Нажмите кнопку **Загрузить**.
  1. Обновите страницу.
  1. Перейдите в резервный бакет и убедитесь, что в нем появились добавленные файлы.

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}


Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../operations/objects/delete-all.md) объекты из бакетов.
1. [Удалите](../operations/buckets/delete.md) бакеты.
1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер `bucket-to-bucket-copying`.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию `copy-function`.