# yc managed-kafka cluster

Manage Kafka clusters.

#### Command Usage

Syntax: 

`yc managed-kafka cluster <command>`

Aliases: 

- `clusters`

#### Command Tree

- [yc managed-kafka cluster get](get.md) — Show information about the specified Kafka cluster
- [yc managed-kafka cluster list](list.md) — List Kafka clusters
- [yc managed-kafka cluster delete](delete.md) — Delete the specified Kafka cluster
- [yc managed-kafka cluster list-operations](list-operations.md) — List operations for the specified Kafka cluster
- [yc managed-kafka cluster list-hosts](list-hosts.md) — List hosts for a cluster.
- [yc managed-kafka cluster list-logs](list-logs.md) — Retrieve logs for a Kafka cluster.
- [yc managed-kafka cluster start](start.md) — Start the specified Kafka cluster
- [yc managed-kafka cluster stop](stop.md) — Stop the specified Kafka cluster
- [yc managed-kafka cluster create](create.md) — Create Kafka cluster
- [yc managed-kafka cluster update](update.md) — Modify configuration or attributes of a Kafka cluster.
- [yc managed-kafka cluster move](move.md) — Move the specified Kafka cluster into the folder
- [yc managed-kafka cluster reschedule-maintenance](reschedule-maintenance.md) — Reschedule currently planned maintenance operation.

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
