---
sourcePath: ru/_cli-ref/cli-ref/managed-services/iot/device/index.md
---
# yc iot device

Manage IoT devices

#### Command Usage

Syntax: 

`yc iot device <group|command>`

Aliases: 

- `devices`

#### Command Tree

- [yc iot device get](get.md) — Show information about specified device
- [yc iot device list](list.md) — List IoT devices
- [yc iot device create](create.md) — Create new device device
- [yc iot device update](update.md) — Update specified device
- [yc iot device logs](logs.md) — Show logs for the specified device
- [yc iot device add-topic-aliases](add-topic-aliases.md) — Add aliases for topics of specified device
- [yc iot device remove-topic-aliases](remove-topic-aliases.md) — Remove aliases for topics of specified device
- [yc iot device delete](delete.md) — Delete specified device
- [yc iot device certificate](certificate/index.md) — Manage IoT device certificates
	- [yc iot device certificate list](certificate/list.md) — List certificates associated with specified device
	- [yc iot device certificate add](certificate/add.md) — Add new certificate to specified device
	- [yc iot device certificate delete](certificate/delete.md) — Delete specified certificate from device
- [yc iot device password](password/index.md) — Manage IoT device passwords
	- [yc iot device password list](password/list.md) — List passwords associated with specified device
	- [yc iot device password add](password/add.md) — Add new password to specified device
	- [yc iot device password delete](password/delete.md) — Delete specified password from specified device

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
