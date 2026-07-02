[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Практические руководства](index.md) > Шифрование на стороне сервера

# Шифрование на стороне сервера

# Шифрование для бакета Object Storage на стороне сервера


В этом сценарии вы включите шифрование для бакета. В качестве ключа симметричного шифрования будет использоваться [ключ Yandex Key Management Service](../../kms/concepts/key.md). Все новые объекты в бакете будут шифроваться указанным ключом по схеме [envelope encryption](../../kms/concepts/envelope.md).


Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).


Чтобы включить шифрование бакета на стороне сервера:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте ключ](#create-key).
1. [Включите шифрование](#enable-encryption).

Если шифровать новые объекты в бакете больше не требуется, [отключите шифрование](#disable-encryption).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета с шифрованием входит:

* плата за хранение данных в бакете ([тарифы Object Storage](../pricing.md#prices-storage));
* плата за операции с данными ([тарифы Object Storage](../pricing.md#prices-operations));
* плата за использование ключей KMS ([тарифы Key Management Service](../../kms/pricing.md#prices)).


## Создайте бакет {#create-bucket}

Вы можете создать новый бакет или использовать существующий. Чтобы создать бакет, выполните:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета.

     Имя должно удовлетворять требованиям:

     * Длина имени должна быть от 3 до 63 символов.
     * Имя может содержать строчные буквы латинского алфавита, цифры, дефисы и точки.
     * Первый и последний символы должны быть буквами или цифрами.
     * Символы справа и слева от точки должны быть буквами или цифрами. 
     * Имя не должно иметь вид IP-адреса (например `10.1.3.9`).

  1. Укажите максимальный размер бакета в ГБ.
  1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите **С авторизацией**.
  1. Нажмите кнопку **Создать бакет**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

  1. Выполните команду:

      ```bash
      aws s3 mb s3://<имя_бакета> --endpoint-url=https://storage.yandexcloud.net
      ```

      Результат:

      ```text
      make_bucket: <имя_бакета>
      ```

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите ресурсы в конфигурационном файле. Чтобы задать параметры, в данном сценарии используется блок `locals`:

      ```
      locals {
        cloud_id    = "<идентификатор_облака>"
        folder_id   = "<идентификатор_каталога>"
        zone        = "ru-central1-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами Object Storage"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        bucket_name = "Имя бакета" # Имя создаваемого бакета. Если не задавать имя бакета для ресурса `yandex_storage_bucket`, имя будет сгенерировано автоматически.
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        cloud_id  = local.cloud_id
        folder_id = local.folder_id
        zone      = local.zone
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
        service_account_id = "${yandex_iam_service_account.buckets-account.id}"
        description        = local.sa_key_desc
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = local.bucket_name
        access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"
      }
      ```

      Подробнее о ресурсах, которые вы можете создать с помощью [Terraform](https://www.terraform.io/docs/language/index.html), смотрите в [документации провайдера](../../terraform/index.md).

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

      1. Подтвердите создание ресурсов.

          После выполнения команды Terraform обновит или создаст в указанном каталоге следующие ресурсы:

          * Сервисный аккаунт `new-buckets-account`.
          * Роль `editor` для сервисного аккаунта `new-buckets-account`.
          * Статический ключ для сервисного аккаунта.
          * Бакет.

          Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Создайте ключ {#create-key}

Создайте новый ключ или используйте существующий. Чтобы создать новый ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать ключ.
  1. Перейдите в сервис **Key Management Service**.
  1. Нажмите кнопку **Создать ключ**.
  1. В открывшемся окне:

      * В поле **Имя** укажите `bucket-key`.
      * В поле **Алгоритм шифрования** выберите `AES-256`.
      * В поле **Период ротации, дни** выберите период [ротации](../../kms/concepts/version.md#rotate-key) `7 дней`.
      * Нажмите кнопку **Создать**.

  Вместе с ключом создается его первая версия: нажмите на ключ в списке, чтобы открыть страницу с его атрибутами.

- Yandex Cloud CLI {#cli}

  Выполните команду:

  ```bash
  yc kms symmetric-key create \
    --name bucket-key \
    --default-algorithm aes-256 \
    --rotation-period 168h
  ```

  Где:

  * `--name` — имя ключа.
  * `--default-algorithm` — алгоритм шифрования: `aes-128`, `aes-192` или `aes-256`.
  * `--rotation-period` — период ротации ключа. Значение задается в часах, минутах и секундах и не может быть менее 24 часов. Например: `--rotation-period 27h14m27s`.

      Чтобы создать ключ без автоматической ротации, не указывайте параметр `--rotation-period`.

  Вместе с ключом создается его первая версия. Она указана в поле `primary_version`.

- Terraform {#tf}

  1. Опишите ресурсы в конфигурационном файле. Чтобы задать параметры, в данном сценарии используется блок `locals`:

      ```
      locals {
        cloud_id    = "<идентификатор_облака>"
        folder_id   = "<идентификатор_каталога>"
        zone        = "ru-central1-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами Object Storage"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        key_name    = "bucket-key" # Имя ключа KMS.
        key_desc    = "Ключ для шифрования бакетов"

        bucket_name = "Имя бакета"
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        cloud_id  = local.cloud_id
        folder_id = local.folder_id
        zone      = local.zone
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
        service_account_id = "${yandex_iam_service_account.buckets-account.id}"
        description        = local.sa_key_desc
      }

      resource "yandex_kms_symmetric_key" "key-a" {
        name              = local.key_name
        description       = local.key_desc
        default_algorithm = "AES_256"
        rotation_period   = "168h"
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = local.bucket_name
        access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"
      }
      ```

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

      1. Подтвердите создание ресурсов.

          После выполнения команды Terraform обновит или создаст в указанном каталоге следующие ресурсы:

          * Сервисный аккаунт `new-buckets-account`.
          * Роль `editor` для сервисного аккаунта `new-buckets-account`.
          * Статический ключ для сервисного аккаунта.
          * Ключ KMS с названием `bucket-key`.
          * Бакет.

          Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом [create](../../kms/api-ref/SymmetricKey/create.md) для ресурса `SymmetricKey`.

{% endlist %}

## Включите шифрование {#enable-encryption}

Чтобы включить шифрование бакета ключом KMS, выполните следующее:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится бакет.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите бакет, созданный ранее.
  1. На панели слева выберите **Безопасность**.
  1. Откройте вкладку **Шифрование**.
  1. В поле **Ключ KMS** выберите ключ `bucket-key`.
  1. Нажмите кнопку **Сохранить**.

- AWS CLI {#aws-cli}

  Выполните команду:

  ```
  aws s3api put-bucket-encryption \
    --bucket <имя_бакета> \
    --endpoint-url=https://storage.yandexcloud.net \
    --server-side-encryption-configuration '{
    "Rules": [
      {
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "aws:kms",
        "KMSMasterKeyID": "<идентификатор_ключа_KMS>"
      },
      "BucketKeyEnabled": true
    }
    ]
  }'
  ```

- Terraform {#tf}

  1. Опишите ресурсы в конфигурационном файле. Чтобы задать параметры, в данном сценарии используется блок `locals`:

      ```
      locals {
        cloud_id    = "<идентификатор_облака>"
        folder_id   = "<идентификатор_каталога>"
        zone        = "ru-central1-a"
        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами Object Storage"
        sa_key_desc = "Статический ключ для ${local.sa_name}"
        key_name    = "bucket-key" # Имя ключа KMS.
        key_desc    = "Ключ для шифрования бакетов"
        bucket_name = "Имя бакета" # Имя бакета.
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        cloud_id  = local.cloud_id
        folder_id = local.folder_id
        zone      = local.zone
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
        service_account_id = "${yandex_iam_service_account.buckets-account.id}"
        description        = local.sa_key_desc
      }

      resource "yandex_kms_symmetric_key" "key-a" {
        name              = local.key_name
        description       = local.key_desc
        default_algorithm = "AES_256"
        rotation_period   = "168h"
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = local.bucket_name
        access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"
        server_side_encryption_configuration {
          rule {
          apply_server_side_encryption_by_default {
            kms_master_key_id = yandex_kms_symmetric_key.key-a.id
            sse_algorithm     = "aws:kms"
          }
        }
        }
      }
      ```

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

      1. Подтвердите создание ресурсов.

          После выполнения команды Terraform обновит или создаст в указанном каталоге следующие ресурсы:

          * Сервисный аккаунт `new-buckets-account`.
          * Роль `editor` для сервисного аккаунта `new-buckets-account`.
          * Статический ключ для сервисного аккаунта.
          * Ключ KMS с названием `bucket-key`.
          * Бакет с шифрованием.

          Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

В результате все новые объекты в бакете будут шифроваться ключом `bucket-key`.

## Отключите шифрование {#disable-encryption}

Если шифровать новые объекты в бакете больше не требуется, отключите шифрование.

{% note alert %}

После отключения шифрования уже загруженные объекты будут храниться зашифрованными. Данные в Object Storage шифруются по схеме [envelope encryption](../../kms/concepts/envelope.md). Удаление ключа равносильно уничтожению зашифрованных им данных.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится бакет.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите бакет, созданный ранее.
  1. На панели слева выберите **Безопасность**.
  1. Откройте вкладку **Шифрование**.
  1. В поле **Ключ KMS** выберите `Не выбрано`.
  1. Нажмите кнопку **Сохранить**.

- AWS CLI {#aws-cli}

  Выполните команду:

  ```bash
  aws s3api delete-bucket-encryption \
    --bucket <имя_бакета> \
    --endpoint-url=https://storage.yandexcloud.net
  ```

- Terraform {#tf}

  1. Опишите ресурсы в конфигурационном файле. Чтобы отключить шифрование, удалите или закомментируйте блок `server_side_encryption_configuration` для ресурса `yandex_storage_bucket`:

      ```
      locals {
        cloud_id    = "<идентификатор_облака>"
        folder_id   = "<идентификатор_каталога>"
        zone        = "ru-central1-a"
        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами Object Storage"
        sa_key_desc = "Статический ключ для ${local.sa_name}"
        key_name    = "bucket-key"
        key_desc    = "Ключ для шифрования бакетов"
        bucket_name = "Имя бакета"
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        cloud_id  = local.cloud_id
        folder_id = local.folder_id
        zone      = local.zone
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
        service_account_id = "${yandex_iam_service_account.buckets-account.id}"
        description        = local.sa_key_desc
      }

      resource "yandex_kms_symmetric_key" "key-a" {
        name              = local.key_name
        description       = local.key_desc
        default_algorithm = "AES_256"
        rotation_period   = "168h"
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = local.bucket_name
        access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"
        /*
          server_side_encryption_configuration {
            rule {
            apply_server_side_encryption_by_default {
              kms_master_key_id = yandex_kms_symmetric_key.key-a.id
              sse_algorithm     = "aws:kms"
            }
          }
          }
        */
      }
      ```

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

      1. Подтвердите обновление ресурсов.

          После выполнения команды Terraform обновит в указанном каталоге следующие ресурсы:

          * Сервисный аккаунт `new-buckets-account`.
          * Роль `editor` для сервисного аккаунта `new-buckets-account`.
          * Статический ключ для сервисного аккаунта.
          * Ключ KMS с названием `bucket-key`.
          * Бакет.

{% endlist %}

В результате в указанном каталоге шифрование для бакета будет отключено. Проверить изменение ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).