# Encrypting data using the {{ yandex-cloud }} CLI and API

In {{ kms-short-name }}, you can encrypt and decrypt small amounts of data (up to 32 KB). For more information about available encryption methods, see [{#T}](../tutorials/encrypt/index.md)

## Before you begin {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

## Encrypt data {#encryption}

{% list tabs %}

- CLI

   The command encrypts the plaintext passed in the `--plaintext-file` and writes the resulting ciphertext to the `--ciphertext-file`.

   * `--id`: ID of the [KMS key](../concepts/key.md), make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key, make sure you set either the `--id` or `--name` flag.
   * `--version-id` (optional): [Version](../concepts/version.md) of the KMS key to be used for encryption. The primary version is used by default.
   * `--plaintext-file`: Input file with plaintext.
   * `--aad-context-file` (optional): Input file with [AAD context](../concepts/encryption.md#add-context).
   * `--ciphertext-file`: Output file with ciphertext.


   ```
   yc kms symmetric-crypto encrypt \
     --id abj76v82ficsmn446ri7 \
     --plaintext-file plaintext-file \
     --ciphertext-file ciphertext-file
   ```

- API

   Use the [encrypt](../api-ref/SymmetricCrypto/encrypt) method for the `SymmetricCrypto` resource.

{% if product == "yandex-cloud" %}
- SDK {{ yandex-cloud }}

   {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK

   {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}

- Google Tink

   {% include [tink](../../_includes/kms/google-encypt.md) %}
   {% endif %}

{% endlist %}

## Decrypt data {#decryption}

{% list tabs %}

- CLI

   The command decrypts the ciphertext passed in the `--ciphertext-file` and writes the resulting plaintext to the `--plaintext-file`:

   * `--id`: ID of the [KMS key](../concepts/key.md), make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key, make sure you set either the `--id` or `--name` flag.
   * `--ciphertext-file`: Input file with plaintext.
   * `--aad-context-file` (optional): Input file with [AAD context](../concepts/encryption.md#add-context).
   * `--plaintext-file`: Output file with ciphertext.

   ```
   yc kms symmetric-crypto decrypt \
     --id abj76v82ficsmn446ri7 \
     --ciphertext-file ciphertext-file \
     --plaintext-file decrypted-file
   ```

- API

   Use the [decrypt](../api-ref/SymmetricCrypto/decrypt) method for the `SymmetricCrypto` resource.

{% if product == "yandex-cloud" %}
- SDK {{ yandex-cloud }}

   {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK

   {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}

- Google Tink

   {% include [tink](../../_includes/kms/google-encypt.md) %}
   {% endif %}

{% endlist %}


#### See also {#see-also}

* [Command line interface (YC CLI)](../../cli).
* [Encryption in Key Management Service](../concepts/encryption.md).
* [Managing keys in KMS](./index.md).
