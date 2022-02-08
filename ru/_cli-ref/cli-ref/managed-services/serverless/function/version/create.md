# yc serverless function version create

Create new function version

#### Command Usage

Syntax: 

`yc serverless function version create (--function-id <FUNCTION_ID>|--function-name <FUNCTION_NAME>) [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--function-id`|<b>`string`</b><br/> Function id.|
|`--function-name`|<b>`string`</b><br/> Function name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--runtime`|<b>`string`</b><br/> Runtime. Valid values are listed by "serverless function runtime list".|
|`--entrypoint`|<b>`string`</b><br/> Entry point.|
|`--memory`|<b>`byteSize`</b><br/> Required memory. Example: '1GB', '128MB'. The default value is 128MB.|
|`--execution-timeout`|<b>`duration`</b><br/> Execution timeout. The default value is 3s|
|`--service-account-id`|<b>`string`</b><br/> Service account id.|
|`--package-bucket-name`|<b>`string`</b><br/> Storage bucket name of the function package.|
|`--package-object-name`|<b>`string`</b><br/> Storage object name of the function package.|
|`--package-sha256`|<b>`string`</b><br/> Sha256 of the function package.|
|`--source-path`|<b>`string`</b><br/> Local filesystem path of the function package: either directory or file (file can be a valid zip archive).|
|`--source-version-id`|<b>`string`</b><br/> ID of a version to make a copy from.|
|`--description`|<b>`string`</b><br/> Version description.|
|`--environment`|<b>`stringToString`</b><br/> Version environment variables.|
|`--tags`|<b>`value[,value]`</b><br/> Version tags.|
|`--network-name`|<b>`string`</b><br/> Version network name.|
|`--network-id`|<b>`string`</b><br/> Version network id.|
|`--subnet-name`|<b>`value[,value]`</b><br/> Version subnet names.|
|`--subnet-id`|<b>`value[,value]`</b><br/> Version subnet ids.|
|`--add-service-account`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Adds a named service account to the version. Can be used multiple times.  Possible property names:  alias Specifies an alias, through which the service account can be accessed.  id Service account id  name Service account name.|

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
