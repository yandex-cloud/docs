---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-kafka/cli-ref/connector-mirrormaker/update.md
---

# yc managed-kafka connector-mirrormaker update

Modify attributes of a Kafka Mirrormaker connector.

#### Command Usage

Syntax:

`yc managed-kafka connector-mirrormaker update <CONNECTOR-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Kafka cluster id. ||
|| `--cluster-name` | `string`

Kafka cluster name. ||
|| `--direction` | `string`

Allows to set direction of mirrormaker connector. Valid values: [ingress, egress]. If this cluster is target cluster of mirrormaker connector then enter "ingress". Otherwise enter "egress". ||
|| `--tasks-max` | `int`

Allows to set maximum number of mirrormaker connector tasks. ||
|| `--properties` | `key=value[,key=value...]`

Allows to set properties for the Kafka mirrormaker connector as key-value pairs. ||
|| `--replication-factor` | `int`

Allows to set mirrormaker connector configuration property "replication-factor". Replication factor of replicated topic. ||
|| `--topics` | `string`

Allows to set connector configuration property "topics". List of topics, separated by comma, that will be replicated from source cluster to target. ||
|| `--this-cluster-alias` | `string`

Allows to set alias of this kafka cluster for mirrormaker connector. ||
|| `--external-cluster` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

External cluster settings.

Possible property names:

- `alias`: Allows to set alias of external kafka cluster for mirrormaker connector.

- `bootstrap-servers`: Allows to set comma-separated list of bootstrap servers to connect to external kafka cluster.Value has format: "host1:port1,host2:port2,...,hostN:portN".

- `security-protocol`: Allows to set security-protocol to connect to external kafka cluster.

- `sasl-mechanism`: Allows to set sasl-mechanism to connect to external kafka cluster.

- `sasl-username`: Allows to set sasl-username to connect to external kafka cluster.

- `sasl-password`: Allows to set sasl-password to connect to external kafka cluster.

- `ssl-truststore-certificates`: Allows to set ssl-truststore-certificates to connect to external kafka cluster.This is a string, that contains PEM-certificates. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

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