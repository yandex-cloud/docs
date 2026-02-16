---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-mysql/cli-ref/user/create.md
---

# yc managed-mysql user create

Create a MySQL user

#### Command Usage

Syntax:

`yc managed-mysql user create <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

MySQL cluster id. ||
|| `--cluster-name` | `string`

MySQL cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--password` | `string`

Password of the MySQL user. ||
|| `--permissions` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Database names and roles. Can be specified multiple times.

Format: database=DBNAME,role=ROLE1,role=ROLE2.

Possible property names:

- `database`: Name of the database that the permission grants access to.

- `role`: Role in the database to assign to the user. Can be specified multiple times. ||
|| `--global-permissions` | `value[,value]`

User global access roles, possible values: FLUSH_OPTIMIZER_COSTS,MDB_ADMIN,PROCESS,REPLICATION_CLIENT,REPLICATION_SLAVE,SHOW_ROUTINE ||
|| `--authentication-plugin` | `string`

Authentication plugin of the MySQL user. ||
|| `--generate-password` | Generate password using Connection Manager. ||
|| `--max-questions-per-hour` | `int`

The maximum permitted number of user questions per hour. ||
|| `--max-updates-per-hour` | `int`

The maximum permitted number of user updates per hour. ||
|| `--max-connections-per-hour` | `int`

The maximum permitted number of simultaneous client connections per hour. ||
|| `--max-user-connections` | `int`

The maximum number of simultaneous connections permitted to any given MySQL user account. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#