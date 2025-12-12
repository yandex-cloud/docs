---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/compute/cli-ref-beta/instance/attach-disk.md
---

# yc beta compute instance attach-disk

Attaches the disk to the instance.

#### Command Usage

Syntax: 

`yc beta compute instance attach-disk <INSTANCE-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--attached-disk-spec`|<b>`shorthand/json`</b><br/>Disk that should be attached.<br/>Shorthand Syntax:<br/>{<br/>auto-delete = bool,<br/>device-name = str,<br/>disk = disk-id=str \| disk-spec={<br/>block-size = int,<br/>description = str,<br/>disk-placement-policy = {<br/>placement-group-id = str,<br/>placement-group-partition = int<br/>},<br/>kms-key-id = str,<br/>name = str,<br/>size = int,<br/>source = image-id=str \| snapshot-id=str,<br/>type-id = str<br/>},<br/>mode = READ_ONLY\|READ_WRITE<br/>}<br/>JSON Syntax:<br/>"{<br/>"auto-delete": "bool",<br/>"device-name": "str",<br/>"disk": {<br/>"disk-id": "str",<br/>"disk-spec": {<br/>"block-size": "int",<br/>"description": "str",<br/>"disk-placement-policy": {<br/>"placement-group-id": "str",<br/>"placement-group-partition": "int"<br/>},<br/>"kms-key-id": "str",<br/>"name": "str",<br/>"size": "int",<br/>"source": {<br/>"image-id": "str",<br/>"snapshot-id": "str"<br/>},<br/>"type-id": "str"<br/>}<br/>},<br/>"mode": "READ_ONLY\|READ_WRITE"<br/>}"<br/>Fields:<br/>auto-delete -> (bool)<br/>Specifies whether the disk will be auto-deleted when the instance is deleted.<br/>device-name -> (string)<br/>Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance. This value can be used to reference the device for mounting, resizing, and so on, from within the instance. If not specified, a random value will be generated.<br/>mode -> (enum<READ_ONLY\|READ_WRITE>)<br/>The mode in which to attach this disk.<br/>disk -> (oneof<disk-id\|disk-spec>)<br/>Oneof disk field<br/>disk-spec -> (struct)<br/>Disk specification.<br/>block-size -> (int)<br/>Block size of the disk, specified in bytes. The default is 4096.<br/>description -> (string)<br/>Description of the disk.<br/>disk-placement-policy -> (struct)<br/>Placement policy configuration.<br/>placement-group-id -> (string)<br/>Placement group ID.<br/>placement-group-partition -> (int)<br/>kms-key-id -> (string)<br/>ID of KMS key for disk encryption<br/>name -> (string)<br/>Name of the disk.<br/>size -> (int)<br/>Size of the disk, specified in bytes.<br/>type-id -> (string)<br/>ID of the disk type. To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List] request.<br/>source -> (oneof<image-id\|snapshot-id>)<br/>Oneof source field<br/>image-id -> (string)<br/>ID of the image to create the disk from.<br/>snapshot-id -> (string)<br/>ID of the snapshot to restore the disk from.<br/>disk-id -> (string)<br/>ID of the disk that should be attached.|
|`--instance-id`|<b>`string`</b><br/>ID of the instance to attach the disk to. To get the instance ID, use a [InstanceService.List] request.|
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
