---
sourcePath: ru/_cli-ref/cli-ref/managed-services/serverless/trigger/create/container-registry.md
---
# yc serverless trigger create container-registry

Create container registry trigger

#### Command Usage

Syntax: 

`yc serverless trigger create container-registry <TRIGGER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Trigger name.|
|`--description`|<b>`string`</b><br/> Trigger description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--registry-id`|<b>`string`</b><br/> Container registry ID.|
|`--registry-name`|<b>`string`</b><br/> Container registry name.|
|`--image-name`|<b>`string`</b><br/> Container image name filter.|
|`--tag`|<b>`string`</b><br/> Container image tag filter.|
|`--events`|<b>`value[,value]`</b><br/> List of container registry events to subscribe. A list can be specified by listing events separated by commas as well as passing this flag multiple times. Available events are: 'create-image' , 'delete-image', 'create-image-tag', 'delete-image-tag'. |
|`--invoke-function-id`|<b>`string`</b><br/> Function to be invoked by worker on the data from Container Registry.|
|`--invoke-function-name`|<b>`string`</b><br/> Function to be invoked by worker on the data from Container Registry.|
|`--invoke-function-tag`|<b>`string`</b><br/> Function tag.|
|`--invoke-function-service-account-id`|<b>`string`</b><br/> Service account to be used by the worker to invoke the function.|
|`--invoke-function-service-account-name`|<b>`string`</b><br/> Service account to be used by the worker to invoke the function.|
|`--invoke-container-id`|<b>`string`</b><br/> Container to be invoked by worker on the data from Container Registry.|
|`--invoke-container-name`|<b>`string`</b><br/> Container to be invoked by worker on the data from Container Registry.|
|`--invoke-container-path`|<b>`string`</b><br/> Container endpoint path.|
|`--invoke-container-service-account-id`|<b>`string`</b><br/> Service account to be used by the worker to invoke the container.|
|`--invoke-container-service-account-name`|<b>`string`</b><br/> Service account to be used by the worker to invoke the container.|
|`--retry-attempts`|<b>`int`</b><br/> Retry attempts, Default: 0|
|`--retry-interval`|<b>`duration`</b><br/> Retry interval. Examples: '10s', '1m'.|
|`--dlq-queue-id`|<b>`string`</b><br/> Dead letter queue identifier.|
|`--dlq-service-account-id`|<b>`string`</b><br/> Service account to handle dead letter queue.|
|`--dlq-service-account-name`|<b>`string`</b><br/> Service account to handle dead letter queue.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

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
