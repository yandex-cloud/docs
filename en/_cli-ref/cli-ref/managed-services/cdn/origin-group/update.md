---
editable: false
---

# yc cdn origin-group update

Update origin group

#### Command Usage

Syntax: 

`yc cdn origin-group update [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`int`</b><br/>Origin group id.|
|`--name`|<b>`string`</b><br/>New group name.|
|`--use-next`|Specifies if use the next origin from the list.|
|`--origin`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Origin specification.<br/><br/>Possible property names:<br/><ul> <li><code>source</code>:     Specifies the source of the origin.</li> <li><code>enabled</code>:     Specifies if origin is enabled.</li> <li><code>backup</code>:     Specifies if origin is backup one.</li> <li><code>meta-bucket-name</code>:     Specifies meta bucket name.</li> <li><code>meta-website-name</code>:     Specifies meta website name.</li> <li><code>meta-balancer-id</code>:     Specifies meta balancer id.</li> </ul>|
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
