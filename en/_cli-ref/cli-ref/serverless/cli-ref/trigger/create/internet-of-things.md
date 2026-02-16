---
editable: false
---

# yc serverless trigger create internet-of-things

Create internet of things trigger

#### Command Usage

Syntax:

`yc serverless trigger create internet-of-things <TRIGGER-NAME> [Flags...] [Global Flags...]`

Aliases:

- `iot-devices`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Trigger name. ||
|| `--description` | `string`

Trigger description. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--registry-id` | `string`

Internet of Things registry ID. ||
|| `--device-id` | `string`

Internet of Things device ID. ||
|| `--mqtt-topic` | `string`

Internet of Things MQTT topic. ||
|| `--batch-size` | `int`

Batch size, 1 - 1000. Default: 1 ||
|| `--batch-cutoff` | `duration`

Batch cutoff. 1 - 60s. Default: 1s. ||
|| `--invoke-function-id` | `string`

Function to be invoked by worker on the data from IoT. ||
|| `--invoke-function-name` | `string`

Function to be invoked by worker on the data from IoT. ||
|| `--invoke-function-tag` | `string`

Function tag. ||
|| `--invoke-function-service-account-id` | `string`

Service account to be used by the worker to invoke the function. ||
|| `--invoke-function-service-account-name` | `string`

Service account to be used by the worker to invoke the function. ||
|| `--invoke-container-id` | `string`

Container to be invoked by worker on the data from IoT. ||
|| `--invoke-container-name` | `string`

Container to be invoked by worker on the data from IoT. ||
|| `--invoke-container-path` | `string`

Container endpoint path. ||
|| `--invoke-container-service-account-id` | `string`

Service account to be used by the worker to invoke the container. ||
|| `--invoke-container-service-account-name` | `string`

Service account to be used by the worker to invoke the container. ||
|| `--gateway-id` | `string`

Gateway to which worker will broadcast on the data from IoT. ||
|| `--gateway-name` | `string`

Gateway to which worker will broadcast on the data from IoT. ||
|| `--gateway-websocket-broadcast-path` | `string`

Gateway endpoint path. ||
|| `--gateway-websocket-broadcast-service-account-id` | `string`

Service account to be used by the worker to broadcast to gateway websocket. ||
|| `--gateway-websocket-broadcast-service-account-name` | `string`

Service account to be used by the worker to broadcast to gateway websocket. ||
|| `--retry-attempts` | `int`

Retry attempts, Default: 0 ||
|| `--retry-interval` | `duration`

Retry interval. Examples: '10s', '1m'. ||
|| `--dlq-queue-id` | `string`

Dead letter queue identifier. ||
|| `--dlq-service-account-id` | `string`

Service account to handle dead letter queue. ||
|| `--dlq-service-account-name` | `string`

Service account to handle dead letter queue. ||
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