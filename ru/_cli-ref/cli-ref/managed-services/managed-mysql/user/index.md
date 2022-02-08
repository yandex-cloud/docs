# yc managed-mysql user

Manage MySQL users

#### Command Usage

Syntax: 

`yc managed-mysql user <command>`

Aliases: 

- `users`

#### Command Tree

- [yc managed-mysql user get](get.md) — Show information about the specified MySQL user
- [yc managed-mysql user list](list.md) — List users for the specified MySQL cluster
- [yc managed-mysql user create](create.md) — Create a MySQL user
- [yc managed-mysql user update](update.md) — Update the specified MySQL user
- [yc managed-mysql user delete](delete.md) — Delete the specified MySQL user
- [yc managed-mysql user grant-permission](grant-permission.md) — Grant permission to the specified MySQL user
- [yc managed-mysql user revoke-permission](revoke-permission.md) — Revoke permission from the specified MySQL user

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
