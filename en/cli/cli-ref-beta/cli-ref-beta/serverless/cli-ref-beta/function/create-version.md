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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--async-invocation-config`|<b>`shorthand/json`</b><br/>Config for asynchronous invocations of the version<br/><br/>Example:|
|`--async-invocation-config`|<b>`failure-target={target={empty-target={}}},`</b><br/>retries-count=1, service-account-id=value, success-target={target={empty-target={}}}<br/><br/>Shorthand Syntax:<br/>{failure-target={target={empty-target={} \| ymq-target={queue-arn=str, service-account-id=str}}}, retries-count=int, service-account-id=str, success-target={target={empty-target={} \| ymq-target={queue-arn=str, service-account-id=str}}}}<br/>Fields:<br/>failure-target      struct  required  — Target for unsuccessful result, if all retries failed<br/>target  oneof<empty-target\|ymq-target>  — Oneof target field<br/>empty-target  struct  — Target to ignore a result<br/>ymq-target    struct  — Target to send a result to ymq<br/>queue-arn           string  required  — Queue ARN<br/>service-account-id  string  required  — Service account which has write permission on the queue.<br/>retries-count       int               — Number of retries of version invocation<br/>service-account-id  string            — Service account which can invoke version<br/>success-target      struct  required  — Target for successful result of the version's invocation<br/>target  oneof<empty-target\|ymq-target>  — Oneof target field<br/>empty-target  struct  — Target to ignore a result<br/>ymq-target    struct  — Target to send a result to ymq<br/>queue-arn           string  required  — Queue ARN<br/>service-account-id  string  required  — Service account which has write permission on the queue.<br/>|
|`--concurrency`|<b>`int`</b><br/>The maximum number of requests processed by a function instance at the same time|
|`--connectivity`|<b>`shorthand/json`</b><br/>Function version connectivity. If specified the version will be attached to specified network/subnet(s).<br/><br/>Example:|
|`--connectivity`|<b>`network-id=value,`</b><br/>subnet-id=value<br/><br/>Shorthand Syntax:<br/>{network-id=str, subnet-id=str,...}<br/>Fields:<br/>network-id  string    — Network the version will have access to.<br/>It's essential to specify network with subnets in all availability zones.<br/>subnet-id   []string  — Complete list of subnets (from the same network) the version can be attached to.<br/>It's essential to specify at least one subnet for each availability zones.<br/>|
|`--description`|<b>`string`</b><br/>Description of the version|
|`--entrypoint`|<b>`string`</b><br/>Entrypoint of the version.|
|`--environment`|<b>`stringToString`</b><br/>Environment settings for the version.|
|`--execution-timeout`|<b>`duration`</b><br/>Timeout for the execution of the version.<br/><br/>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. (duration, e.g. 30s, 5m10s)|
|`--function-id`|<b>`string`</b><br/>ID of the function to create a version for.<br/><br/>To get a function ID, make a [FunctionService.List] request.|
|`--log-options`|<b>`shorthand/json`</b><br/>Options for logging from the function<br/><br/>Example:|
|`--log-options`|<b>`destination={folder-id=value},`</b><br/>disabled=true, min-level=TRACE<br/><br/>Shorthand Syntax:<br/>{destination={folder-id=str \| log-group-id=str}, disabled=bool, min-level=TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL}<br/>Fields:<br/>disabled     bool                                     — Is logging from function disabled.<br/>min-level    enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>  — Minimum log entry level.<br/><br/>See [LogLevel.Level] for details.<br/>destination  oneof<folder-id\|log-group-id>            — Oneof destination field<br/>log-group-id  string  — Entry should be written to log group resolved by ID.<br/>folder-id     string  — Entry should be written to default log group for specified folder.<br/>|
|`--metadata-options`|<b>`shorthand/json`</b><br/>Metadata options for the version.<br/><br/>Example:|
|`--metadata-options`|<b>`aws-v1-http-endpoint=ENABLED,`</b><br/>gce-http-endpoint=ENABLED<br/><br/>Shorthand Syntax:<br/>{aws-v1-http-endpoint=ENABLED\|DISABLED, gce-http-endpoint=ENABLED\|DISABLED}<br/>Fields:<br/>aws-v1-http-endpoint  enum<DISABLED\|ENABLED>  — Enabled access to AWS flavored metadata (IMDSv1)<br/>gce-http-endpoint     enum<DISABLED\|ENABLED>  — Enabled access to GCE flavored metadata<br/>|
|`--mounts`|<b>`shorthand/json`</b><br/>Mounts to be used by the version.<br/><br/>Example:|
|`--mounts`|<b>`[{mode=READ_ONLY,`</b><br/>name=value, target={ephemeral-disk-spec={block-size=1, size=1}}}]<br/><br/>Shorthand Syntax:<br/>[{mode=READ_ONLY\|READ_WRITE, name=str, target={ephemeral-disk-spec={block-size=int, size=int} \| object-storage={bucket-id=str, prefix=str}}},...]<br/>Fields:<br/>mode    enum<READ_ONLY\|READ_WRITE>                           — Mount's mode<br/>name    string                                     required  — Unique mount point name. Device will be mounted into /function/storage/\<name\><br/>target  oneof<ephemeral-disk-spec\|object-storage>            — Oneof target field<br/>object-storage       struct  — Object storage mounts<br/>bucket-id  string  required  — ObjectStorage bucket name for mounting.<br/>prefix     string            — ObjectStorage bucket prefix for mounting.<br/>ephemeral-disk-spec  struct  — Working disk (worker-local non-shared read-write NBS disk templates)<br/>block-size  int  — Optional block size of disk for mount in bytes<br/>size        int  — The size of disk for mount in bytes<br/>|
|`--named-service-accounts`|<b>`stringToString`</b><br/>Additional service accounts to be used by the version.|
|`--resources`|<b>`shorthand/json`</b><br/>Resources allocated to the version.<br/><br/>Example:<br/>--resources memory=1<br/><br/>Shorthand Syntax:<br/>{memory=int}<br/>Fields:<br/>memory  int  — Amount of memory available to the version, specified in bytes, multiple of 128MB.<br/>|
|`--runtime`|<b>`string`</b><br/>Runtime environment for the version.|
|`--secrets`|<b>`shorthand/json`</b><br/>Yandex Lockbox secrets to be used by the version.<br/><br/>Example:|
|`--secrets`|<b>`[{id=value,`</b><br/>key=value, reference={environment-variable=value}, version-id=value}]<br/><br/>Shorthand Syntax:<br/>[{id=str, key=str, reference={environment-variable=str}, version-id=str},...]<br/>Fields:<br/>id          string                       — ID of Yandex Lockbox secret.<br/>key         string                       — Key in secret's payload, which value to be delivered into function environment.<br/>version-id  string                       — ID of Yandex Lockbox version.<br/>reference   oneof\<environment-variable\>  — Oneof reference field<br/>environment-variable  string  — environment variable in which secret's value to be delivered.<br/>|
|`--service-account-id`|<b>`string`</b><br/>ID of the service account to associate with the version.|
|`--storage-mounts`|<b>`shorthand/json`</b><br/>S3 mounts to be used by the version.<br/><br/>Example:|
|`--storage-mounts`|<b>`[{bucket-id=value,`</b><br/>mount-point-name=value, prefix=value, read-only=true}]<br/><br/>Shorthand Syntax:<br/>[{bucket-id=str, mount-point-name=str, prefix=str, read-only=bool},...]<br/>Fields:<br/>bucket-id         string  required  — S3 bucket name for mounting.<br/>mount-point-name  string  required  — Mount point directory name (not path) for mounting.<br/>prefix            string            — S3 bucket prefix for mounting.<br/>read-only         bool              — Is mount read only.<br/>|
|`--tag`|<b>`strings`</b><br/>Function version tags. For details, see [Version tag](https://yandex.cloud/ru/docs/functions/concepts/function#tag).|
|`--tmpfs-size`|<b>`int`</b><br/>Optional size of in-memory mounted /tmp directory in bytes.<br/>Available for versions with resources.memory greater or equal to 1024 MiB.<br/><br/>0 or in range from 512 MiB to 3/4 of resources.memory.|
|`--package`|<b>`shorthand/json`</b><br/>Functions deployment package.<br/><br/>Example:|
|`--package`|<b>`bucket-name=value,`</b><br/>object-name=value, sha256=value<br/><br/>Shorthand Syntax:<br/>{bucket-name=str, object-name=str, sha256=str}<br/>Fields:<br/>bucket-name  string  required  — Name of the bucket that stores the code for the version.<br/>object-name  string  required  — Name of the object in the bucket that stores the code for the version.<br/>sha256       string            — SHA256 hash of the version deployment package.<br/>|
|`--content`|<b>`bytesBase64`</b><br/>Content of the deployment package. (base64)|
|`--version-id`|<b>`string`</b><br/>ID of the version to be copied from. Source version must belong to the same folder as the created version<br/>and the user must have read permissions to the source version.|
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
