# yc dns zone replace-records

Replace all records specified by name and type in dns zone with new ones.

#### Command Usage

Syntax: 

`yc dns zone replace-records <DNS-ZONE-NAME>|<DNS-ZONE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--id`|<b>`string`</b><br/> DNS zone id.|
|`--name`|<b>`string`</b><br/> DNS zone name.|
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|
|`--record`|<b>`"<NAME>`</b><br/>[TTL] <TYPE> <DATA>" record to replace in format "<NAME> [TTL] <TYPE> <DATA>". If record with specified name and type is present it's data field will be overwritten. TTL value will only be used if new record is created.|

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
