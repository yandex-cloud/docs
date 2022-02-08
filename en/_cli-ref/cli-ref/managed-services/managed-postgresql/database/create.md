# yc managed-postgresql database create

Create PostgreSQL database

#### Command Usage

Syntax: 

`yc managed-postgresql database create <DATABASE_NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--cluster-id`|<b>`string`</b><br/> PostgreSQL cluster id.|
|`--cluster-name`|<b>`string`</b><br/> PostgreSQL cluster name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--owner`|<b>`string`</b><br/> Name of the user assigned as the owner of the database.|
|`--lc-collate`|<b>`string`</b><br/> Locale property for database to be created.|
|`--lc-type`|<b>`string`</b><br/> Locale property for database to be created.|
|`--extensions`|<b>`key=value[,key=value...]`</b><br/> A list of extensions NAME=VERSION pairs to add.|

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
