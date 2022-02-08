# yc managed-mysql user revoke-permission

Revoke permission from the specified MySQL user

#### Command Usage

Syntax: 

`yc managed-mysql user revoke-permission <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>MySQL cluster id.|
|`--cluster-name`|<b>`string`</b><br/>MySQL cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--database`|<b>`string`</b><br/>Name of the database that the permission grants access to.|
|`--permissions`|<b>`value[,value]`</b><br/>User database access roles, possible values: ALL,ALL_PRIVILEGES,ALTER,ALTER_ROUTINE,CREATE,CREATE_ROUTINE,CREATE_TEMPORARY_TABLES,CREATE_VIEW,DELETE,DROP,EVENT,EXECUTE,INDEX,INSERT,LOCK_TABLES,REFERENCES,SELECT,SHOW_VIEW,TRIGGER,UPDATE|

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
