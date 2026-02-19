---
editable: false
noIndex: true
---

# yc beta managed-postgresql database update

Updates the specified PostgreSQL database.

#### Command Usage

Syntax:

`yc beta managed-postgresql database update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the PostgreSQL cluster to update a database in. To get the cluster ID use a [ClusterService.List] request. ||
|| `--database-name` | `string`

Name of the database to update. To get the name of the database use a [DatabaseService.List] request. ||
|| `--deletion-protection` | Deletion Protection inhibits deletion of the database Default value: 'unspecified' (inherits cluster's deletion_protection) ||
|| `--extensions` | `shorthand/json`

PostgreSQL extensions that should be enabled for the database. If the field is sent, the list of enabled extensions is rewritten entirely. Therefore, to disable an active extension you should simply send the list omitting this extension.

Shorthand Syntax:

```hcl
[
  {
    name = string,
    version = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "name": "string",
    "version": "string"
  }, ...
]
```

Fields:

```
name -> (string)
  Name of the extension, e.g. 'pg_trgm' or 'pg_btree'. Extensions supported by Managed Service for PostgreSQL are documentation.
version -> (string)
  Version of the extension. The setting is deprecated and has no effect.
``` ||
|| `--new-database-name` | `string`

Optional. New name of the database. ||
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