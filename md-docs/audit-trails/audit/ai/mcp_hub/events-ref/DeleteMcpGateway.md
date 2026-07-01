# AI Studio MCP Hub Audit Trails Events: DeleteMcpGateway

## Event JSON schema {#yandex.cloud.audit.ai.mcp_hub.DeleteMcpGateway2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "mcpGatewayId": "string",
    // Includes only one of the fields `mcpGatewayName`
    "mcpGatewayName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `mcpGatewayDescription`
    "mcpGatewayDescription": "string",
    // end of the list of possible fields
    "mcpGatewayStatus": "string",
    // Includes only one of the fields `mcpGatewayBaseDomain`
    "mcpGatewayBaseDomain": "string",
    // end of the list of possible fields
    // Includes only one of the fields `mcpGatewayLogGroupId`
    "mcpGatewayLogGroupId": "string",
    // end of the list of possible fields
    "mcpGatewayLabels": "object",
    // Includes only one of the fields `mcpGatewayServiceAccountId`
    "mcpGatewayServiceAccountId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `mcpGatewayNetworkId`
    "mcpGatewayNetworkId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `mcpGatewayPublic`
    "mcpGatewayPublic": "boolean",
    // end of the list of possible fields
    "mcpGatewayTools": [
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
            "query": "object",
            "forwardHeaders": {
              "mode": "string",
              "headers": [
                "string"
              ]
            }
          },
          "httpCall": {
            "url": "string",
            "method": "string",
            "body": "string",
            "headers": "object",
            "query": "object",
            "useServiceAccount": "boolean",
            "forwardHeaders": {
              "mode": "string",
              "headers": [
                "string"
              ]
            }
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
            "forwardHeaders": "object",
            "transferHeaders": {
              "mode": "string",
              "headers": [
                "string"
              ]
            }
          },
          "grpcCall": {
            "endpoint": "string",
            "method": "string",
            "useServiceAccount": "boolean",
            "body": "string",
            "headers": "object",
            "forwardHeaders": {
              "mode": "string",
              "headers": [
                "string"
              ]
            }
          },
          "startWorkflow": {
            "workflowId": "string",
            "inputJson": "string",
            "mode": "string"
          }
          // end of the list of possible fields
        },
        "outputJsonSchema": "string"
      }
    ],
    // Includes only one of the fields `transport`
    "transport": "string"
    // end of the list of possible fields
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.ai.mcp_hub.DeleteMcpGateway2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[EventDetails](#yandex.cloud.audit.ai.mcp_hub.DeleteMcpGateway.EventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## EventDetails {#yandex.cloud.audit.ai.mcp_hub.DeleteMcpGateway.EventDetails}

#|
||Field | Description ||
|| mcpGatewayId | **string** ||
|| mcpGatewayName | **string**

Includes only one of the fields `mcpGatewayName`. ||
|| mcpGatewayDescription | **string**

Includes only one of the fields `mcpGatewayDescription`. ||
|| mcpGatewayStatus | **enum** (Status)

- `CREATING`
- `ACTIVE`
- `UPDATING`
- `DELETING`
- `ERROR` ||
|| mcpGatewayBaseDomain | **string**

Includes only one of the fields `mcpGatewayBaseDomain`. ||
|| mcpGatewayLogGroupId | **string**

Includes only one of the fields `mcpGatewayLogGroupId`. ||
|| mcpGatewayLabels | **object** (map<**string**, **string**>) ||
|| mcpGatewayServiceAccountId | **string**

Includes only one of the fields `mcpGatewayServiceAccountId`. ||
|| mcpGatewayNetworkId | **string**

Includes only one of the fields `mcpGatewayNetworkId`. ||
|| mcpGatewayPublic | **boolean**

Includes only one of the fields `mcpGatewayPublic`. ||
|| mcpGatewayTools[] | **[McpTool](#yandex.cloud.serverless.mcpgateway.v1.McpTool)** ||
|| transport | **enum** (McpTransport)

Includes only one of the fields `transport`.

- `SSE`
- `STREAMABLE` ||
|#

## McpTool {#yandex.cloud.serverless.mcpgateway.v1.McpTool}

#|
||Field | Description ||
|| name | **string**

The maximum string length in characters is 128. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_]{0,63})? `. ||
|| description | **string**

The maximum string length in characters is 65536. ||
|| inputJsonSchema | **string** ||
|| action | **[McpToolAction](#yandex.cloud.serverless.mcpgateway.v1.McpToolAction)** ||
|| outputJsonSchema | **string** ||
|#

## McpToolAction {#yandex.cloud.serverless.mcpgateway.v1.McpToolAction}

#|
||Field | Description ||
|| functionCall | **[FunctionCall](#yandex.cloud.serverless.mcpgateway.v1.FunctionCall)**

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| containerCall | **[ContainerCall](#yandex.cloud.serverless.mcpgateway.v1.ContainerCall)**

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| httpCall | **[HttpCall](#yandex.cloud.serverless.mcpgateway.v1.HttpCall)**

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| mcpCall | **[McpCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall)**

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| grpcCall | **[GrpcCall](#yandex.cloud.serverless.mcpgateway.v1.GrpcCall)**

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|| startWorkflow | **[StartWorkflow](#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow)**

Includes only one of the fields `functionCall`, `containerCall`, `httpCall`, `mcpCall`, `grpcCall`, `startWorkflow`. ||
|#

## FunctionCall {#yandex.cloud.serverless.mcpgateway.v1.FunctionCall}

#|
||Field | Description ||
|| functionId | **string** ||
|| tag | **string** ||
|#

## ContainerCall {#yandex.cloud.serverless.mcpgateway.v1.ContainerCall}

#|
||Field | Description ||
|| containerId | **string** ||
|| path | **string** ||
|| method | **enum** (HttpMethod)

- `OPTIONS`
- `GET`
- `HEAD`
- `POST`
- `PUT`
- `PATCH`
- `DELETE`
- `TRACE`
- `CONNECT` ||
|| body | **string** ||
|| headers | **object** (map<**string**, **string**>) ||
|| query | **object** (map<**string**, **string**>) ||
|| forwardHeaders | **[ForwardHeadersPolicy](#yandex.cloud.serverless.mcpgateway.v1.ForwardHeadersPolicy)** ||
|#

## ForwardHeadersPolicy {#yandex.cloud.serverless.mcpgateway.v1.ForwardHeadersPolicy}

#|
||Field | Description ||
|| mode | **enum** (ForwardMode)

- `WHITE_LIST`
- `BLACK_LIST` ||
|| headers[] | **string** ||
|#

## HttpCall {#yandex.cloud.serverless.mcpgateway.v1.HttpCall}

#|
||Field | Description ||
|| url | **string** ||
|| method | **enum** (HttpMethod)

- `OPTIONS`
- `GET`
- `HEAD`
- `POST`
- `PUT`
- `PATCH`
- `DELETE`
- `TRACE`
- `CONNECT` ||
|| body | **string** ||
|| headers | **object** (map<**string**, **string**>) ||
|| query | **object** (map<**string**, **string**>) ||
|| useServiceAccount | **boolean** ||
|| forwardHeaders | **[ForwardHeadersPolicy](#yandex.cloud.serverless.mcpgateway.v1.ForwardHeadersPolicy)** ||
|#

## McpCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall}

#|
||Field | Description ||
|| url | **string** ||
|| toolCall | **[ToolCall](#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall)**

Includes only one of the fields `toolCall`. ||
|| transport | **enum** (Transport)

- `SSE`
- `STREAMABLE` ||
|| unauthorized | **object**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`. ||
|| header | **[HeaderAuthorization](#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization)**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`. ||
|| serviceAccount | **object**

Includes only one of the fields `unauthorized`, `header`, `serviceAccount`. ||
|| forwardHeaders | **object** (map<**string**, **string**>) ||
|| transferHeaders | **[ForwardHeadersPolicy](#yandex.cloud.serverless.mcpgateway.v1.ForwardHeadersPolicy)** ||
|#

## ToolCall {#yandex.cloud.serverless.mcpgateway.v1.McpCall.ToolCall}

#|
||Field | Description ||
|| toolName | **string** ||
|| parametersJson | **string** ||
|#

## HeaderAuthorization {#yandex.cloud.serverless.mcpgateway.v1.McpCall.HeaderAuthorization}

#|
||Field | Description ||
|| headerName | **string** ||
|| headerValue | **string** ||
|#

## GrpcCall {#yandex.cloud.serverless.mcpgateway.v1.GrpcCall}

#|
||Field | Description ||
|| endpoint | **string** ||
|| method | **string** ||
|| useServiceAccount | **boolean** ||
|| body | **string** ||
|| headers | **object** (map<**string**, **string**>) ||
|| forwardHeaders | **[ForwardHeadersPolicy](#yandex.cloud.serverless.mcpgateway.v1.ForwardHeadersPolicy)** ||
|#

## StartWorkflow {#yandex.cloud.serverless.mcpgateway.v1.StartWorkflow}

#|
||Field | Description ||
|| workflowId | **string** ||
|| inputJson | **string** ||
|| mode | **enum** (Mode)

- `SYNC`
- `ASYNC` ||
|#