# Управление ключами KMS с HashiCorp Terraform

# Управление ключами Yandex Key Management Service с HashiCorp Terraform

[Terraform-провайдер](../../terraform/index.md) для Yandex Cloud поддерживает работу с ключами Yandex Key Management Service.

## Добавление ключа {#add}

Чтобы создать новый ключ:

1. Опишите в конфигурационном файле параметры ресурса `yandex_kms_symmetric_key`:

   ```hcl
   resource "yandex_kms_symmetric_key" "key-a" {
     name                = "<имя_ключа>"
     description         = "<описание_ключа>"
     default_algorithm   = "AES_128"
     rotation_period     = "8760h"
     deletion_protection = true
     lifecycle {
       prevent_destroy = true
     }
   }
   ```

   Где:

   * `name` — имя ключа. Формат имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

   * `description` — описание ключа.
   * `default_algorithm` — алгоритм шифрования. Возможные значения: `AES-128`, `AES-192` или `AES-256`.
   * `rotation_period` — период [ротации](../concepts/version.md#rotate-key) (частота смены версии ключа по умолчанию). Чтобы создать ключ без автоматической ротации, не указывайте параметр `rotation_period`.
   * `deletion_protection` — защита от удаления ключа. Чтобы создать ключ без защиты от удаления, не указывайте параметр `deletion_protection`.
   * `lifecycle.prevent_destroy` — защита от удаления ключа при выполнении команд Terraform. Чтобы создать ключ без такой защиты, не указывайте блок `lifecycle`.

   {% note warning %}

   Удаление ключа KMS равносильно уничтожению всех зашифрованных с его помощью данных — без ключа восстановить данные не получится. Параметр `deletion_protection` и блок `lifecycle` необходимы, чтобы обезопасить ключ от удаления (например, командой `terraform destroy`).

   {% endnote %}

   Более подробную информацию о параметрах ресурсов в Terraform см. в [документации провайдера](../../terraform/resources/kms_symmetric_key.md).

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

   В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

1. Примените изменения конфигурации:

   ```bash
   terraform apply
   ```

1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

   После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команд [CLI](../../cli/quickstart.md):

   ```bash
   yc kms symmetric-key list
   ```

## Управление доступом к ключу {#security}

Для управления доступом к ключу через Terraform назначьте необходимые роли на каталог, содержащий ключ. 

Например, [назначьте](../../iam/operations/sa/assign-role-for-sa.md) на сервисный аккаунт роль `kms.keys.encrypterDecrypter`, дающую права шифровать и расшифровывать данные ключами из определенного каталога:

```hcl
resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = "<идентификатор_каталога>"
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:<идентификатор_сервисного_аккаунта>"
}
```

## См. также {#see-also}

* [Начало работы с Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Управление доступом в Key Management Service](../security/index.md).
* [Документация провайдера Yandex Cloud](../../terraform/index.md).
* [Шифрование данных с помощью CLI и API Yandex Cloud](../operations/key.md).