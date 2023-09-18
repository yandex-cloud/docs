---
editable: false
---

# yc serverless trigger update object-storage

Update object storage trigger

#### Command Usage

Syntax: 

`yc serverless trigger update object-storage <TRIGGER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--new-name`|<b>`string`</b><br/>New trigger name.|
|`--description`|<b>`string`</b><br/>Trigger description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs.|
|`--new-bucket-id`|<b>`string`</b><br/>Object storage bucket ID.|
|`--new-prefix`|<b>`string`</b><br/>Object prefix filter.|
|`--new-suffix`|<b>`string`</b><br/>Object suffix filter.|
|`--new-events`|<b>`value[,value]`</b><br/>List of object storage events to subscribe. A list can be specified by listing events separated by commas as well as passing this flag multiple times.<br/>Available events are: 'create-object' , 'delete-object', 'update-object'.<br/>|
|`--new-batch-size`|<b>`int`</b><br/>Batch size, 1 - 10. Default: 1|
|`--new-batch-cutoff`|<b>`duration`</b><br/>Batch cutoff. 1 - 60s. Default: 1s.|
|`--new-invoke-function-id`|<b>`string`</b><br/>Function to be invoked by worker on the data from Object Storage.|
|`--new-invoke-function-name`|<b>`string`</b><br/>Function to be invoked by worker on the data from Object Storage.|
|`--new-invoke-function-tag`|<b>`string`</b><br/>Function tag.|
|`--new-invoke-function-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker to invoke the function.|
|`--new-invoke-function-service-account-name`|<b>`string`</b><br/>Service account to be used by the worker to invoke the function.|
|`--new-invoke-container-id`|<b>`string`</b><br/>Container to be invoked by worker on the data from Object Storage.|
|`--new-invoke-container-name`|<b>`string`</b><br/>Container to be invoked by worker on the data from Object Storage.|
|`--new-invoke-container-path`|<b>`string`</b><br/>Container endpoint path.|
|`--new-invoke-container-service-account-id`|<b>`string`</b><br/>Service account to be used by the worker to invoke the container.|
|`--new-invoke-container-service-account-name`|<b>`string`</b><br/>Service account to be used by the worker to invoke the container.|
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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
