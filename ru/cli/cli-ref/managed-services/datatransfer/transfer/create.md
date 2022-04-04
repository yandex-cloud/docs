---
sourcePath: ru/_cli-ref/cli-ref/managed-services/datatransfer/transfer/create.md
---
# yc datatransfer transfer create

Create transfer

#### Command Usage

Syntax: 

`yc datatransfer transfer create [<TRANSFER-NAME>] [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--source-id`|<b>`string`</b><br/>Source endpoint identifier|
|`--target-id`|<b>`string`</b><br/>Target endpoint identifier|
|`--name`|<b>`string`</b><br/>Transfer name|
|`--description`|<b>`string`</b><br/>Transfer description|
|`--type`|<b>`string`</b><br/>Transfer type. Possible values are: [snapshot-and-increment, snapshot-only, increment-only] Values: 'snapshot-and-increment', 'snapshot-only', 'increment-only'|

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
