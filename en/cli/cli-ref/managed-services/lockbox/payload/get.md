---
sourcePath: en/_cli-ref/cli-ref/managed-services/lockbox/payload/get.md
---
# yc lockbox payload get

Get payload of the specified secret

#### Command Usage

Syntax: 

`yc lockbox payload get <SECRET-NAME>|<SECRET-ID> [Flags][Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Secret id.|
|`--name`|<b>`string`</b><br/>Secret name.|
|`--key`|<b>`string`</b><br/>The key of payload entry to get a single value. Both text and binary values output as is, without any encoding.|
|`--version-id`|<b>`string`</b><br/>Secret version id. By default, the current one is used.|

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
