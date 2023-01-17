---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-mongodb/user/index.md
---

# yc managed-mongodb user

Manage MongoDB users.

#### Command Usage

Syntax: 

`yc managed-mongodb user <command>`

Aliases: 

- `users`

#### Command Tree

- [yc managed-mongodb user get](get.md) — Get information about a MongoDB user.
- [yc managed-mongodb user list](list.md) — List users for a MongoDB cluster.
- [yc managed-mongodb user create](create.md) — Create a MongoDB user.
- [yc managed-mongodb user update](update.md) — Modify attributes of a MongoDB user.
- [yc managed-mongodb user delete](delete.md) — Delete a MongoDB user.
- [yc managed-mongodb user grant-permission](grant-permission.md) — Grant a permission to the specified MongoDB user.
- [yc managed-mongodb user revoke-permission](revoke-permission.md) — Revoke a permission from the specified MongoDB user.

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
