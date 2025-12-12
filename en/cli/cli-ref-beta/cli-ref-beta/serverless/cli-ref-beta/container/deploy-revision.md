---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/container/deploy-revision.md
---

# yc beta serverless container deploy-revision

Deploys a revision for the specified container.

#### Command Usage

Syntax: 

`yc beta serverless container deploy-revision <CONTAINER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--async-invocation-config`|<b>`shorthand/json`</b><br/>Config for asynchronous invocations of the revision.<br/>Shorthand Syntax:<br/>{<br/>service-account-id = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"service-account-id": "str"<br/>}"<br/>Fields:<br/>service-account-id -> (string)<br/>Optional id of service account with permission to invoke container.|
|`--concurrency`|<b>`int`</b><br/>The number of concurrent requests allowed per container instance. The default value is 1.|
|`--connectivity`|<b>`shorthand/json`</b><br/>Network access. If specified the revision will be attached to specified network/subnet(s).<br/>Shorthand Syntax:<br/>{<br/>network-id = str,<br/>subnet-ids = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"network-id": "str",<br/>"subnet-ids": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>network-id -> (string)<br/>Network the revision will have access to.<br/>subnet-ids -> ([]string)<br/>The list of subnets (from the same network) the revision can be attached to. Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids.|
|`--container-id`|<b>`string`</b><br/>ID of the container to create a revision for. To get a container ID, make a [ContainerService.List] request.|
|`--description`|<b>`string`</b><br/>Description of the revision.|
|`--execution-timeout`|<b>`duration`</b><br/>Timeout for the execution of the revision. If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. (duration, e.g. 30s, 5m10s)|
|`--image-spec`|<b>`shorthand/json`</b><br/>Image configuration for the revision.<br/>Shorthand Syntax:<br/>{<br/>args = {<br/>args = str,...<br/>},<br/>command = {<br/>command = str,...<br/>},<br/>environment = {key=str, key=...},<br/>image-url = str,<br/>working-dir = str<br/>}<br/>JSON Syntax:<br/>"{<br/>"args": {<br/>"args": [<br/>"str", ...<br/>]<br/>},<br/>"command": {<br/>"command": [<br/>"str", ...<br/>]<br/>},<br/>"environment": {<br/>"\<key\>": "str", ...<br/>},<br/>"image-url": "str",<br/>"working-dir": "str"<br/>}"<br/>Fields:<br/>args -> (struct)<br/>Override for the image's CMD.<br/>args -> ([]string)<br/>Arguments that will override CMD of an image. Arguments will be passed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.<br/>command -> (struct)<br/>Override for the image's ENTRYPOINT.<br/>command -> ([]string)<br/>Command that will override ENTRYPOINT of an image. Commands will be executed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.<br/>environment -> (map[string,string])<br/>Additional environment for the container.<br/>image-url -> (string)<br/>Image URL, that is used by the revision.<br/>working-dir -> (string)<br/>Override for the image's WORKDIR.|
|`--log-options`|<b>`shorthand/json`</b><br/>Options for logging from the container.<br/>Shorthand Syntax:<br/>{<br/>destination = folder-id=str \| log-group-id=str,<br/>disabled = bool,<br/>min-level = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"disabled": "bool",<br/>"min-level": "TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL"<br/>}"<br/>Fields:<br/>disabled -> (bool)<br/>Is logging from container disabled.<br/>min-level -> (enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>)<br/>Minimum log entry level. See [LogLevel.Level] for details.<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>log-group-id -> (string)<br/>Entry should be written to log group resolved by ID.<br/>folder-id -> (string)<br/>Entry should be written to default log group for specified folder.|
|`--metadata-options`|<b>`shorthand/json`</b><br/>Metadata options for the revision.<br/>Shorthand Syntax:<br/>{<br/>aws-v1-http-endpoint = ENABLED\|DISABLED,<br/>gce-http-endpoint = ENABLED\|DISABLED<br/>}<br/>JSON Syntax:<br/>"{<br/>"aws-v1-http-endpoint": "ENABLED\|DISABLED",<br/>"gce-http-endpoint": "ENABLED\|DISABLED"<br/>}"<br/>Fields:<br/>aws-v1-http-endpoint -> (enum<DISABLED\|ENABLED>)<br/>Enabled access to AWS flavored metadata (IMDSv1)<br/>gce-http-endpoint -> (enum<DISABLED\|ENABLED>)<br/>Enabled access to GCE flavored metadata|
|`--mounts`|<b>`shorthand/json`</b><br/>Mounts to be used by the revision.<br/>Shorthand Syntax:<br/>[<br/>{<br/>mode = READ_ONLY\|READ_WRITE,<br/>mount-point-path = str,<br/>target = ephemeral-disk-spec={<br/>block-size = int,<br/>size = int<br/>} \| object-storage={<br/>bucket-id = str,<br/>prefix = str<br/>}<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"mode": "READ_ONLY\|READ_WRITE",<br/>"mount-point-path": "str",<br/>"target": {<br/>"ephemeral-disk-spec": {<br/>"block-size": "int",<br/>"size": "int"<br/>},<br/>"object-storage": {<br/>"bucket-id": "str",<br/>"prefix": "str"<br/>}<br/>}<br/>}, ...<br/>]"<br/>Fields:<br/>mode -> (enum<READ_ONLY\|READ_WRITE>)<br/>Mount's mode<br/>mount-point-path -> (string)<br/>The absolute mount point path inside the container for mounting.<br/>target -> (oneof<ephemeral-disk-spec\|object-storage>)<br/>Oneof target field<br/>object-storage -> (struct)<br/>Object storage mounts<br/>bucket-id -> (string)<br/>ObjectStorage bucket name for mounting.<br/>prefix -> (string)<br/>ObjectStorage bucket prefix for mounting.<br/>ephemeral-disk-spec -> (struct)<br/>Working disk (worker-local non-shared read-write NBS disk templates)<br/>block-size -> (int)<br/>Optional block size of disk for mount in bytes<br/>size -> (int)<br/>The size of disk for mount in bytes|
|`--provision-policy`|<b>`shorthand/json`</b><br/>Policy for provisioning instances of the revision. The policy is only applied when the revision is ACTIVE.<br/>Shorthand Syntax:<br/>{<br/>min-instances = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"min-instances": "int"<br/>}"<br/>Fields:<br/>min-instances -> (int)<br/>Minimum number of guaranteed provisioned container instances for all zones in total.|
|`--resources`|<b>`shorthand/json`</b><br/>Resources allocated to the revision.<br/>Shorthand Syntax:<br/>{<br/>core-fraction = int,<br/>cores = int,<br/>memory = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"core-fraction": "int",<br/>"cores": "int",<br/>"memory": "int"<br/>}"<br/>Fields:<br/>core-fraction -> (int)<br/>Specifies baseline performance for a core in percent, multiple of 5%. Should be 100% for cores > 1.<br/>cores -> (int)<br/>Number of cores available to the revision.<br/>memory -> (int)<br/>Amount of memory available to the revision, specified in bytes, multiple of 128MB.|
|`--runtime`|<b>`shorthand/json`</b><br/>The container's execution mode.<br/>Shorthand Syntax:<br/>{<br/>type = http={} \| task={}<br/>}<br/>JSON Syntax:<br/>"{<br/>"type": {<br/>"http": {},<br/>"task": {}<br/>}<br/>}"<br/>Fields:<br/>type -> (oneof<http\|task>)<br/>Oneof type field<br/>http -> (struct)<br/>The classic one. You need to run an HTTP server inside the container.<br/>task -> (struct)<br/>We run a process from ENTRYPOINT inside the container for each user request.|
|`--scaling-policy`|<b>`shorthand/json`</b><br/>Policy for scaling instances of the revision.<br/>Shorthand Syntax:<br/>{<br/>zone-instances-limit = int,<br/>zone-requests-limit = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"zone-instances-limit": "int",<br/>"zone-requests-limit": "int"<br/>}"<br/>Fields:<br/>zone-instances-limit -> (int)<br/>Upper limit for instance count in each zone. 0 means no limit.<br/>zone-requests-limit -> (int)<br/>Upper limit of requests count in each zone. 0 means no limit.|
|`--secrets`|<b>`shorthand/json`</b><br/>Yandex Lockbox secrets to be used by the revision.<br/>Shorthand Syntax:<br/>[<br/>{<br/>id = str,<br/>key = str,<br/>reference = environment-variable=str,<br/>version-id = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"id": "str",<br/>"key": "str",<br/>"reference": {<br/>"environment-variable": "str"<br/>},<br/>"version-id": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>id -> (string)<br/>ID of Yandex Lockbox secret.<br/>key -> (string)<br/>Key in secret's payload, which value to be delivered into container environment.<br/>version-id -> (string)<br/>ID of Yandex Lockbox secret.<br/>reference -> (oneof\<environment-variable\>)<br/>Oneof reference field<br/>environment-variable -> (string)<br/>Environment variable in which secret's value is delivered.|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to associate with the revision.|
|`--storage-mounts`|<b>`shorthand/json`</b><br/>S3 mounts to be used by the revision.<br/>Shorthand Syntax:<br/>[<br/>{<br/>bucket-id = str,<br/>mount-point-path = str,<br/>prefix = str,<br/>read-only = bool<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"bucket-id": "str",<br/>"mount-point-path": "str",<br/>"prefix": "str",<br/>"read-only": "bool"<br/>}, ...<br/>]"<br/>Fields:<br/>bucket-id -> (string)<br/>S3 bucket name for mounting.<br/>mount-point-path -> (string)<br/>Mount point path inside the container for mounting.<br/>prefix -> (string)<br/>S3 bucket prefix for mounting.<br/>read-only -> (bool)<br/>Is mount read only.|
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
