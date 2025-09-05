---
editable: false
---

# yc connection-manager connection list

List connections

#### Command Usage

Syntax: 

`yc connection-manager connection list [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--limit`|<b>`int`</b><br/>The maximum number of items to list. Default is 1000 items|
|`--author-id`|<b>`string`</b><br/>Identifier of the author.|
|`--folder-id`|<b>`string`</b><br/>Identifier of the folder.|
|`--mdb-cluster-id`|<b>`string`</b><br/>Identifier of the mdb cluster.|
|`--name-pattern-or-id`|<b>`string`</b><br/>Name pattern or indetifier.|
|`--db-type`|<b>`string`</b><br/>Database type. Values: 'postgresql', 'mysql', 'clickhouse', 'mongodb', 'kafka', 'redis', 'opensearch', 'trino', 'valkey', 'greenplum'|
|`--with-can-use`|Include usage permissions in the response (whether the subject can use or only list the connection).|
|`--is-on-premise`|Filters connections to show only on-premise (true) or cloud-managed (false) deployments.|
|`--is-manual`|Filter connections to show only manual (true), only automatic (false).|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
