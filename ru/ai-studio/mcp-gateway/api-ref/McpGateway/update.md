---
editable: false
apiPlayground:
  - url: https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways/{mcpGatewayId}
    method: patch
    path:
      type: object
      properties:
        mcpGatewayId:
          description: |-
            **string**
            Required field. ID of the MCP Gateway to update.
          type: string
      required:
        - mcpGatewayId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        name:
          description: |-
            **string**
            Updated name of the MCP Gateway.
            The maximum string length in characters is 128. Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Updated description of the MCP Gateway.
            The maximum string length in characters is 4000.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Updated MCP Gateway labels as `key:value` pairs.
            No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_./\@0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_./\@0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        tools:
          description: |-
            **[McpTool](#yandex.cloud.serverless.mcpgateway.v1.McpTool)**
            Updated list of MCP tools associated with the gateway.
          type: array
          items:
            $ref: '#/definitions/McpTool'
        logOptions:
          description: |-
            **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions)**
            Updated logging options for the MCP Gateway.
          $ref: '#/definitions/LogOptions'
        serviceAccountId:
          description: |-
            **string**
            Updated service account ID for the MCP Gateway.
          type: string
        networkId:
          description: |-
            **string**
            Updated network ID for the MCP Gateway.
          type: string
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        public:
          description: |-
            **boolean**
            Updated flag indicating if the MCP Gateway is publicly accessible.
          type: boolean
      additionalProperties: false
    definitions:
      FunctionCall:
        type: object
        properties:
          functionId:
            description: |-
              **string**
              Required field. ID of serverless function to call.
            type: string
          tag:
            description: |-
              **string**
              Tag of serverless function. If empty, $latest tag will be used.
            type: string
        required:
          - functionId
      ContainerCall:
        type: object
        properties:
          containerId:
            description: |-
              **string**
              Required field. ID of serverless container to call.
            type: string
          path:
            description: |-
              **string**
              Relative request path inside the container.
            type: string
          method:
            description: |-
              **enum** (HttpMethod)
              HTTP method to use for the request.
              - `OPTIONS`
              - `GET`
              - `HEAD`
              - `POST`
              - `PUT`
              - `PATCH`
              - `DELETE`
              - `TRACE`
              - `CONNECT`
            type: string
            enum:
              - HTTP_METHOD_UNSPECIFIED
              - OPTIONS
              - GET
              - HEAD
              - POST
              - PUT
              - PATCH
              - DELETE
              - TRACE
              - CONNECT
          body:
            description: |-
              **string**
              Request body to send to the container.
            type: string
          headers:
            description: |-
              **object** (map<**string**, **string**>)
              HTTP headers to include in the request.
            type: object
            additionalProperties:
              type: string
          query:
            description: |-
              **object** (map<**string**, **string**>)
              Query string parameters to include in the request.
            type: object
            additionalProperties:
              type: string
        required:
          - containerId
      HttpCall:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. Absolute URL to send the request to. (required)
            type: string
          method:
            description: |-
              **enum** (HttpMethod)
              HTTP method to use.
              - `OPTIONS`
              - `GET`
              - `HEAD`
              - `POST`
              - `PUT`
              - `PATCH`
              - `DELETE`
              - `TRACE`
              - `CONNECT`
            type: string
            enum:
              - HTTP_METHOD_UNSPECIFIED
              - OPTIONS
              - GET
              - HEAD
              - POST
              - PUT
              - PATCH
              - DELETE
              - TRACE
              - CONNECT
          body:
            description: |-
              **string**
              Request body payload.
            type: string
          headers:
            description: |-
              **object** (map<**string**, **string**>)
              HTTP headers to include.
            type: object
            additionalProperties:
              type: string
          query:
            description: |-
              **object** (map<**string**, **string**>)
              Query string parameters to include.
            type: object
            additionalProperties:
              type: string
          useServiceAccount:
            description: |-
              **boolean**
              Use MCP Gateway service account credentials for the request.
            type: boolean
        required:
          - url
      ToolCall:
        type: object
        properties:
          toolName:
            description: |-
              **string**
              Required field. Name of the tool to invoke on the MCP endpoint. (required)
            type: string
          parametersJson:
            description: |-
              **string**
              JSON-encoded parameters to pass to the tool.
            type: string
        required:
          - toolName
      NoAuthorization:
        type: object
        properties: {}
      HeaderAuthorization:
        type: object
        properties:
          headerName:
            description: |-
              **string**
              Name of the authorization header to send.
            type: string
          headerValue:
            description: |-
              **string**
              Value of the authorization header to send.
            type: string
      SaAuthorization:
        type: object
        properties: {}
      McpCall:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. MCP endpoint base URL. (required)
            type: string
          toolCall:
            description: |-
              **[ToolCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall)**
              Includes only one of the fields `toolCall`.
            $ref: '#/definitions/ToolCall'
          transport:
            description: |-
              **enum** (Transport)
              Transport to use for MCP communication.
              - `SSE`: Server-Sent Events (HTTP SSE).
              - `STREAMABLE`: Streamable HTTP transport.
            type: string
            enum:
              - TRANSPORT_UNSPECIFIED
              - SSE
              - STREAMABLE
          unauthorized:
            description: |-
              **object**
              Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.
              Authorization mode for requests to the MCP endpoint.
            $ref: '#/definitions/NoAuthorization'
          header:
            description: |-
              **[HeaderAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization)**
              Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.
              Authorization mode for requests to the MCP endpoint.
            $ref: '#/definitions/HeaderAuthorization'
          serviceAccount:
            description: |-
              **object**
              Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.
              Authorization mode for requests to the MCP endpoint.
            $ref: '#/definitions/SaAuthorization'
          forwardHeaders:
            description: |-
              **object** (map<**string**, **string**>)
              Headers from the incoming request to forward downstream by name.
            type: object
            additionalProperties:
              type: string
        required:
          - url
        allOf:
          - oneOf:
              - required:
                  - toolCall
          - oneOf:
              - required:
                  - unauthorized
              - required:
                  - header
              - required:
                  - serviceAccount
      GrpcCall:
        type: object
        properties:
          endpoint:
            description: |-
              **string**
              Required field. gRPC server endpoint, e.g., host:port. (required)
            type: string
          method:
            description: |-
              **string**
              Required field. Fully qualified gRPC method name, e.g., package.Service/Method. (required)
            type: string
          useServiceAccount:
            description: |-
              **boolean**
              Use MCP Gateway service account for authentication.
            type: boolean
          body:
            description: |-
              **string**
              Request body payload for the call.
            type: string
          headers:
            description: |-
              **object** (map<**string**, **string**>)
              gRPC/HTTP headers to include with the call.
            type: object
            additionalProperties:
              type: string
        required:
          - endpoint
          - method
      StartWorkflow:
        type: object
        properties:
          workflowId:
            description: |-
              **string**
              Required field. ID of the Workflow to start. (required)
            type: string
          inputJson:
            description: |-
              **string**
              JSON-encoded workflow input payload.
            type: string
          mode:
            description: |-
              **enum** (Mode)
              Execution mode for the workflow.
              Determines whether the call should wait for workflow completion (SYNC)
              or return immediately after starting the workflow (ASYNC).
              - `SYNC`: Synchronous mode. The call blocks until the workflow execution completes.
              - `ASYNC`: Asynchronous mode. The call returns immediately after starting the workflow.
              Returns the execution ID for tracking the workflow progress separately.
            type: string
            enum:
              - MODE_UNSPECIFIED
              - SYNC
              - ASYNC
        required:
          - workflowId
      McpToolAction:
        type: object
        properties:
          functionCall:
            description: |-
              **[FunctionCall](#yandex.cloud.serverless.mcpgateway.v1.FunctionCall)**
              Call Serverless Function.
              Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`.
            $ref: '#/definitions/FunctionCall'
          containerCall:
            description: |-
              **[ContainerCall](#yandex.cloud.serverless.mcpgateway.v1.ContainerCall)**
              Call Serverless Container.
              Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`.
            $ref: '#/definitions/ContainerCall'
          httpCall:
            description: |-
              **[HttpCall](#yandex.cloud.serverless.mcpgateway.v1.HttpCall)**
              Send HTTP request.
              Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`.
            $ref: '#/definitions/HttpCall'
          mcpCall:
            description: |-
              **[McpCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall)**
              Call MCP Gateway.
              Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`.
            $ref: '#/definitions/McpCall'
          grpcCall:
            description: |-
              **[GrpcCall](#yandex.cloud.serverless.mcpgateway.v1.GrpcCall)**
              Call gRPC endpoint. Server must support gRPC reflection.
              Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`.
            $ref: '#/definitions/GrpcCall'
          startWorkflow:
            description: |-
              **[StartWorkflow](#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow)**
              Start Workflow.
              Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`.
            $ref: '#/definitions/StartWorkflow'
        oneOf:
          - required:
              - functionCall
          - required:
              - containerCall
          - required:
              - httpCall
          - required:
              - mcpCall
          - required:
              - grpcCall
          - required:
              - startWorkflow
      McpTool:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the tool.
              The maximum string length in characters is 128. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_]{0,63})? `.
            pattern: ([a-zA-Z][-a-zA-Z0-9_]{0,63})?
            type: string
          description:
            description: |-
              **string**
              Description of the tool.
              The maximum string length in characters is 4000.
            type: string
          inputJsonSchema:
            description: |-
              **string**
              JSON Schema describing tool input.
            type: string
          action:
            description: |-
              **[McpToolAction](#yandex.cloud.serverless.mcpgateway.v1.McpToolAction)**
              Required field. Action to perform when this tool is invoked.
            $ref: '#/definitions/McpToolAction'
        required:
          - name
          - action
      LogOptions:
        type: object
        properties:
          disabled:
            description: |-
              **boolean**
              Is logging from MCP Gateway disabled.
            type: boolean
          logGroupId:
            description: |-
              **string**
              ID of the logging group which should be used for MCP Gateway logs.
              Includes only one of the fields `logGroupId`, `folderId`.
            type: string
          folderId:
            description: |-
              **string**
              ID of the folder which default logging group should be used for MCP Gateway logs.
              Includes only one of the fields `logGroupId`, `folderId`.
            type: string
          minLevel:
            description: |-
              **enum** (Level)
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
                May be used to alert about unrecoverable failures and events.
            type: string
            enum:
              - LEVEL_UNSPECIFIED
              - TRACE
              - DEBUG
              - INFO
              - WARN
              - ERROR
              - FATAL
        oneOf:
          - required:
              - logGroupId
          - required:
              - folderId
---

# MCP Gateway Service, REST: McpGateway.Update

Updates the specified MCP Gateway.

## HTTP request

```
PATCH https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways/{mcpGatewayId}
```

## Path parameters

#|
||Field | Description ||
|| mcpGatewayId | **string**

Required field. ID of the MCP Gateway to update. ||
|#

## Body parameters {#yandex.cloud.serverless.mcpgateway.v1.UpdateMcpGatewayRequest}

```json
{
  "name": "string",
  "description": "string",
  "labels": "object",
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
  "updateMask": "string",
  "public": "boolean"
}
```

#|
||Field | Description ||
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
|| logOptions | **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions)**

Updated logging options for the MCP Gateway. ||
|| serviceAccountId | **string**

Updated service account ID for the MCP Gateway. ||
|| networkId | **string**

Updated network ID for the MCP Gateway. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| public | **boolean**

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "mcpGatewayId": "string",
    "folderId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateMcpGatewayMetadata](#yandex.cloud.serverless.mcpgateway.v1.UpdateMcpGatewayMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| mcpGatewayId | **string**

Required field. ID of the MCP Gateway being updated. ||
|| folderId | **string**

Required field. ID of the folder containing the MCP Gateway. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## McpGateway {#yandex.cloud.serverless.mcpgateway.v1.McpGateway}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the MCP Gateway. Generated at creation time. ||
|| folderId | **string**

Required field. ID of the folder that the MCP Gateway belongs to. ||
|| tools[] | **[McpTool](#yandex.cloud.serverless.mcpgateway.v1.McpTool2)**

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
|| logOptions | **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions2)**

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

## McpTool {#yandex.cloud.serverless.mcpgateway.v1.McpTool2}

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
|| action | **[McpToolAction](#yandex.cloud.serverless.mcpgateway.v1.McpToolAction2)**

Required field. Action to perform when this tool is invoked. ||
|#

## McpToolAction {#yandex.cloud.serverless.mcpgateway.v1.McpToolAction2}

#|
||Field | Description ||
|| functionCall | **[FunctionCall](#yandex.cloud.serverless.mcpgateway.v1.FunctionCall2)**

Call Serverless Function.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| containerCall | **[ContainerCall](#yandex.cloud.serverless.mcpgateway.v1.ContainerCall2)**

Call Serverless Container.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| httpCall | **[HttpCall](#yandex.cloud.serverless.mcpgateway.v1.HttpCall2)**

Send HTTP request.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| mcpCall | **[McpCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall2)**

Call MCP Gateway.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| grpcCall | **[GrpcCall](#yandex.cloud.serverless.mcpgateway.v1.GrpcCall2)**

Call gRPC endpoint. Server must support gRPC reflection.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflow](#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow2)**

Start Workflow.

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|#

## FunctionCall {#yandex.cloud.serverless.mcpgateway.v1.FunctionCall2}

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of serverless function to call. ||
|| tag | **string**

Tag of serverless function. If empty, $latest tag will be used. ||
|#

## ContainerCall {#yandex.cloud.serverless.mcpgateway.v1.ContainerCall2}

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

## HttpCall {#yandex.cloud.serverless.mcpgateway.v1.HttpCall2}

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

## McpCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall2}

#|
||Field | Description ||
|| url | **string**

Required field. MCP endpoint base URL. (required) ||
|| toolCall | **[ToolCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall2)**

Includes only one of the fields `toolCall`. ||
|| transport | **enum** (Transport)

Transport to use for MCP communication.

- `SSE`: Server-Sent Events (HTTP SSE).
- `STREAMABLE`: Streamable HTTP transport. ||
|| unauthorized | **object**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.

Authorization mode for requests to the MCP endpoint. ||
|| header | **[HeaderAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization2)**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.

Authorization mode for requests to the MCP endpoint. ||
|| serviceAccount | **object**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`.

Authorization mode for requests to the MCP endpoint. ||
|| forwardHeaders | **object** (map<**string**, **string**>)

Headers from the incoming request to forward downstream by name. ||
|#

## ToolCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall2}

#|
||Field | Description ||
|| toolName | **string**

Required field. Name of the tool to invoke on the MCP endpoint. (required) ||
|| parametersJson | **string**

JSON-encoded parameters to pass to the tool. ||
|#

## HeaderAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization2}

#|
||Field | Description ||
|| headerName | **string**

Name of the authorization header to send. ||
|| headerValue | **string**

Value of the authorization header to send. ||
|#

## GrpcCall {#yandex.cloud.serverless.mcpgateway.v1.GrpcCall2}

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

## StartWorkflow {#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow2}

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

## LogOptions {#yandex.cloud.serverless.mcpgateway.v1.LogOptions2}

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