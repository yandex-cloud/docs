---
editable: false
apiPlayground:
  - url: https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list MCP Gateways in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListWorkflowsResponse.next_page_token]
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListWorkflowsResponse.next_page_token] returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters functions listed in the response.
            The expression must specify:
            1. The field name. Currently filtering can only be applied to following fields: name, created_at.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{0,61}[a-z0-9])?`.
            Example of a filter: `name=my-mcp-gateway`.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/mcpgateway/v1/mcp-gateway/api-ref/McpGateway/list.md
---

# MCP Gateway Service, REST: McpGateway.List

Retrieves the list of MCP Gateways in the specified folder.

## HTTP request

```
GET https://serverless-mcp-gateway.{{ api-host }}/mcpgateway/v1/mcpGateways
```

## Query parameters {#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list MCP Gateways in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListWorkflowsResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListWorkflowsResponse.next_page_token] returned by a previous list request. ||
|| filter | **string**

A filter expression that filters functions listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to following fields: name, created_at.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{0,61}[a-z0-9])?`.
Example of a filter: `name=my-mcp-gateway`. ||
|#

## Response {#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayResponse}

**HTTP Code: 200 - OK**

```json
{
  "gateways": [
    {
      "id": "string",
      "folderId": "string",
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
      "networkId": "string",
      "serviceAccountId": "string",
      "public": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| gateways[] | **[McpGatewayPreview](#yandex.cloud.serverless.mcpgateway.v1.McpGatewayPreview)**

List of MCP Gateways. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListMcpGatewayRequest.pageSize](#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayRequest), use `next_page_token` as the value
for the [ListMcpGatewayRequest.pageToken](#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## McpGatewayPreview {#yandex.cloud.serverless.mcpgateway.v1.McpGatewayPreview}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the MCP Gateway. Generated at creation time. ||
|| folderId | **string**

Required field. ID of the folder that the MCP Gateway belongs to. ||
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

Required field. Status of the MCP Gateway.

- `CREATING`: MCP Gateway is being created.
- `ACTIVE`: MCP Gateway is ready to use.
- `UPDATING`: MCP Gateway is being updated.
- `DELETING`: MCP Gateway is being deleted.
- `ERROR`: MCP Gateway is in an error state. The only allowed action is delete. ||
|| baseDomain | **string**

Base domain of the MCP Gateway. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions)**

Log options for the MCP Gateway. ||
|| networkId | **string**

ID of the VPC network MCP Gateway will be executed in, in order to access private resources. ||
|| serviceAccountId | **string**

ID of the Service Account which will be used for resource access in MCP Gateway call. ||
|| public | **boolean**

Publicity of the MCP Gateway. Public MCP Gateway can be accessed by anybody. ||
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