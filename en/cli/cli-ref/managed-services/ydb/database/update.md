---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/ydb/database/update.md
---

# yc ydb database update

Update the specified YDB database.

#### Command Usage

Syntax: 

`yc ydb database update <DATABASE-NAME>|<DATABASE-ID> [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--new-name`|<b>`string`</b><br/>A new name of the database.|
|`--no-deletion-protection`|Allows deletion of a database.|
|`--description`|<b>`string`</b><br/>Description of the database.|
|`--resource-preset`|<b>`string`</b><br/>Database resource preset ID.|
|`--labels`|<b>`key=value[,key=value...]`</b><br/>A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'.|
|`--public-ip`|Assign public ips for the database.|
|`--deletion-protection`|Inhibits deletion of a database.|
|`--network-id`|<b>`string`</b><br/>Network id.|
|`--network-name`|<b>`string`</b><br/>Network name.|
|`--subnet-name`|<b>`value[,value]`</b><br/>Adds subnet by Name for the database.|
|`--subnet-id`|<b>`value[,value]`</b><br/>Adds subnet by ID for the database.|
|`--storage`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>YDB database storage options.<br/><br/>Possible property names:<br/><ul> <li><code>type</code>:     YDB database storage type id.</li> <li><code>groups</code>:     YDB database storage group count.</li> </ul>|
|`--fixed-size`|<b>`int`</b><br/>Specifies fixed scale policy size.|
|`--zone`|<b>`string`</b><br/>Specifies database type - zonal.|
|`--region`|<b>`string`</b><br/>Specifies database type - regional.|
|`--location`|<b>`string`</b><br/>Specifies database location.|
|`--dedicated`|Specifies database type - dedicated.|
|`--sls-enable-throttling-rcu`|Enable RU/s throttling limit for a serverless database, true/false.|
|`--sls-throttling-rcu`|<b>`int`</b><br/>Throttling limit for a serverless database, RU/s. Use sls-enable-throttling-rcu flag to trigger throttling on/off.|
|`--sls-provisioned-rcu`|<b>`int`</b><br/>Provisioned capacity limit for a serverless database, RU/s. Set to zero to disable provisioned capacity hourly billing.|
|`--sls-storage-size`|<b>`byteSize`</b><br/>Maximum size for a serverless database. Example: 10GB, 100GB. Units are in GB if not specified. Default value for a new database is 50GB.|
|`--serverless`|Specifies database type - serverless.|
|`--backup`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>YDB database backup config options.<br/><br/>Possible property names:<br/><ul> <li><code>source</code>:     Adds source path to backup.</li> <li><code>exclude</code>:     Exclude path from backup.</li> <li><code>ttl</code>:     Specify backup time to live. Example: '120m', '15m', '7200s'</li> <li><code>name</code>:     Specify backup settings name.</li> <li><code>description</code>:     Specify backup settings description.</li> <li><code>daily-execute-time</code>:     Time of day in UTC time zone, HH:MM 24-hour clock format, when daily backup should be executed. Example: '02:30</li> <li><code>weekly-execute-time</code>:     Time of day in UTC time zone, HH:MM 24-hour clock format, when weekly backup should be executed. Example: '02:30</li> <li><code>weekly-days</code>:     Specify days when weekly backup should be executed.</li> </ul>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|
|`--id`|<b>`string`</b><br/>ID of the YDB database.|
|`--name`|<b>`string`</b><br/>Name of the YDB database.|

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
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
