# yc iam key create

Create an IAM key for for authenticated account or the specified service account. Created key will be written to file in JSON format.

#### Command Usage

Syntax: 

`yc iam key create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`-o`,`--output`|<b>`string`</b><br/>The path where the resulting IAM key should be written.|
|`--user-account`|Key will be created for authenticated account.|
|`--service-account-id`|<b>`string`</b><br/>service account id.|
|`--service-account-name`|<b>`string`</b><br/>service account name.|
|`--description`|<b>`string`</b><br/>Specifies a textual description of the service account.|
|`--algorithm`|<b>`string`</b><br/>Specifies key algorithm. Otherwise server default will be used. Values: 'rsa-2048', 'rsa-4096'|

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
