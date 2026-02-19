---
editable: false
noIndex: true
---

# yc beta compute instance attach-disk

Attaches the disk to the instance.

#### Command Usage

Syntax:

`yc beta compute instance attach-disk <INSTANCE-ID>`

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
|| `--attached-disk-spec` | `shorthand/json`

Disk that should be attached.

Shorthand Syntax:

```hcl
{
  auto-delete = boolean,
  device-name = string,
  disk = disk-id=string | disk-spec={
    block-size = integer,
    description = string,
    disk-placement-policy = {
      placement-group-id = string,
      placement-group-partition = integer
    },
    kms-key-id = string,
    name = string,
    size = integer,
    source = image-id=string | snapshot-id=string,
    type-id = string
  },
  mode = READ_ONLY|READ_WRITE
}
```

JSON Syntax:

```json
{
  "auto-delete": "boolean",
  "device-name": "string",
  "disk": {
    "disk-id": "string",
    "disk-spec": {
      "block-size": "integer",
      "description": "string",
      "disk-placement-policy": {
        "placement-group-id": "string",
        "placement-group-partition": "integer"
      },
      "kms-key-id": "string",
      "name": "string",
      "size": "integer",
      "source": {
        "image-id": "string",
        "snapshot-id": "string"
      },
      "type-id": "string"
    }
  },
  "mode": "READ_ONLY|READ_WRITE"
}
```

Fields:

```
auto-delete -> (boolean)
  Specifies whether the disk will be auto-deleted when the instance is deleted.
device-name -> (string)
  Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. This value can be used to reference the device for mounting, resizing, and so on, from within the instance. If not specified, a random value will be generated.
mode -> (struct)
  The mode in which to attach this disk.
disk -> (oneof<disk-id|disk-spec>)
  Oneof disk field
  disk-spec -> (struct)
    Disk specification.
    block-size -> (integer)
      Block size of the disk, specified in bytes. The default is 4096.
    description -> (string)
      Description of the disk.
    disk-placement-policy -> (struct)
      Placement policy configuration.
      placement-group-id -> (string)
        Placement group ID.
      placement-group-partition -> (integer)
    kms-key-id -> (string)
      ID of KMS key for disk encryption
    name -> (string)
      Name of the disk.
    size -> (integer)
      Size of the disk, specified in bytes.
    type-id -> (string)
      ID of the disk type. To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List] request.
    source -> (oneof<image-id|snapshot-id>)
      Oneof source field
      image-id -> (string)
        ID of the image to create the disk from.
      snapshot-id -> (string)
        ID of the snapshot to restore the disk from.
  disk-id -> (string)
    ID of the disk that should be attached.
``` ||
|| `--instance-id` | `string`

ID of the instance to attach the disk to. To get the instance ID, use a [InstanceService.List] request. ||
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