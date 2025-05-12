# Symmetric data encryption

In this section, you will learn how to use {{ kms-short-name }} to encrypt and decrypt small-sized data (up to 32 KB) in [symmetric encryption](../concepts/symmetric-encryption.md) mode using the CLI and API. For more information about the available encryption methods, see [{#T}](../tutorials/encrypt/index.md).

## Getting started {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

## Encrypt data {#encryption}

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


#### See also {#see-also}

* [Command line interface CLI](../../cli)
* [Symmetric encryption in {{ kms-full-name }}](../concepts/symmetric-encryption.md)
* [Asymmetric encryption in {{ kms-full-name }}](../concepts/asymmetric-encryption.md)
* [Managing keys in KMS](./index.md)
* [Encrypting secrets in Hashicorp Terraform](../../kms/tutorials/terraform-secret.md)
