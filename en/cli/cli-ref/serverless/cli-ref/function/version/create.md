---
editable: false
sourcePath: en/_cli-ref/cli-ref/serverless/cli-ref/function/version/create.md
---

# yc serverless function version create

Create new function version

#### Command Usage

Syntax:

`yc serverless function version create (--function-id <FUNCTION_ID>|--function-name <FUNCTION_NAME>) [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--function-id` | `string`

Function id. ||
|| `--function-name` | `string`

Function name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--runtime` | `string`

Runtime. Valid values are listed by "serverless function runtime list". ||
|| `--entrypoint` | `string`

Entry point. ||
|| `--memory` | `byteSize`

Required memory. Example: '1GB', '128MB'. The default value is 128MB. ||
|| `--execution-timeout` | `duration`

Execution timeout. The default value is 3s ||
|| `--service-account-id` | `string`

Service account id. ||
|| `--package-bucket-name` | `string`

Storage bucket name of the function package. ||
|| `--package-object-name` | `string`

Storage object name of the function package. ||
|| `--package-sha256` | `string`

Sha256 of the function package. ||
|| `--source-path` | `string`

Local filesystem path of the function package: either directory or file (file can be a valid zip archive). ||
|| `--source-version-id` | `string`

ID of a version to make a copy from. ||
|| `--description` | `string`

Version description. ||
|| `--environment` | `stringToString`

Version environment variables. ||
|| `--tags` | `value[,value]`

Version tags. ||
|| `--network-name` | `string`

Version network name. ||
|| `--network-id` | `string`

Version network id. ||
|| `--subnet-name` | `value[,value]`

Version subnet names. ||
|| `--subnet-id` | `value[,value]`

Version subnet ids. ||
|| `--add-service-account` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Adds a named service account to the version. Can be used multiple times.

Possible property names:

- `alias`: Specifies an alias, through which the service account can be accessed.

- `id`: Service account id

- `name`: Service account name. ||
|| `--secret` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Version secret.

Possible property names:

- `name`: Specifies the secret name

- `id`: Specifies the secret id

- `version-id`: Specifies the secret version id. If not provided, current version of the secret will be used.

- `key`: Specifies key of the entry in the secret to use.

- `environment-variable`: Specifies environment variable name that the secret value will be loaded to. ||
|| `--storage-mounts` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

DEPRECATED: Use mounts instead. Storage mounts. Example: mount-point=dir,bucket=user-bucket,read-only=false

Possible property names:

- `mount-point`: Mount point is used for creating the directory to which the bucket is mounted. It will be accessible by the path /function/storage/&lt;mount_point&gt;.

- `bucket`: Specifies a name of the bucket mount to.

- `prefix`: Specifies a prefix of the bucket. Leave empty to mount the entire bucket.

- `read-only`: Select to mount bucket in read only mode. ||
|| `--mount` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Add a mount to the version. Example: type=ephemeral-disk,mount-point=mnt1,size=5GB

Possible property names:

- `type`: Specifies the type of the mount. Valid values are 'object-storage' and 'ephemeral-disk'.

- `mount-point`: Mount point is used for creating the directory to which the target is mounted. It will be accessible by the path /function/storage/&lt;mount_point&gt;.

- `bucket`: [object-storage] Specifies a name of the bucket mount to.

- `prefix`: [object-storage] Specifies a prefix of the bucket. Leave empty to mount the entire bucket.

- `mode`: [object-storage] Specifies mount's accessibility mode. Valid values are 'ro' and 'rw'.

- `size`: [ephemeral-disk] Specifies the size of the disk for mount. Must be a multiple of a gigabyte. Example: '5GB'.

- `block-size`: [ephemeral-disk] Specifies the optional block size of the disk for mount. Valid values: 4KB, 8KB, 16KB, 32KB, 64KB and 128KB. ||
|| `--no-logging` | Disable logging from function. ||
|| `--log-group-id` | `string`

Send logs to custom log group by id. ||
|| `--log-group-name` | `string`

Send logs to custom log group by name. ||
|| `--log-folder-id` | `string`

Send logs to default log group of custom folder by id. ||
|| `--log-folder-name` | `string`

Send logs to default log group of custom folder by name. ||
|| `--min-log-level` | `string`

Min log level. Values: 'trace', 'debug', 'info', 'warn', 'error', 'fatal' ||
|| `--async-max-retries` | `int`

Max retries for async invocation. ||
|| `--async-service-account-id` | `string`

Service account for asynchronous function invocation. ||
|| `--async-success-ymq-arn` | `string`

YMQ ARN target for success invocation. ||
|| `--async-success-sa-id` | `string`

Service account for writing successful result of async invocation function. ||
|| `--async-failure-ymq-arn` | `string`

YMQ ARN target for failure. ||
|| `--async-failure-sa-id` | `string`

Service account for writing unsuccessful result of async invocation function. ||
|| `--tmpfs-size` | `byteSize`

Size of memory for use as in-memory storage mounted as /tmp directory. Example: '512MB', '1GB'. The default value is 0B. ||
|| `--concurrency` | `int`

The maximum number of requests processed by a function instance at the same time. ||
|| `--metadata-options` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Options set the access mode to function's metadata endpoints. Example: aws-v1-http-endpoint=disabled,gce-http-endpoint=enabled

Possible property names:

- `aws-v1-http-endpoint`: Enables access to AWS flavored metadata (IMDSv1). Values: enabled, disabled

- `gce-http-endpoint`: Enables access to GCE flavored metadata. Values: enabled, disabled ||
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