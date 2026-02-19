---
editable: false
noIndex: true
---

# yc beta compute reserved-instance-pool create

Creates an reserved instance pool in the specified folder.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta compute reserved-instance-pool create <FOLDER-ID>`

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
|| `--allow-oversubscription` | Allows the pool to contain more linked instances than the number of available slots (size without pending or unavailable slots). While running instances are still limited by available slots, stopped instances can exceed this limit. Warning: When this option is enabled, attempting to start more instances than the number of available slots will result in a "Not Enough Resources" error. ||
|| `--boot-disk-spec` | `shorthand/json`

Spec is used to determine which License IDs should be allowed for instances created in the pool.

Shorthand Syntax:

```hcl
{
  boot-source = disk-id=string | image-id=string | product-ids={
    product-ids = string,...
  } | snapshot-id=string
}
```

JSON Syntax:

```json
{
  "boot-source": {
    "disk-id": "string",
    "image-id": "string",
    "product-ids": {
      "product-ids": [
        "string", ...
      ]
    },
    "snapshot-id": "string"
  }
}
```

Fields:

```
boot-source -> (oneof<disk-id|image-id|product-ids|snapshot-id>)
  Oneof boot-source field
  disk-id -> (string)
    Disk ID.
  image-id -> (string)
    Image ID.
  snapshot-id -> (string)
    Snapshot ID.
  product-ids -> (struct)
    Product IDs.
    product-ids -> ([]string)
      License IDs that indicate which licenses are attached to resource. License IDs are used to calculate additional charges for the use of the virtual machine.
``` ||
|| `--description` | `string`

Description of the reserved instance pool. ||
|| `--folder-id` | `string`

ID of the folder to create the reserved instance pool in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--gpu-settings` | `shorthand/json`

GPU settings.

Shorthand Syntax:

```hcl
{
  gpu-cluster-id = string
}
```

JSON Syntax:

```json
{
  "gpu-cluster-id": "string"
}
```

Fields:

```
gpu-cluster-id -> (string)
  Attach instance to specified GPU cluster.
``` ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the reserved instance pool. ||
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
|| `--platform-id` | `string`

ID of the hardware platform configuration for the reserved instance pool. This field affects the available values in [resources_spec] field. For more information, see documentation. ||
|| `--resources-spec` | `shorthand/json`

Computing resources of the reserved instance pool instances, such as the amount of memory and number of cores. To get a list of available values, see documentation.

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
|| `--size` | `int`

Desired size of the pool (number of slots for instances in this pool). ||
|| `--zone-id` | `string`

ID of the availability zone where the reserved instance pool resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List] request ||
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