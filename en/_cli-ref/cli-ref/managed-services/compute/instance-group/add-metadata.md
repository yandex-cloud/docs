# yc compute instance-group add-metadata

Add or update metadata for instance template of the specified instance group

#### Command Usage

Syntax: 

`yc compute instance-group add-metadata <INSTANCE-GROUP-NAME>|<INSTANCE-GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> instance group id.|
|`--name`|<b>`string`</b><br/> instance group name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--metadata`|<b>`key=value[,key=value...]`</b><br/> Metadata to add. See for details https://cloud.yandex.ru/docs/compute/concepts/vm-metadata|
|`--metadata-from-file`|<b>`key=value[,key=value...]`</b><br/> Same as --metadata except that the value for the entry will be read from a local file.|

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
