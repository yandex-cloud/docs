---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/cic/cli-ref-beta/private-connection/upsert-static-route.md
---

# yc beta cic private-connection upsert-static-route

Upserts specified static routes to a PrivateConnection resource.  Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax: 

`yc beta cic private-connection upsert-static-route <PRIVATE-CONNECTION-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--ipv4-static-routes`|<b>`shorthand/json`</b><br/>IPv4 StaticRoute configs to upsert<br/>Shorthand Syntax:<br/>[<br/>{<br/>prefix = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"prefix": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>prefix -> (string)<br/>Prefix. It's an ip with format ipPrefix/length where address part of ipPrefix is 0.|
|`--private-connection-id`|<b>`string`</b><br/>ID of the PrivateConnection resource.|
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
