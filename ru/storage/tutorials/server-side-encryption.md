# Шифрование на стороне сервера

В этом сценарии вы включите шифрование для бакета. В качестве ключа симметричного шифрования будет использоваться {% if audience != "internal" %}[ключ {{ kms-full-name }}](../../kms/concepts/key.md){% else %}ключ {{ kms-full-name }}{% endif %}. Все новые объекты в бакете будут шифроваться указанным ключом по схеме {% if audience != "internal" %}[envelope encryption](../../kms/concepts/envelope.md){% else %}envelope encryption{% endif %}.

{% if audience != "internal" %}

Чтобы расшифровывать объекты, у пользователя бакета вместе с ролью {{ objstorage-name }} должна быть роль на чтение ключа шифрования — `kms.keys.encrypterDecrypter` (см. [описание роли](../../kms/security/index.md#service)).

{% endif %}

Чтобы включить шифрование бакета на стороне сервера:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Создайте ключ](#create-key).
1. [Включите шифрование](#enable-encryption).

Если шифровать новые объекты в бакете больше не требуется, [отключите шифрование](#disable-encryption).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" and audience != "internal" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки бакета с шифрованием входит:

* плата за хранение данных в бакете (см. [тарифы {{ objstorage-name }}](../pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-name }}](../pricing.md#prices-operations));
* плата за использование ключей KMS (см. {% if audience != "internal" %}[тарифы {{ kms-name }}](../../kms/pricing.md#prices){% else %}тарифы {{ kms-name }}{% endif %}).

{% endif %}

## Создайте бакет {#create-bucket}

Вы можете создать новый бакет или использовать существующий. Чтобы создать бакет, выполните:

{% list tabs %}

- Консоль управления

  1. Перейдите в [консоль управления]({{ link-console-main }}) и выберите каталог, в котором будете выполнять операции.
  1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Бакет**.
  1. В поле **Имя** введите имя бакета, например, `example-bucket`.

     Имя должно удовлетворять требованиям:

     {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

  1. Укажите максимальный размер бакета в ГБ.
  1. Выберите **Ограниченный** доступ к бакету.
  1. Нажмите кнопку **Создать бакет**.

- {{ TF }}

  Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его и настройте провайдер {{ yandex-cloud }}{% endif %}.

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

        bucket_name = "example-bucket" # Имя создаваемого бакета. Если не задавать имя бакета для ресурса `yandex_storage_bucket`, имя будет сгенерировано автоматически.
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

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      locals {
        cloud_id    = "<идентификатор облака>"
        folder_id   = "<идентификатор каталога>"
        oauth       = "<статический ключ сервисного аккаунта>"
        endpoint    = "{{ api-host }}:443"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами {{ objstorage-name }}"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        bucket_name = "example-bucket" # Имя создаваемого бакета. Если не задавать имя бакета для ресурса `yandex_storage_bucket`, имя будет сгенерировано автоматически.
      }

      terraform {
        required_providers {
          yandex = {
          source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        token            = local.oauth
        cloud_id         = local.cloud_id
        folder_id        = local.folder_id
        zone             = local.zone
        endpoint         = local.endpoint
        storage_endpoint = "{{ s3-storage-host }}"
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

        resource "yandex_resourcemanager_folder_iam_binding" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        members   = [
          "serviceAccount:${yandex_iam_service_account.buckets-account.id}",
        ]
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

      {% endif %}

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
          * Бакет с названием `example-bucket`.

          Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

- AWS CLI

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

  1. Выполните команду:

      ```bash
      aws s3 mb s3://example-bucket --endpoint-url=https://{{ s3-storage-host }}
      ```

      Результат:

      ```bash
      make_bucket: example-bucket
      ```

{% endlist %}

## Создайте ключ {#create-key}

Создайте новый ключ или используйте существующий. Чтобы создать новый ключ:

{% list tabs %}

- Консоль управления

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ kms-name }}**.
  1. На вкладке **Ключи** нажмите кнопку **Создать** и задайте атрибуты ключа:

      * Имя и опциональное описание в свободной форме, например, `key-1` и `bucket-key`.
      * Алгоритм шифрования, например `AES-256`.
      * Период {% if audience != "internal" %}[ротации](../../kms/concepts/version.md#rotate-key){% else %}ротации{% endif %}, например, `7 дней`.
      * Нажмите кнопку **Создать**.

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

        bucket_name = "example-bucket"
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

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      locals {
        cloud_id         = "<идентификатор облака>"
        folder_id        = "<идентификатор каталога>"
        oauth            = "<статический ключ сервисного аккаунта>"
        endpoint         = "{{ api-host }}:443"
        zone             = "{{ region-id }}-a"
        storage_endpoint = "{{ s3-storage-host }}"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами {{ objstorage-name }}"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        key_name    = "key-1" # Имя ключа KMS.
        key_desc    = "Ключ для шифрования бакетов"

        bucket_name = "example-bucket"
      }

      terraform {
        required_providers {
          yandex = {
          source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        token            = local.oauth
        cloud_id         = local.cloud_id
        folder_id        = local.folder_id
        zone             = local.zone
        endpoint         = local.endpoint
        storage_endpoint = local.storage_endpoint
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_binding" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        members   = [
          "serviceAccount:${yandex_iam_service_account.buckets-account.id}",
        ]
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

      {% endif %}

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
          * Бакет `example-bucket`.

          Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

- API

  Воспользуйтесь методом {% if audience != "internal" %}[create](../../kms/api-ref/SymmetricKey/create.md){% else %}create{% endif %} для ресурса `SymmetricKey`.

{% endlist %}

## Включите шифрование {#enable-encryption}

Чтобы включить шифрование бакета ключом {{ kms-short-name }}, выполните следующее:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет `example-bucket`.
  1. В левой панели выберите **Шифрование**.
  1. В поле **Ключ {{ kms-short-name }}** выберите ключ `key-1`.
  1. Нажмите кнопку **Сохранить**.

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

        bucket_name = "example-bucket" # Имя бакета.
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
        members   = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
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

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      locals {
        cloud_id         = "<идентификатор облака>"
        folder_id        = "<идентификатор каталога>"
        oauth            = "<статический ключ сервисного аккаунта>"
        endpoint         = "{{ api-host }}:443"
        zone             = "{{ region-id }}-a"
        storage_endpoint = "{{ s3-storage-host }}"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами {{ objstorage-name }}"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        key_name    = "key-1" # Имя ключа KMS.
        key_desc    = "Ключ для шифрования бакетов"

        bucket_name = "example-bucket" # Имя бакета.
      }

      terraform {
        required_providers {
          yandex = {
          source = "yandex-cloud/yandex"
        }
        }
      }

      provider "yandex" {
        token            = local.oauth
        cloud_id         = local.cloud_id
        folder_id        = local.folder_id
        zone             = local.zone
        endpoint         = local.endpoint
        storage_endpoint = local.storage_endpoint
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_binding" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        members   = [
          "serviceAccount:${yandex_iam_service_account.buckets-account.id}",
        ]
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

      {% endif %}

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
          * Бакет `example-bucket` с шифрованием.

          Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

          В результате успешного выполнения команды все новые объекты в бакете `example-bucket` будут шифроваться ключом `key-1`.

- AWS CLI

  Выполните команду:

  ```
  aws s3api put-bucket-encryption \
    --bucket example-bucket \
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

  В результате успешного выполнения команды все новые объекты в бакете `example-bucket` будут шифроваться ключом `key-1`.

{% endlist %}

## Отключите шифрование {#disable-encryption}

Если шифровать новые объекты в бакете больше не требуется, отключите шифрование.

{% note alert %}

После отключения шифрования уже загруженные объекты будут храниться зашифрованными. Данные в {{ objstorage-name }} шифруются по схеме {% if audience != "internal" %}[envelope encryption](../../kms/concepts/envelope.md){% else %}envelope encryption{% endif %}. Удаление ключа равносильно уничтожению зашифрованных им данных.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет `example-bucket`.
  1. В левой панели выберите **Шифрование**.
  1. В поле **Ключ {{ kms-short-name }}** задайте **Не выбрано**.
  1. Нажмите кнопку **Сохранить**.

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

        bucket_name = "example-bucket"
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

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      locals {
        cloud_id         = "<идентификатор облака>"
        folder_id        = "<идентификатор каталога>"
        oauth            = "<статический ключ сервисного аккаунта>"
        endpoint         = "{{ api-host }}:443"
        zone             = "{{ region-id }}-a"
        storage_endpoint = "{{ s3-storage-host }}"

        sa_name     = "new-buckets-account"
        sa_desc     = "Аккаунт для управления бакетами {{ objstorage-name }}"
        sa_key_desc = "Статический ключ для ${local.sa_name}"

        key_name    = "key-1"
        key_desc    = "Ключ для шифрования бакетов"

        bucket_name = "example-bucket"
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        token            = local.oauth
        cloud_id         = local.cloud_id
        folder_id        = local.folder_id
        zone             = local.zone
        endpoint         = local.endpoint
        storage_endpoint = local.storage_endpoint
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_binding" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        members   = [
          "serviceAccount:${yandex_iam_service_account.buckets-account.id}",
        ]
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

      {% endif %}

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
          * Бакет `example-bucket`.

          В указанном каталоге шифрование для бакета `example-bucket` будет отключено. Проверить изменение ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- AWS CLI

  Выполните команду:

  ```bash
  aws s3api delete-bucket-encryption \
    --bucket example-bucket \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  В результате успешного выполнения шифрование в бакете `example-bucket` будет отключено.

{% endlist %}
