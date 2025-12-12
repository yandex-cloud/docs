---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/function/create-version.md
---

# yc beta serverless function create-version

Creates a version for the specified function.

#### Command Usage

Syntax: 

`yc beta serverless function create-version <FUNCTION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--async-invocation-config`|<b>`shorthand/json`</b><br/>Config for asynchronous invocations of the version<br/>Shorthand Syntax:<br/>{<br/>failure-target = {<br/>target = empty-target={} \| ymq-target={<br/>queue-arn = str,<br/>service-account-id = str<br/>}<br/>},<br/>retries-count = int,<br/>service-account-id = str,<br/>success-target = {<br/>target = empty-target={} \| ymq-target={<br/>queue-arn = str,<br/>service-account-id = str<br/>}<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"failure-target": {<br/>"target": {<br/>"empty-target": {},<br/>"ymq-target": {<br/>"queue-arn": "str",<br/>"service-account-id": "str"<br/>}<br/>}<br/>},<br/>"retries-count": "int",<br/>"service-account-id": "str",<br/>"success-target": {<br/>"target": {<br/>"empty-target": {},<br/>"ymq-target": {<br/>"queue-arn": "str",<br/>"service-account-id": "str"<br/>}<br/>}<br/>}<br/>}"<br/>Fields:<br/>failure-target -> (struct)<br/>Target for unsuccessful result, if all retries failed<br/>target -> (oneof<empty-target\|ymq-target>)<br/>Oneof target field<br/>empty-target -> (struct)<br/>Target to ignore a result<br/>ymq-target -> (struct)<br/>Target to send a result to ymq<br/>queue-arn -> (string)<br/>Queue ARN<br/>service-account-id -> (string)<br/>Service account which has write permission on the queue.<br/>retries-count -> (int)<br/>Number of retries of version invocation<br/>service-account-id -> (string)<br/>Service account which can invoke version<br/>success-target -> (struct)<br/>Target for successful result of the version's invocation<br/>target -> (oneof<empty-target\|ymq-target>)<br/>Oneof target field<br/>empty-target -> (struct)<br/>Target to ignore a result<br/>ymq-target -> (struct)<br/>Target to send a result to ymq<br/>queue-arn -> (string)<br/>Queue ARN<br/>service-account-id -> (string)<br/>Service account which has write permission on the queue.|
|`--concurrency`|<b>`int`</b><br/>The maximum number of requests processed by a function instance at the same time|
|`--connectivity`|<b>`shorthand/json`</b><br/>Function version connectivity. If specified the version will be attached to specified network/subnet(s).<br/>Shorthand Syntax:<br/>{<br/>network-id = str,<br/>subnet-id = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"network-id": "str",<br/>"subnet-id": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>network-id -> (string)<br/>Network the version will have access to. It's essential to specify network with subnets in all availability zones.<br/>subnet-id -> ([]string)<br/>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones.|
|`--description`|<b>`string`</b><br/>Description of the version|
|`--entrypoint`|<b>`string`</b><br/>Entrypoint of the version.|
|`--environment`|<b>`stringToString`</b><br/>Environment settings for the version.|
|`--execution-timeout`|<b>`duration`</b><br/>Timeout for the execution of the version. If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. (duration, e.g. 30s, 5m10s)|
|`--function-id`|<b>`string`</b><br/>ID of the function to create a version for. To get a function ID, make a [FunctionService.List] request.|
|`--log-options`|<b>`shorthand/json`</b><br/>Options for logging from the function<br/>Shorthand Syntax:<br/>{<br/>destination = folder-id=str \| log-group-id=str,<br/>disabled = bool,<br/>min-level = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"disabled": "bool",<br/>"min-level": "TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL"<br/>}"<br/>Fields:<br/>disabled -> (bool)<br/>Is logging from function disabled.<br/>min-level -> (enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>)<br/>Minimum log entry level. See [LogLevel.Level] for details.<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>log-group-id -> (string)<br/>Entry should be written to log group resolved by ID.<br/>folder-id -> (string)<br/>Entry should be written to default log group for specified folder.|
|`--metadata-options`|<b>`shorthand/json`</b><br/>Metadata options for the version.<br/>Shorthand Syntax:<br/>{<br/>aws-v1-http-endpoint = ENABLED\|DISABLED,<br/>gce-http-endpoint = ENABLED\|DISABLED<br/>}<br/>JSON Syntax:<br/>"{<br/>"aws-v1-http-endpoint": "ENABLED\|DISABLED",<br/>"gce-http-endpoint": "ENABLED\|DISABLED"<br/>}"<br/>Fields:<br/>aws-v1-http-endpoint -> (enum<DISABLED\|ENABLED>)<br/>Enabled access to AWS flavored metadata (IMDSv1)<br/>gce-http-endpoint -> (enum<DISABLED\|ENABLED>)<br/>Enabled access to GCE flavored metadata|
|`--mounts`|<b>`shorthand/json`</b><br/>Mounts to be used by the version.<br/>Shorthand Syntax:<br/>[<br/>{<br/>mode = READ_ONLY\|READ_WRITE,<br/>name = str,<br/>target = ephemeral-disk-spec={<br/>block-size = int,<br/>size = int<br/>} \| object-storage={<br/>bucket-id = str,<br/>prefix = str<br/>}<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"mode": "READ_ONLY\|READ_WRITE",<br/>"name": "str",<br/>"target": {<br/>"ephemeral-disk-spec": {<br/>"block-size": "int",<br/>"size": "int"<br/>},<br/>"object-storage": {<br/>"bucket-id": "str",<br/>"prefix": "str"<br/>}<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>mode -> (enum<READ_ONLY\|READ_WRITE>)<br/>Mount's mode<br/>name -> (string)<br/>Unique mount point name. Device will be mounted into /function/storage/\<name\><br/>target -> (oneof<ephemeral-disk-spec\|object-storage>)<br/>Oneof target field<br/>object-storage -> (struct)<br/>Object storage mounts<br/>bucket-id -> (string)<br/>ObjectStorage bucket name for mounting.<br/>prefix -> (string)<br/>ObjectStorage bucket prefix for mounting.<br/>ephemeral-disk-spec -> (struct)<br/>Working disk (worker-local non-shared read-write NBS disk templates)<br/>block-size -> (int)<br/>Optional block size of disk for mount in bytes<br/>size -> (int)<br/>The size of disk for mount in bytes|
|`--named-service-accounts`|<b>`stringToString`</b><br/>Additional service accounts to be used by the version.|
|`--resources`|<b>`shorthand/json`</b><br/>Resources allocated to the version.<br/>Shorthand Syntax:<br/>{<br/>memory = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"memory": "int"<br/>}"<br/>Fields:<br/>memory -> (int)<br/>Amount of memory available to the version, specified in bytes, multiple of 128MB.|
|`--runtime`|<b>`string`</b><br/>Runtime environment for the version.|
|`--secrets`|<b>`shorthand/json`</b><br/>Yandex Lockbox secrets to be used by the version.<br/>Shorthand Syntax:<br/>[<br/>{<br/>id = str,<br/>key = str,<br/>reference = environment-variable=str,<br/>version-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"id": "str",<br/>"key": "str",<br/>"reference": {<br/>"environment-variable": "str"<br/>},<br/>"version-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>id -> (string)<br/>ID of Yandex Lockbox secret.<br/>key -> (string)<br/>Key in secret's payload, which value to be delivered into function environment.<br/>version-id -> (string)<br/>ID of Yandex Lockbox version.<br/>reference -> (oneof\<environment-variable\>)<br/>Oneof reference field<br/>environment-variable -> (string)<br/>environment variable in which secret's value to be delivered.|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to associate with the version.|
|`--storage-mounts`|<b>`shorthand/json`</b><br/>S3 mounts to be used by the version.<br/>Shorthand Syntax:<br/>[<br/>{<br/>bucket-id = str,<br/>mount-point-name = str,<br/>prefix = str,<br/>read-only = bool<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"bucket-id": "str",<br/>"mount-point-name": "str",<br/>"prefix": "str",<br/>"read-only": "bool"<br/>}, ...<br/>]"<br/>Fields:<br/>bucket-id -> (string)<br/>S3 bucket name for mounting.<br/>mount-point-name -> (string)<br/>Mount point directory name (not path) for mounting.<br/>prefix -> (string)<br/>S3 bucket prefix for mounting.<br/>read-only -> (bool)<br/>Is mount read only.|
|`--tag`|<b>`strings`</b><br/>Function version tags. For details, see documentation.|
|`--tmpfs-size`|<b>`int`</b><br/>Optional size of in-memory mounted /tmp directory in bytes. Available for versions with resources.memory greater or equal to 1024 MiB. 0 or in range from 512 MiB to 3/4 of resources.memory.|
|`--package`|<b>`shorthand/json`</b><br/>Functions deployment package.<br/>Shorthand Syntax:<br/>{<br/>bucket-name = str,<br/>object-name = str,<br/>sha256 = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"bucket-name": "str",<br/>"object-name": "str",<br/>"sha256": "str"<br/>}"<br/>Fields:<br/>bucket-name -> (string)<br/>Name of the bucket that stores the code for the version.<br/>object-name -> (string)<br/>Name of the object in the bucket that stores the code for the version.<br/>sha256 -> (string)<br/>SHA256 hash of the version deployment package.|
|`--content`|<b>`bytesBase64`</b><br/>Content of the deployment package. (base64)|
|`--version-id`|<b>`string`</b><br/>ID of the version to be copied from. Source version must belong to the same folder as the created version and the user must have read permissions to the source version.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
