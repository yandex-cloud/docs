---
editable: false
sourcePath: en/_cli-ref/cli-ref/datatransfer/cli-ref/endpoint/create/clickhouse-target.md
---

# yc datatransfer endpoint create clickhouse-target

Create Clickhouse target

#### Command Usage

Syntax:

`yc datatransfer endpoint create clickhouse-target [<ENDPOINT-NAME>] [Flags...] [Global Flags...]`

#### Flags

#|
||Flag | Description ||
|| `--file` | `string`

Path to a file with grpc request, see proto files in the protobuf API specification: https://github.com/yandex-cloud/cloudapi/tree/master/yandex/cloud/datatransfer/v1 ||
|| `--name` | `string`

Endpoint name ||
|| `--description` | `string`

Endpoint description ||
|| `--labels` | `key=value[,key=value...]`

A list of label KEY=VALUE pairs to add. For example, to add two labels named 'foo' and 'bar', both with the value 'baz', use '--labels foo=baz,bar=baz'. ||
|| `--host` | `value[,value]`

Clickhouse server host name or IP address. The format is {shard_name}:{hostname_or_ip_address}, where {shard_name} is an arbitrary shard name this host belongs to. The colon itself is specified as \:, and the backslash is specified as \\. ||
|| `--http-port` | `int`

ClickHouse server HTTP interface port ||
|| `--native-port` | `int`

ClickHouse server native interface port ||
|| `--ca-certificate` | `string`

Path to the CA certificate of the ClickHouse server. Implies enabled TLS ||
|| `--cluster-id` | `string`

Yandex Managed ClickHouse cluster ID ||
|| `--database` | `string`

Database name ||
|| `--user` | `string`

User name ||
|| `--raw-password` | `string`

Raw password value (unsafe, consider --password-file) ||
|| `--password-file` | `string`

Path to the file containing password ||
|| `--subnet-id` | `string`

Yandex Virtual Private Cloud subnet ID to access the ClickHouse server through ||
|| `--security-group` | `value[,value]`

Yandex Virtual Private Cloud security group ID to associate with the endpoint ||
|| `--cluster-name` | `string`

Name of the ClickHouse cluster. For Managed ClickHouse that is name of ShardGroup ||
|| `--alt-name` | `value[,value]`

Alternative table names in target; the format is {source_table_name}:{target_table_name}. The colon itself is specified as \:, and the backslash is specified as \\ ||
|| `--shard-by-column-hash` | `string`

Calculate ClickHouse destination shard name using hash of the specified column ||
|| `--custom-sharding-column-name` | `string`

Look up ClickHouse destination shard name using the specified column's value and the mapping specified with --custom-sharding-mapping ||
|| `--custom-sharding-mapping-string` | `value[,value]`

Put all the rows where the string value of sharding column is {column_value} into the shard {shard_name}. The format is {column_value}:{shard_name}. The colon itself is specified as \:, and the backslash is specified as \\. Sharding column is specified using option --custom-sharding-column-name ||
|| `--shard-by-transfer-id` | Select ClickHouse destination shard name using transfer ID ||
|| `--cleanup-policy` | `string`

Policy describes what to do with existing data on target. Options: drop, truncate, disabled (keep the data, which is default) ||
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