---
editable: false
noIndex: true
---

# yc beta managed-spark job

A set of methods for managing jobs for Spark cluster.

#### Command Usage

Syntax:

`yc beta managed-spark job <command>`

#### Command Tree

- [yc beta managed-spark job cancel](cancel.md) — Cancels the specified Spark job.

- [yc beta managed-spark job create](create.md) — Creates a job for Spark cluster.

- [yc beta managed-spark job get](get.md) — Returns the specified Spark job.

- [yc beta managed-spark job list](list.md) — Retrieves a list of jobs for Spark cluster.

- [yc beta managed-spark job list-log](list-log.md) — Returns a log for Spark job.

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