---
editable: false
---

# yc managed-mongodb user update

Modify attributes of a MongoDB user.

#### Command Usage

Syntax: 

`yc managed-mongodb user update <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>ID of the MongoDB cluster.|
|`--cluster-name`|<b>`string`</b><br/>Name of the MongoDB cluster.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--password`|<b>`string`</b><br/>New password for the user.|
|`--permission`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>New set of permissions for the user. Can be specified multiple times.<br/><br/>Possible property names:<br/><ul> <li><code>database</code>:     Name of the database that the permission grants access to.</li> <li><code>role</code>:     Role in the database to assign to the user. Can be specified multiple times.</li> </ul>|

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
