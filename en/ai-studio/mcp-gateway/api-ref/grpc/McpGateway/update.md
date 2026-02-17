---
editable: false
---

# MCP Gateway Service, gRPC: McpGatewayService.Update

Updates the specified MCP Gateway.

## gRPC request

**rpc Update ([UpdateMcpGatewayRequest](#yandex.cloud.serverless.mcpgateway.v1.UpdateMcpGatewayRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateMcpGatewayRequest {#yandex.cloud.serverless.mcpgateway.v1.UpdateMcpGatewayRequest}

```json
{
  "mcp_gateway_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
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
  "update_mask": "google.protobuf.FieldMask",
  "public": "bool"
}
```

#|
||Field | Description ||
|| mcp_gateway_id | **string**

Required field. ID of the MCP Gateway to update. ||
|| name | **string**

Updated name of the MCP Gateway.

The maximum string length in characters is 128. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `. ||
|| description | **string**

Updated description of the MCP Gateway.

The maximum string length in characters is 4000. ||
|| labels | **object** (map<**string**, **string**>)

Updated MCP Gateway labels as `key:value` pairs.

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. ||
|| tools[] | **[McpTool](#yandex.cloud.serverless.mcpgateway.v1.McpTool)**

Updated list of MCP tools associated with the gateway. ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions)**

Updated logging options for the MCP Gateway. ||
|| service_account_id | **string**

Updated service account ID for the MCP Gateway. ||
|| network_id | **string**

Updated network ID for the MCP Gateway. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask specifying which fields to update. ||
|| public | **bool**

Updated flag indicating if the MCP Gateway is publicly accessible. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "mcp_gateway_id": "string",
    "folder_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateMcpGatewayMetadata](#yandex.cloud.serverless.mcpgateway.v1.UpdateMcpGatewayMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[McpGateway](#yandex.cloud.serverless.mcpgateway.v1.McpGateway)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateMcpGatewayMetadata {#yandex.cloud.serverless.mcpgateway.v1.UpdateMcpGatewayMetadata}

#|
||Field | Description ||
|| mcp_gateway_id | **string**

Required field. ID of the MCP Gateway being updated. ||
|| folder_id | **string**

Required field. ID of the folder containing the MCP Gateway. ||
|#

## McpGateway {#yandex.cloud.serverless.mcpgateway.v1.McpGateway}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the MCP Gateway. Generated at creation time. ||
|| folder_id | **string**

Required field. ID of the folder that the MCP Gateway belongs to. ||
|| tools[] | **[McpTool](#yandex.cloud.serverless.mcpgateway.v1.McpTool2)**

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
|| log_options | **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions2)**

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

## McpTool {#yandex.cloud.serverless.mcpgateway.v1.McpTool2}

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
|| action | **[McpToolAction](#yandex.cloud.serverless.mcpgateway.v1.McpToolAction2)**

Required field. Action to perform when this tool is invoked. ||
|#

## McpToolAction {#yandex.cloud.serverless.mcpgateway.v1.McpToolAction2}

#|
||Field | Description ||
|| function_call | **[FunctionCall](#yandex.cloud.serverless.mcpgateway.v1.FunctionCall2)**

Call Serverless Function.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| container_call | **[ContainerCall](#yandex.cloud.serverless.mcpgateway.v1.ContainerCall2)**

Call Serverless Container.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| http_call | **[HttpCall](#yandex.cloud.serverless.mcpgateway.v1.HttpCall2)**

Send HTTP request.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| mcp_call | **[McpCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall2)**

Call MCP Gateway.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| grpc_call | **[GrpcCall](#yandex.cloud.serverless.mcpgateway.v1.GrpcCall2)**

Call gRPC endpoint. Server must support gRPC reflection.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|| start_workflow | **[StartWorkflow](#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow2)**

Start Workflow.

Includes only one of the fields `function_call`, `container_call`, `http_call`, `mcp_call`, `grpc_call`, `start_workflow`. ||
|#

## FunctionCall {#yandex.cloud.serverless.mcpgateway.v1.FunctionCall2}

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of serverless function to call. ||
|| tag | **string**

Tag of serverless function. If empty, $latest tag will be used. ||
|#

## ContainerCall {#yandex.cloud.serverless.mcpgateway.v1.ContainerCall2}

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

## HttpCall {#yandex.cloud.serverless.mcpgateway.v1.HttpCall2}

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

## McpCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall2}

#|
||Field | Description ||
|| url | **string**

Required field. MCP endpoint base URL. (required) ||
|| tool_call | **[ToolCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall2)**

Includes only one of the fields `tool_call`. ||
|| transport | enum **Transport**

Transport to use for MCP communication.

- `SSE`: Server-Sent Events (HTTP SSE).
- `STREAMABLE`: Streamable HTTP transport. ||
|| unauthorized | **[NoAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.NoAuthorization2)**

Includes only one of the fields `unauthorized`, `header`, `service_account`.

Authorization mode for requests to the MCP endpoint. ||
|| header | **[HeaderAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization2)**

Includes only one of the fields `unauthorized`, `header`, `service_account`.

Authorization mode for requests to the MCP endpoint. ||
|| service_account | **[SaAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.SaAuthorization2)**

Includes only one of the fields `unauthorized`, `header`, `service_account`.

Authorization mode for requests to the MCP endpoint. ||
|| forward_headers | **object** (map<**string**, **string**>)

Headers from the incoming request to forward downstream by name. ||
|#

## ToolCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall2}

#|
||Field | Description ||
|| tool_name | **string**

Required field. Name of the tool to invoke on the MCP endpoint. (required) ||
|| parameters_json | **string**

JSON-encoded parameters to pass to the tool. ||
|#

## NoAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.NoAuthorization2}

No authorization will be sent.

#|
||Field | Description ||
|| Empty | > ||
|#

## HeaderAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization2}

#|
||Field | Description ||
|| header_name | **string**

Name of the authorization header to send. ||
|| header_value | **string**

Value of the authorization header to send. ||
|#

## SaAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.SaAuthorization2}

Use MCP Gateway service account to authorize.

#|
||Field | Description ||
|| Empty | > ||
|#

## GrpcCall {#yandex.cloud.serverless.mcpgateway.v1.GrpcCall2}

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

## StartWorkflow {#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow2}

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

## LogOptions {#yandex.cloud.serverless.mcpgateway.v1.LogOptions2}

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