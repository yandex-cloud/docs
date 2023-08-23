# Data encryption

In this section, you will learn how to use {{ kms-short-name }} to encrypt and decrypt small-sized data (of up to 32 KB) using the CLI and API. For more information about available encryption methods, see [{#T}](../tutorials/encrypt/index.md)

## Getting started {#before-you-begin}

{% include [cli-install](../../_includes/cli-install.md) %}

## Encrypt data {#encryption}

{% list tabs %}

- CLI

   The command encrypts the plain text provided in the `--plaintext-file` and writes the resulting ciphertext to `--ciphertext-file`.

   * `--id`: ID of the [KMS key](../concepts/key.md), make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key, make sure you set either the `--id` or `--name` flag.
   * `--version-id` (optional): [Version](../concepts/version.md) of the KMS key to use for encryption. The primary version is used by default.
   * `--plaintext-file`: Input file with plaintext.
   * `--aad-context-file` (optional): Input file with [AAD context](../concepts/encryption.md#add-context).
   * `--ciphertext-file`: Output file with ciphertext.


   ```
   yc kms symmetric-crypto encrypt \
     --id abj76v82fics******** \
     --plaintext-file plaintext-file \
     --ciphertext-file ciphertext-file
   ```

- API

   To encrypt data, use the [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt.md) REST API method for the [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/Encrypt](../../kms/api-ref/grpc/symmetric_crypto_service.md#Encrypt) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-encryption](../../_includes/kms/terraform-encryption.md) %}

- SDK {{ yandex-cloud }}

   {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK

   {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}

- Google Tink

   {% include [tink](../../_includes/kms/google-encypt.md) %}


{% endlist %}

## Decrypt data {#decryption}

{% list tabs %}

- CLI

   The command decrypts the ciphertext provided in `--ciphertext-file` and writes the resulting plain text to `--plaintext-file`:

   * `--id`: ID of the [KMS key](../concepts/key.md), make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key, make sure you set either the `--id` or `--name` flag.
   * `--ciphertext-file`: Input file with plaintext.
   * `--aad-context-file` (optional): Input file with [AAD context](../concepts/encryption.md#add-context).
   * `--plaintext-file`: Output file with ciphertext.

   ```
   yc kms symmetric-crypto decrypt \
     --id abj76v82fics******** \
     --ciphertext-file ciphertext-file \
     --plaintext-file decrypted-file
   ```

- API

   To decrypt data, use the [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt.md) REST API method for the [SymmetricCrypto](../../kms/api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/Decrypt](../../kms/api-ref/grpc/symmetric_crypto_service.md#Decrypt) gRPC API call.

- SDK {{ yandex-cloud }}

   {% include [yc-sdk](../../_includes/kms/sdk-encypt.md) %}

- AWS Encryption SDK

   {% include [aws-sdk](../../_includes/kms/aws-encypt.md) %}

- Google Tink

   {% include [tink](../../_includes/kms/google-encypt.md) %}


{% endlist %}


#### See also {#see-also}

* [Command line interface (YC CLI)](../../cli).
* [Encryption in Key Management Service](../concepts/encryption.md).
* [Managing keys in KMS](./index.md).
* [Encrypting secrets in Hashicorp Terraform](../../kms/tutorials/terraform-secret.md).
