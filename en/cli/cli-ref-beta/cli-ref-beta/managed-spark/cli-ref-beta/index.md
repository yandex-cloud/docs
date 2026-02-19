---
editable: false
noIndex: true
---

# yc beta managed-spark

Manage Spark clusters

#### Command Usage

Syntax:

`yc beta managed-spark <group>`

#### Command Tree

- [yc beta managed-spark cluster](cluster/index.md) — A set of methods for managing Spark clusters.

  - [yc beta managed-spark cluster create](cluster/create.md) — Creates a Spark cluster.

  - [yc beta managed-spark cluster delete](cluster/delete.md) — Deletes the specified Spark cluster.

  - [yc beta managed-spark cluster get](cluster/get.md) — Returns the specified Spark cluster.

  - [yc beta managed-spark cluster list](cluster/list.md) — Retrieves a list of Spark clusters.

  - [yc beta managed-spark cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified Spark cluster.

  - [yc beta managed-spark cluster list-operations](cluster/list-operations.md) — 

  - [yc beta managed-spark cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified Spark cluster.

  - [yc beta managed-spark cluster start](cluster/start.md) — Start the specified Spark cluster.

  - [yc beta managed-spark cluster stop](cluster/stop.md) — Stops the specified Spark cluster

  - [yc beta managed-spark cluster update](cluster/update.md) — Updates configuration of the specified Spark cluster.

  - [yc beta managed-spark cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified Spark cluster.

- [yc beta managed-spark job](job/index.md) — A set of methods for managing jobs for Spark cluster.

  - [yc beta managed-spark job cancel](job/cancel.md) — Cancels the specified Spark job.

  - [yc beta managed-spark job create](job/create.md) — Creates a job for Spark cluster.

  - [yc beta managed-spark job get](job/get.md) — Returns the specified Spark job.

  - [yc beta managed-spark job list](job/list.md) — Retrieves a list of jobs for Spark cluster.

  - [yc beta managed-spark job list-log](job/list-log.md) — Returns a log for Spark job.

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