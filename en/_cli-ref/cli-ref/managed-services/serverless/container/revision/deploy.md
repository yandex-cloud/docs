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
|`--secret`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Revision secret.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the secret name</li> <li><code>id</code>:     Specifies the secret id</li> <li><code>version-id</code>:     Specifies the secret version id. If not provided, current version of the secret will be used.</li> <li><code>key</code>:     Specifies key of the entry in the secret to use.</li> <li><code>environment-variable</code>:     Specifies environment variable name that the secret value will be loaded to.</li> </ul>|
|`--min-instances`|<b>`int`</b><br/>Set the minimum number of concurrent instances.|
|`--network-id`|<b>`string`</b><br/>Network id to be used in new revision.|
|`--network-name`|<b>`string`</b><br/>Network name to be used in new revision.|
|`--subnets`|<b>`value[,value]`</b><br/>Specifies the subnets for the revision. Can use subnet names or subnet ids, or both.<br/><br/>Example: `--subnets=id1,id2 --subnets=name3'.|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
