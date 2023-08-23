# Encrypting data using the {{ yandex-cloud }} CLI and API

In {{ kms-short-name }}, you can encrypt and decrypt small amounts of data (up to 32 KB). For more information about available encryption methods, see [{#T}](./index.md)

## Getting started {#before-you-begin}

{% include [cli-install](../../../_includes/cli-install.md) %}

## Encrypt data {#encryption}

{% list tabs %}

- CLI

   The command encrypts the plain text provided in the `--plaintext-file` and writes the resulting ciphertext to `--ciphertext-file`.

   * `--id`: ID of the [KMS key](../../concepts/key.md), make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key, make sure you set either the `--id` or `--name` flag.
   * `--version-id` (optional): [Version](../../concepts/version.md) of the KMS key to use for encryption. The primary version is used by default.
   * `--plaintext-file`: Input file with plaintext.
   * `--aad-context-file` (optional): Input file with [AAD context](../../concepts/encryption.md#add-context).
   * `--ciphertext-file`: Output file with ciphertext.

   ```
   yc kms symmetric-crypto encrypt \
     --id abj76v82ficsmn446ri7 \
     --plaintext-file plaintext-file \
     --ciphertext-file ciphertext-file
   ```

- API

   To encrypt data, use the [encrypt](../../api-ref/SymmetricCrypto/encrypt.md) REST API method for the [SymmetricCrypto](../../api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/Encrypt](../../api-ref/grpc/symmetric_crypto_service.md#Encrypt) gRPC API call.

{% endlist %}

## Decrypt data {#decryption}

{% list tabs %}

- CLI

   The command decrypts the ciphertext provided in `--ciphertext-file` and writes the resulting plain text to `--plaintext-file`:

   * `--id`: ID of the [KMS key](../../concepts/key.md), make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key, make sure you set either the `--id` or `--name` flag.
   * `--ciphertext-file`: Input file with plaintext.
   * `--aad-context-file` (optional): Input file with [AAD context](../../concepts/encryption.md#add-context).
   * `--plaintext-file`: Output file with ciphertext.

   ```
   yc kms symmetric-crypto decrypt \
     --id abj76v82ficsmn446ri7 \
     --ciphertext-file ciphertext-file \
     --plaintext-file decrypted-file
   ```

- API

   To decrypt data, use the [decrypt](../../api-ref/SymmetricCrypto/decrypt.md) REST API method for the [SymmetricCrypto](../../api-ref/SymmetricCrypto/index.md) resource or the [SymmetricCryptoService/Decrypt](../../api-ref/grpc/symmetric_crypto_service.md#Decrypt) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [Command line interface CLI](../../../cli).
* [Encryption in {{ kms-name }}](../../concepts/encryption.md).
* [Managing keys in {{ kms-name }}](../../operations/index.md).
