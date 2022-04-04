---
sourcePath: ru/_cli-ref/cli-ref/managed-services/managed-sqlserver/resource-preset/index.md
---
# yc managed-sqlserver resource-preset

Manage SQLServer resource presets

#### Command Usage

Syntax: 

`yc managed-sqlserver resource-preset <command>`

Aliases: 

- `resource-presets`

#### Command Tree

- [yc managed-sqlserver resource-preset get](get.md) — Show information about the specified SQLServer resource preset
- [yc managed-sqlserver resource-preset list](list.md) — List available SQLServer resource presets.

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
