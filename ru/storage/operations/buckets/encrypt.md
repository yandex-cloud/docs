# Шифрование бакета

В {{ objstorage-short-name }} есть возможность шифровать объекты в бакете с помощью [ключей {{ kms-short-name }}](../../../kms/concepts/key.md):
* [Добавьте шифрование бакету](#add), чтобы все новые объекты шифровались указанным ключом.
* Указывайте ключ шифрования при [загрузке объекта через API](../../s3/api-ref/object/upload.md).

{% note alert %}

Данные в {{ objstorage-short-name }} шифруются по схеме [envelope encryption](../../../kms/concepts/envelope.md). Удаление ключа равносильно уничтожению зашифрованных им данных.

{% endnote %}


Чтобы расшифровывать объекты, у пользователя бакета вместе с ролью {{ objstorage-name }} должна быть роль на чтение ключа шифрования — `kms.keys.decrypter` (см. [описание роли](../../../kms/security/index.md#service)).


## Добавить шифрование бакету {#add}

{% list tabs %}

- Консоль управления

  Чтобы добавить ключ {{ kms-short-name }}:
  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите настроить шифрование.
  1. В левой панели выберите **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** выберите ключ или создайте новый:

     {% include [storage-create-kms](../../_includes_service/storage-create-kms.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Перед началом работы [получите IAM-токен](../../../iam/operations/iam-token/create-for-sa.md#via-cli) для сервисного аккаунта и запишите его в файл.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     
     ```
     provider "yandex" {
       cloud_id                 = "<идентификатор облака>"
       folder_id                = "<идентификатор каталога>"
       zone                     = "{{ region-id }}-a"
       service_account_key_file = "key.json"
       }


     resource "yandex_kms_symmetric_key" "key-a" {
       name              = "<имя ключа>"
       description       = "<описание ключа>"
       default_algorithm = "AES_128"
       rotation_period   = "8760h" // 1 год
     }

     resource "yandex_storage_bucket" "test" {
       bucket     = "<имя бакета>"
       access_key = "<идентификатор статического ключа>"
       secret_key = "<секретный ключ>"
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

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:
        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

     ```
     terraform apply
     ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Убрать шифрование бакета {#del}

{% list tabs %}

- Консоль управления

  Чтобы убрать шифрование, удалите ключ {{ kms-short-name }}:
  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите удалить шифрование.
  1. В левой панели выберите **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** выберите **{{ ui-key.yacloud.component.symmetric-key-select.label_no-symmetric-key }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы убрать шифрование бакета, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите блок `server_side_encryption_configuration` в описании бакета.

     {% cut "Пример описания бакета в конфигурации {{ TF }}" %}

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

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../concepts/encryption.md)
