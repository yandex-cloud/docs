# yc managed-sqlserver database backup-import

Import SQLServer database from external backup in Object Storage

#### Command Usage

Syntax: 

`yc managed-sqlserver database backup-import <DATABASE_NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--bucket`|<b>`string`</b><br/>Name of bucket to import backup from.|
|`--path`|<b>`string`</b><br/>Path inside bucket to import backup from. Default is /|
|`--files`|<b>`value[,value]`</b><br/>List of backup files names|
|`--cluster-id`|<b>`string`</b><br/>SQLServer cluster id.|
|`--cluster-name`|<b>`string`</b><br/>SQLServer cluster name.|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

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
