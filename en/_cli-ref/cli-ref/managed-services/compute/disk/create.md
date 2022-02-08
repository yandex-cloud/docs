# yc compute disk create

Create a disk

#### Command Usage

Syntax: 

`yc compute disk create <DISK-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> A name of the disk.|
|`--description`|<b>`string`</b><br/> Specifies a textual description of the disk.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--zone`|<b>`string`</b><br/> The zone of the disk to create.|
|`--type`|<b>`string`</b><br/> Specifies the type of the disk to create.|
|`--size`|<b>`byteSize`</b><br/> Specifies the size of the disk in GB. You can also use M and T suffixes to specify smaller or greater size respectively.|
|`--block-size`|<b>`byteSize`</b><br/> Specifies the block size of the disk in bytes. You can also use K and M suffixes.|
|`--source-image-name`|<b>`string`</b><br/> A source image used to create the disk.|
|`--source-image-id`|<b>`string`</b><br/> An ID of the source image used to create the disk.|
|`--source-image-family`|<b>`string`</b><br/> An image family that is used to create the disk.|
|`--source-snapshot-name`|<b>`string`</b><br/> A source snapshot used to create the disk.|
|`--source-snapshot-id`|<b>`string`</b><br/> An ID of the source snapshot used to create the disk.|
|`--source-image-folder-id`|<b>`string`</b><br/> The folder ID against which all image and image family references will be resolved.|
|`--disk-placement-group-id`|<b>`string`</b><br/> Placement group to create the disk in.|
|`--disk-placement-group-name`|<b>`string`</b><br/> Placement group to create the disk in.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts. Pass 0 to disable retries. Pass any negative value for infinite retries. Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
