---
editable: false
noIndex: true
---

# yc beta managed-trino catalog

A set of methods for managing Trino Cluster Catalog resources.

#### Command Usage

Syntax:

`yc beta managed-trino catalog <command>`

#### Command Tree

- [yc beta managed-trino catalog create](create.md) — Creates a new Trino Catalog.

- [yc beta managed-trino catalog delete](delete.md) — Deletes the specified Trino Catalog.

- [yc beta managed-trino catalog get](get.md) — Returns the specified Trino Catalog resource.

- [yc beta managed-trino catalog list](list.md) — Retrieves a list of Trino Catalog resources.

- [yc beta managed-trino catalog update](update.md) — Updates the specified Trino Catalog.

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