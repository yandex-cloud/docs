# yc serverless api-gateway update

Update API Gateway

#### Command Usage

Syntax: 

`yc serverless api-gateway update <API-GATEWAY-NAME>|<API-GATEWAY-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> Api-gateway id.|
|`--name`|<b>`string`</b><br/> Api-gateway name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/> New api-gateway name.|
|`--description`|<b>`string`</b><br/> New api-gateway description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> New list of label KEY=VALUE pairs to replace existing list.|
|`--spec`|<b>`string`</b><br/> New api-gateway specification file name.|
|`--network-name`|<b>`string`</b><br/> New api-gateway network name.|
|`--network-id`|<b>`string`</b><br/> New api-gateway network id.|
|`--subnet-name`|<b>`value[,value]`</b><br/> New api-gateway subnet names.|
|`--subnet-id`|<b>`value[,value]`</b><br/> New api-gateway subnet ids.|

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
