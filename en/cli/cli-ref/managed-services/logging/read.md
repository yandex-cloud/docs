---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/logging/read.md
---

# yc logging read

Read logs

#### Command Usage

Syntax: 

`yc logging read <LOG-GROUP-NAME>|<LOG-GROUP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--group-id`|<b>`string`</b><br/>Log group id.|
|`--group-name`|<b>`string`</b><br/>Log group name.|
|`--limit`|<b>`int`</b><br/>The maximum number of items to list.|
|`--since`|<b>`timestamp`</b><br/>Show logs since this time|
|`--until`|<b>`timestamp`</b><br/>Show logs until this time|
|`-f`,`--follow`|Output logs as they arrive|
|`--levels`|<b>`value[,value]`</b><br/>Show logs with these levels (comma-separated)|
|`--filter`|<b>`string`</b><br/>Use this filter|
|`--max-response-size`|<b>`byteSize`</b><br/>Specifies the maximum response size in bytes. You can also use M and T suffixes to specify MiB or TiB respectively. Default is 3.5 MiB.|
|`--resource-types`|<b>`value[,value]`</b><br/>Show logs with these resource types (comma-separated)|
|`--resource-ids`|<b>`value[,value]`</b><br/>Show logs with these resource ids (comma-separated)|
|`--stream-names`|<b>`value[,value]`</b><br/>Show logs with these stream names (comma-separated)|

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
