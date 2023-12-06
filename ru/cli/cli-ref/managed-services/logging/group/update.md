---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/logging/group/update.md
---

# yc logging group update

Update log group

#### Command Usage

Syntax: 

`yc logging group update <LOG-GROUP-NAME>|<LOG-GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Log group id.|
|`--name`|<b>`string`</b><br/>Log group name.|
|`--new-name`|<b>`string`</b><br/>New log group name.|
|`--description`|<b>`string`</b><br/>New log group description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New list of label KEY=VALUE pairs to add.|
|`--retention-period`|<b>`duration`</b><br/>New retention period.|
|`--data-stream`|<b>`string`</b><br/>New data stream.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
