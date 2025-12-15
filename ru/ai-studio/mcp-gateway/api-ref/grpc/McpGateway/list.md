---
editable: false
sourcePath: en/_api-ref-grpc/serverless/mcpgateway/v1/mcp-gateway/api-ref/grpc/McpGateway/list.md
---

# MCP Gateway Service, gRPC: McpGatewayService.List

Retrieves the list of MCP Gateways in the specified folder.

## gRPC request

**rpc List ([ListMcpGatewayRequest](#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayRequest)) returns ([ListMcpGatewayResponse](#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayResponse))**

## ListMcpGatewayRequest {#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list MCP Gateways in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListWorkflowsResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

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

## ListMcpGatewayResponse {#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayResponse}

```json
{
  "gateways": [
    {
      "id": "string",
      "folder_id": "string",
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
      "network_id": "string",
      "service_account_id": "string",
      "public": "bool"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| gateways[] | **[McpGatewayPreview](#yandex.cloud.serverless.mcpgateway.v1.McpGatewayPreview)**

List of MCP Gateways. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListMcpGatewayRequest.page_size](#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayRequest), use `next_page_token` as the value
for the [ListMcpGatewayRequest.page_token](#yandex.cloud.serverless.mcpgateway.v1.ListMcpGatewayRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## McpGatewayPreview {#yandex.cloud.serverless.mcpgateway.v1.McpGatewayPreview}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the MCP Gateway. Generated at creation time. ||
|| folder_id | **string**

Required field. ID of the folder that the MCP Gateway belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. Creation timestamp for the MCP Gateway. ||
|| name | **string**

Required field. Name of the MCP Gateway. ||
|| description | **string**

Description of the MCP Gateway. ||
|| labels | **object** (map<**string**, **string**>)

MCP Gateway labels as `key:value` pairs. ||
|| status | enum **Status**

Required field. Status of the MCP Gateway.

- `CREATING`: MCP Gateway is being created.
- `ACTIVE`: MCP Gateway is ready to use.
- `UPDATING`: MCP Gateway is being updated.
- `DELETING`: MCP Gateway is being deleted.
- `ERROR`: MCP Gateway is in an error state. The only allowed action is delete. ||
|| base_domain | **string**

Base domain of the MCP Gateway. ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.mcpgateway.v1.LogOptions)**

Log options for the MCP Gateway. ||
|| network_id | **string**

ID of the VPC network MCP Gateway will be executed in, in order to access private resources. ||
|| service_account_id | **string**

ID of the Service Account which will be used for resource access in MCP Gateway call. ||
|| public | **bool**

Publicity of the MCP Gateway. Public MCP Gateway can be accessed by anybody. ||
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