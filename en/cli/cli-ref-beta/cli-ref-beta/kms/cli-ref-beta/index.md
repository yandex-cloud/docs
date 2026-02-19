---
editable: false
noIndex: true
---

# yc beta kms

Manage Key Management Service resources

#### Command Usage

Syntax:

`yc beta kms <group>`

#### Command Tree

- [yc beta kms asymmetric-encryption-crypto](asymmetric-encryption-crypto/index.md) — Set of methods that perform asymmetric decryption.

  - [yc beta kms asymmetric-encryption-crypto decrypt](asymmetric-encryption-crypto/decrypt.md) — Decrypts the given ciphertext with the specified key.

  - [yc beta kms asymmetric-encryption-crypto get-public-key](asymmetric-encryption-crypto/get-public-key.md) — Gets value of public key.

- [yc beta kms asymmetric-encryption-key](asymmetric-encryption-key/index.md) — Set of methods for managing asymmetric KMS keys.

  - [yc beta kms asymmetric-encryption-key create](asymmetric-encryption-key/create.md) — control plane

  - [yc beta kms asymmetric-encryption-key delete](asymmetric-encryption-key/delete.md) — Deletes the specified asymmetric KMS key. This action also automatically schedules

  - [yc beta kms asymmetric-encryption-key get](asymmetric-encryption-key/get.md) — Returns the specified asymmetric KMS key.

  - [yc beta kms asymmetric-encryption-key list](asymmetric-encryption-key/list.md) — Returns the list of asymmetric KMS keys in the specified folder.

  - [yc beta kms asymmetric-encryption-key list-access-bindings](asymmetric-encryption-key/list-access-bindings.md) — Lists existing access bindings for the specified key.

  - [yc beta kms asymmetric-encryption-key list-operations](asymmetric-encryption-key/list-operations.md) — Lists operations for the specified asymmetric KMS key.

  - [yc beta kms asymmetric-encryption-key set-access-bindings](asymmetric-encryption-key/set-access-bindings.md) — Sets access bindings for the key.

  - [yc beta kms asymmetric-encryption-key update](asymmetric-encryption-key/update.md) — Updates the specified asymmetric KMS key.

  - [yc beta kms asymmetric-encryption-key update-access-bindings](asymmetric-encryption-key/update-access-bindings.md) — Updates access bindings for the specified key.

- [yc beta kms asymmetric-signature-crypto](asymmetric-signature-crypto/index.md) — Set of methods that perform asymmetric signature.

  - [yc beta kms asymmetric-signature-crypto get-public-key](asymmetric-signature-crypto/get-public-key.md) — Gets value of public key.

  - [yc beta kms asymmetric-signature-crypto sign](asymmetric-signature-crypto/sign.md) — Signs data specified KMS key.

  - [yc beta kms asymmetric-signature-crypto sign-hash](asymmetric-signature-crypto/sign-hash.md) — Signs hash value specified KMS key.

- [yc beta kms asymmetric-signature-key](asymmetric-signature-key/index.md) — Set of methods for managing asymmetric signature keys.

  - [yc beta kms asymmetric-signature-key create](asymmetric-signature-key/create.md) — control plane

  - [yc beta kms asymmetric-signature-key delete](asymmetric-signature-key/delete.md) — Deletes the specified asymmetric KMS key. This action also automatically schedules

  - [yc beta kms asymmetric-signature-key get](asymmetric-signature-key/get.md) — Returns the specified asymmetric KMS key.

  - [yc beta kms asymmetric-signature-key list](asymmetric-signature-key/list.md) — Returns the list of asymmetric KMS keys in the specified folder.

  - [yc beta kms asymmetric-signature-key list-access-bindings](asymmetric-signature-key/list-access-bindings.md) — Lists existing access bindings for the specified key.

  - [yc beta kms asymmetric-signature-key list-operations](asymmetric-signature-key/list-operations.md) — Lists operations for the specified asymmetric KMS key.

  - [yc beta kms asymmetric-signature-key set-access-bindings](asymmetric-signature-key/set-access-bindings.md) — Sets access bindings for the key.

  - [yc beta kms asymmetric-signature-key update](asymmetric-signature-key/update.md) — Updates the specified asymmetric KMS key.

  - [yc beta kms asymmetric-signature-key update-access-bindings](asymmetric-signature-key/update-access-bindings.md) — Updates access bindings for the specified key.

- [yc beta kms symmetric-crypto](symmetric-crypto/index.md) — Set of methods that perform symmetric encryption and decryption.

  - [yc beta kms symmetric-crypto decrypt](symmetric-crypto/decrypt.md) — Decrypts the given ciphertext with the specified key.

  - [yc beta kms symmetric-crypto encrypt](symmetric-crypto/encrypt.md) — Encrypts given plaintext with the specified key.

  - [yc beta kms symmetric-crypto generate-data-key](symmetric-crypto/generate-data-key.md) — Generates a new symmetric data encryption key (not a KMS key) and returns

  - [yc beta kms symmetric-crypto re-encrypt](symmetric-crypto/re-encrypt.md) — Re-encrypts a ciphertext with the specified KMS key.

- [yc beta kms symmetric-key](symmetric-key/index.md) — Set of methods for managing symmetric KMS keys.

  - [yc beta kms symmetric-key cancel-version-destruction](symmetric-key/cancel-version-destruction.md) — Cancels previously scheduled version destruction, if the version hasn't been destroyed yet.

  - [yc beta kms symmetric-key create](symmetric-key/create.md) — Creates a symmetric KMS key in the specified folder.

  - [yc beta kms symmetric-key delete](symmetric-key/delete.md) — Deletes the specified symmetric KMS key. This action also automatically schedules

  - [yc beta kms symmetric-key get](symmetric-key/get.md) — Returns the specified symmetric KMS key.

  - [yc beta kms symmetric-key list](symmetric-key/list.md) — Returns the list of symmetric KMS keys in the specified folder.

  - [yc beta kms symmetric-key list-access-bindings](symmetric-key/list-access-bindings.md) — Lists existing access bindings for the specified key.

  - [yc beta kms symmetric-key list-operations](symmetric-key/list-operations.md) — Lists operations for the specified symmetric KMS key.

  - [yc beta kms symmetric-key list-versions](symmetric-key/list-versions.md) — Returns the list of versions of the specified symmetric KMS key.

  - [yc beta kms symmetric-key rotate](symmetric-key/rotate.md) — Rotates the specified key: creates a new key version and makes it the primary version.

  - [yc beta kms symmetric-key schedule-version-destruction](symmetric-key/schedule-version-destruction.md) — Schedules the specified key version for destruction.

  - [yc beta kms symmetric-key set-access-bindings](symmetric-key/set-access-bindings.md) — Sets access bindings for the key.

  - [yc beta kms symmetric-key set-primary-version](symmetric-key/set-primary-version.md) — Sets the primary version for the specified key. The primary version is used

  - [yc beta kms symmetric-key update](symmetric-key/update.md) — Updates the specified symmetric KMS key.

  - [yc beta kms symmetric-key update-access-bindings](symmetric-key/update-access-bindings.md) — Updates access bindings for the specified key.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#