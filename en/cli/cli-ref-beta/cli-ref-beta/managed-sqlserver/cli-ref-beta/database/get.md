---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-sqlserver/cli-ref-beta/database/get.md
---

# yc beta managed-sqlserver database get

Returns the specified SQL Server database.
To get the list of available SQL Server databases, make a [List] request.

#### Command Usage

Syntax:

`yc beta managed-sqlserver database get <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ID of the SQL Server cluster the database belongs to. To get the cluster ID, use a [ClusterService.List] request. ||
|| `--database-name` | `string`

Name of the SQL Server database to return. To get the name of the database use a [DatabaseService.List] request. ||
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

Set the output format: text, yaml, json, table, summary. ||
|| `--summary` | `strings`

Fields to include in summary output.
Each value is a dot-separated path to a field.
Examples:
  --summary instance.id                  # simple field
  --summary instance.type                # another simple field
  --summary instance.disks.size          # collect values from all list elements
  --summary instance.disks[0].size       # field from a specific list element ||
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