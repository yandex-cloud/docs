---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/serverless/cli-ref-beta/mcp-gateway/create.md
---

# yc beta serverless mcp-gateway create

Creates an MCP Gateway in the specified folder.

#### Command Usage

Syntax: 

`yc beta serverless mcp-gateway create <FOLDER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the MCP Gateway.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create the MCP Gateway in.|
|`--labels`|<b>`stringToString`</b><br/>MCP Gateway labels as 'key:value' pairs.|
|`--log-options`|<b>`shorthand/json`</b><br/>Logging options for the MCP Gateway.<br/>Shorthand Syntax:<br/>{<br/>destination = folder-id=str \| log-group-id=str,<br/>disabled = bool,<br/>min-level = TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL<br/>}<br/>JSON Syntax:<br/>"{<br/>"destination": {<br/>"folder-id": "str",<br/>"log-group-id": "str"<br/>},<br/>"disabled": "bool",<br/>"min-level": "TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL"<br/>}"<br/>Fields:<br/>disabled -> (bool)<br/>Is logging from MCP Gateway disabled.<br/>min-level -> (enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>)<br/>Minimum logs level. See [LogLevel.Level] for details.<br/>destination -> (oneof<folder-id\|log-group-id>)<br/>Oneof destination field<br/>log-group-id -> (string)<br/>ID of the logging group which should be used for MCP Gateway logs.<br/>folder-id -> (string)<br/>ID of the folder which default logging group should be used for MCP Gateway logs.|
|`--name`|<b>`string`</b><br/>Name of the MCP Gateway.|
|`--network-id`|<b>`string`</b><br/>Network ID for the MCP Gateway.|
|`--public`|Flag indicating if the MCP Gateway is publicly accessible.|
|`--service-account-id`|<b>`string`</b><br/>Service account ID for the MCP Gateway.|
|`--tools`|<b>`shorthand/json`</b><br/>List of MCP tools.<br/>Shorthand Syntax:<br/>[<br/>{<br/>action = {<br/>action = container-call={<br/>body = str,<br/>container-id = str,<br/>headers = {key=str, key=...},<br/>method = OPTIONS\|GET\|HEAD\|POST\|PUT\|PATCH\|DELETE\|TRACE\|CONNECT,<br/>path = str,<br/>query = {key=str, key=...}<br/>} \| function-call={<br/>function-id = str,<br/>tag = str<br/>} \| grpc-call={<br/>body = str,<br/>endpoint = str,<br/>headers = {key=str, key=...},<br/>method = str,<br/>use-service-account = bool<br/>} \| http-call={<br/>body = str,<br/>headers = {key=str, key=...},<br/>method = OPTIONS\|GET\|HEAD\|POST\|PUT\|PATCH\|DELETE\|TRACE\|CONNECT,<br/>query = {key=str, key=...},<br/>url = str,<br/>use-service-account = bool<br/>} \| mcp-call={<br/>action = tool-call={<br/>parameters-json = str,<br/>tool-name = str<br/>},<br/>authorization = header={<br/>header-name = str,<br/>header-value = str<br/>} \| service-account={} \| unauthorized={},<br/>forward-headers = {key=str, key=...},<br/>transport = SSE\|STREAMABLE,<br/>url = str<br/>} \| start-workflow={<br/>input-json = str,<br/>mode = SYNC\|ASYNC,<br/>workflow-id = str<br/>}<br/>},<br/>description = str,<br/>input-json-schema = str,<br/>name = str<br/>}, ...<br/>]<br/>JSON Syntax:<br/>"[<br/>{<br/>"action": {<br/>"action": {<br/>"container-call": {<br/>"body": "str",<br/>"container-id": "str",<br/>"headers": {<br/>"\<key\>": "str", ...<br/>},<br/>"method": "OPTIONS\|GET\|HEAD\|POST\|PUT\|PATCH\|DELETE\|TRACE\|CONNECT",<br/>"path": "str",<br/>"query": {<br/>"\<key\>": "str", ...<br/>}<br/>},<br/>"function-call": {<br/>"function-id": "str",<br/>"tag": "str"<br/>},<br/>"grpc-call": {<br/>"body": "str",<br/>"endpoint": "str",<br/>"headers": {<br/>"\<key\>": "str", ...<br/>},<br/>"method": "str",<br/>"use-service-account": "bool"<br/>},<br/>"http-call": {<br/>"body": "str",<br/>"headers": {<br/>"\<key\>": "str", ...<br/>},<br/>"method": "OPTIONS\|GET\|HEAD\|POST\|PUT\|PATCH\|DELETE\|TRACE\|CONNECT",<br/>"query": {<br/>"\<key\>": "str", ...<br/>},<br/>"url": "str",<br/>"use-service-account": "bool"<br/>},<br/>"mcp-call": {<br/>"action": {<br/>"tool-call": {<br/>"parameters-json": "str",<br/>"tool-name": "str"<br/>}<br/>},<br/>"authorization": {<br/>"header": {<br/>"header-name": "str",<br/>"header-value": "str"<br/>},<br/>"service-account": {},<br/>"unauthorized": {}<br/>},<br/>"forward-headers": {<br/>"\<key\>": "str", ...<br/>},<br/>"transport": "SSE\|STREAMABLE",<br/>"url": "str"<br/>},<br/>"start-workflow": {<br/>"input-json": "str",<br/>"mode": "SYNC\|ASYNC",<br/>"workflow-id": "str"<br/>}<br/>}<br/>},<br/>"description": "str",<br/>"input-json-schema": "str",<br/>"name": "str"<br/>}, ...<br/>]"<br/>Fields:<br/>action -> (struct)<br/>Action to perform when this tool is invoked.<br/>action -> (oneof<container-call\|function-call\|grpc-call\|http-call\|mcp-call\|start-workflow>)<br/>Oneof action field<br/>function-call -> (struct)<br/>Call Serverless Function.<br/>function-id -> (string)<br/>ID of serverless function to call.<br/>tag -> (string)<br/>Tag of serverless function. If empty, \$latest tag will be used.<br/>container-call -> (struct)<br/>Call Serverless Container.<br/>body -> (string)<br/>Request body to send to the container.<br/>container-id -> (string)<br/>ID of serverless container to call.<br/>headers -> (map[string,string])<br/>HTTP headers to include in the request.<br/>method -> (enum<CONNECT\|DELETE\|GET\|HEAD\|OPTIONS\|PATCH\|POST\|PUT\|TRACE>)<br/>HTTP method to use for the request.<br/>path -> (string)<br/>Relative request path inside the container.<br/>query -> (map[string,string])<br/>Query string parameters to include in the request.<br/>http-call -> (struct)<br/>Send HTTP request.<br/>body -> (string)<br/>Request body payload.<br/>headers -> (map[string,string])<br/>HTTP headers to include.<br/>method -> (enum<CONNECT\|DELETE\|GET\|HEAD\|OPTIONS\|PATCH\|POST\|PUT\|TRACE>)<br/>HTTP method to use.<br/>query -> (map[string,string])<br/>Query string parameters to include.<br/>url -> (string)<br/>Absolute URL to send the request to. (required)<br/>use-service-account -> (bool)<br/>Use MCP Gateway service account credentials for the request.<br/>mcp-call -> (struct)<br/>Call MCP Gateway.<br/>forward-headers -> (map[string,string])<br/>Headers from the incoming request to forward downstream by name.<br/>transport -> (enum<SSE\|STREAMABLE>)<br/>Transport to use for MCP communication.<br/>url -> (string)<br/>MCP endpoint base URL. (required)<br/>action -> (oneof\<tool-call\>)<br/>Oneof action field<br/>tool-call -> (struct)<br/>parameters-json -> (string)<br/>JSON-encoded parameters to pass to the tool.<br/>tool-name -> (string)<br/>Name of the tool to invoke on the MCP endpoint. (required)<br/>authorization -> (oneof<header\|service-account\|unauthorized>)<br/>Oneof authorization field<br/>unauthorized -> (struct)<br/>header -> (struct)<br/>header-name -> (string)<br/>Name of the authorization header to send.<br/>header-value -> (string)<br/>Value of the authorization header to send.<br/>service-account -> (struct)<br/>grpc-call -> (struct)<br/>Call gRPC endpoint. Server must support gRPC reflection.<br/>body -> (string)<br/>Request body payload for the call.<br/>endpoint -> (string)<br/>gRPC server endpoint, e.g., host:port. (required)<br/>headers -> (map[string,string])<br/>gRPC/HTTP headers to include with the call.<br/>method -> (string)<br/>Fully qualified gRPC method name, e.g., package.Service/Method. (required)<br/>use-service-account -> (bool)<br/>Use MCP Gateway service account for authentication.<br/>start-workflow -> (struct)<br/>Start Workflow.<br/>input-json -> (string)<br/>JSON-encoded workflow input payload.<br/>mode -> (enum<ASYNC\|SYNC>)<br/>Execution mode for the workflow. Determines whether the call should wait for workflow completion (SYNC) or return immediately after starting the workflow (ASYNC).<br/>workflow-id -> (string)<br/>ID of the Workflow to start. (required)<br/>description -> (string)<br/>Description of the tool.<br/>input-json-schema -> (string)<br/>JSON Schema describing tool input.<br/>name -> (string)<br/>Name of the tool.|
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
