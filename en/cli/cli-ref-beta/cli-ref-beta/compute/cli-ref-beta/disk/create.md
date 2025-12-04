---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/disk/create.md
---

# yc beta compute disk create

Creates a disk in the specified folder.

#### Command Usage

Syntax: 

`yc beta compute disk create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--block-size`|<b>`int`</b><br/>Block size used for disk, specified in bytes. The default is 4096.|
|`--description`|<b>`string`</b><br/>Description of the disk.|
|`--disk-placement-policy`|<b>`shorthand/json`</b><br/>Placement policy configuration.<br/><br/>Example:|
|`--disk-placement-policy`|<b>`placement-group-id=value,`</b><br/>placement-group-partition=1<br/><br/>Shorthand Syntax:<br/>{placement-group-id=str, placement-group-partition=int}<br/>Fields:<br/>placement-group-id         string  — Placement group ID.<br/>placement-group-partition  int     —<br/>|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a disk in.<br/>To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--hardware-generation`|<b>`shorthand/json`</b><br/>Specify the overrides to hardware_generation of a source disk, image or snapshot,<br/>or to the default values if the source does not define it.<br/><br/>Example:<br/>--hardware-generation features={generation2-features={}}<br/><br/>Shorthand Syntax:<br/>{features={generation2-features={} \| legacy-features={pci-topology=PCI_TOPOLOGY_V1\|PCI_TOPOLOGY_V2}}}<br/>Fields:<br/>features  oneof<generation2-features\|legacy-features>  — Oneof features field<br/>legacy-features       struct  —<br/>pci-topology  enum<PCI_TOPOLOGY_V1\|PCI_TOPOLOGY_V2>  —<br/>generation2-features  struct  —<br/>|
|`--kms-key-id`|<b>`string`</b><br/>ID of KMS key for disk encryption.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the disk.|
|`--size`|<b>`int`</b><br/>Size of the disk, specified in bytes.<br/>If the disk was created from a image, this value should be more than the<br/>[yandex.cloud.compute.v1.Image.min_disk_size] value.|
|`--snapshot-schedule-ids`|<b>`strings`</b><br/>List of IDs of the snapshot schedules to attach the disk to.|
|`--type-id`|<b>`string`</b><br/>ID of the disk type.<br/>To get a list of available disk types use the [yandex.cloud.compute.v1.DiskTypeService.List] request.|
|`--zone-id`|<b>`string`</b><br/>ID of the availability zone where the disk resides.<br/>To get a list of available zones use the [yandex.cloud.compute.v1.ZoneService.List] request.|
|`--image-id`|<b>`string`</b><br/>ID of the image to create the disk from.|
|`--snapshot-id`|<b>`string`</b><br/>ID of the snapshot to restore the disk from.|
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
