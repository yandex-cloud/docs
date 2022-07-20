---
sourcePath: en/_cli-ref/cli-ref/managed-services/iot/index.md
---
# yc iot

Manage Yandex IoT Core resources

#### Command Usage

Syntax: 

`yc iot <group>`

#### Command Tree

- [yc iot registry](registry/index.md) — Manage IoT registries
	- [yc iot registry get](registry/get.md) — Show information about specified registry
	- [yc iot registry list](registry/list.md) — List IoT registries
	- [yc iot registry create](registry/create.md) — Create new device registry
	- [yc iot registry update](registry/update.md) — Update specified registry
	- [yc iot registry logs](registry/logs.md) — Show logs for the specified registry
	- [yc iot registry add-labels](registry/add-labels.md) — Add labels to specified registry
	- [yc iot registry remove-labels](registry/remove-labels.md) — Remove labels from specified registry
	- [yc iot registry delete](registry/delete.md) — Delete specified registry
	- [yc iot registry list-device-topic-aliases](registry/list-device-topic-aliases.md) — List all topic aliases set for devices in this registry
- [yc iot device](device/index.md) — Manage IoT devices
	- [yc iot device get](device/get.md) — Show information about specified device
	- [yc iot device list](device/list.md) — List IoT devices
	- [yc iot device create](device/create.md) — Create new device device
	- [yc iot device update](device/update.md) — Update specified device
	- [yc iot device logs](device/logs.md) — Show logs for the specified device
	- [yc iot device add-topic-aliases](device/add-topic-aliases.md) — Add aliases for topics of specified device
	- [yc iot device remove-topic-aliases](device/remove-topic-aliases.md) — Remove aliases for topics of specified device
	- [yc iot device delete](device/delete.md) — Delete specified device
- [yc iot mqtt](mqtt/index.md) — Exchange MQTT messages
	- [yc iot mqtt publish](mqtt/publish.md) — Publish telemetry
	- [yc iot mqtt subscribe](mqtt/subscribe.md) — Subscribe telemetry

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
