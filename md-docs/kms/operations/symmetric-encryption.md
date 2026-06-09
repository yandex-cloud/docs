# Симметричное шифрование данных

В этом разделе вы узнаете, как в {{ kms-short-name }} шифровать и расшифровывать данные небольшого размера (до 32 КБ) с помощью CLI, {{ TF }} и API по схеме [симметричного шифрования](../concepts/symmetric-encryption.md). Подробнее о возможных способах шифрования читайте в разделе [{#T}](../tutorials/encrypt/index.md)

## Перед началом работы {#before-you-begin}

Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

## Зашифруйте данные {#encryption}

{% note info %}

Изменения, вызванные [eventually consistent операциями](../concepts/consistency.md), становятся применимыми для шифрования с задержкой до трех часов.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Команда зашифрует открытый текст, переданный в файле `--plaintext-file`, и запишет полученный шифртекст в файл `--ciphertext-file`.

  * `--id` —  идентификатор [ключа KMS](../concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
  * `--name` — название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
  * `--version-id` — (опционально) [версия](../concepts/version.md) ключа KMS, которая будет использоваться для шифрования. По умолчанию используется основная.
  * `--plaintext-file` — входной файл с открытым текстом.
  * `--aad-context-file` — (опционально) входной файл с [AAD-контекстом](../concepts/symmetric-encryption.md#add-context).
  * `--ciphertext-file` — выходной файл с шифртекстом.

  ```bash
  yc kms symmetric-crypto encrypt \
    --id abj76v82fics******** \
    --plaintext-file plaintext-file \
    --ciphertext-file ciphertext-file
  ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы зашифровать данные:
  
  1. Опишите в конфигурационном файле параметры ресурса `yandex_kms_secret_ciphertext` с указанием на [ключ {{ kms-short-name }}](../concepts/key.md) в поле `key_id`:
  
     ```hcl
     resource "yandex_kms_secret_ciphertext" "password" {
       key_id      = "<идентификатор_ключа>"
       aad_context = "additional authenticated data"
       plaintext   = "strong password"
     }
     ```
  
     Где:
  
     * `key_id` — идентификатор ключа {{ kms-short-name }}.
     * `aad_context` — ([AAD-контекст](../concepts/symmetric-encryption.md#add-context)).
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

- API {#api}

  Чтобы зашифровать данные, воспользуйтесь методом REST API [encrypt](../api-ref/SymmetricCrypto/encrypt.md) для ресурса [SymmetricCrypto](../api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/Encrypt](../api-ref/grpc/SymmetricCrypto/encrypt.md).

- SDK {{ yandex-cloud }} {#sdk-yc}

  О том, как шифровать и расшифровывать данные с помощью SDK {{ yandex-cloud }} читайте в разделе [{#T}](../tutorials/encrypt/sdk.md).

- AWS Encryption SDK {#sdk-aws}

  О том, как шифровать и расшифровывать данные с помощью [AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html) читайте в разделе [{#T}](../tutorials/encrypt/aws-encryption-sdk.md).

- Google Tink {#google-tink}

  О том, как шифровать и расшифровывать данные с помощью [Google Tink](https://github.com/google/tink) читайте в разделе [{#T}](../tutorials/encrypt/google-tink.md).

{% endlist %}

## Расшифруйте данные {#decryption}

{% note info %}

Изменения, вызванные [eventually consistent операциями](../concepts/consistency.md), становятся применимыми для расшифрования с задержкой до трех часов.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Команда расшифрует шифртекст, переданный в файле `--ciphertext-file`, и запишет полученный открытый текст в файл `--plaintext-file`:

  * `--id` — идентификатор [ключа KMS](../concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
  * `--name` — название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
  * `--ciphertext-file` — входной файл с шифртекстом.
  * `--aad-context-file` — (опционально) входной файл с [AAD-контекстом](../concepts/symmetric-encryption.md#add-context).
  * `--plaintext-file` — выходной файл с открытым текстом.

  ```bash
  yc kms symmetric-crypto decrypt \
    --id abj76v82fics******** \
    --ciphertext-file ciphertext-file \
    --plaintext-file decrypted-file
  ```

- API {#api}

  Чтобы расшифровать данные, воспользуйтесь методом REST API [decrypt](../api-ref/SymmetricCrypto/decrypt.md) для ресурса [SymmetricCrypto](../api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/Decrypt](../api-ref/grpc/SymmetricCrypto/decrypt.md).

- SDK {{ yandex-cloud }} {#sdk-yc}

  О том, как шифровать и расшифровывать данные с помощью SDK {{ yandex-cloud }} читайте в разделе [{#T}](../tutorials/encrypt/sdk.md).

- AWS Encryption SDK {#sdk-aws}

  О том, как шифровать и расшифровывать данные с помощью [AWS Encryption SDK](https://docs.aws.amazon.com/encryption-sdk/latest/developer-guide/introduction.html) читайте в разделе [{#T}](../tutorials/encrypt/aws-encryption-sdk.md).

- Google Tink {#google-tink}

  О том, как шифровать и расшифровывать данные с помощью [Google Tink](https://github.com/google/tink) читайте в разделе [{#T}](../tutorials/encrypt/google-tink.md).

{% endlist %}

## Смените ключ шифрования данных {#reencryption}

{% note info %}

Изменения, вызванные [eventually consistent операциями](../concepts/consistency.md), становятся применимыми для смены ключа шифрования с задержкой до трех часов.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Команда расшифрует шифртекст, переданный в файле `--source-ciphertext-file`, зашифрует его другим ключом или другой версией исходного ключа и запишет в файл `--ciphertext-file`.

  * `--id` или `--name` — идентификатор или имя нового [ключа KMS](../concepts/key.md), который будет использоваться для шифрования.

    {% note info %}

    * Чтобы использовать другой ключ, укажите флаг `--id` или `--name`.

    * Чтобы сменить только версию ключа, не указывайте ни `--id`, ни `--name`.

    {% endnote %}

  * `--version-id` — (опционально) [версия](../concepts/version.md) ключа KMS, которая будет использоваться для шифрования. По умолчанию используется основная.
  * `--aad-context-file` — (опционально) выходной файл с [AAD-контекстом](../concepts/symmetric-encryption.md#add-context).
  * `--ciphertext-file` — выходной файл с шифртекстом.
  * `--source-key-id` — идентификатор ключа {{ kms-name }}, использованного для шифрования исходного текста.
  * `--source-aad-context-file` — (опционально) входной файл с AAD-контекстом.
  * `--source-ciphertext-file` — входной файл с шифртекстом.

  ```bash
  yc kms symmetric-crypto reencrypt \
    --id <идентификатор_ключа> \
    --ciphertext-file ciphertext-file
    --source-key-id <идентификатор_исходного_ключа> \
    --source-ciphertext-file source-ciphertext-file
  ```

- API {#api}

  Чтобы сменить ключ или версию ключа шифрования данных, воспользуйтесь методом REST API [reEncrypt](../api-ref/SymmetricCrypto/reEncrypt.md) для ресурса [SymmetricCrypto](../api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/ReEncrypt](../api-ref/grpc/SymmetricCrypto/reEncrypt.md).

{% endlist %}

#### См. также {#see-also}

* [Интерфейс командной строки CLI](../../cli/index.md).
* [Симметричное шифрование в {{ kms-full-name }}](../concepts/symmetric-encryption.md).
* [Асимметричное шифрование в {{ kms-full-name }}](../concepts/asymmetric-encryption.md).
* [Управление ключами в KMS](index.md).
* [Шифрование секретов в HashiCorp Terraform](../tutorials/terraform-secret.md).