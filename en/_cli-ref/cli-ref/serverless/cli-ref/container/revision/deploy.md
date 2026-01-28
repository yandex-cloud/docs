---
editable: false
---

# yc serverless container revision deploy

Deploy new container revision

#### Command Usage

Syntax:

`yc serverless container revision deploy (--container-id <CONTAINER_ID>|--container-name <CONTAINER_NAME>) [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--container-id` | `string`

Container id. ||
|| `--container-name` | `string`

Container name. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|| `--memory` | `byteSize`

Required memory. Example: '1GB', '128MB'. The default value is 128MB. ||
|| `--cores` | `int`

Number of cores that will be available to a container instance. ||
|| `--core-fraction` | `int`

If provided, specifies baseline performance for a core in percent. ||
|| `--execution-timeout` | `duration`

Execution timeout. The default value is 3s ||
|| `--concurrency` | `int`

Set the maximum number of concurrent requests allowed per container instance. ||
|| `--service-account-id` | `string`

Service account id. ||
|| `--description` | `string`

Revision description. ||
|| `--environment` | `stringToString`

Revision environment variables. ||
|| `--image` | `string`

Image to run ||
|| `--command` | `value[,value]`

Comma-separated entrypoint for the container image. If not specified, the image's default ENTRYPOINT will be used. Pass an empty string to reset it to zero value. ||
|| `--args` | `value[,value]`

Comma-separated list of arguments that are passed to the command, run by a container. If not specified, the image's default CMD will be used. Pass an empty string to reset it to zero value. ||
|| `--secret` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Revision secret.

Possible property names:

- `name`: Specifies the secret name

- `id`: Specifies the secret id

- `version-id`: Specifies the secret version id. If not provided, current version of the secret will be used.

- `key`: Specifies key of the entry in the secret to use.

- `environment-variable`: Specifies environment variable name that the secret value will be loaded to. ||
|| `--min-instances` | `int`

Set the minimum number of concurrent instances. ||
|| `--zone-instances-limit` | `int`

Upper limit for instances count in each zone. ||
|| `--zone-requests-limit` | `int`

Upper limit for requests count in each zone. ||
|| `--network-id` | `string`

Network id to be used in new revision. ||
|| `--network-name` | `string`

Network name to be used in new revision. ||
|| `--subnets` | `value[,value]`

Specifies the subnets for the revision. Can use subnet names or subnet ids, or both.

Example: `--subnets=id1,id2 --subnets=name3'. ||
|| `--storage-mounts` | `mount-point-path=/data,bucket=user-bucket,read-only=false`

DEPRECATED: Use mounts instead. Storage mounts. Example: mount-point-path=/data,bucket=user-bucket,read-only=false

Possible property names:

- `mount-point-path`: Mount point path is used for binding the storage bucket with a directory inside the serverless container.

- `bucket`: Specifies a name of the bucket mount to.

- `prefix`: Specifies a prefix of the bucket. Leave empty to mount the entire bucket.

- `read-only`: Select to mount bucket in read only mode. ||
|| `--mount` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Add a mount to the revision. Example: type=ephemeral-disk,mount-point=/mnt/point,size=5GB

Possible property names:

- `type`: Specifies the type of the mount. Valid values are 'object-storage' and 'ephemeral-disk'.

- `mount-point`: Mount point is used to create the directory to which the target is mounted. It should be an absolute path.

- `bucket`: [object-storage] Specifies a name of the bucket mount to.

- `prefix`: [object-storage] Specifies a prefix of the bucket. Leave empty to mount the entire bucket.

- `mode`: [object-storage] Specifies mount's accessibility mode. Valid values are 'ro' and 'rw'.

- `size`: [ephemeral-disk] Specifies the size of the disk for mount. Must be a multiple of a gigabyte. Example: '5GB'.

- `block-size`: [ephemeral-disk] Specifies the optional block size of the disk for mount. Valid values: 4KB, 8KB, 16KB, 32KB, 64KB and 128KB. ||
|| `--runtime` | `string`

Container execution method. Valid values are 'http' and 'task'. ||
|| `--metadata-options` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

Options set the access mode to revision's metadata endpoints. Example: aws-v1-http-endpoint=disabled,gce-http-endpoint=enabled

Possible property names:

- `aws-v1-http-endpoint`: Enables access to AWS flavored metadata (IMDSv1). Values: enabled, disabled

- `gce-http-endpoint`: Enables access to GCE flavored metadata. Values: enabled, disabled ||
|| `--no-logging` | Disable logging from container. ||
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
|| `--async-service-account-id` | `string`

Service account for asynchronous container invocation. ||
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