---
editable: false
noIndex: true
---

# yc beta managed-mysql user create

Creates a user in a cluster.

#### Command Usage

Syntax:

`yc beta managed-mysql user create <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cluster-id` | `string`

ID of the cluster to create the user in. To get this ID, make a [ClusterService.List] request. ||
|| `--user-spec` | `shorthand/json`

Configuration of the user.

Shorthand Syntax:

```hcl
{
  authentication-plugin = MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH,
  connection-limits = {
    max-connections-per-hour = integer,
    max-questions-per-hour = integer,
    max-updates-per-hour = integer,
    max-user-connections = integer
  },
  generate-password = boolean,
  global-permissions = [
    REPLICATION_CLIENT|REPLICATION_SLAVE|PROCESS|FLUSH_OPTIMIZER_COSTS|SHOW_ROUTINE|MDB_ADMIN, ...
  ],
  name = string,
  password = string,
  permissions = [
    {
      database-name = string,
      roles = [
        ALL_PRIVILEGES|ALTER|ALTER_ROUTINE|CREATE|CREATE_ROUTINE|CREATE_TEMPORARY_TABLES|CREATE_VIEW|DELETE|DROP|EVENT|EXECUTE|INDEX|INSERT|LOCK_TABLES|SELECT|SHOW_VIEW|TRIGGER|UPDATE|REFERENCES, ...
      ]
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "authentication-plugin": "MYSQL_NATIVE_PASSWORD|CACHING_SHA2_PASSWORD|SHA256_PASSWORD|MYSQL_NO_LOGIN|MDB_IAMPROXY_AUTH",
  "connection-limits": {
    "max-connections-per-hour": "integer",
    "max-questions-per-hour": "integer",
    "max-updates-per-hour": "integer",
    "max-user-connections": "integer"
  },
  "generate-password": "boolean",
  "global-permissions": [
    "REPLICATION_CLIENT|REPLICATION_SLAVE|PROCESS|FLUSH_OPTIMIZER_COSTS|SHOW_ROUTINE|MDB_ADMIN", ...
  ],
  "name": "string",
  "password": "string",
  "permissions": [
    {
      "database-name": "string",
      "roles": [
        "ALL_PRIVILEGES|ALTER|ALTER_ROUTINE|CREATE|CREATE_ROUTINE|CREATE_TEMPORARY_TABLES|CREATE_VIEW|DELETE|DROP|EVENT|EXECUTE|INDEX|INSERT|LOCK_TABLES|SELECT|SHOW_VIEW|TRIGGER|UPDATE|REFERENCES", ...
      ]
    }, ...
  ]
}
```

Fields:

```
authentication-plugin -> (struct)
  User authentication plugin.
connection-limits -> (struct)
  Set of user connection limits.
  max-connections-per-hour -> (integer)
    The maximum permitted number of simultaneous client connections per hour.
  max-questions-per-hour -> (integer)
    The maximum permitted number of user questions per hour.
  max-updates-per-hour -> (integer)
    The maximum permitted number of user updates per hour.
  max-user-connections -> (integer)
    The maximum number of simultaneous connections permitted to any given MySQL user account.
generate-password -> (boolean)
  Generate password using Connection Manager.
global-permissions -> ([]struct)
  Set of global permissions to grant to the user.
name -> (string)
  Name of the user.
password -> (string)
  Password of the user.
permissions -> ([]struct)
  Set of permissions granted to the user to access specific databases. One permission per database. When a permission for a database is set, the user will have access to the database.
  database-name -> (string)
    Name of the database that the permission grants access to.
  roles -> ([]struct)
    Roles granted to the user within the database. See documentation for details.
``` ||
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