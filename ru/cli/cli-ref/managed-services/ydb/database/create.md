---
sourcePath: ru/_cli-ref/cli-ref/managed-services/ydb/database/create.md
---
# yc ydb database create

Create YDB database.

#### Command Usage

Syntax: 

`yc ydb database create <DATABASE-NAME> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/> Name of the database.|
|`--description`|<b>`string`</b><br/> Description of the database.|
|`--resource-preset`|<b>`string`</b><br/> Database resource preset ID.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/> A list of label KEY=VALUE pairs to add.|
|`--public-ip`| Assign public ips for the database.|
|`--network-id`|<b>`string`</b><br/> Network id.|
|`--network-name`|<b>`string`</b><br/> Network name.|
|`--subnet-name`|<b>`value[,value]`</b><br/> Adds subnet by Name for the database.|
|`--subnet-id`|<b>`value[,value]`</b><br/> Adds subnet by ID for the database.|
|`--storage`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> YDB database storage options.  Possible property names:  type YDB database storage type id.  groups YDB database storage group count.  |
|`--fixed-size`|<b>`int`</b><br/> Specifies fixed scale policy size.|
|`--zone`|<b>`string`</b><br/> Specifies database type - zonal.|
|`--region`|<b>`string`</b><br/> Specifies database type - regional.|
|`--location`|<b>`string`</b><br/> Specifies database location.|
|`--dedicated`| Specifies database type - dedicated.|
|`--sls-enable-throttling-rcu`| Enable RU/s throttling limit for a serverless database, true/false.|
|`--sls-throttling-rcu`|<b>`int`</b><br/> Throttling limit for a serverless database, RU/s. Use sls-enable-throttling-rcu flag to trigger throttling on/off.|
|`--sls-provisioned-rcu`|<b>`int`</b><br/> Provisioned capacity limit for a serverless database, RU/s. Set to zero to disable provisioned capacity hourly billing.|
|`--sls-storage-size`|<b>`byteSize`</b><br/> Maximum size for a serverless database. Example: 10GB, 100GB. Units are in GB if not specified. Default value for a new database is 50GB.|
|`--serverless`| Specifies database type - serverless.|
|`--backup`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/> YDB database backup config options.  Possible property names:  source Adds source path to backup.  exclude Exclude path from backup.  ttl Specify backup time to live. Example: '120m', '15m', '7200s'  name Specify backup settings name.  description Specify backup settings description.  daily-execute-time Time of day in UTC time zone, HH:MM 24-hour clock format, when daily backup should be executed. Example: '02:30  weekly-execute-time Time of day in UTC time zone, HH:MM 24-hour clock format, when weekly backup should be executed. Example: '02:30  weekly-days Specify days when weekly backup should be executed.  |
|`--async`| Display information about the operation in progress, without waiting for the operation to complete.|

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
