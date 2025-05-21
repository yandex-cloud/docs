---
editable: false
---

# yc serverless eventrouter bus update

Update the specified bus

#### Command Usage

Syntax: 

`yc serverless eventrouter bus update <BUS-NAME>|<BUS-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Bus id.|
|`--name`|<b>`string`</b><br/>Bus name.|
|`--new-name`|<b>`string`</b><br/>New bus name.|
|`--description`|<b>`string`</b><br/>Bus description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--deletion-protection`|Prevents accidental bus removal.|
|`--no-deletion-protection`|Remove bus deletion protection.|
|`--enable-logging`|Enable logging.|
|`--disable-logging`|Disable logging.|
|`--log-options`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Logs delivery options<br/><br/>Possible property names:<br/><ul> <li><code>log-group-id</code>:     Write logs to this log group.</li> <li><code>folder-id</code>:     Write logs to default log group of this folder if log group id is not specified.</li> <li><code>min-level</code>:     Minimal level of logs to write. Values: 'trace', 'debug', 'info', 'warn', 'error', 'fatal'</li> </ul>|
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
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
