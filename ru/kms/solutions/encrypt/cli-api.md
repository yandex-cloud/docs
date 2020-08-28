# Шифрование данных с помощью CLI и API {{ yandex-cloud }}

В сервисе {{ kms-short-name }} с помощью CLI и API вы можете шифровать и расшифровывать данные небольшого размера (до 32 КБ). Подробнее о возможных способах шифрования читайте в разделе [{#T}](index.md)

## Перед началом работы {#before-you-begin}

{% include [cli-install](../../../_includes/cli-install.md) %}

## Зашифруйте данные {#encryption}

{% list tabs %}

- CLI
     
    Команда зашифрует открытый текст, переданный в файле `--plaintext-file`, и запишет полученный шифртекст в файл `--ciphertext-file`.

    * `--id` –  идентификатор [ключа KMS](../../concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
    * `--name` – название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
    * `--version-id` – (опционально) [версия](../../concepts/version.md) ключа KMS, которая будет использоваться для шифрования. По умолчанию используется основная.
    * `--plaintext-file` – входной файл с открытым текстом.
    * `--aad-context-file` – (опционально) входной файл с [AAD-контекстом](../../concepts/encryption.md#add-context).
    * `--ciphertext-file` – выходной файл с шифртекстом.

    ```
    $ yc kms symmetric-crypto encrypt \
      --id abj76v82ficsmn446ri7 \
      --plaintext-file plaintext-file \
      --ciphertext-file ciphertext-file
    ```
    
- API 

    Воспользуйтесь методом [encrypt](../../api-ref/SymmetricCrypto/encrypt) для ресурса `SymmetricCrypto`.
    
{% endlist %}

## Расшифруйте данные {#decryption}

{% list tabs %}

- CLI

    Команда расшифрует шифртекст, переданный в файле `--ciphertext-file`, и запишет полученный открытый текст в файл `--plaintext-file`:
    
    * `--id` – идентификатор [ключа KMS](../../concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
    * `--name` – название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
    * `--ciphertext-file` – входной файл с открытым текстом.
    * `--aad-context-file` – (опционально) входной файл с [AAD-контекстом](../../concepts/encryption.md#add-context).
    * `--plaintext-file` – выходной файл с шифртекстом.
    
    ```
    $ yc kms symmetric-crypto decrypt \
      --id abj76v82ficsmn446ri7 \
      --ciphertext-file ciphertext-file \
      --plaintext-file decrypted-file
    ```
    
- API 

    Воспользуйтесь методом [decrypt](../../api-ref/SymmetricCrypto/decrypt) для ресурса `SymmetricCrypto`.
    
{% endlist %}

#### См. также {#see-also}

* [Интерфейс командной строки YC CLI](../../../cli).
* [Шифрование в Key Management Service](../../concepts/encryption.md).
* [Управление ключами в KMS](../../operations/index.md).
