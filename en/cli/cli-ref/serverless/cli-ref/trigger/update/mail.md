---
editable: false
sourcePath: en/_cli-ref/cli-ref/serverless/cli-ref/trigger/update/mail.md
---

# yc serverless trigger update mail

Update Mail trigger

#### Command Usage

Syntax:

`yc serverless trigger update mail <TRIGGER-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--new-name` | `string`

New trigger name. ||
|| `--description` | `string`

Trigger description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs. ||
|| `--new-batch-size` | `int`

Batch size, 1 - 10. Default: 1 ||
|| `--new-batch-cutoff` | `duration`

Batch cutoff. 1 - 60s. Default: 1s. ||
|| `--new-invoke-function-id` | `string`

Function to be invoked by worker on the data from email. ||
|| `--new-invoke-function-name` | `string`

Function to be invoked by worker on the data from email. ||
|| `--new-invoke-function-tag` | `string`

Function tag. ||
|| `--new-invoke-function-service-account-id` | `string`

Service account to be used by the worker to invoke the function. ||
|| `--new-invoke-function-service-account-name` | `string`

Service account to be used by the worker to invoke the function. ||
|| `--new-invoke-container-id` | `string`

Container to be invoked by worker on the data from email. ||
|| `--new-invoke-container-name` | `string`

Container to be invoked by worker on the data from email. ||
|| `--new-invoke-container-path` | `string`

Container endpoint path. ||
|| `--new-invoke-container-service-account-id` | `string`

Service account to be used by the worker to invoke the container. ||
|| `--new-invoke-container-service-account-name` | `string`

Service account to be used by the worker to invoke the container. ||
|| `--new-gateway-id` | `string`

Gateway to which worker will broadcast the data from email. ||
|| `--new-gateway-name` | `string`

Gateway to which worker will broadcast the data from email. ||
|| `--new-gateway-websocket-broadcast-path` | `string`

Gateway endpoint path. ||
|| `--new-gateway-websocket-broadcast-service-account-id` | `string`

Service account to be used by the worker to broadcast to gateway websocket. ||
|| `--new-gateway-websocket-broadcast-service-account-name` | `string`

Service account to be used by the worker to broadcast to gateway websocket. ||
|| `--new-function-retry-attempts` | `int`

Retry attempts, Default: 0 ||
|| `--new-function-retry-interval` | `duration`

Retry interval. Examples: '10s', '1m'. ||
|| `--new-container-retry-attempts` | `int`

Retry attempts, Default: 0 ||
|| `--new-container-retry-interval` | `duration`

Retry interval. Examples: '10s', '1m'. ||
|| `--new-function-dlq-queue-id` | `string`

Dead letter queue identifier. ||
|| `--new-container-dlq-queue-id` | `string`

Dead letter queue identifier. ||
|| `--new-function-dlq-service-account-id` | `string`

Service account to handle dead letter queue. ||
|| `--new-function-dlq-service-account-name` | `string`

Service account to handle dead letter queue. ||
|| `--new-container-dlq-service-account-id` | `string`

Service account to handle dead letter queue. ||
|| `--new-container-dlq-service-account-name` | `string`

Service account to handle dead letter queue. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--id` | `string`

Trigger id. ||
|| `--name` | `string`

Trigger name. ||
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