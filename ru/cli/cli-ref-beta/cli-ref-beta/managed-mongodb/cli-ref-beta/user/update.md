---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mongodb/cli-ref-beta/user/update.md
---

# yc beta managed-mongodb user update

Updates the specified MongoDB user.

#### Command Usage

Syntax: 

`yc beta managed-mongodb user update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the MongoDB cluster the user belongs to.<br/>To get the cluster ID, use a [ClusterService.List] request.|
|`--password`|<b>`string`</b><br/>New password for the user.|
|`--permissions`|<b>`shorthand/json`</b><br/>New set of permissions for the user.<br/><br/>Example:|
|`--permissions`|<b>`[{database-name=value,`</b><br/>roles=value}]<br/><br/>Shorthand Syntax:<br/>[{database-name=str, roles=str,...},...]<br/>Fields:<br/>database-name  string    — Name of the database that the permission grants access to.<br/>roles          []string  — MongoDB roles for the [database_name] database that the permission grants.<br/>|
|`--user-name`|<b>`string`</b><br/>Name of the user to be updated.<br/>To get the name of the user, use a [UserService.List] request.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
