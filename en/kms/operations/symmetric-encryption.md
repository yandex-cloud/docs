# Symmetric data encryption

In this section, you will learn how to use {{ kms-short-name }} to encrypt and decrypt small-sized data (up to 32 KB) in [symmetric encryption](../concepts/symmetric-encryption.md) mode using the CLI, {{ TF }}, and API. For more information about the available encryption methods, see [{#T}](../tutorials/encrypt/index.md).

## Getting started {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

## Encrypt data {#encryption}

{% note info %}

Changes caused by [eventually consistent operations](../concepts/consistency.md) require up to three hours to become encryptable.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  This command will encrypt the plain text provided in `--plaintext-file` and write the resulting ciphertext to `--ciphertext-file`:

  * `--id`: ID of the [KMS key](../concepts/key.md). Make sure you set either the `--id` or `--name` flag.
  * `--name`: Name of the KMS key. Make sure you set either the `--id` or `--name` flag.
  * `--version-id` (optional): [Version](../concepts/version.md) of the KMS key to use for encryption. The primary version is used by default.
  * `--plaintext-file`: Input plaintext file.
  * `--aad-context-file` (optional): Input file with [AAD context](../concepts/symmetric-encryption.md#add-context).
  * `--ciphertext-file`: Output file with ciphertext.

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

  To encrypt data, use the [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt.md) REST API method for the [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/Encrypt](../../kms/api-ref/grpc/SymmetricCrypto/encrypt.md) gRPC API call.

- {{ yandex-cloud }} SDK {#sdk-yc}

  {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK {#sdk-aws}

  {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}

- Google Tink {#google-tink}

  {% include [tink](../../_includes/kms/google-encypt.md) %}

{% endlist %}

## Decrypt data {#decryption}

{% note info %}

Changes caused by [eventually consistent operations](../concepts/consistency.md) require up to three hours to become decryptable.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  This command will decrypt the ciphertext provided in `--ciphertext-file` and write the resulting plain text to `--plaintext-file`:

  * `--id`: ID of the [KMS key](../concepts/key.md). Make sure you set either the `--id` or `--name` flag.
  * `--name`: Name of the KMS key. Make sure you set either the `--id` or `--name` flag.
  * `--ciphertext-file`: Input file with ciphertext.
  * `--aad-context-file` (optional): Input file with [AAD context](../concepts/symmetric-encryption.md#add-context).
  * `--plaintext-file`: Output plaintext file.

  ```bash
  yc kms symmetric-crypto decrypt \
    --id abj76v82fics******** \
    --ciphertext-file ciphertext-file \
    --plaintext-file decrypted-file
  ```

- API {#api}

  To decrypt data, use the [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt.md) REST API method for the [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/Decrypt](../../kms/api-ref/grpc/SymmetricCrypto/decrypt.md) gRPC API call.

- {{ yandex-cloud }} SDK {#sdk-yc}

  {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK {#sdk-aws}

  {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}

- Google Tink {#google-tink}

  {% include [tink](../../_includes/kms/google-encypt.md) %}

{% endlist %}

## Change the data encryption key {#reencryption}

{% note info %}

Changes triggered by [eventually consistent operations](../concepts/consistency.md) allow an encryption key change after as much as three hours.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  This command will decrypt the ciphertext from `--source-ciphertext-file`, re-encrypt it with a different key or a different version of the source key, and then write the resulting ciphertext to `--ciphertext-file`.

  * `--id` or `--name`: ID or name of the new [KMS key](../concepts/key.md) for re-encryption.

    {% note info %}

    * To use a different key, specify the `--id` or `--name` flag.

    * To only change the key version, skip both `--id` and `--name`.

    {% endnote %}

  * `--version-id` (optional): [Version](../concepts/version.md) of the KMS key to use for encryption. The primary version is used by default.
  * `--aad-context-file` (optional): Output file with [AAD context](../concepts/symmetric-encryption.md#add-context).
  * `--ciphertext-file`: Output file with ciphertext.
  * `--source-key-id`: ID of the {{ kms-name }} encryption key used for source text encryption.
  * `--source-aad-context-file` (optional): Input file with AAD context.
  * `--source-ciphertext-file`: Input file with ciphertext.

  ```bash
  yc kms symmetric-crypto reencrypt \
    --id <key_ID> \
    --ciphertext-file ciphertext-file
    --source-key-id <source_key_ID> \
    --source-ciphertext-file source-ciphertext-file
  ```

- API {#api}

  To change the data encryption key or its version, use the [reEncrypt](../../kms/api-ref/SymmetricCrypto/reEncrypt.md) REST API method for the [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/ReEncrypt](../../kms/api-ref/grpc/SymmetricCrypto/reEncrypt.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [Command line interface CLI](../../cli)
* [Symmetric encryption in {{ kms-full-name }}](../concepts/symmetric-encryption.md)
* [Asymmetric encryption in {{ kms-full-name }}](../concepts/asymmetric-encryption.md)
* [Managing keys in KMS](./index.md)
* [Encrypting secrets in Hashicorp Terraform](../../kms/tutorials/terraform-secret.md)
