---
editable: false
---

# yc kms asymmetric-signature-key

Manage asymmetric signature keys

#### Command Usage

Syntax: 

`yc kms asymmetric-signature-key <command>`

Aliases: 

- `asymmetric-signature-keys`

#### Command Tree

- [yc kms asymmetric-signature-key get](get.md) — Show information about the specified asymmetric signature key
- [yc kms asymmetric-signature-key list](list.md) — List asymmetric signature keys of the specified folder
- [yc kms asymmetric-signature-key create](create.md) — Create asymmetric signature key
- [yc kms asymmetric-signature-key update](update.md) — Update the specified asymmetric signature key
- [yc kms asymmetric-signature-key delete](delete.md) — Delete the specified asymmetric signature key
- [yc kms asymmetric-signature-key list-operations](list-operations.md) — List operations for the specified asymmetric signature key
- [yc kms asymmetric-signature-key list-access-bindings](list-access-bindings.md) — List access bindings for the specified asymmetric signature key
- [yc kms asymmetric-signature-key set-access-bindings](set-access-bindings.md) — Set access bindings for the specified asymmetric signature key and delete all existing access bindings if there were any
- [yc kms asymmetric-signature-key add-access-binding](add-access-binding.md) — Add access binding for the specified asymmetric signature key
- [yc kms asymmetric-signature-key remove-access-binding](remove-access-binding.md) — Remove access binding for the specified asymmetric signature key

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
|`-h`,`--help`|Display help for the command.|
