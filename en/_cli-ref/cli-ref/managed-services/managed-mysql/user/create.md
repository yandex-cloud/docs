---
editable: false
---

# yc managed-mysql user create

Create a MySQL user

#### Command Usage

Syntax: 

`yc managed-mysql user create <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>MySQL cluster id.|
|`--cluster-name`|<b>`string`</b><br/>MySQL cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--password`|<b>`string`</b><br/>Password of the MySQL user.|
|`--permissions`|<b>`value[,value]`</b><br/>Names of the databases that the permission grants access to.|
|`--global-permissions`|<b>`value[,value]`</b><br/>User global access roles, possible values: FLUSH_OPTIMIZER_COSTS,PROCESS,REPLICATION_CLIENT,REPLICATION_SLAVE,SHOW_ROUTINE|
|`--authentication-plugin`|<b>`string`</b><br/>Authentication plugin of the MySQL user.|
|`--max-questions-per-hour`|<b>`int`</b><br/>The maximum permitted number of user questions per hour.|
|`--max-updates-per-hour`|<b>`int`</b><br/>The maximum permitted number of user updates per hour.|
|`--max-connections-per-hour`|<b>`int`</b><br/>The maximum permitted number of simultaneous client connections per hour.|
|`--max-user-connections`|<b>`int`</b><br/>The maximum number of simultaneous connections permitted to any given MySQL user account.|

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
