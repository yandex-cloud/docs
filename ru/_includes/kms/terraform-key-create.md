Чтобы создать новый ключ:

1. Опишите в конфигурационном файле параметры ресурса `yandex_kms_symmetric_key`:

   ```hcl
   resource "yandex_kms_symmetric_key" "key-a" {
     name              = "<имя_ключа>"
     description       = "<описание_ключа>"
     default_algorithm = "AES_128"
     rotation_period   = "8760h"
     lifecycle {
       prevent_destroy = true
     }
   }
   ```

   Где:

   * `name` — имя ключа. Формат имени:

      {% include [name-format](../../_includes/name-format.md) %}

   * `description` — описание ключа.
   * `default_algorithm` — алгоритм шифрования. Возможные значения: `AES-128`, `AES-192` или `AES-256`.
   * `rotation_period` — период [ротации](../../kms/concepts/version.md#rotate-key) (частота смены версии ключа по умолчанию). Чтобы создать ключ без автоматической ротации, не указывайте параметр `rotation_period`.

   {% note warning %}

   Удаление ключа {{ kms-short-name }} равносильно уничтожению всех зашифрованных с его помощью данных — без ключа восстановить данные не получится. Блок `lifecycle` необходим, чтобы обезопасить ключ от удаления (например, командой `terraform destroy`).

   {% endnote %}

   Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/kms_symmetric_key).

1. Проверьте конфигурацию командой:

   ```bash
   terraform validate
   ```

   Если конфигурация является корректной, появится сообщение:

   ```text
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

   После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

   ```bash
   yc kms symmetric-key list
   ```
