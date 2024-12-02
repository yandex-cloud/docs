---
editable: false
---

# yc serverless function version create

Create new function version

#### Command Usage

Syntax: 

`yc serverless function version create (--function-id <FUNCTION_ID>|--function-name <FUNCTION_NAME>) [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--function-id`|<b>`string`</b><br/>Function id.|
|`--function-name`|<b>`string`</b><br/>Function name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--runtime`|<b>`string`</b><br/>Runtime. Valid values are listed by "serverless function runtime list".|
|`--entrypoint`|<b>`string`</b><br/>Entry point.|
|`--memory`|<b>`byteSize`</b><br/>Required memory. Example: '1GB', '128MB'. The default value is 128MB.|
|`--execution-timeout`|<b>`duration`</b><br/>Execution timeout. The default value is 3s|
|`--service-account-id`|<b>`string`</b><br/>Service account id.|
|`--package-bucket-name`|<b>`string`</b><br/>Storage bucket name of the function package.|
|`--package-object-name`|<b>`string`</b><br/>Storage object name of the function package.|
|`--package-sha256`|<b>`string`</b><br/>Sha256 of the function package.|
|`--source-path`|<b>`string`</b><br/>Local filesystem path of the function package: either directory or file (file can be a valid zip archive).|
|`--source-version-id`|<b>`string`</b><br/>ID of a version to make a copy from.|
|`--description`|<b>`string`</b><br/>Version description.|
|`--environment`|<b>`stringToString`</b><br/>Version environment variables.|
|`--tags`|<b>`value[,value]`</b><br/>Version tags.|
|`--network-name`|<b>`string`</b><br/>Version network name.|
|`--network-id`|<b>`string`</b><br/>Version network id.|
|`--subnet-name`|<b>`value[,value]`</b><br/>Version subnet names.|
|`--subnet-id`|<b>`value[,value]`</b><br/>Version subnet ids.|
|`--add-service-account`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Adds a named service account to the version. Can be used multiple times.<br/><br/>Possible property names:<br/><ul> <li><code>alias</code>:     Specifies an alias, through which the service account can be accessed.</li> <li><code>id</code>:     Service account id</li> <li><code>name</code>:     Service account name.</li> </ul>|
|`--secret`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Version secret.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Specifies the secret name</li> <li><code>id</code>:     Specifies the secret id</li> <li><code>version-id</code>:     Specifies the secret version id. If not provided, current version of the secret will be used.</li> <li><code>key</code>:     Specifies key of the entry in the secret to use.</li> <li><code>environment-variable</code>:     Specifies environment variable name that the secret value will be loaded to.</li> </ul>|
|`--storage-mounts`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>DEPRECATED: Use mounts instead. Storage mounts. Example: mount-point=dir,bucket=user-bucket,read-only=false<br/><br/>Possible property names:<br/><ul> <li><code>mount-point</code>:     Mount point is used for creating the directory to which the bucket is mounted. It will be accessible by the path /function/storage/&lt;mount_point&gt;.</li> <li><code>bucket</code>:     Specifies a name of the bucket mount to.</li> <li><code>prefix</code>:     Specifies a prefix of the bucket. Leave empty to mount the entire bucket.</li> <li><code>read-only</code>:     Select to mount bucket in read only mode.</li> </ul>|
|`--mount`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Add a mount to the version. Example: type=ephemeral-disk,mount-point=mnt1,size=5GB<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     Specifies the type of the mount. Valid values are 'object-storage' and 'ephemeral-disk'.</li> <li><code>mount-point</code>:     Mount point is used for creating the directory to which the target is mounted. It will be accessible by the path /function/storage/&lt;mount_point&gt;.</li> <li><code>bucket</code>:     [object-storage] Specifies a name of the bucket mount to.</li> <li><code>prefix</code>:     [object-storage] Specifies a prefix of the bucket. Leave empty to mount the entire bucket.</li> <li><code>mode</code>:     [object-storage] Specifies mount's accessibility mode. Valid values are 'ro' and 'rw'.</li> <li><code>size</code>:     [ephemeral-disk] Specifies the size of the disk for mount. Must be a multiple of a gigabyte. Example: '5GB'.</li> <li><code>block-size</code>:     [ephemeral-disk] Specifies the optional block size of the disk for mount. Valid values: 4KB, 8KB, 16KB, 32KB, 64KB and 128KB.</li> </ul>|
|`--no-logging`|Disable logging from function.|
|`--log-group-id`|<b>`string`</b><br/>Send logs to custom log group by id.|
|`--log-group-name`|<b>`string`</b><br/>Send logs to custom log group by name.|
|`--log-folder-id`|<b>`string`</b><br/>Send logs to default log group of custom folder by id.|
|`--log-folder-name`|<b>`string`</b><br/>Send logs to default log group of custom folder by name.|
|`--min-log-level`|<b>`string`</b><br/>Min log level. Values: 'trace', 'debug', 'info', 'warn', 'error', 'fatal'|
|`--async-max-retries`|<b>`int`</b><br/>Max retries for async invocation.|
|`--async-service-account-id`|<b>`string`</b><br/>Service account for asynchronous function invocation.|
|`--async-success-ymq-arn`|<b>`string`</b><br/>YMQ ARN target for success invocation.|
|`--async-success-sa-id`|<b>`string`</b><br/>Service account for writing successful result of async invocation function.|
|`--async-failure-ymq-arn`|<b>`string`</b><br/>YMQ ARN target for failure.|
|`--async-failure-sa-id`|<b>`string`</b><br/>Service account for writing unsuccessful result of async invocation function.|
|`--tmpfs-size`|<b>`byteSize`</b><br/>Size of memory for use as in-memory storage mounted as /tmp directory. Example: '512MB', '1GB'. The default value is 0B.|
|`--concurrency`|<b>`int`</b><br/>The maximum number of requests processed by a function instance at the same time.|

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
