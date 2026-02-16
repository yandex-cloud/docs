---
editable: false
sourcePath: en/_cli-ref/cli-ref/ydb/cli-ref/database/create.md
---

# yc ydb database create

Create YDB database.

#### Command Usage

Syntax:

`yc ydb database create <DATABASE-NAME> [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--name` | `string`

Name of the database. ||
|| `--description` | `string`

Description of the database. ||
|| `--resource-preset` | `string`

Database resource preset ID. ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--public-ip` | Assign public ips for the database. ||
|| `--deletion-protection` | Inhibits deletion of a database. ||
|| `--network-id` | `string`

Network id. ||
|| `--network-name` | `string`

Network name. ||
|| `--subnet-name` | `value[,value]`

Adds subnet by Name for the database. ||
|| `--subnet-id` | `value[,value]`

Adds subnet by ID for the database. ||
|| `--security-group-name` | `value[,value]`

Adds security-group by Name for the database. ||
|| `--security-group-id` | `value[,value]`

Adds security-group by ID for the database. ||
|| `--storage` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

YDB database storage options.

Possible property names:

- `type`: YDB database storage type id.

- `groups`: YDB database storage group count. ||
|| `--fixed-size` | `int`

Specifies fixed scale policy size. ||
|| `--zone` | `string`

Specifies database type - zonal. ||
|| `--region` | `string`

Specifies database type - regional. ||
|| `--location` | `string`

Specifies database location. ||
|| `--dedicated` | Specifies database type - dedicated. ||
|| `--sls-enable-throttling-rcu` | Enable RU/s throttling limit for a serverless database, true/false. ||
|| `--sls-throttling-rcu` | `int`

Throttling limit for a serverless database, RU/s. Use sls-enable-throttling-rcu flag to trigger throttling on/off. ||
|| `--sls-provisioned-rcu` | `int`

Provisioned capacity limit for a serverless database, RU/s. Set to zero to disable provisioned capacity hourly billing. ||
|| `--sls-storage-size` | `byteSize`

Maximum size for a serverless database. Example: 10GB, 100GB. Units are in GB if not specified. Default value for a new database is 50GB. ||
|| `--serverless` | Specifies database type - serverless. ||
|| `--backup` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

YDB database backup config options.

Possible property names:

- `source`: Adds source path to backup.

- `exclude`: Exclude path from backup.

- `ttl`: Specify backup time to live. Example: '120m', '15m', '7200s'

- `name`: Specify backup settings name.

- `description`: Specify backup settings description.

- `daily-execute-time`: Time of day in UTC time zone, HH:MM 24-hour clock format, when daily backup should be executed. Example: '02:30

- `weekly-execute-time`: Time of day in UTC time zone, HH:MM 24-hour clock format, when weekly backup should be executed. Example: '02:30

- `weekly-days`: Specify days when weekly backup should be executed.

- `storage-class`: Specify backup storage class Values: 'standard', 'reduced-redundancy', 'standard-ia', 'onezone-ia', 'intelligent-tiering', 'glacier', 'deep-archive', 'outposts' ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#