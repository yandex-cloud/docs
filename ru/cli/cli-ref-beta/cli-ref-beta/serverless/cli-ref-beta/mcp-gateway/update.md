---
editable: false
noIndex: true
---

# yc beta serverless mcp-gateway update

Updates the specified MCP Gateway.

#### Command Usage

Syntax:

`yc beta serverless mcp-gateway update <MCP-GATEWAY-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Updated description of the MCP Gateway. ||
|| `--labels` | `map<string><string>`

Updated MCP Gateway labels as 'key:value' pairs. ||
|| `--log-options` | `shorthand/json`

Updated logging options for the MCP Gateway.

Shorthand Syntax:

```hcl
{
  destination = folder-id=string | log-group-id=string,
  disabled = boolean,
  min-level = TRACE|DEBUG|INFO|WARN|ERROR|FATAL
}
```

JSON Syntax:

```json
{
  "destination": {
    "folder-id": "string",
    "log-group-id": "string"
  },
  "disabled": "boolean",
  "min-level": "TRACE|DEBUG|INFO|WARN|ERROR|FATAL"
}
```

Fields:

```
disabled -> (boolean)
  Is logging from MCP Gateway disabled.
min-level -> (struct)
  Minimum logs level. See [LogLevel.Level] for details.
destination -> (oneof<folder-id|log-group-id>)
  Oneof destination field
  log-group-id -> (string)
    ID of the logging group which should be used for MCP Gateway logs.
  folder-id -> (string)
    ID of the folder which default logging group should be used for MCP Gateway logs.
