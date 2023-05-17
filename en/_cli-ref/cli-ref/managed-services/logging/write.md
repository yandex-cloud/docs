---
editable: false
---

# yc logging write

Write to log

#### Command Usage

Syntax: 

`yc logging write <LOG-GROUP-NAME>|<LOG-GROUP-ID> [MESSAGE] [JSON-PAYLOAD] [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--group-id`|<b>`string`</b><br/>Log group id.|
|`--group-name`|<b>`string`</b><br/>Log group name.|
|`--message`|<b>`string`</b><br/>Message|
|`--resource-type`|<b>`string`</b><br/>Resource type|
|`--resource-id`|<b>`string`</b><br/>Resource ID|
|`--json-payload`|<b>`string`</b><br/>Json payload to be sent|
|`--json-file`|<b>`string`</b><br/>File containing json payload to be sent|
|`--timestamp`|<b>`timestamp`</b><br/>Log entry creation time, default: now|
|`--level`|<b>`string`</b><br/>Log level|
|`--stream-name`|<b>`string`</b><br/>Stream name|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
