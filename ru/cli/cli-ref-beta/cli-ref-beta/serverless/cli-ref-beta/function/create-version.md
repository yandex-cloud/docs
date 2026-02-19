---
editable: false
noIndex: true
---

# yc beta serverless function create-version

Creates a version for the specified function.

#### Command Usage

Syntax:

`yc beta serverless function create-version <FUNCTION-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--async-invocation-config` | `shorthand/json`

Config for asynchronous invocations of the version

Shorthand Syntax:

```hcl
{
  failure-target = {
    target = empty-target={} | ymq-target={
      queue-arn = string,
      service-account-id = string
    }
  },
  retries-count = integer,
  service-account-id = string,
  success-target = {
    target = empty-target={} | ymq-target={
      queue-arn = string,
      service-account-id = string
    }
  }
}
```

JSON Syntax:

```json
{
  "failure-target": {
    "target": {
      "empty-target": {},
      "ymq-target": {
        "queue-arn": "string",
        "service-account-id": "string"
      }
    }
  },
  "retries-count": "integer",
  "service-account-id": "string",
  "success-target": {
    "target": {
      "empty-target": {},
      "ymq-target": {
        "queue-arn": "string",
        "service-account-id": "string"
      }
    }
  }
}
```

Fields:

```
failure-target -> (struct)
  Target for unsuccessful result, if all retries failed
  target -> (oneof<empty-target|ymq-target>)
    Oneof target field
    empty-target -> (struct)
      Target to ignore a result
    ymq-target -> (struct)
      Target to send a result to ymq
      queue-arn -> (string)
        Queue ARN
      service-account-id -> (string)
        Service account which has write permission on the queue.
retries-count -> (integer)
  Number of retries of version invocation
service-account-id -> (string)
  Service account which can invoke version
success-target -> (struct)
  Target for successful result of the version's invocation
  target -> (oneof<empty-target|ymq-target>)
    Oneof target field
    empty-target -> (struct)
      Target to ignore a result
    ymq-target -> (struct)
      Target to send a result to ymq
      queue-arn -> (string)
        Queue ARN
      service-account-id -> (string)
        Service account which has write permission on the queue.
``` ||
|| `--concurrency` | `int`

The maximum number of requests processed by a function instance at the same time ||
|| `--connectivity` | `shorthand/json`

Function version connectivity. If specified the version will be attached to specified network/subnet(s).

Shorthand Syntax:

```hcl
{
  network-id = string,
  subnet-id = string,...
}
```

JSON Syntax:

```json
{
  "network-id": "string",
  "subnet-id": [
    "string", ...
  ]
}
```

Fields:

```
network-id -> (string)
  Network the version will have access to. It's essential to specify network with subnets in all availability zones.
subnet-id -> ([]string)
  Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones.
``` ||
|| `--description` | `string`

Description of the version ||
|| `--entrypoint` | `string`

Entrypoint of the version. ||
|| `--environment` | `map<string><string>`

Environment settings for the version. ||
|| `--execution-timeout` | `duration`

Timeout for the execution of the version. If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code. (duration, e.g. 30s, 5m10s) ||
|| `--function-id` | `string`

ID of the function to create a version for. To get a function ID, make a [FunctionService.List] request. ||
|| `--log-options` | `shorthand/json`

Options for logging from the function

Shorthand Syntax:

```hcl
{
  destination = folder-id=string | log-group-id=string,
  disabled = boolean,
  min-level = TRACE|DEBUG|INFO|WARN|ERROR|FATAL
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "string",
    "log-group-id": "string"
  },
  "disabled": "boolean",
  "min-level": "TRACE|DEBUG|INFO|WARN|ERROR|FATAL"
}
```

Fields:

```
disabled -> (boolean)
  Is logging from function disabled.
min-level -> (struct)
  Minimum log entry level. See [LogLevel.Level] for details.
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  log-group-id -> (string)
    Entry should be written to log group resolved by ID.
  folder-id -> (string)
    Entry should be written to default log group for specified folder.
``` ||
|| `--metadata-options` | `shorthand/json`

Metadata options for the version.

Shorthand Syntax:

```hcl
{
  aws-v1-http-endpoint = ENABLED|DISABLED,
  gce-http-endpoint = ENABLED|DISABLED
}
```

JSON Syntax:

```json
{
  "aws-v1-http-endpoint": "ENABLED|DISABLED",
  "gce-http-endpoint": "ENABLED|DISABLED"
}
```

Fields:

