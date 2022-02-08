# yc managed-sqlserver user grant-permission

Grant database access to the specified SQLServer user

#### Command Usage

Syntax: 

`yc managed-sqlserver user grant-permission <USER-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/>SQLServer cluster id.|
|`--cluster-name`|<b>`string`</b><br/>SQLServer cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--database`|<b>`string`</b><br/>Name of the database that user is permitted to connect to.|
|`--roles`|<b>`value[,value]`</b><br/>User database access roles, possible values: DB_ACCESSADMIN,DB_BACKUPOPERATOR,DB_DATAREADER,DB_DATAWRITER,DB_DDLADMIN,DB_DENYDATAREADER,DB_DENYDATAWRITER,DB_OWNER,DB_SECURITYADMIN|

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
