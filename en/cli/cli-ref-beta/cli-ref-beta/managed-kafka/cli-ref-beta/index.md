---
editable: false
noIndex: true
---

# yc beta managed-kafka

Manage Apache Kafka clusters, brokers, topics, users and connectors

#### Command Usage

Syntax:

`yc beta managed-kafka <group>`

#### Command Tree

- [yc beta managed-kafka cluster](cluster/index.md) — A set of methods for managing Apache Kafka® clusters.

  - [yc beta managed-kafka cluster create](cluster/create.md) — Creates a new Apache Kafka® cluster in the specified folder.

  - [yc beta managed-kafka cluster delete](cluster/delete.md) — Deletes the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster get](cluster/get.md) — Returns the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster list](cluster/list.md) — Retrieves the list of Apache Kafka® clusters that belong to the specified folder.

  - [yc beta managed-kafka cluster list-access-bindings](cluster/list-access-bindings.md) — Retrieves a list of access bindings for the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster list-hosts](cluster/list-hosts.md) — Retrieves a list of hosts for the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster list-logs](cluster/list-logs.md) — Retrieves logs for the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster list-operations](cluster/list-operations.md) — Retrieves the list of operations for the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster move](cluster/move.md) — Moves the specified Apache Kafka® cluster to the specified folder.

  - [yc beta managed-kafka cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule planned maintenance operation.

  - [yc beta managed-kafka cluster set-access-bindings](cluster/set-access-bindings.md) — Sets access bindings for the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster start](cluster/start.md) — Starts the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster stop](cluster/stop.md) — Stops the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster update](cluster/update.md) — Updates the specified Apache Kafka® cluster.

  - [yc beta managed-kafka cluster update-access-bindings](cluster/update-access-bindings.md) — Updates access bindings for the specified Apache Kafka® cluster.

- [yc beta managed-kafka connector](connector/index.md) — A set of methods for managing Apache Kafka® connectors.

  - [yc beta managed-kafka connector create](connector/create.md) — Creates a new Apache Kafka® connector in a cluster.

  - [yc beta managed-kafka connector delete](connector/delete.md) — Deletes an Apache Kafka® connector.

  - [yc beta managed-kafka connector get](connector/get.md) — Returns information about an Apache Kafka® connector.

  - [yc beta managed-kafka connector list](connector/list.md) — Retrieves the list of Apache Kafka® connectors in a cluster.

  - [yc beta managed-kafka connector pause](connector/pause.md) — Pauses an Apache Kafka® connector.

  - [yc beta managed-kafka connector resume](connector/resume.md) — Resumes an Apache Kafka® connector.

  - [yc beta managed-kafka connector update](connector/update.md) — Updates an Apache Kafka® connector.

- [yc beta managed-kafka resource-preset](resource-preset/index.md) — A set of methods for managing Kafka resource presets.

  - [yc beta managed-kafka resource-preset get](resource-preset/get.md) — Returns the specified resource preset.

  - [yc beta managed-kafka resource-preset list](resource-preset/list.md) — Retrieves the list of available resource presets.

- [yc beta managed-kafka topic](topic/index.md) — A set of methods for managing Kafka topics.

  - [yc beta managed-kafka topic create](topic/create.md) — Creates a new Kafka topic in the specified cluster.

  - [yc beta managed-kafka topic delete](topic/delete.md) — Deletes the specified Kafka topic.

  - [yc beta managed-kafka topic get](topic/get.md) — Returns the specified Kafka topic.

  - [yc beta managed-kafka topic list](topic/list.md) — Retrieves the list of Kafka topics in the specified cluster.

  - [yc beta managed-kafka topic update](topic/update.md) — Updates the specified Kafka topic.

- [yc beta managed-kafka user](user/index.md) — A set of methods for managing Kafka users.

  - [yc beta managed-kafka user create](user/create.md) — Creates a Kafka user in the specified cluster.

  - [yc beta managed-kafka user delete](user/delete.md) — Deletes the specified Kafka user.

  - [yc beta managed-kafka user get](user/get.md) — Returns the specified Kafka user.

  - [yc beta managed-kafka user grant-permission](user/grant-permission.md) — Grants permission to the specified Kafka user.

  - [yc beta managed-kafka user list](user/list.md) — Retrieves the list of Kafka users in the specified cluster.

  - [yc beta managed-kafka user revoke-permission](user/revoke-permission.md) — Revokes permission from the specified Kafka user.

  - [yc beta managed-kafka user update](user/update.md) — Updates the specified Kafka user.

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