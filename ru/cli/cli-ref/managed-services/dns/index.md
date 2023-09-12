---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/dns/index.md
---

# yc dns

Manage Yandex DNS resources

#### Command Usage

Syntax: 

`yc dns <group>`

#### Command Tree

- [yc dns zone](zone/index.md) — Manage dns zones
	- [yc dns zone get](zone/get.md) — Get information about a dns zone.
	- [yc dns zone list](zone/list.md) — List dns zones in folder.
	- [yc dns zone create](zone/create.md) — Create a dns zone in the specified folder.
	- [yc dns zone update](zone/update.md) — Modify configuration or attributes of a dns zone.
	- [yc dns zone update-private-networks](zone/update-private-networks.md) — Modify private networks of a dns zone.
	- [yc dns zone delete](zone/delete.md) — Delete a dns zone.
	- [yc dns zone list-records](zone/list-records.md) — List dns zone records.
	- [yc dns zone add-records](zone/add-records.md) — Add records to dns zone.
	- [yc dns zone delete-records](zone/delete-records.md) — Delete records from dns zone.
	- [yc dns zone replace-records](zone/replace-records.md) — Replace all records specified by name and type in dns zone with new ones.
	- [yc dns zone add-labels](zone/add-labels.md) — Assign labels to the specified dns zone.
	- [yc dns zone remove-labels](zone/remove-labels.md) — Remove labels from the specified dns zone
	- [yc dns zone list-operations](zone/list-operations.md) — List operations of the specified dns zone.
	- [yc dns zone list-access-bindings](zone/list-access-bindings.md) — List access bindings of the specified dns zone.
	- [yc dns zone set-access-bindings](zone/set-access-bindings.md) — Set access bindings to the specified dns zone and delete all existing access bindings if there are any.
	- [yc dns zone add-access-binding](zone/add-access-binding.md) — Add access binding to the specified dns zone
	- [yc dns zone remove-access-binding](zone/remove-access-binding.md) — Remove access binding from the specified dns zone
- [yc dns bind-file](bind-file/index.md) — Manage bind file
	- [yc dns bind-file migrate-to-terraform](bind-file/migrate-to-terraform.md) — Writes terraform specification to stdout

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
