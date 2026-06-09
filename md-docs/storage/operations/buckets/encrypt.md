# Шифрование бакета


В Object Storage есть возможность шифровать объекты в бакете с помощью [ключей KMS](../../../kms/concepts/key.md):
* [Добавьте шифрование бакету](#add), чтобы все новые объекты шифровались указанным ключом.
* Указывайте ключ шифрования при [загрузке объекта через API](../../s3/api-ref/object/upload.md).

{% note alert %}

Данные в Object Storage шифруются по схеме [envelope encryption](../../../kms/concepts/envelope.md). Удаление ключа равносильно уничтожению зашифрованных им данных.

{% endnote %}


Чтобы работать с объектами в [зашифрованном](../../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) вместе с [ролью](../../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее см. [Сервисные роли Key Management Service](../../../kms/security/index.md#service-roles).


## Добавить шифрование бакету {#add}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы добавить ключ KMS:
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите бакет, для которого хотите настроить шифрование.
  1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **Безопасность**.
  1. Выберите вкладку **Шифрование**.
  1. В поле **Ключ KMS** выберите ключ или создайте новый:

     1. Если в каталоге еще нет ключей, нажмите кнопку **Создать ключ**. Если ключи есть, но они вам не подходят, нажмите кнопку **Создать**.
     1. Введите имя ключа.
     1. Выберите алгоритм шифрования и период ротации.
     1. Нажмите **Создать**.

  1. Нажмите **Сохранить**.

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Перед началом работы [получите IAM-токен](../../../iam/operations/iam-token/create-for-sa.md#via-cli) для сервисного аккаунта и запишите его в файл.


  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     provider "yandex" {
       cloud_id                 = "<идентификатор_облака>"
       folder_id                = "<идентификатор_каталога>"
       zone                     = "ru-central1-a"
       service_account_key_file = "key.json"
     }

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

     resource "yandex_kms_symmetric_key" "key-a" {
       name              = "<имя_ключа>"
       description       = "<описание_ключа>"
       default_algorithm = "AES_128"
       rotation_period   = "8760h" // 1 год
     }

     resource "yandex_storage_bucket" "test" {
       bucket     = "<имя_бакета>"
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
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

     Где:

     * `service_account_key_file` — путь к файлу, содержащему IAM-токен для сервисного аккаунта (или содержимое файла).
     * `default_algorithm` — алгоритм шифрования, который будет использоваться с новой [версией ключа](../../../kms/concepts/version.md). Новая версия генерируется при следующей ротации ключа. Значение по умолчанию `AES_128`.
     * `rotation_period` — [период ротации](../../../kms/concepts/version.md#rotate-key). Чтобы отключить автоматическую ротацию, не указывайте этот параметр.
     * `apply_server_side_encryption_by_default` — параметры шифрования по умолчанию на стороне сервера:
       * `kms_master_key_id` — идентификатор мастер ключа KMS, используемый для шифрования.
       * `sse_algorithm` — используемый алгоритм шифрования на стороне сервера. Поддерживается только значение `aws:kms`.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в Terraform см. в [документации провайдера](../../../terraform/resources/storage_bucket.md).

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

## Убрать шифрование бакета {#del}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы убрать шифрование, удалите ключ KMS:
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите бакет, для которого хотите убрать шифрование.
  1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **Безопасность**.
  1. Выберите вкладку **Шифрование**.
  1. В поле **Ключ KMS** выберите **Не выбрано**.
  1. Нажмите **Сохранить**.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.



  Чтобы убрать шифрование бакета, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите блок `server_side_encryption_configuration` в описании бакета.

     {% cut "Пример описания бакета в конфигурации Terraform" %}

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       bucket     = "my-bucket"
       access_key = "123JE02jKxusn********"
       secret_key = "ExamP1eSecReTKeykdo********"
       server_side_encryption_configuration { // Этот блок нужно удалить, чтобы отключить шифрование
         rule {
           apply_server_side_encryption_by_default {
             kms_master_key_id = "abjbeb2bgg4l********"
             sse_algorithm     = "aws:kms"
           }
         }
       }
     }
     ...
     ```

     {% endcut %}

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}


#### См. также {#see-also}

* [Шифрование в Object Storage](../../concepts/encryption.md)