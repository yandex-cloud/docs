# yc managed-kafka v0

Manage Apache Kafka clusters, brokers, topics, users and connectors.

#### Command Usage

Syntax:

`yc managed-kafka v0 <group>`

#### Command Tree

- [yc managed-kafka v0 cluster](cluster/index.md) — Manage Kafka clusters.

  - [yc managed-kafka v0 cluster add-access-binding](cluster/add-access-binding.md) — Add access binding for the specified Kafka cluster

  - [yc managed-kafka v0 cluster create](cluster/create.md) — Create Kafka cluster

  - [yc managed-kafka v0 cluster delete](cluster/delete.md) — Delete the specified Kafka cluster

  - [yc managed-kafka v0 cluster get](cluster/get.md) — Show information about the specified Kafka cluster

  - [yc managed-kafka v0 cluster list](cluster/list.md) — List Kafka clusters

  - [yc managed-kafka v0 cluster list-access-bindings](cluster/list-access-bindings.md) — List access bindings for the specified Kafka cluster

  - [yc managed-kafka v0 cluster list-hosts](cluster/list-hosts.md) — List hosts for a cluster.

  - [yc managed-kafka v0 cluster list-logs](cluster/list-logs.md) — Retrieve logs for a Kafka cluster.

  - [yc managed-kafka v0 cluster list-operations](cluster/list-operations.md) — List operations for the specified Kafka cluster

  - [yc managed-kafka v0 cluster move](cluster/move.md) — Move the specified Kafka cluster into the folder

  - [yc managed-kafka v0 cluster remove-access-binding](cluster/remove-access-binding.md) — Remove access binding for the specified Kafka cluster

  - [yc managed-kafka v0 cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

  - [yc managed-kafka v0 cluster set-access-bindings](cluster/set-access-bindings.md) — Set access bindings for the specified Kafka cluster and delete all existing access bindings if there were any

  - [yc managed-kafka v0 cluster start](cluster/start.md) — Start the specified Kafka cluster

  - [yc managed-kafka v0 cluster stop](cluster/stop.md) — Stop the specified Kafka cluster

  - [yc managed-kafka v0 cluster update](cluster/update.md) — Modify configuration or attributes of a Kafka cluster.

- [yc managed-kafka v0 connector](connector/index.md) — Manage Kafka connectors.

  - [yc managed-kafka v0 connector delete](connector/delete.md) — Delete a Kafka connector.

  - [yc managed-kafka v0 connector get](connector/get.md) — Get information about a Kafka connector.

  - [yc managed-kafka v0 connector list](connector/list.md) — List connectors of a Kafka cluster.

  - [yc managed-kafka v0 connector pause](connector/pause.md) — Pause a Kafka connector.

  - [yc managed-kafka v0 connector resume](connector/resume.md) — Resume a Kafka connector.

- [yc managed-kafka v0 connector-iceberg-sink](connector-iceberg-sink/index.md) — Manage Kafka Iceberg-Sink connector.

  - [yc managed-kafka v0 connector-iceberg-sink create](connector-iceberg-sink/create.md) — Create a Kafka Iceberg-Sink connector.

  - [yc managed-kafka v0 connector-iceberg-sink update](connector-iceberg-sink/update.md) — Modify attributes of a Kafka Iceberg-Sink connector.

- [yc managed-kafka v0 connector-mirrormaker](connector-mirrormaker/index.md) — Manage Kafka Mirrormaker connector.

  - [yc managed-kafka v0 connector-mirrormaker create](connector-mirrormaker/create.md) — Create a Kafka Mirrormaker connector.

  - [yc managed-kafka v0 connector-mirrormaker update](connector-mirrormaker/update.md) — Modify attributes of a Kafka Mirrormaker connector.

- [yc managed-kafka v0 connector-s3-sink](connector-s3-sink/index.md) — Manage Kafka S3-Sink connector.

  - [yc managed-kafka v0 connector-s3-sink create](connector-s3-sink/create.md) — Create a Kafka S3-Sink connector.

  - [yc managed-kafka v0 connector-s3-sink update](connector-s3-sink/update.md) — Modify attributes of a Kafka S3-Sink connector.

- [yc managed-kafka v0 topic](topic/index.md) — Manage Kafka topics.

  - [yc managed-kafka v0 topic create](topic/create.md) — Create a Kafka topic.

  - [yc managed-kafka v0 topic delete](topic/delete.md) — Delete a Kafka topic.

  - [yc managed-kafka v0 topic get](topic/get.md) — Get information about a Kafka topic.

  - [yc managed-kafka v0 topic list](topic/list.md) — List topics of a Kafka cluster.

  - [yc managed-kafka v0 topic update](topic/update.md) — Modify attributes of a Kafka topic.

- [yc managed-kafka v0 user](user/index.md) — Manage Kafka users.

  - [yc managed-kafka v0 user create](user/create.md) — Create a Kafka user.

  - [yc managed-kafka v0 user delete](user/delete.md) — Delete a Kafka user.

  - [yc managed-kafka v0 user get](user/get.md) — Get information about a Kafka user.

  - [yc managed-kafka v0 user grant-permission](user/grant-permission.md) — Grant permission to the specified Kafka user.

  - [yc managed-kafka v0 user list](user/list.md) — List users of a Kafka cluster.

  - [yc managed-kafka v0 user revoke-permission](user/revoke-permission.md) — Revoke permission from the specified Kafka user.

  - [yc managed-kafka v0 user update](user/update.md) — Modify attributes of a Kafka user.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#