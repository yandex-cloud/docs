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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--async-invocation-config`|<b>`shorthand/json`</b><br/>Config for asynchronous invocations of the revision.<br/><br/>Example:<br/>--async-invocation-config service-account-id=value<br/><br/>Shorthand Syntax:<br/>{service-account-id=str}<br/>Fields:<br/>service-account-id  string  — Optional id of service account with permission to invoke container.<br/>|
|`--concurrency`|<b>`int`</b><br/>The number of concurrent requests allowed per container instance.<br/><br/>The default value is 1.|
|`--connectivity`|<b>`shorthand/json`</b><br/>Network access. If specified the revision will be attached to specified network/subnet(s).<br/><br/>Example:|
|`--connectivity`|<b>`network-id=value,`</b><br/>subnet-ids=value<br/><br/>Shorthand Syntax:<br/>{network-id=str, subnet-ids=str,...}<br/>Fields:<br/>network-id  string    — Network the revision will have access to.<br/>subnet-ids  []string  — The list of subnets (from the same network) the revision can be attached to.<br/><br/>Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids.<br/>|
|`--container-id`|<b>`string`</b><br/>ID of the container to create a revision for.<br/><br/>To get a container ID, make a [ContainerService.List] request.|
|`--description`|<b>`string`</b><br/>Description of the revision.|
|`--execution-timeout`|<b>`duration`</b><br/>Timeout for the execution of the revision.<br/><br/>If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. (duration, e.g. 30s, 5m10s)|
|`--image-spec`|<b>`shorthand/json`</b><br/>Image configuration for the revision.<br/><br/>Example:|
|`--image-spec`|<b>`args={args=value},`</b><br/>command={command=value}, environment={key=value}, image-url=value, working-dir=value<br/><br/>Shorthand Syntax:<br/>{args={args=str,...}, command={command=str,...}, environment={key=str, key=...}, image-url=str, working-dir=str}<br/>Fields:<br/>args         struct                        — Override for the image's CMD.<br/>args  []string  — Arguments that will override CMD of an image.<br/><br/>Arguments will be passed as is. The runtime will not substitute environment<br/>variables or execute shell commands. If one wants to do that, they should<br/>invoke shell interpreter with an appropriate shell script.<br/>command      struct                        — Override for the image's ENTRYPOINT.<br/>command  []string  — Command that will override ENTRYPOINT of an image.<br/><br/>Commands will be executed as is. The runtime will not substitute environment<br/>variables or execute shell commands. If one wants to do that, they should<br/>invoke shell interpreter with an appropriate shell script.<br/>environment  map[string,string]            — Additional environment for the container.<br/>image-url    string              required  — Image URL, that is used by the revision.<br/>working-dir  string                        — Override for the image's WORKDIR.<br/>|
|`--log-options`|<b>`shorthand/json`</b><br/>Options for logging from the container.<br/><br/>Example:|
|`--log-options`|<b>`destination={folder-id=value},`</b><br/>disabled=true, min-level=TRACE<br/><br/>Shorthand Syntax:<br/>{destination={folder-id=str \| log-group-id=str}, disabled=bool, min-level=TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL}<br/>Fields:<br/>disabled     bool                                     — Is logging from container disabled.<br/>min-level    enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>  — Minimum log entry level.<br/><br/>See [LogLevel.Level] for details.<br/>destination  oneof<folder-id\|log-group-id>            — Oneof destination field<br/>log-group-id  string  — Entry should be written to log group resolved by ID.<br/>folder-id     string  — Entry should be written to default log group for specified folder.<br/>|
|`--metadata-options`|<b>`shorthand/json`</b><br/>Metadata options for the revision.<br/><br/>Example:|
|`--metadata-options`|<b>`aws-v1-http-endpoint=ENABLED,`</b><br/>gce-http-endpoint=ENABLED<br/><br/>Shorthand Syntax:<br/>{aws-v1-http-endpoint=ENABLED\|DISABLED, gce-http-endpoint=ENABLED\|DISABLED}<br/>Fields:<br/>aws-v1-http-endpoint  enum<DISABLED\|ENABLED>  — Enabled access to AWS flavored metadata (IMDSv1)<br/>gce-http-endpoint     enum<DISABLED\|ENABLED>  — Enabled access to GCE flavored metadata<br/>|
|`--mounts`|<b>`shorthand/json`</b><br/>Mounts to be used by the revision.<br/><br/>Example:|
|`--mounts`|<b>`[{mode=READ_ONLY,`</b><br/>mount-point-path=value, target={ephemeral-disk-spec={block-size=1, size=1}}}]<br/><br/>Shorthand Syntax:<br/>[{mode=READ_ONLY\|READ_WRITE, mount-point-path=str, target={ephemeral-disk-spec={block-size=int, size=int} \| object-storage={bucket-id=str, prefix=str}}},...]<br/>Fields:<br/>mode              enum<READ_ONLY\|READ_WRITE>                           — Mount's mode<br/>mount-point-path  string                                     required  — The absolute mount point path inside the container for mounting.<br/>target            oneof<ephemeral-disk-spec\|object-storage>            — Oneof target field<br/>object-storage       struct  — Object storage mounts<br/>bucket-id  string  required  — ObjectStorage bucket name for mounting.<br/>prefix     string            — ObjectStorage bucket prefix for mounting.<br/>ephemeral-disk-spec  struct  — Working disk (worker-local non-shared read-write NBS disk templates)<br/>block-size  int  — Optional block size of disk for mount in bytes<br/>size        int  — The size of disk for mount in bytes<br/>|
|`--provision-policy`|<b>`shorthand/json`</b><br/>Policy for provisioning instances of the revision.<br/><br/>The policy is only applied when the revision is ACTIVE.<br/><br/>Example:<br/>--provision-policy min-instances=1<br/><br/>Shorthand Syntax:<br/>{min-instances=int}<br/>Fields:<br/>min-instances  int  — Minimum number of guaranteed provisioned container instances for all zones<br/>in total.<br/>|
|`--resources`|<b>`shorthand/json`</b><br/>Resources allocated to the revision.<br/><br/>Example:|
|`--resources`|<b>`core-fraction=1,`</b><br/>cores=1, memory=1<br/><br/>Shorthand Syntax:<br/>{core-fraction=int, cores=int, memory=int}<br/>Fields:<br/>core-fraction  int  — Specifies baseline performance for a core in percent, multiple of 5%.<br/>Should be 100% for cores > 1.<br/>cores          int  — Number of cores available to the revision.<br/>memory         int  — Amount of memory available to the revision, specified in bytes, multiple of 128MB.<br/>|
|`--runtime`|<b>`shorthand/json`</b><br/>The container's execution mode.<br/><br/>Example:<br/>--runtime type={http={}}<br/><br/>Shorthand Syntax:<br/>{type={http={} \| task={}}}<br/>Fields:<br/>type  oneof<http\|task>  — Oneof type field<br/>http  struct  — The classic one. You need to run an HTTP server inside the container.<br/>task  struct  — We run a process from ENTRYPOINT inside the container for each user request.<br/>|
|`--scaling-policy`|<b>`shorthand/json`</b><br/>Policy for scaling instances of the revision.<br/><br/>Example:|
|`--scaling-policy`|<b>`zone-instances-limit=1,`</b><br/>zone-requests-limit=1<br/><br/>Shorthand Syntax:<br/>{zone-instances-limit=int, zone-requests-limit=int}<br/>Fields:<br/>zone-instances-limit  int  — Upper limit for instance count in each zone.<br/>0 means no limit.<br/>zone-requests-limit   int  — Upper limit of requests count in each zone.<br/>0 means no limit.<br/>|
|`--secrets`|<b>`shorthand/json`</b><br/>Yandex Lockbox secrets to be used by the revision.<br/><br/>Example:|
|`--secrets`|<b>`[{id=value,`</b><br/>key=value, reference={environment-variable=value}, version-id=value}]<br/><br/>Shorthand Syntax:<br/>[{id=str, key=str, reference={environment-variable=str}, version-id=str},...]<br/>Fields:<br/>id          string                       — ID of Yandex Lockbox secret.<br/>key         string                       — Key in secret's payload, which value to be delivered into container environment.<br/>version-id  string                       — ID of Yandex Lockbox secret.<br/>reference   oneof\<environment-variable\>  — Oneof reference field<br/>environment-variable  string  — Environment variable in which secret's value is delivered.<br/>|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to associate with the revision.|
|`--storage-mounts`|<b>`shorthand/json`</b><br/>S3 mounts to be used by the revision.<br/><br/>Example:|
|`--storage-mounts`|<b>`[{bucket-id=value,`</b><br/>mount-point-path=value, prefix=value, read-only=true}]<br/><br/>Shorthand Syntax:<br/>[{bucket-id=str, mount-point-path=str, prefix=str, read-only=bool},...]<br/>Fields:<br/>bucket-id         string  required  — S3 bucket name for mounting.<br/>mount-point-path  string  required  — Mount point path inside the container for mounting.<br/>prefix            string            — S3 bucket prefix for mounting.<br/>read-only         bool              — Is mount read only.<br/>|
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