```
aws-v1-http-endpoint -> (struct)
  Enabled access to AWS flavored metadata (IMDSv1)
gce-http-endpoint -> (struct)
  Enabled access to GCE flavored metadata
``` ||
|| `--mounts` | `shorthand/json`

Mounts to be used by the version.

Shorthand Syntax:

```hcl
[
  {
    mode = READ_ONLY|READ_WRITE,
    name = string,
    target = ephemeral-disk-spec={
      block-size = integer,
      size = integer
    } | object-storage={
      bucket-id = string,
      prefix = string
    }
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "mode": "READ_ONLY|READ_WRITE",
    "name": "string",
    "target": {
      "ephemeral-disk-spec": {
        "block-size": "integer",
        "size": "integer"
      },
      "object-storage": {
        "bucket-id": "string",
        "prefix": "string"
      }
    }
  }, ...
]
```

Fields:

```
mode -> (struct)
  Mount's mode
name -> (string)
  Unique mount point name. Device will be mounted into /function/storage/<name>
target -> (oneof<ephemeral-disk-spec|object-storage>)
  Oneof target field
  object-storage -> (struct)
    Object storage mounts
    bucket-id -> (string)
      ObjectStorage bucket name for mounting.
    prefix -> (string)
      ObjectStorage bucket prefix for mounting.
  ephemeral-disk-spec -> (struct)
    Working disk (worker-local non-shared read-write NBS disk templates)
    block-size -> (integer)
      Optional block size of disk for mount in bytes
    size -> (integer)
      The size of disk for mount in bytes
``` ||
|| `--named-service-accounts` | `map<string><string>`

Additional service accounts to be used by the version. ||
|| `--resources` | `shorthand/json`

Resources allocated to the version.

Shorthand Syntax:

```hcl
{
  memory = integer
}
```

JSON Syntax:

```json
{
  "memory": "integer"
}
```

Fields:

```
memory -> (integer)
  Amount of memory available to the version, specified in bytes, multiple of 128MB.
``` ||
|| `--runtime` | `string`

Runtime environment for the version. ||
|| `--secrets` | `shorthand/json`

Yandex Lockbox secrets to be used by the version.

Shorthand Syntax:

```hcl
[
  {
    id = string,
    key = string,
    reference = environment-variable=string,
    version-id = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "id": "string",
    "key": "string",
    "reference": {
      "environment-variable": "string"
    },
    "version-id": "string"
  }, ...
]
```

Fields:

```
id -> (string)
  ID of Yandex Lockbox secret.
key -> (string)
  Key in secret's payload, which value to be delivered into function environment.
version-id -> (string)
  ID of Yandex Lockbox version.
reference -> (oneof<environment-variable>)
  Oneof reference field
  environment-variable -> (string)
    environment variable in which secret's value to be delivered.
``` ||
|| `--service-account-id` | `string`

ID of the service account to associate with the version. ||
|| `--storage-mounts` | `shorthand/json`

S3 mounts to be used by the version.

Shorthand Syntax:

```hcl
[
  {
    bucket-id = string,
    mount-point-name = string,
    prefix = string,
    read-only = boolean
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "bucket-id": "string",
    "mount-point-name": "string",
    "prefix": "string",
    "read-only": "boolean"
  }, ...
]
```

Fields:

```
bucket-id -> (string)
  S3 bucket name for mounting.
mount-point-name -> (string)
  Mount point directory name (not path) for mounting.
prefix -> (string)
  S3 bucket prefix for mounting.
read-only -> (boolean)
  Is mount read only.
``` ||
|| `--tag` | `[]string`

Function version tags. For details, see documentation. ||
|| `--tmpfs-size` | `int`

Optional size of in-memory mounted /tmp directory in bytes. Available for versions with resources.memory greater or equal to 1024 MiB. 0 or in range from 512 MiB to 3/4 of resources.memory. ||
|| `--package` | `shorthand/json`

Functions deployment package.

Shorthand Syntax:

```hcl
{
  bucket-name = string,
  object-name = string,
  sha256 = string
}
```

JSON Syntax:

```json
{
  "bucket-name": "string",
  "object-name": "string",
  "sha256": "string"
}
```

Fields:

```
bucket-name -> (string)
  Name of the bucket that stores the code for the version.
object-name -> (string)
  Name of the object in the bucket that stores the code for the version.
sha256 -> (string)
  SHA256 hash of the version deployment package.
``` ||
|| `--content` | `bytesBase64`

Content of the deployment package. (base64) ||
|| `--version-id` | `string`

ID of the version to be copied from. Source version must belong to the same folder as the created version and the user must have read permissions to the source version. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#