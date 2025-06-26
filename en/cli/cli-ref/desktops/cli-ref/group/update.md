---
editable: false
sourcePath: en/_cli-ref/cli-ref/desktops/cli-ref/group/update.md
---

# yc desktops group update

Update desktop group

#### Command Usage

Syntax: 

`yc desktops group update [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Desktop group id.|
|`--name`|<b>`string`</b><br/>Desktop group name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--image-id`|<b>`string`</b><br/>Desktop group image id.|
|`--new-name`|<b>`string`</b><br/>New desktop group name.|
|`--description`|<b>`string`</b><br/>New desktop group description.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>New desktop group labels.|
|`--resources-spec`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>New resources specification for desktop group.<br/><br/>Possible property names:<br/><ul> <li><code>memory</code>:     Specifies how much memory desktop should have. (required)</li> <li><code>cores</code>:     Amount of cores to attach to the desktop. (required)</li> <li><code>core-fraction</code>:     Amount of core-fraction to attach to the desktop. (required)</li> </ul>|
|`--boot-disk-spec`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>New boot disk specification for desktop group.<br/><br/>Possible property names:<br/><ul> <li><code>disk-type</code>:     Disk type (required)</li> <li><code>disk-size</code>:     Disk size (required)</li> </ul>|
|`--data-disk-spec`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>New data disk specification for desktop group.<br/><br/>Possible property names:<br/><ul> <li><code>disk-type</code>:     Disk type (required)</li> <li><code>disk-size</code>:     Disk size (required)</li> </ul>|
|`--group-config`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>New configuration for desktop group.<br/><br/>Possible property names:<br/><ul> <li><code>max-group-size</code>:     Max group size (required)</li> <li><code>hot-standby</code>:     Hot standby (required)</li> <li><code>user-account-id</code>:     User account ids</li> </ul>|

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
