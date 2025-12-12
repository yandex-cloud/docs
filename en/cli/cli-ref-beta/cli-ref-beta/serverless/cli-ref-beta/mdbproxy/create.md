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
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the proxy.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create a proxy in. To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List] request.|
|`--labels`|<b>`stringToString`</b><br/>Resource labels as 'key:value' pairs.|
|`--name`|<b>`string`</b><br/>Name of the proxy. The name must be unique within the folder.|
|`--target`|<b>`shorthand/json`</b><br/>Proxy target.<br/>Shorthand Syntax:<br/>{<br/>mdb = clickhouse={<br/>cluster-id = str,<br/>db = str,<br/>endpoint = str,<br/>password = str,<br/>user = str<br/>} \| postgresql={<br/>cluster-id = str,<br/>db = str,<br/>endpoint = str,<br/>password = str,<br/>user = str<br/>}<br/>}<br/>JSON Syntax:<br/>"{<br/>"mdb": {<br/>"clickhouse": {<br/>"cluster-id": "str",<br/>"db": "str",<br/>"endpoint": "str",<br/>"password": "str",<br/>"user": "str"<br/>},<br/>"postgresql": {<br/>"cluster-id": "str",<br/>"db": "str",<br/>"endpoint": "str",<br/>"password": "str",<br/>"user": "str"<br/>}<br/>}<br/>}"<br/>Fields:<br/>mdb -> (oneof<clickhouse\|postgresql>)<br/>Oneof mdb field<br/>clickhouse -> (struct)<br/>Clickhouse settings for proxy.<br/>cluster-id -> (string)<br/>Cluster identifier for clickhouse.<br/>db -> (string)<br/>Clickhouse database name.<br/>endpoint -> (string)<br/>Clickhouse proxy-host for connection, output only field.<br/>password -> (string)<br/>Clickhouse password, input only field.<br/>user -> (string)<br/>Clickhouse user.<br/>postgresql -> (struct)<br/>PostgreSQL settings for proxy.<br/>cluster-id -> (string)<br/>Cluster identifier for postgresql.<br/>db -> (string)<br/>PostgreSQL database name.<br/>endpoint -> (string)<br/>PostgreSQL proxy-host for connection, output only field.<br/>password -> (string)<br/>PostgreSQL password, input only field.<br/>user -> (string)<br/>PostgreSQL user.|
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
