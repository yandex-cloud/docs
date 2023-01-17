---
editable: false
---

# yc kms

Manage Yandex Key Management Service resources

#### Command Usage

Syntax: 

`yc kms <group>`

#### Command Tree

- [yc kms symmetric-key](symmetric-key/index.md) — Manage symmetric keys
	- [yc kms symmetric-key get](symmetric-key/get.md) — Show information about the specified symmetric key
	- [yc kms symmetric-key list](symmetric-key/list.md) — List symmetric keys of the specified folder
	- [yc kms symmetric-key list-versions](symmetric-key/list-versions.md) — List versions of the specified symmetric key
	- [yc kms symmetric-key create](symmetric-key/create.md) — Create symmetric key
	- [yc kms symmetric-key update](symmetric-key/update.md) — Update the specified symmetric key
	- [yc kms symmetric-key delete](symmetric-key/delete.md) — Delete the specified symmetric key
	- [yc kms symmetric-key set-primary-version](symmetric-key/set-primary-version.md) — Set primary version of the specified symmetric key
	- [yc kms symmetric-key schedule-version-destruction](symmetric-key/schedule-version-destruction.md) — Schedule destruction of the specified symmetric key version
	- [yc kms symmetric-key cancel-version-destruction](symmetric-key/cancel-version-destruction.md) — Cancel destruction of the scheduled for destruction symmetric key version
	- [yc kms symmetric-key rotate](symmetric-key/rotate.md) — Rotate the specified symmetric key: creates a new key version and makes it the primary version
	- [yc kms symmetric-key list-operations](symmetric-key/list-operations.md) — List operations for the specified symmetric key
	- [yc kms symmetric-key list-access-bindings](symmetric-key/list-access-bindings.md) — List access bindings for the specified symmetric key
	- [yc kms symmetric-key set-access-bindings](symmetric-key/set-access-bindings.md) — Set access bindings for the specified symmetric key and delete all existing access bindings if there were any
	- [yc kms symmetric-key add-access-binding](symmetric-key/add-access-binding.md) — Add access binding for the specified symmetric key
	- [yc kms symmetric-key remove-access-binding](symmetric-key/remove-access-binding.md) — Remove access binding for the specified symmetric key
- [yc kms symmetric-crypto](symmetric-crypto/index.md) — Perform symmetric crypto operations
	- [yc kms symmetric-crypto encrypt](symmetric-crypto/encrypt.md) — Encrypt data with specified symmetric key
	- [yc kms symmetric-crypto decrypt](symmetric-crypto/decrypt.md) — Decrypt data with specified symmetric key
	- [yc kms symmetric-crypto generate-data-key](symmetric-crypto/generate-data-key.md) — Generate data key and encrypt it with specified symmetric key
	- [yc kms symmetric-crypto re-encrypt](symmetric-crypto/re-encrypt.md) — Re-encrypt a ciphertext with the specified symmetric key

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
