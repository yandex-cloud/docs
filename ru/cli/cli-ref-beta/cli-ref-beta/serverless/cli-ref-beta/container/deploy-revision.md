---
editable: false
noIndex: true
---

# yc beta serverless container deploy-revision

Deploys a revision for the specified container.

#### Command Usage

Syntax:

`yc beta serverless container deploy-revision <CONTAINER-ID>`

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

Config for asynchronous invocations of the revision.

Shorthand Syntax:

```hcl
{
  service-account-id = string
}
```

JSON Syntax:

```json
{
  "service-account-id": "string"
}
```

Fields:

```
service-account-id -> (string)
  Optional id of service account with permission to invoke container.
``` ||
|| `--concurrency` | `int`

The number of concurrent requests allowed per container instance. The default value is 1. ||
|| `--connectivity` | `shorthand/json`

Network access. If specified the revision will be attached to specified network/subnet(s).

Shorthand Syntax:

```hcl
{
  network-id = string,
  subnet-ids = string,...
}
```

JSON Syntax:

```json
{
  "network-id": "string",
  "subnet-ids": [
    "string", ...
  ]
}
```

Fields:

```
network-id -> (string)
  Network the revision will have access to.
subnet-ids -> ([]string)
  The list of subnets (from the same network) the revision can be attached to. Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids.
``` ||
|| `--container-id` | `string`

ID of the container to create a revision for. To get a container ID, make a [ContainerService.List] request. ||
|| `--description` | `string`

Description of the revision. ||
|| `--execution-timeout` | `duration`

Timeout for the execution of the revision. If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code. (duration, e.g. 30s, 5m10s) ||
|| `--image-spec` | `shorthand/json`

Image configuration for the revision.

Shorthand Syntax:

```hcl
{
  args = {
    args = string,...
  },
  command = {
    command = string,...
  },
  environment = {key=string, key=...},
  image-url = string,
  working-dir = string
}
```

JSON Syntax:

```json
{
  "args": {
    "args": [
      "string", ...
    ]
  },
  "command": {
    "command": [
      "string", ...
    ]
  },
  "environment": {
    "<key>": "string", ...
  },
  "image-url": "string",
  "working-dir": "string"
}
```

Fields:

```
args -> (struct)
  Override for the image's CMD.
  args -> ([]string)
    Arguments that will override CMD of an image. Arguments will be passed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.
command -> (struct)
  Override for the image's ENTRYPOINT.
  command -> ([]string)
    Command that will override ENTRYPOINT of an image. Commands will be executed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.
environment -> (map[string,string])
  Additional environment for the container.
image-url -> (string)
  Image URL, that is used by the revision.
working-dir -> (string)
  Override for the image's WORKDIR.
``` ||
|| `--log-options` | `shorthand/json`

Options for logging from the container.

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
  Is logging from container disabled.
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

Metadata options for the revision.

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

Mounts to be used by the revision.

Shorthand Syntax:

```hcl
[
  {
    mode = READ_ONLY|READ_WRITE,
    mount-point-path = string,
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
    "mount-point-path": "string",
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
mount-point-path -> (string)
  The absolute mount point path inside the container for mounting.
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
|| `--provision-policy` | `shorthand/json`

Policy for provisioning instances of the revision. The policy is only applied when the revision is ACTIVE.

Shorthand Syntax:

```hcl
{
  min-instances = integer
}
```

JSON Syntax:

```json
{
  "min-instances": "integer"
}
```

Fields:

```
min-instances -> (integer)
  Minimum number of guaranteed provisioned container instances for all zones in total.
``` ||
|| `--resources` | `shorthand/json`

Resources allocated to the revision.

Shorthand Syntax:

```hcl
{
  core-fraction = integer,
  cores = integer,
  memory = integer
}
```

JSON Syntax:

```json
{
  "core-fraction": "integer",
  "cores": "integer",
  "memory": "integer"
}
```

Fields:

```
core-fraction -> (integer)
  Specifies baseline performance for a core in percent, multiple of 5%. Should be 100% for cores > 1.
cores -> (integer)
  Number of cores available to the revision.
memory -> (integer)
  Amount of memory available to the revision, specified in bytes, multiple of 128MB.
``` ||
|| `--runtime` | `shorthand/json`

The container's execution mode.

Shorthand Syntax:

```hcl
{
  type = http={} | task={}
}
```

JSON Syntax:

```json
{
  "type": {
    "http": {},
    "task": {}
  }
}
```

Fields:

```
type -> (oneof<http|task>)
  Oneof type field
  http -> (struct)
    The classic one. You need to run an HTTP server inside the container.
  task -> (struct)
    We run a process from ENTRYPOINT inside the container for each user request.
``` ||
|| `--scaling-policy` | `shorthand/json`

Policy for scaling instances of the revision.

Shorthand Syntax:

```hcl
{
  zone-instances-limit = integer,
  zone-requests-limit = integer
}
```

JSON Syntax:

```json
{
  "zone-instances-limit": "integer",
  "zone-requests-limit": "integer"
}
```

Fields:

```
zone-instances-limit -> (integer)
  Upper limit for instance count in each zone. 0 means no limit.
zone-requests-limit -> (integer)
  Upper limit of requests count in each zone. 0 means no limit.
``` ||
|| `--secrets` | `shorthand/json`

Yandex Lockbox secrets to be used by the revision.

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
  Key in secret's payload, which value to be delivered into container environment.
version-id -> (string)
  ID of Yandex Lockbox secret.
reference -> (oneof<environment-variable>)
  Oneof reference field
  environment-variable -> (string)
    Environment variable in which secret's value is delivered.
``` ||
|| `--service-account-id` | `string`

ID of the service account to associate with the revision. ||
|| `--storage-mounts` | `shorthand/json`

S3 mounts to be used by the revision.

Shorthand Syntax:

```hcl
[
  {
    bucket-id = string,
    mount-point-path = string,
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
    "mount-point-path": "string",
    "prefix": "string",
    "read-only": "boolean"
  }, ...
]
```

Fields:

```
bucket-id -> (string)
  S3 bucket name for mounting.
mount-point-path -> (string)
  Mount point path inside the container for mounting.
prefix -> (string)
  S3 bucket prefix for mounting.
read-only -> (boolean)
  Is mount read only.
``` ||
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