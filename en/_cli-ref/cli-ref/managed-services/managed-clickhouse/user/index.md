---
editable: false
---

# yc managed-clickhouse user

Manage ClickHouse users.

#### Command Usage

Syntax: 

`yc managed-clickhouse user <command>`

Aliases: 

- `users`

#### Command Tree

- [yc managed-clickhouse user get](get.md) — Get information about a ClickHouse user.
- [yc managed-clickhouse user list](list.md) — List users for a ClickHouse cluster.
- [yc managed-clickhouse user create](create.md) — Create a ClickHouse user.
- [yc managed-clickhouse user update](update.md) — Modify attributes of a ClickHouse user.
- [yc managed-clickhouse user delete](delete.md) — Delete a ClickHouse user.
- [yc managed-clickhouse user grant-permission](grant-permission.md) — Grant a permission to a ClickHouse user.
- [yc managed-clickhouse user revoke-permission](revoke-permission.md) — Revoke a permission from a ClickHouse user.
- [yc managed-clickhouse user add-quota](add-quota.md) — Add quota to a ClickHouse user.
- [yc managed-clickhouse user update-quota](update-quota.md) — Update ClickHouse user quota by interval.
- [yc managed-clickhouse user remove-quota](remove-quota.md) — Remove quota from a ClickHouse user by interval.

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
