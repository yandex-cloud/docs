# yc serverless trigger create yds

Create YDS trigger

#### Command Usage

Syntax: 

`yc serverless trigger create yds <TRIGGER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Trigger name.|
|`--description`|<b>`string`</b><br/> Trigger description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--database`|<b>`string`</b><br/> Data Stream database.|
|`--stream`|<b>`string`</b><br/> Data Stream name.|
|`--stream-service-account-id`|<b>`string`</b><br/> Service account to be used by the worker to access the Data Stream.|
|`--stream-service-account-name`|<b>`string`</b><br/> Service account to be used by the worker to access the Data Stream.|
|`--batch-size`|<b>`byteSize`</b><br/> Batch size, 1b - 64kb. Default: 1b|
|`--batch-cutoff`|<b>`duration`</b><br/> Batch cutoff. 1 - 60s. Default: 1s.|
|`--invoke-function-id`|<b>`string`</b><br/> Function to be invoked by worker on the data from Data Stream.|
|`--invoke-function-name`|<b>`string`</b><br/> Function to be invoked by worker on the data from Data Stream.|
|`--invoke-function-tag`|<b>`string`</b><br/> Function tag.|
|`--invoke-function-service-account-id`|<b>`string`</b><br/> Service account to be used by the worker to invoke the function.|
|`--invoke-function-service-account-name`|<b>`string`</b><br/> Service account to be used by the worker to invoke the function.|
|`--invoke-container-id`|<b>`string`</b><br/> Container to be invoked by worker on the data from Data Stream.|
|`--invoke-container-name`|<b>`string`</b><br/> Container to be invoked by worker on the data from Data Stream.|
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
