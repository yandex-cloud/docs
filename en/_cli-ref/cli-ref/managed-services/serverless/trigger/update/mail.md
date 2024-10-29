---
editable: false
---

# yc serverless trigger update mail

Update Mail trigger

#### Command Usage

Syntax: 

`yc serverless trigger update mail <TRIGGER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--new-name`|<b>`string`</b><br/>New trigger name.|
|`--description`|<b>`string`</b><br/>Trigger description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs.|
|`--new-batch-size`|<b>`int`</b><br/>Batch size, 1 - 10. Default: 1|
|`--new-batch-cutoff`|<b>`duration`</b><br/>Batch cutoff. 1 - 60s. Default: 1s.|
|`--new-invoke-function-id`|<b>`string`</b><br/>Function to be invoked by worker on the data from email.|
|`--new-invoke-function-name`|<b>`string`</b><br/>Function to be invoked by worker on the data from email.|
|`--new-invoke-function-tag`|<b>`string`</b><br/>Function tag.|
|`--new-invoke-function-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker to invoke the function.|
|`--new-invoke-function-service-account-name`|<b>`string`</b><br/>Service account to be used by the worker to invoke the function.|
|`--new-invoke-container-id`|<b>`string`</b><br/>Container to be invoked by worker on the data from email.|
|`--new-invoke-container-name`|<b>`string`</b><br/>Container to be invoked by worker on the data from email.|
|`--new-invoke-container-path`|<b>`string`</b><br/>Container endpoint path.|
|`--new-invoke-container-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker to invoke the container.|
|`--new-invoke-container-service-account-name`|<b>`string`</b><br/>Service account to be used by the worker to invoke the container.|
|`--new-gateway-id`|<b>`string`</b><br/>Gateway to which worker will broadcast the data from email.|
|`--new-gateway-name`|<b>`string`</b><br/>Gateway to which worker will broadcast the data from email.|
|`--new-gateway-websocket-broadcast-path`|<b>`string`</b><br/>Gateway endpoint path.|
|`--new-gateway-websocket-broadcast-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker to broadcast to gateway websocket.|
|`--new-gateway-websocket-broadcast-service-account-name`|<b>`string`</b><br/>Service account to be used by the worker to broadcast to gateway websocket.|
|`--new-function-retry-attempts`|<b>`int`</b><br/>Retry attempts, Default: 0|
|`--new-function-retry-interval`|<b>`duration`</b><br/>Retry interval. Examples: '10s', '1m'.|
|`--new-container-retry-attempts`|<b>`int`</b><br/>Retry attempts, Default: 0|
|`--new-container-retry-interval`|<b>`duration`</b><br/>Retry interval. Examples: '10s', '1m'.|
|`--new-function-dlq-queue-id`|<b>`string`</b><br/>Dead letter queue identifier.|
|`--new-container-dlq-queue-id`|<b>`string`</b><br/>Dead letter queue identifier.|
|`--new-function-dlq-service-account-id`|<b>`string`</b><br/>Service account to handle dead letter queue.|
|`--new-function-dlq-service-account-name`|<b>`string`</b><br/>Service account to handle dead letter queue.|
|`--new-container-dlq-service-account-id`|<b>`string`</b><br/>Service account to handle dead letter queue.|
|`--new-container-dlq-service-account-name`|<b>`string`</b><br/>Service account to handle dead letter queue.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--id`|<b>`string`</b><br/>Trigger id.|
|`--name`|<b>`string`</b><br/>Trigger name.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
