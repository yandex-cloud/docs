---
editable: false
sourcePath: en/_cli-ref/cli-ref/kms/cli-ref/index.md
---

# yc kms

Manage Yandex Key Management Service resources

#### Command Usage

Syntax: 

`yc kms <group>`

#### Command Tree

- [yc kms asymmetric-encryption-crypto](asymmetric-encryption-crypto/index.md) — Perform asymmetric encryption crypto operations
	- [yc kms asymmetric-encryption-crypto decrypt](asymmetric-encryption-crypto/decrypt.md) — Decrypt data with specified asymmetric encryption key
	- [yc kms asymmetric-encryption-crypto get-public-key](asymmetric-encryption-crypto/get-public-key.md) — Get public key
- [yc kms asymmetric-encryption-key](asymmetric-encryption-key/index.md) — Manage asymmetric encryption keys
	- [yc kms asymmetric-encryption-key add-access-binding](asymmetric-encryption-key/add-access-binding.md) — Add access binding for the specified asymmetric encryption key
	- [yc kms asymmetric-encryption-key create](asymmetric-encryption-key/create.md) — Create asymmetric encryption key
	- [yc kms asymmetric-encryption-key delete](asymmetric-encryption-key/delete.md) — Delete the specified asymmetric encryption key
	- [yc kms asymmetric-encryption-key get](asymmetric-encryption-key/get.md) — Show information about the specified asymmetric encryption key
	- [yc kms asymmetric-encryption-key list](asymmetric-encryption-key/list.md) — List asymmetric encryption keys of the specified folder
	- [yc kms asymmetric-encryption-key list-access-bindings](asymmetric-encryption-key/list-access-bindings.md) — List access bindings for the specified asymmetric encryption key
	- [yc kms asymmetric-encryption-key list-operations](asymmetric-encryption-key/list-operations.md) — List operations for the specified asymmetric encryption key
	- [yc kms asymmetric-encryption-key remove-access-binding](asymmetric-encryption-key/remove-access-binding.md) — Remove access binding for the specified asymmetric encryption key
	- [yc kms asymmetric-encryption-key set-access-bindings](asymmetric-encryption-key/set-access-bindings.md) — Set access bindings for the specified asymmetric encryption key and delete all existing access bindings if there were any
	- [yc kms asymmetric-encryption-key update](asymmetric-encryption-key/update.md) — Update the specified asymmetric encryption key
- [yc kms asymmetric-signature-crypto](asymmetric-signature-crypto/index.md) — Perform asymmetric signature crypto operations
	- [yc kms asymmetric-signature-crypto get-public-key](asymmetric-signature-crypto/get-public-key.md) — Get public key
	- [yc kms asymmetric-signature-crypto sign](asymmetric-signature-crypto/sign.md) — Sign data with specified asymmetric signature key
	- [yc kms asymmetric-signature-crypto sign-hash](asymmetric-signature-crypto/sign-hash.md) — Sign hash value with specified asymmetric signature key
- [yc kms asymmetric-signature-key](asymmetric-signature-key/index.md) — Manage asymmetric signature keys
	- [yc kms asymmetric-signature-key add-access-binding](asymmetric-signature-key/add-access-binding.md) — Add access binding for the specified asymmetric signature key
	- [yc kms asymmetric-signature-key create](asymmetric-signature-key/create.md) — Create asymmetric signature key
	- [yc kms asymmetric-signature-key delete](asymmetric-signature-key/delete.md) — Delete the specified asymmetric signature key
	- [yc kms asymmetric-signature-key get](asymmetric-signature-key/get.md) — Show information about the specified asymmetric signature key
	- [yc kms asymmetric-signature-key list](asymmetric-signature-key/list.md) — List asymmetric signature keys of the specified folder
	- [yc kms asymmetric-signature-key list-access-bindings](asymmetric-signature-key/list-access-bindings.md) — List access bindings for the specified asymmetric signature key
	- [yc kms asymmetric-signature-key list-operations](asymmetric-signature-key/list-operations.md) — List operations for the specified asymmetric signature key
	- [yc kms asymmetric-signature-key remove-access-binding](asymmetric-signature-key/remove-access-binding.md) — Remove access binding for the specified asymmetric signature key
	- [yc kms asymmetric-signature-key set-access-bindings](asymmetric-signature-key/set-access-bindings.md) — Set access bindings for the specified asymmetric signature key and delete all existing access bindings if there were any
	- [yc kms asymmetric-signature-key update](asymmetric-signature-key/update.md) — Update the specified asymmetric signature key
- [yc kms symmetric-crypto](symmetric-crypto/index.md) — Perform symmetric crypto operations
	- [yc kms symmetric-crypto decrypt](symmetric-crypto/decrypt.md) — Decrypt data with specified symmetric key
	- [yc kms symmetric-crypto encrypt](symmetric-crypto/encrypt.md) — Encrypt data with specified symmetric key
	- [yc kms symmetric-crypto generate-data-key](symmetric-crypto/generate-data-key.md) — Generate data key and encrypt it with specified symmetric key
	- [yc kms symmetric-crypto re-encrypt](symmetric-crypto/re-encrypt.md) — Re-encrypt a ciphertext with the specified symmetric key
- [yc kms symmetric-key](symmetric-key/index.md) — Manage symmetric keys
	- [yc kms symmetric-key add-access-binding](symmetric-key/add-access-binding.md) — Add access binding for the specified symmetric key
	- [yc kms symmetric-key cancel-version-destruction](symmetric-key/cancel-version-destruction.md) — Cancel destruction of the scheduled for destruction symmetric key version
	- [yc kms symmetric-key create](symmetric-key/create.md) — Create symmetric key
	- [yc kms symmetric-key delete](symmetric-key/delete.md) — Delete the specified symmetric key
	- [yc kms symmetric-key get](symmetric-key/get.md) — Show information about the specified symmetric key
	- [yc kms symmetric-key list](symmetric-key/list.md) — List symmetric keys of the specified folder
	- [yc kms symmetric-key list-access-bindings](symmetric-key/list-access-bindings.md) — List access bindings for the specified symmetric key
	- [yc kms symmetric-key list-operations](symmetric-key/list-operations.md) — List operations for the specified symmetric key
	- [yc kms symmetric-key list-versions](symmetric-key/list-versions.md) — List versions of the specified symmetric key
	- [yc kms symmetric-key remove-access-binding](symmetric-key/remove-access-binding.md) — Remove access binding for the specified symmetric key
	- [yc kms symmetric-key rotate](symmetric-key/rotate.md) — Rotate the specified symmetric key: creates a new key version and makes it the primary version
	- [yc kms symmetric-key schedule-version-destruction](symmetric-key/schedule-version-destruction.md) — Schedule destruction of the specified symmetric key version
	- [yc kms symmetric-key set-access-bindings](symmetric-key/set-access-bindings.md) — Set access bindings for the specified symmetric key and delete all existing access bindings if there were any
	- [yc kms symmetric-key set-primary-version](symmetric-key/set-primary-version.md) — Set primary version of the specified symmetric key
	- [yc kms symmetric-key update](symmetric-key/update.md) — Update the specified symmetric key

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
