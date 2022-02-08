# yc serverless container revision deploy

Deploy new container revision

#### Command Usage

Syntax: 

`yc serverless container revision deploy (--container-id <CONTAINER_ID>|--container-name <CONTAINER_NAME>) [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--container-id`|<b>`string`</b><br/>Container id.|
|`--container-name`|<b>`string`</b><br/>Container name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--memory`|<b>`byteSize`</b><br/>Required memory. Example: '1GB', '128MB'. The default value is 128MB.|
|`--cores`|<b>`int`</b><br/>Number of cores that will be available to a container instance.|
|`--core-fraction`|<b>`int`</b><br/>If provided, specifies baseline performance for a core in percent.|
|`--execution-timeout`|<b>`duration`</b><br/>Execution timeout. The default value is 3s|
|`--concurrency`|<b>`int`</b><br/>Set the maximum number of concurrent requests allowed per container instance.|
|`--service-account-id`|<b>`string`</b><br/>Service account id.|
|`--description`|<b>`string`</b><br/>Revision description.|
|`--environment`|<b>`stringToString`</b><br/>Revision environment variables.|
|`--image`|<b>`string`</b><br/>Image to run|
|`--command`|<b>`value[,value]`</b><br/>Comma-separated entrypoint for the container image. If not specified, the image's default ENTRYPOINT will be used. Pass an empty string to reset it to zero value.|
|`--args`|<b>`value[,value]`</b><br/>Comma-separated list of arguments that are passed to the command, run by a container. If not specified, the image's default CMD will be used. Pass an empty string to reset it to zero value.|

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