``` ||
|| `--mcp-gateway-id` | `string`

ID of the MCP Gateway to update. ||
|| `--name` | `string`

Updated name of the MCP Gateway. ||
|| `--network-id` | `string`

Updated network ID for the MCP Gateway. ||
|| `--public` | Updated flag indicating if the MCP Gateway is publicly accessible. ||
|| `--service-account-id` | `string`

Updated service account ID for the MCP Gateway. ||
|| `--tools` | `shorthand/json`

Updated list of MCP tools associated with the gateway.

Shorthand Syntax:

```hcl
[
  {
    action = {
      action = container-call={
        body = string,
        container-id = string,
        forward-headers = {
          headers = string,...,
          mode = WHITE_LIST|BLACK_LIST
        },
        headers = {key=string, key=...},
        method = OPTIONS|GET|HEAD|POST|PUT|PATCH|DELETE|TRACE|CONNECT,
        path = string,
        query = {key=string, key=...}
      } | function-call={
        function-id = string,
        tag = string
      } | grpc-call={
        body = string,
        endpoint = string,
        forward-headers = {
          headers = string,...,
          mode = WHITE_LIST|BLACK_LIST
        },
        headers = {key=string, key=...},
        method = string,
        use-service-account = boolean
      } | http-call={
        body = string,
        forward-headers = {
          headers = string,...,
          mode = WHITE_LIST|BLACK_LIST
        },
        headers = {key=string, key=...},
        method = OPTIONS|GET|HEAD|POST|PUT|PATCH|DELETE|TRACE|CONNECT,
        query = {key=string, key=...},
        url = string,
        use-service-account = boolean
      } | mcp-call={
        action = tool-call={
          parameters-json = string,
          tool-name = string
        },
        authorization = header={
          header-name = string,
          header-value = string
        } | service-account={} | unauthorized={},
        forward-headers = {key=string, key=...},
        transfer-headers = {
          headers = string,...,
          mode = WHITE_LIST|BLACK_LIST
        },
        transport = SSE|STREAMABLE,
        url = string
      } | start-workflow={
        input-json = string,
        mode = SYNC|ASYNC,
        workflow-id = string
      }
    },
    description = string,
    input-json-schema = string,
    name = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "action": {
      "action": {
        "container-call": {
          "body": "string",
          "container-id": "string",
          "forward-headers": {
            "headers": [
              "string", ...
            ],
            "mode": "WHITE_LIST|BLACK_LIST"
          },
          "headers": {
            "<key>": "string", ...
          },
          "method": "OPTIONS|GET|HEAD|POST|PUT|PATCH|DELETE|TRACE|CONNECT",
          "path": "string",
          "query": {
            "<key>": "string", ...
          }
        },
        "function-call": {
          "function-id": "string",
          "tag": "string"
        },
        "grpc-call": {
          "body": "string",
          "endpoint": "string",
          "forward-headers": {
            "headers": [
              "string", ...
            ],
            "mode": "WHITE_LIST|BLACK_LIST"
          },
          "headers": {
            "<key>": "string", ...
          },
          "method": "string",
          "use-service-account": "boolean"
        },
        "http-call": {
          "body": "string",
          "forward-headers": {
            "headers": [
              "string", ...
            ],
            "mode": "WHITE_LIST|BLACK_LIST"
          },
          "headers": {
            "<key>": "string", ...
          },
          "method": "OPTIONS|GET|HEAD|POST|PUT|PATCH|DELETE|TRACE|CONNECT",
          "query": {
            "<key>": "string", ...
          },
          "url": "string",
          "use-service-account": "boolean"
        },
        "mcp-call": {
          "action": {
            "tool-call": {
              "parameters-json": "string",
              "tool-name": "string"
            }
          },
          "authorization": {
            "header": {
              "header-name": "string",
              "header-value": "string"
            },
            "service-account": {},
            "unauthorized": {}
          },
          "forward-headers": {
            "<key>": "string", ...
          },
          "transfer-headers": {
            "headers": [
              "string", ...
            ],
            "mode": "WHITE_LIST|BLACK_LIST"
          },
          "transport": "SSE|STREAMABLE",
          "url": "string"
        },
        "start-workflow": {
          "input-json": "string",
          "mode": "SYNC|ASYNC",
          "workflow-id": "string"
        }
      }
    },
    "description": "string",
    "input-json-schema": "string",
    "name": "string"
  }, ...
]
```

Fields:

```
action -> (struct)
  Action to perform when this tool is invoked.
  action -> (oneof<container-call|function-call|grpc-call|http-call|mcp-call|start-workflow>)
    Oneof action field
    function-call -> (struct)
      Call Serverless Function.
      function-id -> (string)
        ID of serverless function to call.
      tag -> (string)
        Tag of serverless function. If empty, $latest tag will be used.
    container-call -> (struct)
      Call Serverless Container.
      body -> (string)
        Request body to send to the container.
      container-id -> (string)
        ID of serverless container to call.
      forward-headers -> (struct)
        Policy that defines which headers from the incoming request should be forwarded
        headers -> ([]string)
          List of HTTP header names to forward. Interpretation depends on the mode: - WHITE_LIST: only these headers will be forwarded (all others are excluded) - BLACK_LIST: all headers except these will be forwarded (these are excluded)
        mode -> (struct)
          Mode of header forwarding. Determines how the headers list is interpreted.
      headers -> (map[string,string])
        HTTP headers to include in the request.
      method -> (struct)
        HTTP method to use for the request.
      path -> (string)
        Relative request path inside the container.
      query -> (map[string,string])
        Query string parameters to include in the request.
    http-call -> (struct)
      Send HTTP request.
      body -> (string)
        Request body payload.
      forward-headers -> (struct)
        Policy that defines which headers from the incoming request should be forwarded
        headers -> ([]string)
          List of HTTP header names to forward. Interpretation depends on the mode: - WHITE_LIST: only these headers will be forwarded (all others are excluded) - BLACK_LIST: all headers except these will be forwarded (these are excluded)
        mode -> (struct)
          Mode of header forwarding. Determines how the headers list is interpreted.
      headers -> (map[string,string])
        HTTP headers to include.
      method -> (struct)
        HTTP method to use.
      query -> (map[string,string])
        Query string parameters to include.
      url -> (string)
        Absolute URL to send the request to. (required)
      use-service-account -> (boolean)
        Use MCP Gateway service account credentials for the request.
    mcp-call -> (struct)
      Call MCP Gateway.
      forward-headers -> (map[string,string])
        Headers from the incoming request to forward downstream by name.
      transfer-headers -> (struct)
        Policy that defines which headers from the incoming request should be forwarded to the HTTP endpoint
        headers -> ([]string)
          List of HTTP header names to forward. Interpretation depends on the mode: - WHITE_LIST: only these headers will be forwarded (all others are excluded) - BLACK_LIST: all headers except these will be forwarded (these are excluded)
        mode -> (struct)
          Mode of header forwarding. Determines how the headers list is interpreted.
      transport -> (struct)
        Transport to use for MCP communication.
      url -> (string)
        MCP endpoint base URL. (required)
      action -> (oneof<tool-call>)
        Oneof action field
        tool-call -> (struct)
          Tool call action to invoke a specific tool on the MCP endpoint.
          parameters-json -> (string)
            JSON-encoded parameters to pass to the tool.
          tool-name -> (string)
            Name of the tool to invoke on the MCP endpoint. (required)
      authorization -> (oneof<header|service-account|unauthorized>)
        Oneof authorization field
        unauthorized -> (struct)
          No authorization mode.
        header -> (struct)
          Header-based authorization.
          header-name -> (string)
            Name of the authorization header to send.
          header-value -> (string)
            Value of the authorization header to send.
        service-account -> (struct)
          Service account authorization.
    grpc-call -> (struct)
      Call gRPC endpoint. Server must support gRPC reflection.
      body -> (string)
        Request body payload for the call.
      endpoint -> (string)
        gRPC server endpoint, e.g., host:port. (required)
      forward-headers -> (struct)
        Policy that defines which headers from the incoming request should be forwarded
        headers -> ([]string)
          List of HTTP header names to forward. Interpretation depends on the mode: - WHITE_LIST: only these headers will be forwarded (all others are excluded) - BLACK_LIST: all headers except these will be forwarded (these are excluded)
        mode -> (struct)
          Mode of header forwarding. Determines how the headers list is interpreted.
      headers -> (map[string,string])
        gRPC/HTTP headers to include with the call.
      method -> (string)
        Fully qualified gRPC method name, e.g., package.Service/Method. (required)
      use-service-account -> (boolean)
        Use MCP Gateway service account for authentication.
    start-workflow -> (struct)
      Start Workflow.
      input-json -> (string)
        JSON-encoded workflow input payload.
      mode -> (struct)
        Execution mode for the workflow. Determines whether the call should wait for workflow completion (SYNC) or return immediately after starting the workflow (ASYNC).
      workflow-id -> (string)
        ID of the Workflow to start. (required)
description -> (string)
  Description of the tool.
input-json-schema -> (string)
  JSON Schema describing tool input.
name -> (string)
  Name of the tool.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#