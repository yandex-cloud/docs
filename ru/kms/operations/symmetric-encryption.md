# Симметричное шифрование данных

В этом разделе вы узнаете, как в {{ kms-short-name }} шифровать и расшифровывать данные небольшого размера (до 32 КБ) с помощью CLI и API по схеме [симметричного шифрования](../concepts/symmetric-encryption.md). Подробнее о возможных способах шифрования читайте в разделе [{#T}](../tutorials/encrypt/index.md)

## Перед началом работы {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

## Зашифруйте данные {#encryption}

{% list tabs %}

- CLI
     
  Команда зашифрует открытый текст, переданный в файле `--plaintext-file`, и запишет полученный шифртекст в файл `--ciphertext-file`.

  * `--id` —  идентификатор [ключа KMS](../concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
  * `--name` — название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
  * `--version-id` — (опционально) [версия](../concepts/version.md) ключа KMS, которая будет использоваться для шифрования. По умолчанию используется основная.
  * `--plaintext-file` — входной файл с открытым текстом.
  * `--aad-context-file` — (опционально) входной файл с [AAD-контекстом](../concepts/symmetric-encryption.md#add-context).
  * `--ciphertext-file` — выходной файл с шифртекстом.

  ```
  yc kms symmetric-crypto encrypt \
    --id abj76v82fics******** \
    --plaintext-file plaintext-file \
    --ciphertext-file ciphertext-file
  ```
    
- API 

  Чтобы зашифровать данные, воспользуйтесь методом REST API [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt.md) для ресурса [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/Encrypt](../../kms/api-ref/grpc/symmetric_crypto_service.md#Encrypt).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-encryption](../../_includes/kms/terraform-encryption.md) %}

- SDK {{ yandex-cloud }}

  {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK

  {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}
    
- Google Tink

  {% include [tink](../../_includes/kms/google-encypt.md) %}


{% endlist %}

## Расшифруйте данные {#decryption}

{% list tabs %}

- CLI

  Команда расшифрует шифртекст, переданный в файле `--ciphertext-file`, и запишет полученный открытый текст в файл `--plaintext-file`:

  * `--id` — идентификатор [ключа KMS](../concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
  * `--name` — название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
  * `--ciphertext-file` — входной файл с открытым текстом.
  * `--aad-context-file` — (опционально) входной файл с [AAD-контекстом](../concepts/symmetric-encryption.md#add-context).
  * `--plaintext-file` — выходной файл с шифртекстом.

  ```
  yc kms symmetric-crypto decrypt \
    --id abj76v82fics******** \
    --ciphertext-file ciphertext-file \
    --plaintext-file decrypted-file
  ```

- API 

  Чтобы расшифровать данные, воспользуйтесь методом REST API [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt.md) для ресурса [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/Decrypt](../../kms/api-ref/grpc/symmetric_crypto_service.md#Decrypt).

- SDK {{ yandex-cloud }}

  {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK

  {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}
    
- Google Tink

  {% include [tink](../../_includes/kms/google-encypt.md) %}

    
{% endlist %}


#### См. также {#see-also}

* [Интерфейс командной строки YC CLI](../../cli).
* [Симметричное шифрование в {{ kms-full-name }}](../concepts/symmetric-encryption.md).
* [Асимметричное шифрование в {{ kms-full-name }}](../concepts/asymmetric-encryption.md).
* [Управление ключами в KMS](./index.md).
* [Шифрование секретов в Hashicorp Terraform](../../kms/tutorials/terraform-secret.md).
