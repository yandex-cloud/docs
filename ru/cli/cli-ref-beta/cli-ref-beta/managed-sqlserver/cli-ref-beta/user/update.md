---
editable: false
noIndex: true
---

# yc beta managed-sqlserver user update

Modifies the specified SQL Server user.

#### Command Usage

Syntax:

`yc beta managed-sqlserver user update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the SQL Server cluster the user belongs to. To get the cluster ID, use a [ClusterService.List] request. ||
|| `--password` | `string`

New password for the user. ||
|| `--permissions` | `shorthand/json`

New set of permissions for the user.

Shorthand Syntax:

```hcl
[
  {
    database-name = string,
    roles = [
      DB_OWNER|DB_SECURITYADMIN|DB_ACCESSADMIN|DB_BACKUPOPERATOR|DB_DDLADMIN|DB_DATAWRITER|DB_DATAREADER|DB_DENYDATAWRITER|DB_DENYDATAREADER, ...
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
      "DB_OWNER|DB_SECURITYADMIN|DB_ACCESSADMIN|DB_BACKUPOPERATOR|DB_DDLADMIN|DB_DATAWRITER|DB_DATAREADER|DB_DENYDATAWRITER|DB_DENYDATAREADER", ...
    ]
  }, ...
]
```

Fields:

```
database-name -> (string)
  Name of the database the permission grants access to.
roles -> ([]struct)
  Roles granted to the user within the database.
``` ||
|| `--server-roles` | `shorthand/json`

New set of server roles granted to the login.

Shorthand Syntax:

```hcl
[
  MDB_MONITOR, ...
]
```

JSON Syntax:

```json
[
  "MDB_MONITOR", ...
]
``` ||
|| `--user-name` | `string`

Name of the user to be updated. To get the name of the user use a [UserService.List] request. ||
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