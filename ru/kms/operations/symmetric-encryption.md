# Симметричное шифрование данных

В этом разделе вы узнаете, как в {{ kms-short-name }} шифровать и расшифровывать данные небольшого размера (до 32 КБ) с помощью CLI, {{ TF }} и API по схеме [симметричного шифрования](../concepts/symmetric-encryption.md). Подробнее о возможных способах шифрования читайте в разделе [{#T}](../tutorials/encrypt/index.md)

## Перед началом работы {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

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

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-encryption](../../_includes/kms/terraform-encryption.md) %}

- API {#api}

  Чтобы зашифровать данные, воспользуйтесь методом REST API [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt.md) для ресурса [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/Encrypt](../../kms/api-ref/grpc/SymmetricCrypto/encrypt.md).

- SDK {{ yandex-cloud }} {#sdk-yc}

  {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK {#sdk-aws}

  {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}

- Google Tink {#google-tink}

  {% include [tink](../../_includes/kms/google-encypt.md) %}

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

  Чтобы расшифровать данные, воспользуйтесь методом REST API [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt.md) для ресурса [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/Decrypt](../../kms/api-ref/grpc/SymmetricCrypto/decrypt.md).

- SDK {{ yandex-cloud }} {#sdk-yc}

  {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK {#sdk-aws}

  {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}

- Google Tink {#google-tink}

  {% include [tink](../../_includes/kms/google-encypt.md) %}

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
  yc kms symmetric-crypto re-encrypt \
    --id <идентификатор_ключа> \
    --ciphertext-file ciphertext-file \
    --source-key-id <идентификатор_исходного_ключа> \
    --source-ciphertext-file source-ciphertext-file
  ```

- API {#api}

  Чтобы сменить ключ или версию ключа шифрования данных, воспользуйтесь методом REST API [reEncrypt](../../kms/api-ref/SymmetricCrypto/reEncrypt.md) для ресурса [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/ReEncrypt](../../kms/api-ref/grpc/SymmetricCrypto/reEncrypt.md).

{% endlist %}

## Сгенерируйте ключ шифрования данных {#generate-data-key}

У метода `encrypt` есть ограничение на размер данных — 32 КБ. Большие объемы шифруют по схеме [envelope encryption](../concepts/envelope.md): данные шифруются локально ключом шифрования данных (DEK), а сам DEK шифруется ключом {{ kms-short-name }} и хранится рядом с шифртекстом.

{{ kms-short-name }} умеет сгенерировать DEK и сразу вернуть его в двух видах: в открытом и в зашифрованном ключом {{ kms-short-name }}. Открытый DEK используют для локального шифрования и уничтожают сразу после, зашифрованный сохраняют вместе с данными.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для генерации ключа шифрования данных:

     ```bash
     yc kms symmetric-crypto generate-data-key --help
     ```

  1. Сгенерируйте ключ:

     ```bash
     yc kms symmetric-crypto generate-data-key \
       --id <идентификатор_ключа> \
       --data-key-spec AES_256 \
       --data-key-plaintext-file data-key-plaintext-file \
       --data-key-ciphertext-file data-key-ciphertext-file
     ```

     Где:

     * `--id` — идентификатор [ключа KMS](../concepts/key.md), которым будет зашифрован DEK. Вместо него можно указать `--name` с именем ключа.
     * `--version-id` — (опционально) [версия](../concepts/version.md) ключа KMS. По умолчанию используется основная.
     * `--data-key-spec` — алгоритм генерируемого DEK: `AES_128`, `AES_192` или `AES_256`.
     * `--data-key-plaintext-file` — выходной файл с открытым DEK.
     * `--data-key-ciphertext-file` — выходной файл с зашифрованным DEK.
     * `--aad-context-file` — (опционально) входной файл с [AAD-контекстом](../concepts/symmetric-encryption.md#add-context).
     * `--skip-plaintext` — (опционально) не записывать открытый DEK. По умолчанию он возвращается.

  {% note warning %}

  Не сохраняйте открытый DEK надолго. Расшифровывайте его только на время шифрования или расшифрования данных и уничтожайте сразу после. Подробнее в разделе [{#T}](../concepts/envelope.md#specify).

  {% endnote %}

- API {#api}

  Чтобы сгенерировать ключ шифрования данных, воспользуйтесь методом REST API [generateDataKey](../../kms/api-ref/SymmetricCrypto/generateDataKey.md) для ресурса [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/GenerateDataKey](../../kms/api-ref/grpc/SymmetricCrypto/generateDataKey.md) и передайте в запросе:

  * идентификатор ключа {{ kms-short-name }} в параметре `keyId`;
  * алгоритм генерируемого ключа в параметре `dataKeySpec`;
  * (опционально) AAD-контекст в параметре `aadContext`;
  * (опционально) `skipPlaintext` со значением `true`, чтобы в ответе не было открытого ключа.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Интерфейс командной строки CLI](../../cli)
* [Симметричное шифрование в {{ kms-full-name }}](../concepts/symmetric-encryption.md)
* [Асимметричное шифрование в {{ kms-full-name }}](../concepts/asymmetric-encryption.md)
* [Управление ключами в KMS](./index.md)
* [Шифрование секретов в HashiCorp Terraform](../../kms/tutorials/terraform-secret.md)
