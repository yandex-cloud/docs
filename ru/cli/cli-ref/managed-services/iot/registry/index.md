---
sourcePath: en/_cli-ref/cli-ref/managed-services/iot/registry/index.md
---
# yc iot registry

Manage IoT registries

#### Command Usage

Syntax: 

`yc iot registry <group|command>`

Aliases: 

- `registries`

#### Command Tree

- [yc iot registry get](get.md) — Show information about specified registry
- [yc iot registry list](list.md) — List IoT registries
- [yc iot registry create](create.md) — Create new device registry
- [yc iot registry update](update.md) — Update specified registry
- [yc iot registry logs](logs.md) — Show logs for the specified registry
- [yc iot registry add-labels](add-labels.md) — Add labels to specified registry
- [yc iot registry remove-labels](remove-labels.md) — Remove labels from specified registry
- [yc iot registry delete](delete.md) — Delete specified registry
- [yc iot registry list-device-topic-aliases](list-device-topic-aliases.md) — List all topic aliases set for devices in this registry
- [yc iot registry certificate](certificate/index.md) — Manage IoT device registry certificates
	- [yc iot registry certificate list](certificate/list.md) — List certificates associated with specified registry
	- [yc iot registry certificate add](certificate/add.md) — Add new certificate to specified registry
	- [yc iot registry certificate delete](certificate/delete.md) — Delete specified certificate from registry
- [yc iot registry password](password/index.md) — Manage IoT device registry passwords
	- [yc iot registry password list](password/list.md) — List passwords associated with specified registry
	- [yc iot registry password add](password/add.md) — Add new password to specified registry
	- [yc iot registry password delete](password/delete.md) — Delete specified password from specified registry

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
