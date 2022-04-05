---
sourcePath: en/_cli-ref/cli-ref/managed-services/managed-kafka/index.md
---
# yc managed-kafka

Manage Apache Kafka clusters, brokers, topics and users.

#### Command Usage

Syntax: 

`yc managed-kafka <group>`

Aliases: 

- `kafka`

#### Command Tree

- [yc managed-kafka cluster](cluster/index.md) — Manage Kafka clusters.
	- [yc managed-kafka cluster get](cluster/get.md) — Show information about the specified Kafka cluster
	- [yc managed-kafka cluster list](cluster/list.md) — List Kafka clusters
	- [yc managed-kafka cluster delete](cluster/delete.md) — Delete the specified Kafka cluster
	- [yc managed-kafka cluster list-operations](cluster/list-operations.md) — List operations for the specified Kafka cluster
	- [yc managed-kafka cluster list-hosts](cluster/list-hosts.md) — List hosts for a cluster.
	- [yc managed-kafka cluster list-logs](cluster/list-logs.md) — Retrieve logs for a Kafka cluster.
	- [yc managed-kafka cluster start](cluster/start.md) — Start the specified Kafka cluster
	- [yc managed-kafka cluster stop](cluster/stop.md) — Stop the specified Kafka cluster
	- [yc managed-kafka cluster create](cluster/create.md) — Create Kafka cluster
	- [yc managed-kafka cluster update](cluster/update.md) — Modify configuration or attributes of a Kafka cluster.
	- [yc managed-kafka cluster move](cluster/move.md) — Move the specified Kafka cluster into the folder
	- [yc managed-kafka cluster reschedule-maintenance](cluster/reschedule-maintenance.md) — Reschedule currently planned maintenance operation.
- [yc managed-kafka topic](topic/index.md) — Manage Kafka topics.
	- [yc managed-kafka topic get](topic/get.md) — Get information about a Kafka topic.
	- [yc managed-kafka topic list](topic/list.md) — List topics of a Kafka cluster.
	- [yc managed-kafka topic create](topic/create.md) — Create a Kafka topic.
	- [yc managed-kafka topic update](topic/update.md) — Modify attributes of a Kafka topic.
	- [yc managed-kafka topic delete](topic/delete.md) — Delete a Kafka topic.
- [yc managed-kafka user](user/index.md) — Manage Kafka users.
	- [yc managed-kafka user get](user/get.md) — Get information about a Kafka user.
	- [yc managed-kafka user list](user/list.md) — List users of a Kafka cluster.
	- [yc managed-kafka user create](user/create.md) — Create a Kafka user.
	- [yc managed-kafka user update](user/update.md) — Modify attributes of a Kafka user.
	- [yc managed-kafka user delete](user/delete.md) — Delete a Kafka user.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
