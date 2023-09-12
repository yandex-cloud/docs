---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/compute/instance/attach-new-disk.md
---

# yc compute instance attach-new-disk

Attach new disk to the specified virtual machine instance

#### Command Usage

Syntax: 

`yc compute instance attach-new-disk <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Instance id.|
|`--name`|<b>`string`</b><br/>Instance name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--disk-name`|<b>`string`</b><br/>Specifies the name of the disk.|
|`--type`|<b>`string`</b><br/>The type of the disk. To get a list of available disk types, run 'yc compute disk-type list'. The default disk type is network-hdd.|
|`--size`|<b>`byteSize`</b><br/>The size of the disk in GB. You can also use M and T suffixes to specify smaller or greater size respectively. If not specified, inferred size is used. If the disk is created from a snapshot, disk size of the snapshot is used. If the disk is created from an image, size of the image is used.If no source is specified, default disk size is used.|
|`--block-size`|<b>`byteSize`</b><br/>Specifies the block size of the disk in bytes. You can also use K and M suffixes.|
|`--snapshot-name`|<b>`string`</b><br/>A source snapshot used to create the disk.|
|`--snapshot-id`|<b>`string`</b><br/>An ID of the source snapshot used to create the disk.|
|`--image-name`|<b>`string`</b><br/>A source image used to create the disk.|
|`--image-id`|<b>`string`</b><br/>An ID of the source image used to create the disk.|
|`--image-family`|<b>`string`</b><br/>An image family that is used to create the disk.|
|`--image-folder-id`|<b>`string`</b><br/>The folder ID that is used to resolve references for image-name or image-family.|
|`--disk-placement-group-id`|<b>`string`</b><br/>An ID of the placement group to create the disk in|
|`--disk-placement-group-name`|<b>`string`</b><br/>A placement group to create the disk in|
|`--disk-placement-group-partition`|<b>`int`</b><br/>A placement group partition to create the disk in. Used when a placement group is created with the partition strategy.|
|`--device-name`|<b>`string`</b><br/>Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.|
|`--auto-delete`|Specifies if this persistent disk will be automatically deleted when the instance is deleted.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
