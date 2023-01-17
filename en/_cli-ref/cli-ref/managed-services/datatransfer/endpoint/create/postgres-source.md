---
editable: false
---

# yc datatransfer endpoint create postgres-source

Create PostgreSQL source

#### Command Usage

Syntax: 

`yc datatransfer endpoint create postgres-source [<ENDPOINT-NAME>] [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>Endpoint name|
|`--description`|<b>`string`</b><br/>Endpoint description|
|`--cluster-id`|<b>`string`</b><br/>Yandex Managed Service for PostgreSQL cluster ID|
|`--host`|<b>`value[,value]`</b><br/>PostgreSQL server host name or IP address|
|`--port`|<b>`int`</b><br/>PostgreSQL server port|
|`--ca-certificate`|<b>`string`</b><br/>Path to the CA certificate of the PostgreSQL server. Implies enabled TLS|
|`--subnet-id`|<b>`string`</b><br/>Yandex Virtual Private Cloud subnet ID to access the PostgreSQL server through|
|`--database`|<b>`string`</b><br/>Database name|
|`--user`|<b>`string`</b><br/>User name|
|`--raw-password`|<b>`string`</b><br/>Raw password value (unsafe, consider --password-file)|
|`--password-file`|<b>`string`</b><br/>Path to the file containing password|
|`-i`,`--include-table`|<b>`value[,value]`</b><br/>Do not transfer tables other than these|
|`-p`,`--exclude-table`|<b>`value[,value]`</b><br/>Do not transfer these tables|
|`--slot-lag-limit`|<b>`int`</b><br/>Terminate replication once the WAL lag on the slot exceeds the specified limit, in bytes. Unlimited by default|
|`--service-schema`|<b>`string`</b><br/>Schema to create auxiliary tables in|
|`-b`,`--transfer-before-data`|<b>`value[,value]`</b><br/>Schema objects to transfer before transferring data, one of [sequence, sequence_owned_by, table, primary_key, fk_constraint, default_values, constraint, index, view, function, trigger, type, rule, collation, policy, cast, materialized_view]|
|`-a`,`--transfer-after-data`|<b>`value[,value]`</b><br/>Schema objects to transfer after transferring data, one of [sequence, sequence_owned_by, table, primary_key, fk_constraint, default_values, constraint, index, view, function, trigger, type, rule, collation, policy, cast, materialized_view]|

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
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
