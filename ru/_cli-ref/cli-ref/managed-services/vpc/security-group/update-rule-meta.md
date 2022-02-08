# yc vpc security-group update-rule-meta

Update rule of a security group.

#### Command Usage

Syntax: 

`yc vpc security-group update-rule-meta <SECURITY-GROUP-NAME>|<SECURITY-GROUP-ID> --rule-id VALUE [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Security group's id.|
|`--name`|<b>`string`</b><br/> Security group's name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--rule-id`|<b>`string`</b><br/> security group rule ID for update|
|`--description`|<b>`string`</b><br/> New description for the security group rule.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> New set of labels for the security group rule as key-value pairs. Existing set of labels will be completely overwritten.|

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
