---
editable: false
noIndex: true
---

# yc beta dataproc job

A set of methods for managing Yandex Data Processing jobs.

#### Command Usage

Syntax:

`yc beta dataproc job <command>`

#### Command Tree

- [yc beta dataproc job cancel](cancel.md) — Cancels the specified Yandex Data Processing job.

- [yc beta dataproc job create](create.md) — Creates a job for a cluster.

- [yc beta dataproc job get](get.md) — Returns the specified job.

- [yc beta dataproc job list](list.md) — Retrieves a list of jobs for a cluster.

- [yc beta dataproc job list-log](list-log.md) — Returns a log for specified job.

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