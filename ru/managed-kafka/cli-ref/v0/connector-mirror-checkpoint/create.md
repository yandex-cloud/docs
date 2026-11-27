---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/managed-kafka/cli-ref/v0/connector-mirror-checkpoint/create/
alternate:
  - href: ru/managed-kafka/cli-ref/v0/connector-mirror-checkpoint/create.md
    type: text/markdown
    title: Markdown version
---

# yc managed-kafka v0 connector-mirror-checkpoint create

Create a Kafka MirrorCheckpoint connector.

#### Command Usage

Syntax:

`yc managed-kafka v0 connector-mirror-checkpoint create <CONNECTOR-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--cluster-id` | `string`

Kafka cluster id. ||
|| `--cluster-name` | `string`

Kafka cluster name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--tasks-max` | `int`

Maximum number of MirrorCheckpoint connector tasks. ||
|| `--properties` | `key=value[,key=value...]`

Additional MirrorCheckpoint properties as key-value pairs. ||
|| `--groups` | `[]string`

Literal consumer group names to synchronize, separated by comma. ||
|| `--replication-policy` | `string`

Topic naming policy. Defaults to the Source setting captured at creation; an empty value resets the override on update. Values: 'default', 'identity' ||
|| `--offset-syncs-topic-location` | `string`

Offset-mapping topic location. Defaults to the Source setting captured at creation; an empty value resets the override on update. Values: 'source', 'target' ||
|| `--source-connector-name` | `string`

Existing MirrorMaker connector in this cluster whose settings are copied at creation. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#