---
editable: false
---

# yc serverless api-gateway websocket send

Send data to connection

#### Command Usage

Syntax: 

`yc serverless api-gateway websocket send <CONNECTION-ID> [Flags...] [Global Flags...]`

Aliases: 

- `push`
- `forward`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Connection id.|
|`-t`,`--type`|<b>`string`</b><br/>Type of data to send. May be TEXT or BINARY. Defaults to TEXT.|
|`-d`,`--data`|<b>`string`</b><br/>Data payload to send. Binary data should be base64-encoded.|
|`-f`,`--file`|<b>`string`</b><br/>Send the contents of the file as the data.|
|`-l`,`--stdin`|Read data from stdin, sending a separate message for each line. Binary data should be base64-encoded.|

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
