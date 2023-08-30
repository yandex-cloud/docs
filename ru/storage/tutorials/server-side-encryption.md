# Шифрование на стороне сервера

В этом сценарии вы включите шифрование для бакета. В качестве ключа симметричного шифрования будет использоваться [ключ {{ kms-full-name }}](../../kms/concepts/key.md). Все новые объекты в бакете будут шифроваться указанным ключом по схеме [envelope encryption](../../kms/concepts/envelope.md).


Чтобы расшифровывать объекты, у пользователя бакета вместе с ролью {{ objstorage-name }} должна быть роль на чтение ключа шифрования — `kms.keys.decrypter` (см. [описание роли](../../kms/security/index.md#service-roles)).


Чтобы включить шифрование бакета на стороне сервера:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте ключ](#create-key).
1. [Включите шифрование](#enable-encryption).

Если шифровать новые объекты в бакете больше не требуется, [отключите шифрование](#disable-encryption).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета с шифрованием входит:

* плата за хранение данных в бакете (см. [тарифы {{ objstorage-name }}](../pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../pricing.md#prices-operations));
* плата за использование ключей KMS (см. [тарифы {{ kms-name }}](../../kms/pricing.md#prices)).


## Создайте бакет {#create-bucket}

Вы можете создать новый бакет или использовать существующий. Чтобы создать бакет, выполните:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета.

     Имя должно удовлетворять требованиям:

     {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

  1. Укажите максимальный размер бакета в ГБ.
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите ресурсы в конфигурационном файле. Чтобы задать параметры, в данном сценарии используется блок `locals`:

      
      ```
      locals {
        cloud_id    = "<идентификатор облака>"
        folder_id   = "<идентификатор каталога>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами {{ objstorage-name }}"
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
        token     = local.oauth
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



      Более подробную информацию о ресурсах, которые вы можете создать с помощью [{{ TF }}](https://www.terraform.io/docs/language/index.html), см. в [документации провайдера]({{ tf-provider-link }}).

  2. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.

	    1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  3. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      2. Подтвердите создание ресурсов.

          После выполнения команды {{ TF }} обновит или создаст в указанном каталоге следующие ресурсы:

          * Сервисный аккаунт `new-buckets-account`.
          * Роль `editor` для сервисного аккаунта `new-buckets-account`.
          * Статический ключ для сервисного аккаунта.
          * Бакет.

          Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

- AWS CLI

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

  1. Выполните команду:

      ```bash
      aws s3 mb s3://<имя_бакета> --endpoint-url=https://{{ s3-storage-host }}
      ```

      Результат:

      ```bash
      make_bucket: <имя_бакета>
      ```

{% endlist %}

## Создайте ключ {#create-key}

Создайте новый ключ или используйте существующий. Чтобы создать новый ключ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать ключ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}**.
  1. В открывшемся окне:

      * В поле **{{ ui-key.yacloud.common.name }}** укажите `bucket-key`.
      * В поле **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** выберите `AES-256`.
      * В поле **{{ ui-key.yacloud.kms.symmetric-key.form.field_rotation }}** выберите период [ротации](../../kms/concepts/version.md#rotate-key) `7 дней`.
      * Нажмите кнопку **{{ ui-key.yacloud.kms.symmetric-key.create.button_create }}**.

  Вместе с ключом создается его первая версия: нажмите на ключ в списке, чтобы открыть страницу с его атрибутами.

- CLI

  Выполните команду:

  ```bash
  yc kms symmetric-key create \
    --name key-1 \
    --default-algorithm aes-256 \
    --rotation-period 7d
  ```

  Где:

  * `name` — имя ключа.
  * `default-algorithm` — алгоритм шифрования: `aes-128`, `aes-192` или `aes-256`.
  * `rotation-period` — период ротации ключа. Чтобы создать ключ без автоматической ротации, не указывайте параметр `rotation-period`.

  Вместе с ключом создается его первая версия. Она указана в поле `primary_version`.

- {{ TF }}

  1. Опишите ресурсы в конфигурационном файле. Чтобы задать параметры, в данном сценарии используется блок `locals`:

      
      ```
      locals {
        cloud_id    = "<идентификатор облака>"
        folder_id   = "<идентификатор каталога>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами {{ objstorage-name }}"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        key_name    = "key-1" # Имя ключа KMS.
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
        token     = local.oauth
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

          Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание ресурсов.

          После выполнения команды {{ TF }} обновит или создаст в указанном каталоге следующие ресурсы:

          * Сервисный аккаунт `new-buckets-account`.
          * Роль `editor` для сервисного аккаунта `new-buckets-account`.
          * Статический ключ для сервисного аккаунта.
          * Ключ {{ kms-short-name }} с названием `key-1`.
          * Бакет.

          Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

- API

  Воспользуйтесь методом [create](../../kms/api-ref/SymmetricKey/create.md) для ресурса `SymmetricKey`.

{% endlist %}

## Включите шифрование {#enable-encryption}

Чтобы включить шифрование бакета ключом {{ kms-short-name }}, выполните следующее:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, созданный ранее.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** выберите ключ `key-1`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- {{ TF }}

  1. Опишите ресурсы в конфигурационном файле. Чтобы задать параметры, в данном сценарии используется блок `locals`:

      
      ```
      locals {
        cloud_id    = "<идентификатор облака>"
        folder_id   = "<идентификатор каталога>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами {{ objstorage-name }}"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        key_name    = "key-1" # Имя ключа KMS.
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
        token     = local.oauth
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

          Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание ресурсов.

          После выполнения команды {{ TF }} обновит или создаст в указанном каталоге следующие ресурсы:

          * Сервисный аккаунт `new-buckets-account`.
          * Роль `editor` для сервисного аккаунта `new-buckets-account`.
          * Статический ключ для сервисного аккаунта.
          * Ключ {{ kms-short-name }} с названием `key-1`.
          * Бакет с шифрованием.

          Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

          В результате успешного выполнения команды все новые объекты в бакете будут шифроваться ключом `key-1`.

- AWS CLI

  Выполните команду:

  ```
  aws s3api put-bucket-encryption \
    --bucket <имя_бакета> \
    --endpoint-url=https://{{ s3-storage-host }} \
    --server-side-encryption-configuration '{
	  "Rules": [
	    {
		  "ApplyServerSideEncryptionByDefault": {
		    "SSEAlgorithm": "aws:kms",
		    "KMSMasterKeyID": "<идентификатор ключа KMS>"
		  },
		  "BucketKeyEnabled": true
		}
	  ]
	}'
  ```

  В результате успешного выполнения команды все новые объекты в бакете будут шифроваться ключом `key-1`.

{% endlist %}

## Отключите шифрование {#disable-encryption}

Если шифровать новые объекты в бакете больше не требуется, отключите шифрование.

{% note alert %}

После отключения шифрования уже загруженные объекты будут храниться зашифрованными. Данные в {{ objstorage-name }} шифруются по схеме [envelope encryption](../../kms/concepts/envelope.md). Удаление ключа равносильно уничтожению зашифрованных им данных.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, созданный ранее.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** выберите **{{ ui-key.yacloud.component.symmetric-key-select.label_no-symmetric-key }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- {{ TF }}

  1. Опишите ресурсы в конфигурационном файле. Чтобы отключить шифрование, удалите или закомментируйте блок `server_side_encryption_configuration` для ресурса `yandex_storage_bucket`:

      
      ```
      locals {
        cloud_id    = "<идентификатор облака>"
        folder_id   = "<идентификатор каталога>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами {{ objstorage-name }}"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        key_name    = "key-1"
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
        token     = local.oauth
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

          Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите обновление ресурсов.

          После выполнения команды {{ TF }} обновит в указанном каталоге следующие ресурсы:

          * Сервисный аккаунт `new-buckets-account`.
          * Роль `editor` для сервисного аккаунта `new-buckets-account`.
          * Статический ключ для сервисного аккаунта.
          * Ключ {{ kms-short-name }} с названием `key-1`.
          * Бакет.

          В указанном каталоге шифрование для бакета будет отключено. Проверить изменение ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- AWS CLI

  Выполните команду:

  ```bash
  aws s3api delete-bucket-encryption \
    --bucket <имя_бакета> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  В результате успешного выполнения шифрование в бакете будет отключено.

{% endlist %}
