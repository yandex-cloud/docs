---
editable: false
noIndex: true
---

# yc beta compute instance update

Updates the specified instance.

#### Command Usage

Syntax:

`yc beta compute instance update <INSTANCE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--application` | `shorthand/json`

Instance application settings.

Shorthand Syntax:

```hcl
{
  cloudbackup = {
    backup-id = string,
    enabled = boolean,
    initial-policy-ids = string,...,
    instance-registration-id = string,
    recovery-from-backup = boolean
  },
  container = container-solution={
    environment = {key=string, key=...},
    product-id = string,
    secrets = {key={
      id = string,
      key = string,
      version-id = string
    }, key=...}
  }
}
```

JSON Syntax:

```json
{
  "cloudbackup": {
    "backup-id": "string",
    "enabled": "boolean",
    "initial-policy-ids": [
      "string", ...
    ],
    "instance-registration-id": "string",
    "recovery-from-backup": "boolean"
  },
  "container": {
    "container-solution": {
      "environment": {
        "<key>": "string", ...
      },
      "product-id": "string",
      "secrets": {
        "<key>": {
          "id": "string",
          "key": "string",
          "version-id": "string"
        }, ...
      }
    }
  }
}
```

Fields:

```
cloudbackup -> (struct)
  Backup settings.
  backup-id -> (string)
    ID of the backup to recover from.
  enabled -> (boolean)
    If true, backup is enabled.
  initial-policy-ids -> ([]string)
    A list of policy IDs to apply after resource registration.
  instance-registration-id -> (string)
    ID of the instance registration for cloud backup agent installation.
  recovery-from-backup -> (boolean)
    If true, recovery from backup starts on instance.
container -> (oneof<container-solution>)
  Oneof container field
  container-solution -> (struct)
    Container specification.
    environment -> (map[string,string])
      A list of the environmets.
    product-id -> (string)
      ID of the product.
    secrets -> (map[string,struct])
      A list of the secrets.
      id -> (string)
        ID of the secret.
      key -> (string)
        Name of the key.
      version-id -> (string)
        Version of the secret.
``` ||
|| `--description` | `string`

Description of the instance. ||
|| `--instance-id` | `string`

ID of the Instance resource to update. To get the instance ID, use a [InstanceService.List] request. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. Existing set of 'labels' is completely replaced by the provided set. ||
|| `--maintenance-grace-period` | `duration`

Time between notification via metadata service and maintenance (duration, e.g. 30s, 5m10s) ||
|| `--maintenance-policy` | `enum`

Behaviour on maintenance events Possible Values: 'restart', 'migrate' ||
|| `--metadata` | `map<string><string>`

The metadata 'key:value' pairs that will be assigned to this instance. This includes custom metadata and predefined keys. The total size of all keys and values must be less than 512 KB. Existing set of 'metadata' is completely replaced by the provided set. Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance. The values must be 256 KB or less. For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see documentation. ||
|| `--metadata-options` | `shorthand/json`

Options allow user to configure access to instance's metadata

Shorthand Syntax:

```hcl
{
  aws-v1-http-endpoint = ENABLED|DISABLED,
  aws-v1-http-token = ENABLED|DISABLED,
  gce-http-endpoint = ENABLED|DISABLED,
  gce-http-token = ENABLED|DISABLED
}
```

JSON Syntax:

```json
{
  "aws-v1-http-endpoint": "ENABLED|DISABLED",
  "aws-v1-http-token": "ENABLED|DISABLED",
  "gce-http-endpoint": "ENABLED|DISABLED",
  "gce-http-token": "ENABLED|DISABLED"
}
```

Fields:

```
aws-v1-http-endpoint -> (struct)
  Enabled access to AWS flavored metadata (IMDSv1)
aws-v1-http-token -> (struct)
  Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)
gce-http-endpoint -> (struct)
  Enabled access to GCE flavored metadata
gce-http-token -> (struct)
  Enabled access to IAM credentials with GCE flavored metadata
``` ||
|| `--name` | `string`

Name of the instance. ||
|| `--network-settings` | `shorthand/json`

Network settings.

Shorthand Syntax:

```hcl
{
  type = STANDARD|SOFTWARE_ACCELERATED|HARDWARE_ACCELERATED
}
```

JSON Syntax:

```json
{
  "type": "STANDARD|SOFTWARE_ACCELERATED|HARDWARE_ACCELERATED"
}
```

Fields:

```
type -> (struct)
  Network Type
``` ||
|| `--placement-policy` | `shorthand/json`

Placement policy configuration.

Shorthand Syntax:

```hcl
{
  host-affinity-rules = [
    {
      key = string,
      op = IN|NOT_IN,
      values = string,...
    }, ...
  ],
  placement-group-id = string,
  placement-group-partition = integer
}
```

JSON Syntax:

```json
{
  "host-affinity-rules": [
    {
      "key": "string",
      "op": "IN|NOT_IN",
      "values": [
        "string", ...
      ]
    }, ...
  ],
  "placement-group-id": "string",
  "placement-group-partition": "integer"
}
```

Fields:

```
host-affinity-rules -> ([]struct)
  List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.
  key -> (string)
    Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'
  op -> (struct)
    Include or exclude action
  values -> ([]string)
    Affinity value or host ID or host group ID
placement-group-id -> (string)
  Placement group ID.
placement-group-partition -> (integer)
  Placement group partition
``` ||
|| `--platform-id` | `string`

ID of the hardware platform configuration for the instance. This field affects the available values in [resources_spec] field. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see documentation. ||
|| `--reserved-instance-pool-id` | `string`

ID of the reserved instance pool that the instance should belong to. Attaching/detaching running instance will increase/decrease the size of the reserved instance pool. Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool. Reserved instance pool resource configuration must match the resource configuration of the instance. ||
|| `--resources-spec` | `shorthand/json`

Computing resources of the instance, such as the amount of memory and number of cores. To get a list of available values, see documentation.

Shorthand Syntax:

```hcl
{
  core-fraction = integer,
  cores = integer,
  gpus = integer,
  memory = integer
}
```

JSON Syntax:

```json
{
  "core-fraction": "integer",
  "cores": "integer",
  "gpus": "integer",
  "memory": "integer"
}
```

Fields:

```
core-fraction -> (integer)
  Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. For example, if you need only 5% of the CPU performance, you can set core_fraction=5. For more information, see documentation.
cores -> (integer)
  The number of cores available to the instance.
gpus -> (integer)
  The number of GPUs available to the instance.
memory -> (integer)
  The amount of memory available to the instance, specified in bytes.
``` ||
|| `--scheduling-policy` | `shorthand/json`

Scheduling policy configuration.

Shorthand Syntax:

```hcl
{
  preemptible = boolean
}
```

JSON Syntax:

```json
{
  "preemptible": "boolean"
}
```

Fields:

```
preemptible -> (boolean)
  True for short-lived compute instances. For more information, see documentation.
``` ||
|| `--serial-port-settings` | `shorthand/json`

Serial port settings

Shorthand Syntax:

```hcl
{
  ssh-authorization = INSTANCE_METADATA|OS_LOGIN
}
```

JSON Syntax:

```json
{
  "ssh-authorization": "INSTANCE_METADATA|OS_LOGIN"
}
```

Fields:

```
ssh-authorization -> (struct)
  Authentication and authorization in serial console when using SSH protocol
``` ||
|| `--service-account-id` | `string`

ID of the service account to use for documentation. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List] request. ||
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