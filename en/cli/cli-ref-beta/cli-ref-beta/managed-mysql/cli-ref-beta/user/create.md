---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-mysql/cli-ref-beta/user/create.md
---

# yc beta managed-mysql user create

Creates a user in a cluster.

#### Command Usage

Syntax: 

`yc beta managed-mysql user create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to create the user in. To get this ID, make a [ClusterService.List] request.|
|`--user-spec`|<b>`shorthand/json`</b><br/>Configuration of the user.<br/>Shorthand Syntax:<br/>{<br/>authentication-plugin = MYSQL_NATIVE_PASSWORD\|CACHING_SHA2_PASSWORD\|SHA256_PASSWORD\|MYSQL_NO_LOGIN\|MDB_IAMPROXY_AUTH,<br/>connection-limits = {<br/>max-connections-per-hour = int,<br/>max-questions-per-hour = int,<br/>max-updates-per-hour = int,<br/>max-user-connections = int<br/>},<br/>generate-password = bool,<br/>global-permissions = REPLICATION_CLIENT\|REPLICATION_SLAVE\|PROCESS\|FLUSH_OPTIMIZER_COSTS\|SHOW_ROUTINE\|MDB_ADMIN,...,<br/>name = str,<br/>password = str,<br/>permissions = [<br/>{<br/>database-name = str,<br/>roles = ALL_PRIVILEGES\|ALTER\|ALTER_ROUTINE\|CREATE\|CREATE_ROUTINE\|CREATE_TEMPORARY_TABLES\|CREATE_VIEW\|DELETE\|DROP\|EVENT\|EXECUTE\|INDEX\|INSERT\|LOCK_TABLES\|SELECT\|SHOW_VIEW\|TRIGGER\|UPDATE\|REFERENCES,...<br/>}, ...<br/>]<br/>}<br/>JSON Syntax:<br/>"{<br/>"authentication-plugin": "MYSQL_NATIVE_PASSWORD\|CACHING_SHA2_PASSWORD\|SHA256_PASSWORD\|MYSQL_NO_LOGIN\|MDB_IAMPROXY_AUTH",<br/>"connection-limits": {<br/>"max-connections-per-hour": "int",<br/>"max-questions-per-hour": "int",<br/>"max-updates-per-hour": "int",<br/>"max-user-connections": "int"<br/>},<br/>"generate-password": "bool",<br/>"global-permissions": [<br/>"REPLICATION_CLIENT\|REPLICATION_SLAVE\|PROCESS\|FLUSH_OPTIMIZER_COSTS\|SHOW_ROUTINE\|MDB_ADMIN", ...<br/>],<br/>"name": "str",<br/>"password": "str",<br/>"permissions": [<br/>{<br/>"database-name": "str",<br/>"roles": [<br/>"ALL_PRIVILEGES\|ALTER\|ALTER_ROUTINE\|CREATE\|CREATE_ROUTINE\|CREATE_TEMPORARY_TABLES\|CREATE_VIEW\|DELETE\|DROP\|EVENT\|EXECUTE\|INDEX\|INSERT\|LOCK_TABLES\|SELECT\|SHOW_VIEW\|TRIGGER\|UPDATE\|REFERENCES", ...<br/>]<br/>}, ...<br/>]<br/>}"<br/>Fields:<br/>authentication-plugin -> (enum<CACHING_SHA2_PASSWORD\|MDB_IAMPROXY_AUTH\|MYSQL_NATIVE_PASSWORD\|MYSQL_NO_LOGIN\|SHA256_PASSWORD>)<br/>User authentication plugin.<br/>connection-limits -> (struct)<br/>Set of user connection limits.<br/>max-connections-per-hour -> (int)<br/>The maximum permitted number of simultaneous client connections per hour.<br/>max-questions-per-hour -> (int)<br/>The maximum permitted number of user questions per hour.<br/>max-updates-per-hour -> (int)<br/>The maximum permitted number of user updates per hour.<br/>max-user-connections -> (int)<br/>The maximum number of simultaneous connections permitted to any given MySQL user account.<br/>generate-password -> (bool)<br/>Generate password using Connection Manager.<br/>global-permissions -> ([]int)<br/>Set of global permissions to grant to the user.<br/>name -> (string)<br/>Name of the user.<br/>password -> (string)<br/>Password of the user.<br/>permissions -> ([]struct)<br/>Set of permissions granted to the user to access specific databases. One permission per database. When a permission for a database is set, the user will have access to the database.<br/>database-name -> (string)<br/>Name of the database that the permission grants access to.<br/>roles -> ([]int)<br/>Roles granted to the user within the database. See documentation for details.|
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
