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
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--description`|<b>`string`</b><br/>Description of the MCP Gateway.|
|`--folder-id`|<b>`string`</b><br/>ID of the folder to create the MCP Gateway in.|
|`--labels`|<b>`stringToString`</b><br/>MCP Gateway labels as 'key:value' pairs.|
|`--log-options`|<b>`shorthand/json`</b><br/>Logging options for the MCP Gateway.<br/><br/>Example:|
|`--log-options`|<b>`destination={folder-id=value},`</b><br/>disabled=true, min-level=TRACE<br/><br/>Shorthand Syntax:<br/>{destination={folder-id=str \| log-group-id=str}, disabled=bool, min-level=TRACE\|DEBUG\|INFO\|WARN\|ERROR\|FATAL}<br/>Fields:<br/>disabled     bool                                     — Is logging from MCP Gateway disabled.<br/>min-level    enum<DEBUG\|ERROR\|FATAL\|INFO\|TRACE\|WARN>  — Minimum logs level.<br/><br/>See [LogLevel.Level] for details.<br/>destination  oneof<folder-id\|log-group-id>            — Oneof destination field<br/>log-group-id  string  — ID of the logging group which should be used for MCP Gateway logs.<br/>folder-id     string  — ID of the folder which default logging group should be used for MCP Gateway logs.<br/>|
|`--name`|<b>`string`</b><br/>Name of the MCP Gateway.|
|`--network-id`|<b>`string`</b><br/>Network ID for the MCP Gateway.|
|`--public`|Flag indicating if the MCP Gateway is publicly accessible.|
|`--service-account-id`|<b>`string`</b><br/>Service account ID for the MCP Gateway.|
|`--tools`|<b>`shorthand/json`</b><br/>List of MCP tools.<br/><br/>Example:|
|`--tools`|<b>`[{action={action={container-call={body=value,`</b><br/>container-id=value, headers={key=value}, method=OPTIONS, path=value, query={key=value}}}}, description=value, input-json-schema=value, name=value}]<br/><br/>Shorthand Syntax:<br/>[{action={action={container-call={body=str, container-id=str, headers={key=str, key=...}, method=OPTIONS\|GET\|HEAD\|POST\|PUT\|PATCH\|DELETE\|TRACE\|CONNECT, path=str, query={key=str, key=...}} \| function-call={function-id=str, tag=str} \| grpc-call={body=str, endpoint=str, headers={key=str, key=...}, method=str, use-service-account=bool} \| http-call={body=str, headers={key=str, key=...}, method=OPTIONS\|GET\|HEAD\|POST\|PUT\|PATCH\|DELETE\|TRACE\|CONNECT, query={key=str, key=...}, url=str, use-service-account=bool} \| mcp-call={action={tool-call={parameters-json=str, tool-name=str}}, authorization={header={header-name=str, header-value=str} \| service-account={} \| unauthorized={}}, forward-headers={key=str, key=...}, transport=SSE\|STREAMABLE, url=str} \| start-workflow={input-json=str, mode=SYNC\|ASYNC, workflow-id=str}}}, description=str, input-json-schema=str, name=str},...]<br/>Fields:<br/>action             struct  required  — Action to perform when this tool is invoked.<br/>action  oneof<container-call\|function-call\|grpc-call\|http-call\|mcp-call\|start-workflow>  — Oneof action field<br/>function-call   struct  — Call Serverless Function.<br/>function-id  string  required  — ID of serverless function to call.<br/>tag          string            — Tag of serverless function. If empty, \$latest tag will be used.<br/>container-call  struct  — Call Serverless Container.<br/>body          string                                                                — Request body to send to the container.<br/>container-id  string                                                      required  — ID of serverless container to call.<br/>headers       map[string,string]                                                    — HTTP headers to include in the request.<br/>method        enum<CONNECT\|DELETE\|GET\|HEAD\|OPTIONS\|PATCH\|POST\|PUT\|TRACE>            — HTTP method to use for the request.<br/>path          string                                                                — Relative request path inside the container.<br/>query         map[string,string]                                                    — Query string parameters to include in the request.<br/>http-call       struct  — Send HTTP request.<br/>body                 string                                                                — Request body payload.<br/>headers              map[string,string]                                                    — HTTP headers to include.<br/>method               enum<CONNECT\|DELETE\|GET\|HEAD\|OPTIONS\|PATCH\|POST\|PUT\|TRACE>            — HTTP method to use.<br/>query                map[string,string]                                                    — Query string parameters to include.<br/>url                  string                                                      required  — Absolute URL to send the request to. (required)<br/>use-service-account  bool                                                                  — Use MCP Gateway service account credentials for the request.<br/>mcp-call        struct  — Call MCP Gateway.<br/>forward-headers  map[string,string]                                    — Headers from the incoming request to forward downstream by name.<br/>transport        enum<SSE\|STREAMABLE>                                  — Transport to use for MCP communication.<br/>url              string                                      required  — MCP endpoint base URL. (required)<br/>action           oneof\<tool-call\>                                      — Oneof action field<br/>tool-call  struct  —<br/>parameters-json  string            — JSON-encoded parameters to pass to the tool.<br/>tool-name        string  required  — Name of the tool to invoke on the MCP endpoint. (required)<br/>authorization    oneof<header\|service-account\|unauthorized>            — Oneof authorization field<br/>unauthorized     struct  —<br/>header           struct  —<br/>header-name   string  — Name of the authorization header to send.<br/>header-value  string  — Value of the authorization header to send.<br/>service-account  struct  —<br/>grpc-call       struct  — Call gRPC endpoint. Server must support gRPC reflection.<br/>body                 string                        — Request body payload for the call.<br/>endpoint             string              required  — gRPC server endpoint, e.g., host:port. (required)<br/>headers              map[string,string]            — gRPC/HTTP headers to include with the call.<br/>method               string              required  — Fully qualified gRPC method name, e.g., package.Service/Method. (required)<br/>use-service-account  bool                          — Use MCP Gateway service account for authentication.<br/>start-workflow  struct  — Start Workflow.<br/>input-json   string                      — JSON-encoded workflow input payload.<br/>mode         enum<ASYNC\|SYNC>            — Execution mode for the workflow.<br/>Determines whether the call should wait for workflow completion (SYNC)<br/>or return immediately after starting the workflow (ASYNC).<br/>workflow-id  string            required  — ID of the Workflow to start. (required)<br/>description        string            — Description of the tool.<br/>input-json-schema  string            — JSON Schema describing tool input.<br/>name               string  required  — Name of the tool.<br/>|
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
