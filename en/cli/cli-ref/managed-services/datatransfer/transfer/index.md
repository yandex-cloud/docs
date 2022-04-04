---
sourcePath: en/_cli-ref/cli-ref/managed-services/datatransfer/transfer/index.md
---
# yc datatransfer transfer

Manage transfers

#### Command Usage

Syntax: 

`yc datatransfer transfer <command>`

#### Command Tree

- [yc datatransfer transfer create](create.md) — Create transfer
- [yc datatransfer transfer update](update.md) — Update transfer
- [yc datatransfer transfer delete](delete.md) — Delete transfer
- [yc datatransfer transfer get](get.md) — Get transfer
- [yc datatransfer transfer list](list.md) — List transfers in folder
- [yc datatransfer transfer activate](activate.md) — Activate transfer
- [yc datatransfer transfer deactivate](deactivate.md) — Deactivate transfer

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
