---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# yc ydb database create

Create YDB database.

#### Command Usage

Syntax: 

`yc ydb database create <DATABASE-NAME> [Flags...] [Global Flags...]`

#### Global Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Name of the database.|
|`--description`|<b>`string`</b><br/> Description of the database.|
|`--resource-preset`|<b>`string`</b><br/> Database resource preset ID.|
|`--public-ip`| Assign public ips for the database.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name. --subnet-name value[,value] Adds subnet by Name for the database. --subnet-id value[,value] Adds subnet by ID for the database. --storage PROPERTY=VALUE[,PROPERTY=VALUE...] YDB database storage options.  Possible property names:  type YDB database storage type id.  groups YDB database storage group count.  |
|`--fixed-size`|<b>`int`</b><br/> Specifies fixed scale policy size.|
|`--zone`|<b>`string`</b><br/> Specifies database type - zonal.|
|`--region`|<b>`string`</b><br/> Specifies database type - regional.|
|`--location`|<b>`string`</b><br/> Specifies database location.|
|`--dedicated`| Specifies database type - dedicated.|
|`--serverless`| Specifies database type - serverless. --backup PROPERTY=VALUE[,PROPERTY=VALUE...] YDB database backup config options.  Possible property names:  source Adds source path to backup.  exclude Exclude path from backup.  ttl Specify backup time to live. Example: '120m', '15m', '7200s'  name Specify backup settings name.  description Specify backup settings description.  daily-execute-time Time of day in UTC time zone, HH:MM 24-hour clock format, when daily backup should be executed. Example: '02:30  weekly-execute-time Time of day in UTC time zone, HH:MM 24-hour clock format, when weekly backup should be executed. Example: '02:30  weekly-days Specify days when weekly backup should be executed.  |
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

#### Flags

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
