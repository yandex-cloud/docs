---
editable: false
noIndex: true
---

# yc beta managed-clickhouse format-schema update

Changes a format schema.

#### Command Usage

Syntax:

`yc beta managed-clickhouse format-schema update <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

ClickHouse cluster ID. To get a ClickHouse cluster ID, use the [ClusterService.List] method. ||
|| `--format-schema-name` | `string`

Format schema name. To get a format schema name, use the [FormatSchemaService.List] method. ||
|| `--uri` | `string`

documentation of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. ||
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