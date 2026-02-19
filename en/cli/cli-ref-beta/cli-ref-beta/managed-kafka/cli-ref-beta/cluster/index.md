---
editable: false
noIndex: true
---

# yc beta managed-kafka cluster

A set of methods for managing Apache Kafka® clusters.

#### Command Usage

Syntax:

`yc beta managed-kafka cluster <command>`

#### Command Tree

- [yc beta managed-kafka cluster create](create.md) — Creates a new Apache Kafka® cluster in the specified folder.

- [yc beta managed-kafka cluster delete](delete.md) — Deletes the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster get](get.md) — Returns the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster list](list.md) — Retrieves the list of Apache Kafka® clusters that belong to the specified folder.

- [yc beta managed-kafka cluster list-access-bindings](list-access-bindings.md) — Retrieves a list of access bindings for the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster list-hosts](list-hosts.md) — Retrieves a list of hosts for the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster list-logs](list-logs.md) — Retrieves logs for the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster list-operations](list-operations.md) — Retrieves the list of operations for the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster move](move.md) — Moves the specified Apache Kafka® cluster to the specified folder.

- [yc beta managed-kafka cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule planned maintenance operation.

- [yc beta managed-kafka cluster set-access-bindings](set-access-bindings.md) — Sets access bindings for the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster start](start.md) — Starts the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster stop](stop.md) — Stops the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster update](update.md) — Updates the specified Apache Kafka® cluster.

- [yc beta managed-kafka cluster update-access-bindings](update-access-bindings.md) — Updates access bindings for the specified Apache Kafka® cluster.

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