---
editable: false
---

# yc dns zone

Manage dns zones

#### Command Usage

Syntax: 

`yc dns zone <command>`

Aliases: 

- `zones`

#### Command Tree

- [yc dns zone get](get.md) — Get information about a dns zone.
- [yc dns zone list](list.md) — List dns zones in folder.
- [yc dns zone create](create.md) — Create a dns zone in the specified folder.
- [yc dns zone update](update.md) — Modify configuration or attributes of a dns zone.
- [yc dns zone delete](delete.md) — Delete a dns zone.
- [yc dns zone list-records](list-records.md) — List dns zone records.
- [yc dns zone add-records](add-records.md) — Add records to dns zone.
- [yc dns zone delete-records](delete-records.md) — Delete records from dns zone.
- [yc dns zone replace-records](replace-records.md) — Replace all records specified by name and type in dns zone with new ones.
- [yc dns zone add-labels](add-labels.md) — Assign labels to the specified dns zone.
- [yc dns zone remove-labels](remove-labels.md) — Remove labels from the specified dns zone
- [yc dns zone list-operations](list-operations.md) — List operations of the specified dns zone.
- [yc dns zone list-access-bindings](list-access-bindings.md) — List access bindings of the specified dns zone.
- [yc dns zone set-access-bindings](set-access-bindings.md) — Set access bindings to the specified dns zone and delete all existing access bindings if there are any.
- [yc dns zone add-access-binding](add-access-binding.md) — Add access binding to the specified dns zone
- [yc dns zone remove-access-binding](remove-access-binding.md) — Remove access binding from the specified dns zone

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
