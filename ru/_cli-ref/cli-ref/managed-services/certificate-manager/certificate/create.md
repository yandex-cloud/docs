# yc certificate-manager certificate create

Create an imported certificate

#### Command Usage

Syntax: 

`yc certificate-manager certificate create [Flags...] [Global Flags...]`

Aliases: 

- `import`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Specifies the name of the certificate.|
|`--description`|<b>`string`</b><br/> Specifies the textual description of the certificate.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--chain`|<b>`string`</b><br/> Path to PEM file with a chain of the certificate.|
|`--key`|<b>`string`</b><br/> Path to PEM file with a private key of the certificate.|
|`--deletion-protection`| Protects deletion of certificate.|
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
