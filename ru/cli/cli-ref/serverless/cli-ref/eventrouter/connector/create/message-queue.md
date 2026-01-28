---
editable: false
sourcePath: en/_cli-ref/cli-ref/serverless/cli-ref/eventrouter/connector/create/message-queue.md
---

# yc serverless eventrouter connector create message-queue

Create a message queue connector

#### Command Usage

Syntax:

`yc serverless eventrouter connector create message-queue <CONNECTOR-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--bus-id` | `string`

Connector bus id. ||
|| `--name` | `string`

Connector name. ||
|| `--description` | `string`

Connector description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--deletion-protection` | Prevents accidental connector removal. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--queue-arn` | `string`

Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| `--visibility-timeout` | `duration`

Queue visibility timeout override. ||
|| `--polling-timeout` | `duration`

Queue polling timeout. ||
|| `--batch-size` | `int`

Batch size for polling. ||
|| `--service-account-id` | `string`

Service account which has read access to the queue. ||
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