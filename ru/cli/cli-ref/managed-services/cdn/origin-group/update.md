---
sourcePath: ru/_cli-ref/cli-ref/managed-services/cdn/origin-group/update.md
---
# yc cdn origin-group update

Update origin group

#### Command Usage

Syntax: 

`yc cdn origin-group update [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`int`</b><br/> Origin group id.|
|`--name`|<b>`string`</b><br/> New group name.|
|`--use-next`| Specifies if use the next origin from the list.|
|`--origin`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> Origin specification.  Possible property names:  source Specifies the source of the origin.  enabled Specifies if origin is enabled.  backup Specifies if origin is backup one.  meta-bucket-name Specifies meta bucket name.  meta-website-name Specifies meta website name.  meta-balancer-id Specifies meta balancer id.  |
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
