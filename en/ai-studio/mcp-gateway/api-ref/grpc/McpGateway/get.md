---
editable: false
---

# MCP Gateway Service, gRPC: McpGatewayService.Get

Retrieves the specified MCP Gateway.

## gRPC request

**rpc Get ([GetMcpGatewayRequest](#yandex.cloud.serverless.mcpgateway.v1.GetMcpGatewayRequest)) returns ([McpGateway](#yandex.cloud.serverless.mcpgateway.v1.McpGateway))**

## GetMcpGatewayRequest {#yandex.cloud.serverless.mcpgateway.v1.GetMcpGatewayRequest}

```json
{
  "mcp_gateway_id": "string"
}
```

#|
||Field | Description ||
|| mcp_gateway_id | **string**

Required field. ID of the MCP Gateway. ||
|#

## McpGateway {#yandex.cloud.serverless.mcpgateway.v1.McpGateway}

```json
{
  "id": "string",
  "folder_id": "string",
  "tools": [
    {
      "name": "string",
      "description": "string",
      "input_json_schema": "string",
      "action": {
        // Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`
        "function_call": {
          "function_id": "string",
          "tag": "string"
        },
        "container_call": {
          "container_id": "string",
          "path": "string",
          "method": "HttpMethod",
          "body": "string",
          "headers": "map<string, string>",
          "query": "map<string, string>"
        },
        "http_call": {
          "url": "string",
          "method": "HttpMethod",
          "body": "string",
          "headers": "map<string, string>",
          "query": "map<string, string>",
          "use_service_account": "bool"
        },
        "mcp_call": {
          "url": "string",
          // Includes only one of the fields `tool_call`
          "tool_call": {
            "tool_name": "string",
            "parameters_json": "string"
          },
          // end of the list of possible fields
          "transport": "Transport",
          // Includes only one of the fields `unauthorized`, `header`, `service_account`
          "unauthorized": "NoAuthorization",
          "header": {
            "header_name": "string",
            "header_value": "string"
          },
          "service_account": "SaAuthorization",
          // end of the list of possible fields
          "forward_headers": "map<string, string>"
        },
        "grpc_call": {
          "endpoint": "string",
          "method": "string",
          "use_service_account": "bool",
          "body": "string",
          "headers": "map<string, string>"
        },
        "start_workflow": {
          "workflow_id": "string",
          "input_json": "string",
          "mode": "Mode"
        }
        // end of the list of possible fields
      }
    }
  ],
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "status": "Status",
  "base_domain": "string",
  "log_options": {
    "disabled": "bool",
    // Includes only one of the fields `log_group_id`, `folder_id`
    "log_group_id": "string",
    "folder_id": "string",
    // end of the list of possible fields
    "min_level": "Level"
  },
  "service_account_id": "string",
  "network_id": "string",
  "cloud_id": "string",
  "public": "bool"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. ID of the MCP Gateway. Generated at creation time. ||
|| folder_id | **string**

Required field. ID of the folder that the MCP Gateway belongs to. ||
|| tools[] | **[McpTool](#yandex.cloud.serverless.mcpgateway.v1.McpTool)**

Tools of the MCP Gateway. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Creation timestamp for the MCP Gateway. ||
|| name | **string**

Required field. Name of the MCP Gateway. ||
|| description | **string**

Description of the MCP Gateway. ||
|| labels | **object** (map<**string**, **string**>)

MCP Gateway labels as `key:value` pairs. ||
|| status | enum **Status**

Status of the MCP Gateway.

- `CREATING`: MCP Gateway is being created.
- `ACTIVE`: MCP Gateway is ready to use.
- `UPDATING`: MCP Gateway is being updated.
- `DELETING`: MCP Gateway is being deleted.
- `ERROR`: MCP Gateway is in an error state. The only allowed action is delete. ||
|| base_domain | **string**

Base domain of the MCP Gateway. ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions)**

Log options for the MCP Gateway. ||
|| service_account_id | **string**

ID of the Service Account which will be used for resource access in MCP Gateway call. ||
|| network_id | **string**

ID of the VPC network MCP Gateway will be executed in, in order to access private resources. ||
|| cloud_id | **string**

Required field. ID of the cloud that the MCP Gateway belongs to. ||
|| public | **bool**

Publicity of the MCP Gateway. Public MCP Gateway can be accessed by anybody. ||
|#

## McpTool {#yandex.cloud.serverless.mcpgateway.v1.McpTool}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the tool.

