# Шифрование данных с помощью CLI и API {{ yandex-cloud }}

C помощью {{ kms-short-name }} вы можете шифровать и расшифровывть данные небольшого размера (до 32 КБ).

## Перед началом работы {#before-you-begin}

{% include [cli-install](../cli-install.md) %}

## Зашифруйте данные {#encryption}

{% list tabs %}

- CLI

    Команда зашифрует открытый текст, переданный в файле `--plaintext-file`, и запишет полученный шифртекст в файл `--ciphertext-file`.

    ```
    yc kms symmetric-crypto encrypt \
      --id abj76v82ficsmn446ri7 \
      --plaintext-file plaintext.txt \
      --ciphertext-file ciphertext
    ```

    Где:

    * `--id` –  идентификатор [ключа KMS](../../kms/concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
    * `--name` – название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
    * `--version-id` – (опционально) [версия](../../kms/concepts/version.md) ключа KMS, которая будет использоваться для шифрования. По умолчанию используется основная.
    * `--plaintext-file` – входной файл с открытым текстом.
    * `--aad-context-file` – (опционально) входной файл с [AAD-контекстом](../../kms/concepts/encryption.md#add-context).
    * `--ciphertext-file` – выходной файл с шифртекстом.

- API 

    Воспользуйтесь методом [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt) для ресурса `SymmetricCrypto`.

{% endlist %}

## Расшифруйте данные {#decryption}

{% list tabs %}

- CLI

    Команда расшифрует шифртекст, переданный в файле `--ciphertext-file`, и запишет полученный открытый текст в файл `--plaintext-file`:

    ```
    yc kms symmetric-crypto decrypt \
      --id abj76v82ficsmn446ri7 \
      --ciphertext-file ciphertext \
      --plaintext-file decrypted.txt
    ```

    Где:

    * `--id` – идентификатор [ключа KMS](../../kms/concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
    * `--name` – название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
    * `--ciphertext-file` – входной файл с открытым текстом.
    * `--aad-context-file` – (опционально) входной файл с [AAD-контекстом](../../kms/concepts/encryption.md#add-context).
    * `--plaintext-file` – выходной файл с шифртекстом.

- API 

    Воспользуйтесь методом [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt) для ресурса `SymmetricCrypto`.

{% endlist %}

## Перешифруйте данные  {#reencrypt}

{% list tabs %}

- CLI

    Команда заново зашифрует шифртекст, переданный в файле `--source-ciphertext-file`, другим ключом или другой версией ключа, и запишет полученный шифртекст в файл `--ciphertext-file`:

    ```
    yc kms symmetric-crypto re-encrypt \
      --id abj76v82ficsmn446ri7 \
      --source-key-id abj76v82ficsmn446ri7 \
      --source-ciphertext-file old-ciphertext \
      --ciphertext-file new-ciphertext 
    ```

    Где:

    * `--id` –  идентификатор [ключа KMS](../../kms/concepts/key.md), должен быть указан один из флагов: `--id` или `--name`.
    * `--name` – название ключа KMS, должен быть указан один из флагов: `--id` или `--name`.
    * `--version-id` – (опционально) [версия](../../kms/concepts/version.md) ключа KMS, которая будет использоваться для шифрования. По умолчанию используется основная.
    * `--aad-context-file` – (опционально) входной файл с [AAD-контекстом](../../kms/concepts/encryption.md#add-context), с которым шифртекст будет перешифрован.
    * `--source-key-id` – идентификатор ключа KMS, которым шифртекст зашифрован на момент запуска команды.
    * `--source-ciphertext-file` – входной файл с шифртекстом.
    * `--source-aad-context-file` –  (опционально) входной файл с AAD-контекстом, с которым шифртекст зашифрован на момент запуска команды.
    * `--ciphertext-file` – выходной файл с заново зашифрованным шифртекстом.

- API 

    Воспользуйтесь методом [reEncrypt](../../api-ref/SymmetricCrypto/reEncrypt) для ресурса `SymmetricCrypto`.

{% endlist %}


#### См. также {#see-also}

* [Интерфейс командной строки YC CLI](../../cli).
* [Шифрование в Key Management Service](../../kms/concepts/encryption.md).
* [Управление ключами в KMS](../../kms/operations/index.md).