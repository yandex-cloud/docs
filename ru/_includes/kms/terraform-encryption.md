Чтобы зашифровать данные:

1. Опишите в конфигурационном файле параметры ресурса `yandex_kms_secret_ciphertext` с указанием на [ключ {{ kms-short-name }}](../../kms/concepts/key.md) в поле `key_id`:

   ```hcl
   resource "yandex_kms_secret_ciphertext" "password" {
     key_id      = "<идентификатор ключа>"
     aad_context = "additional authenticated data"
     plaintext   = "strong password"
   }
   ```

   Где:

   * `key_id` — идентификатор ключа {{ kms-short-name }}.
   * `aad_context` — ([AAD-контекст](../../kms/concepts/encryption.md#add-context)).
   * `plaintext` — строка, которую нужно зашифровать.

   {% note warning %}

   Использование `yandex_kms_secret_ciphertext` позволяет скрыть секреты при разворачивании инфраструктуры, но в общем случае указание `plaintext` и `aad_context` в конфигурационном файле в открытом виде небезопасно. Секреты могут быть прочитаны из файла конфигурации, могут попасть в {{ TF }}-state или могут быть прочитаны из логов выполнения.

   {% endnote %}

   Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/kms_secret_ciphertext).

1. Проверьте конфигурацию командой:

   ```
   terraform validate
   ```
  
   Если конфигурация является корректной, появится сообщение:
  
   ```
   Success! The configuration is valid.
   ```

1. Выполните команду:

   ```
   terraform plan
   ```

   В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

1. Примените изменения конфигурации:

   ```
   terraform apply
   ```
  
1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

   После этого доступ к шифртексту можно получить через переменную `ciphertext`, а к зашифрованным данным — `plaintext`.


   Для проверки вы можете добавить в файл конфигурации следующий код с выходной переменной `decrypted_pass`.

   {% note alert %}
   
   Это небезопасно и может быть использовано только для тестирования.

   {% endnote %}

   ```hcl
   output "decrypted_pass" {
     sensitive = true
     value     = yandex_kms_secret_ciphertext.password.plaintext
   }
   ```

   После обновления конфигурации можно проверить зашифрованные данные командой:

   ```hcl
   terraform output decrypted_pass
   ```

   Результат:
   
   ```
   "strong password"
   ```

   {% endnote %}

