---
editable: false
noIndex: true
---

# yc beta managed-clickhouse format-schema

A set of methods for managing [format schemas](https://clickhouse.com/docs/en/interfaces/formats) for input and output data.

#### Command Usage

Syntax:

`yc beta managed-clickhouse format-schema <command>`

#### Command Tree

- [yc beta managed-clickhouse format-schema create](create.md) — Adds a format schema to a cluster.

- [yc beta managed-clickhouse format-schema delete](delete.md) — Deletes a format schema from a cluster.

- [yc beta managed-clickhouse format-schema get](get.md) — Returns detailed information about a given format schema.

- [yc beta managed-clickhouse format-schema list](list.md) — Returns a list of format schemas in a cluster.

- [yc beta managed-clickhouse format-schema update](update.md) — Changes a format schema.

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