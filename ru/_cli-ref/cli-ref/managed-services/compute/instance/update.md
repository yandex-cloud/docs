# yc compute instance update

Update the specified virtual machine instance

#### Command Usage

Syntax: 

`yc compute instance update <INSTANCE-NAME>|<INSTANCE-ID> [Flags...] [Global Flags...]`

#### Global Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Instance id.|
|`--name`|<b>`string`</b><br/> Instance name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/> A new name of the instance.|
|`--description`|<b>`string`</b><br/> Specifies a textual description of the instance. --labels key=value[,key=value...] A list of label KEY=VALUE pairs to add. --metadata key=value[,key=value...] Metadata to be made available to the guest operating system running on the instance. See for details https://cloud.yandex.ru/docs/compute/concepts/vm-metadata --metadata-from-file key=value[,key=value...] Same as --metadata except that the value for the entry will be read from a local file.|
|`--memory`|<b>`byteSize`</b><br/> Specifies how much memory instance should have.|
|`--cores`|<b>`int`</b><br/> Specifies how many CPU cores instance should have.|
|`--core-fraction`|<b>`int`</b><br/> If provided, specifies baseline performance for a core in percent.|
|`--gpus`|<b>`int`</b><br/> Specifies how many GPUs instance should have.|
|`--platform`|<b>`string`</b><br/> Specifies platform for the instance. --network-settings PROPERTY=VALUE[,PROPERTY=VALUE...] Network settings for the instance.  Possible property names:  type Type of a network for virtual machine instance. Values: standard, software-accelerated  |
|`--placement-group-id`|<b>`string`</b><br/> Placement group to add the instance to (use an empty string to remove the instance from placement group).|
|`--placement-group-name`|<b>`string`</b><br/> Placement group to add the instance to (use an empty string to remove the instance from placement group).|
|`--service-account-id`|<b>`string`</b><br/> Service account, which token can be obtained inside VM from metadata service.|
|`--service-account-name`|<b>`string`</b><br/> Service account, which token can be obtained inside VM from metadata service.|

#### Flags

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
