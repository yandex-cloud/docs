[Документация Yandex Cloud](../../../../../../../../index.md) > [Интерфейс командной строки](../../../../../../../index.md) > [Справочник (англ.)](../../../../../../index.md) > [serverless](../../../../index.md) > [v0](../../../index.md) > [trigger](../../index.md) > [v2](../index.md) > [create](index.md) > object-storage

# yc serverless v0 trigger v2 create object-storage

Create object storage trigger

#### Command Usage

Syntax:

`yc serverless trigger v2 create object-storage <TRIGGER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--name` | `string`

Trigger name. ||
|| `--description` | `string`

Trigger description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--action` | `value[,value]`

Action as JSON or '@path/to/file.json'. To set multiple actions, use multiple --action flags. ||
|| `--bucket-id` | `string`

ID of the bucket to monitor. ||
|| `--prefix` | `string`

Filter events by object key prefix. Optional. ||
|| `--suffix` | `string`

Filter events by object key suffix. Optional. ||
|| `--events` | `value[,value]`

Event types to listen for. At least one value is required. ||
|| `--batch-max-count` | `int`

Maximum number of events in a batch. ||
|| `--batch-max-bytes` | `int`

Maximum size of events in a batch. ||
|| `--batch-cutoff` | `duration`

Maximum time to wait before flushing an incomplete batch. ||
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