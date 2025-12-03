---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/mdbproxy/create.md
---

# yc beta serverless mdbproxy create

Creates a proxy in the specified folder.

#### Command Usage

Syntax: 

`yc beta serverless mdbproxy create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the proxy.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a proxy in.<br/><br/>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the proxy.<br/>The name must be unique within the folder.|
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
