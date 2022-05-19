# yc ydb backup

Manage YDB backups.

#### Command Usage

Syntax: 

`yc ydb backup <command>`

#### Command Tree

- [yc ydb backup get](get.md) — Get information about the specified YDB backup.
- [yc ydb backup list](list.md) — List YDB backups in a folder.
- [yc ydb backup delete](delete.md) — Delete the specified YDB backups.
- [yc ydb backup list-access-bindings](list-access-bindings.md) — List access bindings for the specified YDB backup.
- [yc ydb backup set-access-bindings](set-access-bindings.md) — Set access bindings for the specified YDB backup and delete all existing access bindings if there were any.
- [yc ydb backup add-access-binding](add-access-binding.md) — Add access binding for the specified YDB backup.
- [yc ydb backup remove-access-binding](remove-access-binding.md) — Remove access binding for the specified YDB backup.

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
