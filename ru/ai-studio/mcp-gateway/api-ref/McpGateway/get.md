---
editable: false
apiPlayground:
  - url: https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways/{mcpGatewayId}
    method: get
    path:
      type: object
      properties:
        mcpGatewayId:
          description: |-
            **string**
            Required field. ID of the MCP Gateway.
          type: string
      required:
        - mcpGatewayId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/mcpgateway/v1/mcp-gateway/api-ref/McpGateway/get.md
---

# MCP Gateway Service, REST: McpGateway.Get

Retrieves the specified MCP Gateway.

## HTTP request

```
GET https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways/{mcpGatewayId}
```

## Path parameters

#|
||Field | Description ||
|| mcpGatewayId | **string**

Required field. ID of the MCP Gateway. ||
|#

## Response {#yandex.cloud.serverless.mcpgateway.v1.McpGateway}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "tools": [
    {
      "name": "string",
      "description": "string",
      "inputJsonSchema": "string",
      "action": {
        // Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`
        "functionCall": {
          "functionId": "string",
          "tag": "string"
        },
        "containerCall": {
          "containerId": "string",
          "path": "string",
          "method": "string",
          "body": "string",
          "headers": "object",
          "query": "object"
        },
        "httpCall": {
          "url": "string",
          "method": "string",
          "body": "string",
          "headers": "object",
          "query": "object",
          "useServiceAccount": "boolean"
        },
        "mcpCall": {
          "url": "string",
          // Includes only one of the fields `toolCall`
          "toolCall": {
            "toolName": "string",
            "parametersJson": "string"
          },
          // end of the list of possible fields
          "transport": "string",
          // Includes only one of the fields `unauthorized`, `header`, `serviceAccount`
          "unauthorized": "object",
          "header": {
            "headerName": "string",
            "headerValue": "string"
          },
          "serviceAccount": "object",
          // end of the list of possible fields
          "forwardHeaders": "object"
        },
        "grpcCall": {
          "endpoint": "string",
          "method": "string",
          "useServiceAccount": "boolean",
          "body": "string",
          "headers": "object"
        },
        "startWorkflow": {
          "workflowId": "string",
          "inputJson": "string",
          "mode": "string"
        }
        // end of the list of possible fields
      }
    }
  ],
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "baseDomain": "string",
  "logOptions": {
    "disabled": "boolean",
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields
    "minLevel": "string"
  },
  "serviceAccountId": "string",
  "networkId": "string",
  "cloudId": "string",
  "public": "boolean"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. ID of the MCP Gateway. Generated at creation time. ||
|| folderId | **string**

Required field. ID of the folder that the MCP Gateway belongs to. ||
|| tools[] | **[McpTool](#yandex.cloud.serverless.mcpgateway.v1.McpTool)**

Tools of the MCP Gateway. ||
|| createdAt | **string** (date-time)

Required field. Creation timestamp for the MCP Gateway.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Required field. Name of the MCP Gateway. ||
|| description | **string**

Description of the MCP Gateway. ||
|| labels | **object** (map<**string**, **string**>)

MCP Gateway labels as `key:value` pairs. ||
|| status | **enum** (Status)

Status of the MCP Gateway.

- `CREATING`: MCP Gateway is being created.
- `ACTIVE`: MCP Gateway is ready to use.
- `UPDATING`: MCP Gateway is being updated.
- `DELETING`: MCP Gateway is being deleted.
- `ERROR`: MCP Gateway is in an error state. The only allowed action is delete. ||
|| baseDomain | **string**

Base domain of the MCP Gateway. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions)**

Log options for the MCP Gateway. ||
|| serviceAccountId | **string**

ID of the Service Account which will be used for resource access in MCP Gateway call. ||
|| networkId | **string**

ID of the VPC network MCP Gateway will be executed in, in order to access private resources. ||
|| cloudId | **string**

Required field. ID of the cloud that the MCP Gateway belongs to. ||
|| public | **boolean**

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
|| inputJsonSchema | **string**

