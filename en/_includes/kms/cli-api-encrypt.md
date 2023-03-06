# Encrypting data using the {{ yandex-cloud }} CLI and API

Using {{ kms-short-name }} you can encrypt and decrypt small amounts of data (up to 32 KB).

## Getting started {#before-you-begin}

{% include [cli-install](../cli-install.md) %}

## Encrypt data {#encryption}

{% list tabs %}

- CLI

   The command encrypts the plaintext sent to `--plaintext-file` and writes the resulting ciphertext to `--ciphertext-file`.

   ```
   yc kms symmetric-crypto encrypt \
     --id abj76v82ficsmn446ri7 \
     --plaintext-file plaintext.txt \
     --ciphertext-file ciphertext
   ```

   Where:

   * `--id`: ID of the [KMS key](../../kms/concepts/key.md). Make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key. Make sure you set either the `--id` or `--name` flag.
   * `--version-id` (optional): [Version](../../kms/concepts/version.md) of the KMS key to use for encryption. The primary version is used by default.
   * `--plaintext-file`: Input file with plaintext.
   * `--aad-context-file` (optional): Input file with [AAD context](../../kms/concepts/encryption.md#add-context).
   * `--ciphertext-file`: Output file with ciphertext.

- API

   Use the [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt) method for the `SymmetricCrypto` resource.

{% endlist %}

## Decrypt data {#decryption}

{% list tabs %}

- CLI

   The command decrypts the ciphertext sent to `--ciphertext-file` and writes the resulting plaintext to the `--plaintext-file`:

   ```
   yc kms symmetric-crypto decrypt \
     --id abj76v82ficsmn446ri7 \
     --ciphertext-file ciphertext \
     --plaintext-file decrypted.txt
   ```

   Where:

   * `--id`: ID of the [KMS key](../../kms/concepts/key.md). Make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key. Make sure you set either the `--id` or `--name` flag.
   * `--ciphertext-file`: Input file with plaintext.
   * `--aad-context-file` (optional): Input file with [AAD context](../../kms/concepts/encryption.md#add-context).
   * `--plaintext-file`: Output file with ciphertext.

- API

   Use the [decrypt](../../kms/api-ref/SymmetricCrypto/decrypt) method for the `SymmetricCrypto` resource.

{% endlist %}

## Re-encrypt data {#reencrypt}

{% list tabs %}

- CLI

   The command re-encrypts the ciphertext sent to the `--source-ciphertext-file` file with a different key or a different version of the key, and then writes the resulting ciphertext to `--ciphertext-file`:

   ```
   yc kms symmetric-crypto re-encrypt \
     --id abj76v82ficsmn446ri7 \
     --source-key-id abj76v82ficsmn446ri7 \
     --source-ciphertext-file old-ciphertext \
     --ciphertext-file new-ciphertext
   ```

   Where:

   * `--id`: ID of the [KMS key](../../kms/concepts/key.md). Make sure you set either the `--id` or `--name` flag.
   * `--name`: Name of the KMS key. Make sure you set either the `--id` or `--name` flag.
   * `--version-id` (optional): [Version](../../kms/concepts/version.md) of the KMS key to use for encryption. The primary version is used by default.
   * `--aad-context-file` (optional): Input file with [AAD context](../../kms/concepts/encryption.md#add-context), with which the ciphertext will be re-encrypted.
   * `--source-key-id`: ID of the KMS key the ciphertext was encrypted with when the command was run.
   * `--source-ciphertext-file`: Input file with the ciphertext.
   * `--source-aad-context-file` (optional): Input file with the AAD context the ciphertext was encrypted with when the command was run.
   * `--ciphertext-file`: Output file with the re-encrypted ciphertext.

- API

   Use the [reEncrypt](../../api-ref/SymmetricCrypto/reEncrypt) method for the `SymmetricCrypto` resource.

{% endlist %}


#### See also {#see-also}

* [Command line interface (YC CLI)](../../cli).
* [Encryption in Key Management Service](../../kms/concepts/encryption.md).
* [Managing keys in KMS](../../kms/operations/index.md).