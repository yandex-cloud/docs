# yc certificate-manager certificate update

Update the specified certificate

#### Command Usage

Syntax: 

`yc certificate-manager certificate update <CERTIFICATE> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Specifies the certificate ID.|
|`--name`|<b>`string`</b><br/>Specifies the certificate name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>Specifies the new name of the certificate.|
|`--description`|<b>`string`</b><br/>Specifies the new description of the certificate.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of new label KEY=VALUE pairs to update.|
|`--chain`|<b>`string`</b><br/>Path to the PEM file with the new certificate chain. Only for imported certificates.|
|`--key`|<b>`string`</b><br/>Path to the PEM file with the new private key. Only for imported certificates.|
|`--deletion-protection`|Protects deletion of certificate.|
|`--no-deletion-protection`|Remove deletion protection of certificate.|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
