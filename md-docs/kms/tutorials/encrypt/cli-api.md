[Документация Yandex Cloud](../../../index.md) > [Yandex Key Management Service](../../index.md) > [Практические руководства](../index.md) > [Шифрование данных](index.md) > Шифрование с помощью CLI и API Yandex Cloud

# Шифрование данных с помощью CLI и API Yandex Cloud

В сервисе Yandex Key Management Service с помощью CLI и API вы можете шифровать и расшифровывать данные небольшого размера (до 32 КБ). Подробнее о возможных способах шифрования читайте в разделе [Какой способ шифрования выбрать?](index.md)

## Перед началом работы {#before-you-begin}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

## Зашифруйте данные {#encryption}

{% note info %}

Изменения, вызванные [eventually consistent операциями](../../concepts/consistency.md), становятся применимыми для шифрования с задержкой до трех часов.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Команда зашифрует открытый текст, переданный в файле `--plaintext-file`, и запишет полученный шифртекст в файл `--ciphertext-file`.

  * `--id` — идентификатор [ключа KMS](../../concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
  * `--name` — название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
  * `--version-id` — (опционально) [версия](../../concepts/version.md) ключа KMS, которая будет использоваться для шифрования. По умолчанию используется основная.
  * `--plaintext-file` — входной файл с открытым текстом.
  * `--aad-context-file` — (опционально) входной файл с [AAD-контекстом](../../concepts/symmetric-encryption.md#add-context).
  * `--ciphertext-file` — выходной файл с шифртекстом.

  ```bash
  yc kms symmetric-crypto encrypt \
    --id abj76v82fics******** \
    --plaintext-file plaintext-file \
    --ciphertext-file ciphertext-file
  ```

- API {#api}

  Чтобы зашифровать данные, воспользуйтесь методом REST API [encrypt](../../api-ref/SymmetricCrypto/encrypt.md) для ресурса [SymmetricCrypto](../../api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/Encrypt](../../api-ref/grpc/SymmetricCrypto/encrypt.md).

{% endlist %}

## Расшифруйте данные {#decryption}

{% note info %}

Изменения, вызванные [eventually consistent операциями](../../concepts/consistency.md), становятся применимыми для расшифрования с задержкой до трех часов.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Команда расшифрует шифртекст, переданный в файле `--ciphertext-file`, и запишет полученный открытый текст в файл `--plaintext-file`:

  * `--id` — идентификатор [ключа KMS](../../concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
  * `--name` — название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
  * `--ciphertext-file` — входной файл с открытым текстом.
  * `--aad-context-file` — (опционально) входной файл с [AAD-контекстом](../../concepts/symmetric-encryption.md#add-context).
  * `--plaintext-file` — выходной файл с шифртекстом.

  ```bash
  yc kms symmetric-crypto decrypt \
    --id abj76v82fics******** \
    --ciphertext-file ciphertext-file \
    --plaintext-file decrypted-file
  ```

- API {#api}

  Чтобы расшифровать данные, воспользуйтесь методом REST API [decrypt](../../api-ref/SymmetricCrypto/decrypt.md) для ресурса [SymmetricCrypto](../../api-ref/SymmetricCrypto/index.md) или вызовом gRPC API [SymmetricCryptoService/Decrypt](../../api-ref/grpc/SymmetricCrypto/decrypt.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Интерфейс командной строки CLI](../../../cli/index.md).
* [Симметричное шифрование в Yandex Key Management Service](../../concepts/symmetric-encryption.md).
* [Асимметричное шифрование в Yandex Key Management Service](../../concepts/asymmetric-encryption.md).
* [Управление ключами в Key Management Service](../../operations/index.md).