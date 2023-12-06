---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/application-load-balancer/backend-group/update.md
---

# yc application-load-balancer backend-group update

Update the specified backend group

#### Command Usage

Syntax: 

`yc application-load-balancer backend-group update <BACKEND_GROUP-NAME>|<BACKEND_GROUP-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/>Backend group id.|
|`--name`|<b>`string`</b><br/>Backend group name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--new-name`|<b>`string`</b><br/>A new name of the backend group.|
|`--description`|<b>`string`</b><br/>A description of the backend group.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--connection-affinity`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Connection affinity type for backend-group.<br/><br/>Possible property names:<br/><ul> <li><code>source-ip</code>:     Use IP address to define a connection for session affinity.</li> </ul>|
|`--cookie-affinity`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Cookie affinity type for backend-group.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the cookie.</li> <li><code>ttl</code>:     TTL of the cookie.</li> </ul>|
|`--header-affinity`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Header affinity type for backend-group.<br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     Name of the header.</li> </ul>|
|`--clean-session-affinity`|Clean session affinity value|

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
