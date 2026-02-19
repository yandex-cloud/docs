---
editable: false
noIndex: true
---

# yc beta managed-mongodb user update

Updates the specified MongoDB user.

#### Command Usage

Syntax:

`yc beta managed-mongodb user update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the MongoDB cluster the user belongs to. To get the cluster ID, use a [ClusterService.List] request. ||
|| `--password` | `string`

New password for the user. ||
|| `--permissions` | `shorthand/json`

New set of permissions for the user.

Shorthand Syntax:

```hcl
[
  {
    database-name = string,
    roles = string,...
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "database-name": "string",
    "roles": [
      "string", ...
    ]
  }, ...
]
```

Fields:

```
database-name -> (string)
  Name of the database that the permission grants access to.
roles -> ([]string)
  MongoDB roles for the [database_name] database that the permission grants.
``` ||
|| `--user-name` | `string`

Name of the user to be updated. To get the name of the user, use a [UserService.List] request. ||
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