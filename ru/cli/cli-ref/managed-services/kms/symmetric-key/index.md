---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/kms/symmetric-key/index.md
---

# yc kms symmetric-key

Manage symmetric keys

#### Command Usage

Syntax: 

`yc kms symmetric-key <command>`

Aliases: 

- `symmetric-keys`

#### Command Tree

- [yc kms symmetric-key get](get.md) — Show information about the specified symmetric key
- [yc kms symmetric-key list](list.md) — List symmetric keys of the specified folder
- [yc kms symmetric-key list-versions](list-versions.md) — List versions of the specified symmetric key
- [yc kms symmetric-key create](create.md) — Create symmetric key
- [yc kms symmetric-key update](update.md) — Update the specified symmetric key
- [yc kms symmetric-key delete](delete.md) — Delete the specified symmetric key
- [yc kms symmetric-key set-primary-version](set-primary-version.md) — Set primary version of the specified symmetric key
- [yc kms symmetric-key schedule-version-destruction](schedule-version-destruction.md) — Schedule destruction of the specified symmetric key version
- [yc kms symmetric-key cancel-version-destruction](cancel-version-destruction.md) — Cancel destruction of the scheduled for destruction symmetric key version
- [yc kms symmetric-key rotate](rotate.md) — Rotate the specified symmetric key: creates a new key version and makes it the primary version
- [yc kms symmetric-key list-operations](list-operations.md) — List operations for the specified symmetric key
- [yc kms symmetric-key list-access-bindings](list-access-bindings.md) — List access bindings for the specified symmetric key
- [yc kms symmetric-key set-access-bindings](set-access-bindings.md) — Set access bindings for the specified symmetric key and delete all existing access bindings if there were any
- [yc kms symmetric-key add-access-binding](add-access-binding.md) — Add access binding for the specified symmetric key
- [yc kms symmetric-key remove-access-binding](remove-access-binding.md) — Remove access binding for the specified symmetric key

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
