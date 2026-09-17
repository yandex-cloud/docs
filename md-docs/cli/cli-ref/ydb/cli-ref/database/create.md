[Документация Yandex Cloud](../../../../../index.md) > [Интерфейс командной строки](../../../../index.md) > [Справочник (англ.)](../../../index.md) > [ydb](../index.md) > [database](index.md) > create

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

ID of the network. ||
|| `--network-name` | `string`

Name of the network. ||
|| `--subnet-name` | `[]string`

Adds subnet by Name for the database. ||
|| `--subnet-id` | `[]string`

Adds subnet by ID for the database. ||
|| `--security-group-name` | `[]string`

Adds security-group by Name for the database. ||
|| `--security-group-id` | `[]string`

Adds security-group by ID for the database. ||
|| `--storage` | `PROPERTY=VALUE[,PROPERTY=VALUE...]`

YDB database storage options. ||
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

YDB database backup config options. ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#