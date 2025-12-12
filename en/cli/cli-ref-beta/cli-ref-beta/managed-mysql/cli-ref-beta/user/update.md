---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mysql/cli-ref-beta/user/update.md
---

# yc beta managed-mysql user update

Updates a user in a cluster.

#### Command Usage

Syntax: 

`yc beta managed-mysql user update <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--authentication-plugin`|<b>`enum`</b><br/>New user authentication plugin. Possible Values: 'mysql-native-password', 'caching-sha2-password', 'sha256-password', 'mysql-no-login', 'mdb-iamproxy-auth'|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to update the user in. To get this ID, make a [ClusterService.List] request.|
|`--connection-limits`|<b>`shorthand/json`</b><br/>Set of changed user connection limits.<br/>Shorthand Syntax:<br/>{<br/>max-connections-per-hour = int,<br/>max-questions-per-hour = int,<br/>max-updates-per-hour = int,<br/>max-user-connections = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"max-connections-per-hour": "int",<br/>"max-questions-per-hour": "int",<br/>"max-updates-per-hour": "int",<br/>"max-user-connections": "int"<br/>}"<br/>Fields:<br/>max-connections-per-hour -> (int)<br/>The maximum permitted number of simultaneous client connections per hour.<br/>max-questions-per-hour -> (int)<br/>The maximum permitted number of user questions per hour.<br/>max-updates-per-hour -> (int)<br/>The maximum permitted number of user updates per hour.<br/>max-user-connections -> (int)<br/>The maximum number of simultaneous connections permitted to any given MySQL user account.|
|`--generate-password`|Generate password using Connection Manager.|
|`--global-permissions`|<b>`int32Slice`</b><br/>New set of global permissions to grant to the user.|
|`--password`|<b>`string`</b><br/>New password for the user.|
|`--permissions`|<b>`shorthand/json`</b><br/>A new set of permissions that should be granted to the user.<br/>Shorthand Syntax:<br/>[<br/>{<br/>database-name = str,<br/>roles = ALL_PRIVILEGES\|ALTER\|ALTER_ROUTINE\|CREATE\|CREATE_ROUTINE\|CREATE_TEMPORARY_TABLES\|CREATE_VIEW\|DELETE\|DROP\|EVENT\|EXECUTE\|INDEX\|INSERT\|LOCK_TABLES\|SELECT\|SHOW_VIEW\|TRIGGER\|UPDATE\|REFERENCES,...<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"database-name": "str",<br/>"roles": [<br/>"ALL_PRIVILEGES\|ALTER\|ALTER_ROUTINE\|CREATE\|CREATE_ROUTINE\|CREATE_TEMPORARY_TABLES\|CREATE_VIEW\|DELETE\|DROP\|EVENT\|EXECUTE\|INDEX\|INSERT\|LOCK_TABLES\|SELECT\|SHOW_VIEW\|TRIGGER\|UPDATE\|REFERENCES", ...<br/>]<br/>}, ...<br/>]"<br/>Fields:<br/>database-name -> (string)<br/>Name of the database that the permission grants access to.<br/>roles -> ([]int)<br/>Roles granted to the user within the database. See documentation for details.|
|`--user-name`|<b>`string`</b><br/>Name of the user to update. To get this name, make a [UserService.List] request.|
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
