---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-kafka/cli-ref-beta/user/index.md
---

# yc beta managed-kafka user

A set of methods for managing Kafka users.

#### Command Usage

Syntax: 

`yc beta managed-kafka user <command>`

#### Command Tree

- [yc beta managed-kafka user create](create.md) — Creates a Kafka user in the specified cluster.
- [yc beta managed-kafka user delete](delete.md) — Deletes the specified Kafka user.
- [yc beta managed-kafka user get](get.md) — Returns the specified Kafka user.
- [yc beta managed-kafka user grant-permission](grant-permission.md) — Grants permission to the specified Kafka user.
- [yc beta managed-kafka user list](list.md) — Retrieves the list of Kafka users in the specified cluster.
- [yc beta managed-kafka user revoke-permission](revoke-permission.md) — Revokes permission from the specified Kafka user.
- [yc beta managed-kafka user update](update.md) — Updates the specified Kafka user.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
