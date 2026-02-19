---
editable: false
noIndex: true
---

# yc beta backup resource

A set of methods for managing backup resources: [Compute Cloud instances](/docs/backup/concepts/vm-connection#os).

#### Command Usage

Syntax:

`yc beta backup resource <command>`

#### Command Tree

- [yc beta backup resource create-directory](create-directory.md) — CreateDirectory creates new directory by requested path.

- [yc beta backup resource delete](delete.md) — Delete specific Compute Cloud instance from Cloud Backup. It does not delete

- [yc beta backup resource get](get.md) — Get specific Compute Cloud instance.

- [yc beta backup resource get-instance-registration-token](get-instance-registration-token.md) — Get instance registration token to install backup agent withot SA attached to instance

- [yc beta backup resource list](list.md) — List resources: Compute Cloud instances.

- [yc beta backup resource list-directory](list-directory.md) — ListDirectory returns all subdirectories found in requested directory identified

- [yc beta backup resource list-operations](list-operations.md) — ListOperations return all operations in backup service for given instance

- [yc beta backup resource list-tasks](list-tasks.md) — List tasks of resources.

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