The maximum string length in characters is 128. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_]{0,63})? `. ||
|| description | **string**

Description of the tool.

The maximum string length in characters is 4000. ||
|| input_json_schema | **string**

JSON Schema describing tool input. ||
|| action | **[McpToolAction](#yandex.cloud.serverless.mcpgateway.v1.McpToolAction)**

Required field. Action to perform when this tool is invoked. ||
|#

## McpToolAction {#yandex.cloud.serverless.mcpgateway.v1.McpToolAction}

#|
||Field | Description ||
|| function_call | **[FunctionCall](#yandex.cloud.serverless.mcpgateway.v1.FunctionCall)**

Call Serverless Function.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| container_call | **[ContainerCall](#yandex.cloud.serverless.mcpgateway.v1.ContainerCall)**

Call Serverless Container.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| http_call | **[HttpCall](#yandex.cloud.serverless.mcpgateway.v1.HttpCall)**

Send HTTP request.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| mcp_call | **[McpCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall)**

Call MCP Gateway.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| grpc_call | **[GrpcCall](#yandex.cloud.serverless.mcpgateway.v1.GrpcCall)**

Call gRPC endpoint. Server must support gRPC reflection.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| start_workflow | **[StartWorkflow](#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow)**

Start Workflow.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|#

## FunctionCall {#yandex.cloud.serverless.mcpgateway.v1.FunctionCall}

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of serverless function to call. ||
|| tag | **string**

Tag of serverless function. If empty, $latest tag will be used. ||
|#

## ContainerCall {#yandex.cloud.serverless.mcpgateway.v1.ContainerCall}

#|
||Field | Description ||
|| container_id | **string**

Required field. ID of serverless container to call. ||
|| path | **string**

Relative request path inside the container. ||
|| method | enum **HttpMethod**

HTTP method to use for the request.

- `OPTIONS`
- `GET`
- `HEAD`
- `POST`
- `PUT`
- `PATCH`
- `DELETE`
- `TRACE`
- `CONNECT` ||
|| body | **string**

Request body to send to the container. ||
|| headers | **object** (map<**string**, **string**>)

HTTP headers to include in the request. ||
|| query | **object** (map<**string**, **string**>)

Query string parameters to include in the request. ||
|#

## HttpCall {#yandex.cloud.serverless.mcpgateway.v1.HttpCall}

#|
||Field | Description ||
|| url | **string**

Required field. Absolute URL to send the request to. (required) ||
|| method | enum **HttpMethod**

HTTP method to use.

- `OPTIONS`
- `GET`
- `HEAD`
- `POST`
- `PUT`
- `PATCH`
- `DELETE`
- `TRACE`
- `CONNECT` ||
|| body | **string**

Request body payload. ||
|| headers | **object** (map<**string**, **string**>)

HTTP headers to include. ||
|| query | **object** (map<**string**, **string**>)

Query string parameters to include. ||
|| use_service_account | **bool**

Use MCP Gateway service account credentials for the request. ||
|#

## McpCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall}

#|
||Field | Description ||
|| url | **string**

Required field. MCP endpoint base URL. (required) ||
|| tool_call | **[ToolCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall)**

Includes only one of the fields `tool_call`. ||
|| transport | enum **Transport**

Transport to use for MCP communication.

- `SSE`: Server-Sent Events (HTTP SSE).
- `STREAMABLE`: Streamable HTTP transport. ||
|| unauthorized | **[NoAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.NoAuthorization)**

Includes only one of the fields `unauthorized`, `header`, `service_account`.

Authorization mode for requests to the MCP endpoint. ||
|| header | **[HeaderAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization)**

Includes only one of the fields `unauthorized`, `header`, `service_account`.

Authorization mode for requests to the MCP endpoint. ||
|| service_account | **[SaAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.SaAuthorization)**

Includes only one of the fields `unauthorized`, `header`, `service_account`.

Authorization mode for requests to the MCP endpoint. ||
|| forward_headers | **object** (map<**string**, **string**>)

Headers from the incoming request to forward downstream by name. ||
|#

## ToolCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall}

#|
||Field | Description ||
|| tool_name | **string**

Required field. Name of the tool to invoke on the MCP endpoint. (required) ||
|| parameters_json | **string**

JSON-encoded parameters to pass to the tool. ||
|#

## NoAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.NoAuthorization}

No authorization will be sent.

#|
||Field | Description ||
|| Empty | > ||
|#

## HeaderAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization}

#|
||Field | Description ||
|| header_name | **string**

Name of the authorization header to send. ||
|| header_value | **string**

Value of the authorization header to send. ||
|#

## SaAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.SaAuthorization}

Use MCP Gateway service account to authorize.

#|
||Field | Description ||
|| Empty | > ||
|#

## GrpcCall {#yandex.cloud.serverless.mcpgateway.v1.GrpcCall}

#|
||Field | Description ||
|| endpoint | **string**

Required field. gRPC server endpoint, e.g., host:port. (required) ||
|| method | **string**

Required field. Fully qualified gRPC method name, e.g., package.Service/Method. (required) ||
|| use_service_account | **bool**

Use MCP Gateway service account for authentication. ||
|| body | **string**

Request body payload for the call. ||
|| headers | **object** (map<**string**, **string**>)

gRPC/HTTP headers to include with the call. ||
|#

## StartWorkflow {#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow}

#|
||Field | Description ||
|| workflow_id | **string**

Required field. ID of the Workflow to start. (required) ||
|| input_json | **string**

JSON-encoded workflow input payload. ||
|| mode | enum **Mode**

Execution mode for the workflow.
Determines whether the call should wait for workflow completion (SYNC)
or return immediately after starting the workflow (ASYNC).

- `SYNC`: Synchronous mode. The call blocks until the workflow execution completes.
- `ASYNC`: Asynchronous mode. The call returns immediately after starting the workflow.
Returns the execution ID for tracking the workflow progress separately. ||
|#

## LogOptions {#yandex.cloud.serverless.mcpgateway.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from MCP Gateway disabled. ||
|| log_group_id | **string**

ID of the logging group which should be used for MCP Gateway logs.

Includes only one of the fields `log_group_id`, `folder_id`. ||
|| folder_id | **string**

ID of the folder which default logging group should be used for MCP Gateway logs.

Includes only one of the fields `log_group_id`, `folder_id`. ||
|| min_level | enum **Level**

Minimum logs level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|#