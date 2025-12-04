---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mongodb/cli-ref-beta/user/index.md
---

# yc beta managed-mongodb user

A set of methods for managing MongoDB User resources.

#### Command Usage

Syntax: 

`yc beta managed-mongodb user <command>`

#### Command Tree

- [yc beta managed-mongodb user create](create.md) — Creates a MongoDB user in the specified cluster.
- [yc beta managed-mongodb user delete](delete.md) — Deletes the specified MongoDB user.
- [yc beta managed-mongodb user get](get.md) — Returns the specified MongoDB User resource.
- [yc beta managed-mongodb user grant-permission](grant-permission.md) — Grants permission to the specified MongoDB user.
- [yc beta managed-mongodb user list](list.md) — Retrieves the list of MongoDB User resources in the specified cluster.
- [yc beta managed-mongodb user revoke-permission](revoke-permission.md) — Revokes permission from the specified MongoDB user.
- [yc beta managed-mongodb user update](update.md) — Updates the specified MongoDB user.

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
