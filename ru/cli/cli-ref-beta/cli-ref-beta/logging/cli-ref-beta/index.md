---
editable: false
noIndex: true
---

# yc beta logging

Manage Cloud Logging resourses

#### Command Usage

Syntax:

`yc beta logging <group>`

#### Command Tree

- [yc beta logging export](export/index.md) — A set of methods for managing log exports.

  - [yc beta logging export create](export/create.md) — Creates a export in the specified folder.

  - [yc beta logging export delete](export/delete.md) — Deletes the specified export.

  - [yc beta logging export get](export/get.md) — Returns the specified export.

  - [yc beta logging export list](export/list.md) — Retrieves the list of exports in the specified folder.

  - [yc beta logging export list-access-bindings](export/list-access-bindings.md) — Lists existing access bindings for the specified export.

  - [yc beta logging export list-operations](export/list-operations.md) — Lists operations for the specified export.

  - [yc beta logging export run](export/run.md) — Run new logs export from log group to sink

  - [yc beta logging export set-access-bindings](export/set-access-bindings.md) — Sets access bindings for the specified export.

  - [yc beta logging export update](export/update.md) — Updates the specified export.

  - [yc beta logging export update-access-bindings](export/update-access-bindings.md) — Updates access bindings for the specified export.

- [yc beta logging group](group/index.md) — A set of methods for managing log groups.

  - [yc beta logging group create](group/create.md) — Creates a log group in the specified folder.

  - [yc beta logging group delete](group/delete.md) — Deletes the specified log group.

  - [yc beta logging group get](group/get.md) — Returns the specified log group.

  - [yc beta logging group list](group/list.md) — Retrieves the list of log groups in the specified folder.

  - [yc beta logging group list-access-bindings](group/list-access-bindings.md) — Lists existing access bindings for the specified log group.

  - [yc beta logging group list-operations](group/list-operations.md) — Lists operations for the specified log group.

  - [yc beta logging group list-resources](group/list-resources.md) — Retrieves the resources (type and IDs) in the specified log group.

  - [yc beta logging group set-access-bindings](group/set-access-bindings.md) — Sets access bindings for the specified log group.

  - [yc beta logging group stats](group/stats.md) — Returns stats for the specified log group.

  - [yc beta logging group update](group/update.md) — Updates the specified log group.

  - [yc beta logging group update-access-bindings](group/update-access-bindings.md) — Updates access bindings for the specified log group.

- [yc beta logging log-ingestion](log-ingestion/index.md) — A set of methods for writing to log groups.

  - [yc beta logging log-ingestion write](log-ingestion/write.md) — Write log entries to specified destination.

- [yc beta logging log-reading](log-reading/index.md) — A set of methods for reading from log groups.

  - [yc beta logging log-reading read](log-reading/read.md) — Read log entries from the specified log group.

- [yc beta logging sink](sink/index.md) — A set of methods for managing log sinks.

  - [yc beta logging sink create](sink/create.md) — Creates a sink in the specified folder.

  - [yc beta logging sink delete](sink/delete.md) — Deletes the specified sink.

  - [yc beta logging sink get](sink/get.md) — Returns the specified sink.

  - [yc beta logging sink list](sink/list.md) — Retrieves the list of sinks in the specified folder.

  - [yc beta logging sink list-access-bindings](sink/list-access-bindings.md) — Lists existing access bindings for the specified sink.

  - [yc beta logging sink list-operations](sink/list-operations.md) — Lists operations for the specified sink.

  - [yc beta logging sink set-access-bindings](sink/set-access-bindings.md) — Sets access bindings for the specified sink.

  - [yc beta logging sink update](sink/update.md) — Updates the specified sink.

  - [yc beta logging sink update-access-bindings](sink/update-access-bindings.md) — Updates access bindings for the specified sink.

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