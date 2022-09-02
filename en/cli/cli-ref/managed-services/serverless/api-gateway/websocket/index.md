---
sourcePath: en/_cli-ref/cli-ref/managed-services/serverless/api-gateway/websocket/index.md
---
# yc serverless api-gateway websocket

Manage websocket connections

#### Command Usage

Syntax: 

`yc serverless api-gateway websocket <command>`

Aliases: 

- `connection`
- `ws`

#### Command Tree

- [yc serverless api-gateway websocket get](get.md) — Get connection
- [yc serverless api-gateway websocket send](send.md) — Send data to connection
- [yc serverless api-gateway websocket disconnect](disconnect.md) — Close connection

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
