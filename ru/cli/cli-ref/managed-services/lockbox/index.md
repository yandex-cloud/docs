---
sourcePath: ru/_cli-ref/cli-ref/managed-services/lockbox/index.md
---
# yc lockbox

[PREVIEW] Manage Yandex Lockbox resources

#### Command Usage

Syntax: 

`yc lockbox <group>`

#### Command Tree

- [yc lockbox secret](secret/index.md) — Manage secrets
	- [yc lockbox secret get](secret/get.md) — Show information about the specified secret
	- [yc lockbox secret list](secret/list.md) — List secrets for the specified folder
	- [yc lockbox secret list-versions](secret/list-versions.md) — List versions for the specified secret
	- [yc lockbox secret create](secret/create.md) — Create a secret
	- [yc lockbox secret update](secret/update.md) — Update the specified secret
	- [yc lockbox secret add-version](secret/add-version.md) — Add new payload version for the specified secret based on an existing one
	- [yc lockbox secret delete](secret/delete.md) — Delete the specified secret
	- [yc lockbox secret activate](secret/activate.md) — Activate the specified secret
	- [yc lockbox secret deactivate](secret/deactivate.md) — Deactivate the specified secret
	- [yc lockbox secret schedule-version-destruction](secret/schedule-version-destruction.md) — Schedule destruction of the specified secret version
	- [yc lockbox secret cancel-version-destruction](secret/cancel-version-destruction.md) — Cancel destruction of the specified secret version
	- [yc lockbox secret list-operations](secret/list-operations.md) — List operations for the specified secret
	- [yc lockbox secret list-access-bindings](secret/list-access-bindings.md) — List access bindings for the specified secret
	- [yc lockbox secret set-access-bindings](secret/set-access-bindings.md) — Set access bindings for the specified secret and delete all existing access bindings if there were any
	- [yc lockbox secret add-access-binding](secret/add-access-binding.md) — Add access binding for the specified secret
	- [yc lockbox secret remove-access-binding](secret/remove-access-binding.md) — Remove access binding for the specified secret
- [yc lockbox payload](payload/index.md) — Access secret payload
	- [yc lockbox payload get](payload/get.md) — Get payload of the specified secret

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
