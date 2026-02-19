---
editable: false
noIndex: true
---

# yc beta compute disk create

Creates a disk in the specified folder.
You can create an empty disk or restore it from a snapshot or an image.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta compute disk create <FOLDER-ID>`

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
|| `--block-size` | `int`

Block size used for disk, specified in bytes. The default is 4096. ||
|| `--description` | `string`

Description of the disk. ||
|| `--disk-placement-policy` | `shorthand/json`

Placement policy configuration.

Shorthand Syntax:

```hcl
{
  placement-group-id = string,
  placement-group-partition = integer
}
```

JSON Syntax:

```json
{
  "placement-group-id": "string",
  "placement-group-partition": "integer"
}
```

Fields:

```
placement-group-id -> (string)
  Placement group ID.
placement-group-partition -> (integer)
``` ||
|| `--folder-id` | `string`

ID of the folder to create a disk in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request. ||
|| `--hardware-generation` | `shorthand/json`

Specify the overrides to hardware_generation of a source disk, image or snapshot, or to the default values if the source does not define it.

Shorthand Syntax:

```hcl
{
  features = generation2-features={} | legacy-features={
    pci-topology = PCI_TOPOLOGY_V1|PCI_TOPOLOGY_V2
  }
}
```

JSON Syntax:

```json
{
  "features": {
    "generation2-features": {},
    "legacy-features": {
      "pci-topology": "PCI_TOPOLOGY_V1|PCI_TOPOLOGY_V2"
    }
  }
}
```

Fields:

```
features -> (oneof<generation2-features|legacy-features>)
  Oneof features field
  legacy-features -> (struct)
    pci-topology -> (struct)
  generation2-features -> (struct)
``` ||
|| `--kms-key-id` | `string`

ID of KMS key for disk encryption. ||
|| `--labels` | `map<string><string>`

Resource labels as 'key:value' pairs. ||
|| `--name` | `string`

Name of the disk. ||
|| `--size` | `int`

Size of the disk, specified in bytes. If the disk was created from a image, this value should be more than the [yandex.cloud.compute.v1.Image.min_disk_size] value. ||
|| `--snapshot-schedule-ids` | `[]string`

List of IDs of the snapshot schedules to attach the disk to. ||
|| `--type-id` | `string`

ID of the disk type. To get a list of available disk types use the [yandex.cloud.compute.v1.DiskTypeService.List] request. ||
|| `--zone-id` | `string`

ID of the availability zone where the disk resides. To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List] request. ||
|| `--image-id` | `string`

ID of the image to create the disk from. ||
|| `--snapshot-id` | `string`

ID of the snapshot to restore the disk from. ||
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