JSON Schema describing tool input. ||
|| action | **[McpToolAction](#yandex.cloud.serverless.mcpgateway.v1.McpToolAction)**

Required field. Action to perform when this tool is invoked. ||
|#

## McpToolAction {#yandex.cloud.serverless.mcpgateway.v1.McpToolAction}

#|
||Field | Description ||
|| functionCall | **[FunctionCall](#yandex.cloud.serverless.mcpgateway.v1.FunctionCall)**

Call Serverless Function.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| containerCall | **[ContainerCall](#yandex.cloud.serverless.mcpgateway.v1.ContainerCall)**

Call Serverless Container.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| httpCall | **[HttpCall](#yandex.cloud.serverless.mcpgateway.v1.HttpCall)**

Send HTTP request.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| mcpCall | **[McpCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall)**

Call MCP Gateway.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| grpcCall | **[GrpcCall](#yandex.cloud.serverless.mcpgateway.v1.GrpcCall)**

Call gRPC endpoint. Server must support gRPC reflection.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflow](#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow)**

Start Workflow.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|#

## FunctionCall {#yandex.cloud.serverless.mcpgateway.v1.FunctionCall}

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of serverless function to call. ||
|| tag | **string**

Tag of serverless function. If empty, $latest tag will be used. ||
|#

## ContainerCall {#yandex.cloud.serverless.mcpgateway.v1.ContainerCall}

#|
||Field | Description ||
|| containerId | **string**

Required field. ID of serverless container to call. ||
|| path | **string**

Relative request path inside the container. ||
|| method | **enum** (HttpMethod)

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
|| method | **enum** (HttpMethod)

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
|| useServiceAccount | **boolean**

Use MCP Gateway service account credentials for the request. ||
|#

## McpCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall}

#|
||Field | Description ||
|| url | **string**

Required field. MCP endpoint base URL. (required) ||
|| toolCall | **[ToolCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall)**

Includes only one of the fields `toolCall`. ||
|| transport | **enum** (Transport)

Transport to use for MCP communication.

- `SSE`: Server-Sent Events (HTTP SSE).
- `STREAMABLE`: Streamable HTTP transport. ||
|| unauthorized | **object**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.

Authorization mode for requests to the MCP endpoint. ||
|| header | **[HeaderAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization)**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.

Authorization mode for requests to the MCP endpoint. ||
|| serviceAccount | **object**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.

Authorization mode for requests to the MCP endpoint. ||
|| forwardHeaders | **object** (map<**string**, **string**>)

Headers from the incoming request to forward downstream by name. ||
|#

## ToolCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall}

#|
||Field | Description ||
|| toolName | **string**

Required field. Name of the tool to invoke on the MCP endpoint. (required) ||
|| parametersJson | **string**

JSON-encoded parameters to pass to the tool. ||
|#

## HeaderAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization}

#|
||Field | Description ||
|| headerName | **string**

Name of the authorization header to send. ||
|| headerValue | **string**

Value of the authorization header to send. ||
|#

## GrpcCall {#yandex.cloud.serverless.mcpgateway.v1.GrpcCall}

#|
||Field | Description ||
|| endpoint | **string**

Required field. gRPC server endpoint, e.g., host:port. (required) ||
|| method | **string**

Required field. Fully qualified gRPC method name, e.g., package.Service/Method. (required) ||
|| useServiceAccount | **boolean**

Use MCP Gateway service account for authentication. ||
|| body | **string**

Request body payload for the call. ||
|| headers | **object** (map<**string**, **string**>)

gRPC/HTTP headers to include with the call. ||
|#

## StartWorkflow {#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow}

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow to start. (required) ||
|| inputJson | **string**

JSON-encoded workflow input payload. ||
|| mode | **enum** (Mode)

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
|| disabled | **boolean**

Is logging from MCP Gateway disabled. ||
|| logGroupId | **string**

ID of the logging group which should be used for MCP Gateway logs.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| folderId | **string**

ID of the folder which default logging group should be used for MCP Gateway logs.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| minLevel | **enum** (Level)

Minimum logs level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

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