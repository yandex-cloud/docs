---
editable: false
sourcePath: en/_cli-ref/cli-ref/managed-services/datatransfer/endpoint/update/clickhouse-source.md
---

# yc datatransfer endpoint update clickhouse-source

Update Clickhouse source

#### Command Usage

Syntax: 

`yc datatransfer endpoint update clickhouse-source [<ENDPOINT-ID>] [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Endpoint name|
|`--description`|<b>`string`</b><br/>Endpoint description|
|`--host`|<b>`value[,value]`</b><br/>Clickhouse server host name or IP address. The format is {shard_name}:{hostname_or_ip_address}, where {shard_name} is an arbitrary shard name this host belongs to. The colon itself is specified as \:, and the backslash is specified as \\.|
|`--http-port`|<b>`int`</b><br/>ClickHouse server HTTP interface port|
|`--native-port`|<b>`int`</b><br/>ClickHouse server native interface port|
|`--ca-certificate`|<b>`string`</b><br/>Path to the CA certificate of the ClickHouse server. Implies enabled TLS|
|`--cluster-id`|<b>`string`</b><br/>Yandex Managed ClickHouse cluster ID|
|`--database`|<b>`string`</b><br/>Database name|
|`--user`|<b>`string`</b><br/>User name|
|`--raw-password`|<b>`string`</b><br/>Raw password value (unsafe, consider --password-file)|
|`--password-file`|<b>`string`</b><br/>Path to the file containing password|
|`--subnet-id`|<b>`string`</b><br/>Yandex Virtual Private Cloud subnet ID to access the ClickHouse server through|
|`--security-group`|<b>`value[,value]`</b><br/>Yandex Virtual Private Cloud security group ID to associate with the endpoint|
|`--include-table`|<b>`value[,value]`</b><br/>Do not transfer tables other than these|
|`--exclude-table`|<b>`value[,value]`</b><br/>Do not transfer these tables|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
