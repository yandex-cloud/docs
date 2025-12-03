---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/mdbproxy/update.md
---

# yc beta serverless mdbproxy update

Updates the specified proxy.

#### Command Usage

Syntax: 

`yc beta serverless mdbproxy update <PROXY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--description`|<b>`string`</b><br/>New description for the proxy.|
|`--labels`|<b>`stringToString`</b><br/>Proxy labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>New name for the proxy.<br/>The name must be unique within the folder.|
|`--proxy-id`|<b>`string`</b><br/>ID of the proxy to update.|
|`--target`|<b>`shorthand/json`</b><br/>Proxy target.<br/><br/>Example:|
|`--target`|<b>`mdb={clickhouse={cluster-id=value,`</b><br/>db=value, endpoint=value, password=value, user=value}}<br/><br/>Shorthand Syntax:<br/>{mdb={clickhouse={cluster-id=str, db=str, endpoint=str, password=str, user=str} \| postgresql={cluster-id=str, db=str, endpoint=str, password=str, user=str}}}<br/>Fields:<br/>mdb  oneof<clickhouse\|postgresql>  — Oneof mdb field<br/>clickhouse  struct  — Clickhouse settings for proxy.<br/>cluster-id  string  required  — Cluster identifier for clickhouse.<br/>db          string  required  — Clickhouse database name.<br/>endpoint    string            — Clickhouse proxy-host for connection, output only field.<br/>password    string            — Clickhouse password, input only field.<br/>user        string  required  — Clickhouse user.<br/>postgresql  struct  — PostgreSQL settings for proxy.<br/>cluster-id  string  required  — Cluster identifier for postgresql.<br/>db          string  required  — PostgreSQL database name.<br/>endpoint    string            — PostgreSQL proxy-host for connection, output only field.<br/>password    string            — PostgreSQL password, input only field.<br/>user        string  required  — PostgreSQL user.<br/>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
