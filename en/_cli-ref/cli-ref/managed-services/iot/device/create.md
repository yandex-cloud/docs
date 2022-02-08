# yc iot device create

Create new device device

#### Command Usage

Syntax: 

`yc iot device create <DEVICE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--registry-id`|<b>`string`</b><br/> Registry id.|
|`--registry-name`|<b>`string`</b><br/> Registry name.|
|`--name`|<b>`string`</b><br/> Name of device.|
|`--description`|<b>`string`</b><br/> Description of device/|
|`--certificate-file`|<b>`string`</b><br/> Path to X.509 certificate file to associate with selected device.|
|`--topic-aliases`|<b>`key=value[,key=value...]`</b><br/> A list of ALIAS=TOPIC_PREFIX pairs to add.|
|`--password`|<b>`string`</b><br/> Password for entity. Usage of --read-password is more secure|
|`--read-password`| Read password for entity from input|
|`--generate-password`| Generate random password|
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
