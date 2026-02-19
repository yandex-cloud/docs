---
editable: false
noIndex: true
---

# yc beta managed-mysql user update

Updates a user in a cluster.

#### Command Usage

Syntax:

`yc beta managed-mysql user update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--authentication-plugin` | `enum`

New user authentication plugin. Possible Values: 'mysql-native-password', 'caching-sha2-password', 'sha256-password', 'mysql-no-login', 'mdb-iamproxy-auth' ||
|| `--cluster-id` | `string`

ID of the cluster to update the user in. To get this ID, make a [ClusterService.List] request. ||
|| `--connection-limits` | `shorthand/json`

Set of changed user connection limits.

Shorthand Syntax:

```hcl
{
  max-connections-per-hour = integer,
  max-questions-per-hour = integer,
  max-updates-per-hour = integer,
  max-user-connections = integer
}
```

JSON Syntax:

```json
{
  "max-connections-per-hour": "integer",
  "max-questions-per-hour": "integer",
  "max-updates-per-hour": "integer",
  "max-user-connections": "integer"
}
```

Fields:

```
max-connections-per-hour -> (integer)
  The maximum permitted number of simultaneous client connections per hour.
max-questions-per-hour -> (integer)
  The maximum permitted number of user questions per hour.
max-updates-per-hour -> (integer)
  The maximum permitted number of user updates per hour.
max-user-connections -> (integer)
  The maximum number of simultaneous connections permitted to any given MySQL user account.
``` ||
|| `--generate-password` | Generate password using Connection Manager. ||
|| `--global-permissions` | `shorthand/json`

New set of global permissions to grant to the user.

Shorthand Syntax:

```hcl
[
  REPLICATION_CLIENT|REPLICATION_SLAVE|PROCESS|FLUSH_OPTIMIZER_COSTS|SHOW_ROUTINE|MDB_ADMIN, ...
]
```

JSON Syntax:

```json
[
  "REPLICATION_CLIENT|REPLICATION_SLAVE|PROCESS|FLUSH_OPTIMIZER_COSTS|SHOW_ROUTINE|MDB_ADMIN", ...
]
``` ||
|| `--password` | `string`

New password for the user. ||
|| `--permissions` | `shorthand/json`

A new set of permissions that should be granted to the user.

Shorthand Syntax:

```hcl
[
  {
    database-name = string,
    roles = [
      ALL_PRIVILEGES|ALTER|ALTER_ROUTINE|CREATE|CREATE_ROUTINE|CREATE_TEMPORARY_TABLES|CREATE_VIEW|DELETE|DROP|EVENT|EXECUTE|INDEX|INSERT|LOCK_TABLES|SELECT|SHOW_VIEW|TRIGGER|UPDATE|REFERENCES, ...
    ]
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "database-name": "string",
    "roles": [
      "ALL_PRIVILEGES|ALTER|ALTER_ROUTINE|CREATE|CREATE_ROUTINE|CREATE_TEMPORARY_TABLES|CREATE_VIEW|DELETE|DROP|EVENT|EXECUTE|INDEX|INSERT|LOCK_TABLES|SELECT|SHOW_VIEW|TRIGGER|UPDATE|REFERENCES", ...
    ]
  }, ...
]
```

Fields:

```
database-name -> (string)
  Name of the database that the permission grants access to.
roles -> ([]struct)
  Roles granted to the user within the database. See documentation for details.
``` ||
|| `--user-name` | `string`

Name of the user to update. To get this name, make a [UserService.List] request. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#