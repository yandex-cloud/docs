---
editable: false
---

# yc iam federation

Manage federations

#### Command Usage

Syntax: 

`yc iam federation <command>`

Aliases: 

- `federations`

#### Command Tree

- [yc iam federation get](get.md) — Show information about the specified federation
- [yc iam federation list](list.md) — List federations
- [yc iam federation create](create.md) — Create a federation
- [yc iam federation update](update.md) — Update the specified federation
- [yc iam federation delete](delete.md) — Delete the specified federation
- [yc iam federation add-user-accounts](add-user-accounts.md) — Add user accounts to the specified federation
- [yc iam federation list-user-accounts](list-user-accounts.md) — List user accounts of the specified federation
- [yc iam federation list-operations](list-operations.md) — List operations for the specified federation

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
