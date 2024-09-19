# Encrypting data using the {{ yandex-cloud }} CLI and API

In {{ kms-short-name }}, you can encrypt and decrypt small amounts of data (up to 32 KB). For more information about the available encryption methods, see [{#T}](./index.md).

## Getting started {#before-you-begin}

{% include [cli-install](../../../_includes/cli-install.md) %}

## Encrypt data {#encryption}

{% list tabs group=instructions %}

- CLI {#cli}

  This command will encrypt the plain text provided in `--plaintext-file` and write the resulting ciphertext to `--ciphertext-file`:

  * `--id`: ID of the [KMS key](../../concepts/key.md). Make sure you set either the `--id` or `--name` flag.
  * `--name`: Name of the KMS key. Make sure you set either the `--id` or `--name` flag.
  * `--version-id` (optional): [Version](../../concepts/version.md) of the KMS key to use for encryption. The primary version is used by default.
  * `--plaintext-file`: Input file with plaintext.
  * `--aad-context-file` (optional): Input file with [AAD context](../../concepts/symmetric-encryption.md#add-context).
  * `--ciphertext-file`: Output file with ciphertext.

  ```bash
  yc kms symmetric-crypto encrypt \
    --id abj76v82fics******** \
    --plaintext-file plaintext-file \
    --ciphertext-file ciphertext-file
  ```

- API {#api}

  To encrypt data, use the [encrypt](../../api-ref/SymmetricCrypto/encrypt.md) REST API method for the [SymmetricCrypto](../../api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/Encrypt](../../api-ref/grpc/symmetric_crypto_service.md#Encrypt) gRPC API call.

{% endlist %}

## Decrypt data {#decryption}

{% list tabs group=instructions %}

- CLI {#cli}

  This command will decrypt the ciphertext provided in `--ciphertext-file` and write the resulting plain text to `--plaintext-file`:

  * `--id`: ID of the [KMS key](../../concepts/key.md). Make sure you set either the `--id` or `--name` flag.
  * `--name`: Name of the KMS key. Make sure you set either the `--id` or `--name` flag.
  * `--ciphertext-file`: Input file with plaintext.
  * `--aad-context-file` (optional): Input file with [AAD context](../../concepts/symmetric-encryption.md#add-context).
  * `--plaintext-file`: Output file with ciphertext.

  ```bash
  yc kms symmetric-crypto decrypt \
    --id abj76v82fics******** \
    --ciphertext-file ciphertext-file \
    --plaintext-file decrypted-file
  ```

- API {#api}

  To decrypt data, use the [decrypt](../../api-ref/SymmetricCrypto/decrypt.md) REST API method for the [SymmetricCrypto](../../api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/Decrypt](../../api-ref/grpc/symmetric_crypto_service.md#Decrypt) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [Command line interface CLI](../../../cli).
* [Symmetric encryption in {{ kms-full-name }}](../../concepts/symmetric-encryption.md).
* [Asymmetric encryption in {{ kms-full-name }}](../../concepts/asymmetric-encryption.md).
* [Managing keys in {{ kms-name }}](../../operations/index.md).
