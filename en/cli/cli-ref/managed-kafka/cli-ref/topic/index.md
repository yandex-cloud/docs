---
editable: false
---

# yc managed-kafka topic

Manage Kafka topics.

#### Command Usage

Syntax:

`yc managed-kafka topic <command>`

Aliases:

- `topics`

#### Command Tree

- [yc managed-kafka topic create](create.md) — Create a Kafka topic.

- [yc managed-kafka topic delete](delete.md) — Delete a Kafka topic.

- [yc managed-kafka topic get](get.md) — Get information about a Kafka topic.

- [yc managed-kafka topic list](list.md) — List topics of a Kafka cluster.

- [yc managed-kafka topic update](update.md) — Modify attributes of a Kafka topic.

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