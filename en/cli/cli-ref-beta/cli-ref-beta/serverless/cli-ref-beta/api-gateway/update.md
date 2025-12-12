---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/api-gateway/update.md
---

# yc beta serverless api-gateway update

Updates the specified API gateway.

#### Command Usage

Syntax: 

`yc beta serverless api-gateway update <API-GATEWAY-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--api-gateway-id`|<b>`string`</b><br/>ID of the API gateway to update. To get a API gateway ID make a [ApiGatewayService.List] request.|
|`--canary`|<b>`shorthand/json`</b><br/>Canary release of the gateway.<br/>Shorthand Syntax:<br/>{<br/>variables = {key={<br/>variable-value = bool-value=bool \| double-value=double \| int-value=int \| string-value=str<br/>}, key=...},<br/>weight = int<br/>}<br/>JSON Syntax:<br/>"{<br/>"variables": {<br/>"\<key\>": {<br/>"variable-value": {<br/>"bool-value": "bool",<br/>"double-value": "double",<br/>"int-value": "int",<br/>"string-value": "str"<br/>}<br/>}, ...<br/>},<br/>"weight": "int"<br/>}"<br/>Fields:<br/>variables -> (map[string,struct])<br/>Values specification variables, associated with canary.<br/>variable-value -> (oneof<bool-value\|double-value\|int-value\|string-value>)<br/>Oneof variable-value field<br/>string-value -> (string)<br/>int-value -> (int)<br/>double-value -> (double)<br/>bool-value -> (bool)<br/>weight -> (int)<br/>It describes percentage of requests, which will be processed by canary.|
|`--connectivity`|<b>`shorthand/json`</b><br/>Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s).<br/>Shorthand Syntax:<br/>{<br/>network-id = str,<br/>subnet-id = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"network-id": "str",<br/>"subnet-id": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>network-id -> (string)<br/>Network the gateway will have access to. It's essential to specify network with subnets in all availability zones.<br/>subnet-id -> ([]string)<br/>Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones.|
|`--description`|<b>`string`</b><br/>New description for the API gateway.|
|`--execution-timeout`|<b>`duration`</b><br/>Timeout for gateway call execution (duration, e.g. 30s, 5m10s)|
|`--labels`|<b>`stringToString`</b><br/>API gateway labels as 'key:value' pairs. Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [yandex.cloud.serverless.apigateway.v1.ApiGatewayService.Get] request.|
|`--log-options`|<b>`shorthand/json`</b><br/>Options for logging from the API gateway.<br/>Shorthand Syntax:<br/>{<br/>destination = folder-id=str \| log-group-id=str,<br/>disabled = bool,<br/>min-level = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"disabled": "bool",<br/>"min-level": "TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL"<br/>}"<br/>Fields:<br/>disabled -> (bool)<br/>Is logging from API gateway disabled.<br/>min-level -> (enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>)<br/>Minimum log entry level. See [LogLevel.Level] for details.<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>log-group-id -> (string)<br/>Entry should be written to log group resolved by ID.<br/>folder-id -> (string)<br/>Entry should be written to default log group for specified folder.|
|`--name`|<b>`string`</b><br/>New name for the API gateway. The name must be unique within the folder.|
|`--variables`|<b>`shorthand/json`</b><br/>Values of variables defined in the specification.<br/>Shorthand Syntax:<br/>{key={<br/>variable-value = bool-value=bool \| double-value=double \| int-value=int \| string-value=str<br/>}, key=...}<br/>JSON Syntax:<br/>"{<br/>"\<key\>": {<br/>"variable-value": {<br/>"bool-value": "bool",<br/>"double-value": "double",<br/>"int-value": "int",<br/>"string-value": "str"<br/>}<br/>}, ...<br/>}"<br/>Fields:<br/>variable-value -> (oneof<bool-value\|double-value\|int-value\|string-value>)<br/>Oneof variable-value field<br/>string-value -> (string)<br/>int-value -> (int)<br/>double-value -> (double)<br/>bool-value -> (bool)|
|`--openapi-spec`|<b>`string`</b><br/>The text of specification, JSON or YAML.|
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
