---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/v1/apigateway/api-ref/grpc/ApiGateway/list.md
---

# API Gateway Service, gRPC: ApiGatewayService.List

Retrieves the list of API gateways in the specified folder.

## gRPC request

**rpc List ([ListApiGatewayRequest](#yandex.cloud.serverless.apigateway.v1.ListApiGatewayRequest)) returns ([ListApiGatewayResponse](#yandex.cloud.serverless.apigateway.v1.ListApiGatewayResponse))**

## ListApiGatewayRequest {#yandex.cloud.serverless.apigateway.v1.ListApiGatewayRequest}

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

Required field. ID of the folder to list API gateways in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListApiGatewayResponse.next_page_token](#yandex.cloud.serverless.apigateway.v1.ListApiGatewayResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListApiGatewayResponse.next_page_token](#yandex.cloud.serverless.apigateway.v1.ListApiGatewayResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters functions listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [ApiGateway.name](index) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{0,61}[a-z0-9])?`.
Example of a filter: `name=my-apigw`. ||
|#

## ListApiGatewayResponse {#yandex.cloud.serverless.apigateway.v1.ListApiGatewayResponse}

```json
{
  "api_gateways": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "status": "Status",
      "domain": "string",
      "log_group_id": "string",
      "attached_domains": [
        {
          "domain_id": "string",
          "certificate_id": "string",
          "enabled": "bool",
          "domain": "string"
        }
      ],
      "connectivity": {
        "network_id": "string",
        "subnet_id": [
          "string"
        ]
      },
      "log_options": {
        "disabled": "bool",
        // Includes only one of the fields `log_group_id`, `folder_id`
        "log_group_id": "string",
        "folder_id": "string",
        // end of the list of possible fields
        "min_level": "Level"
      },
      "variables": {
        // Includes only one of the fields `string_value`, `int_value`, `double_value`, `bool_value`
        "string_value": "string",
        "int_value": "int64",
        "double_value": "double",
        "bool_value": "bool"
        // end of the list of possible fields
      },
      "canary": {
        "weight": "int64",
        "variables": {
          // Includes only one of the fields `string_value`, `int_value`, `double_value`, `bool_value`
          "string_value": "string",
          "int_value": "int64",
          "double_value": "double",
          "bool_value": "bool"
          // end of the list of possible fields
        }
      },
      "execution_timeout": "google.protobuf.Duration"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| api_gateways[] | **[ApiGateway](#yandex.cloud.serverless.apigateway.v1.ApiGateway)**

List of API gateways in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListApiGatewayRequest.page_size](#yandex.cloud.serverless.apigateway.v1.ListApiGatewayRequest), use `nextPageToken` as the value
for the [ListApiGatewayRequest.page_token](#yandex.cloud.serverless.apigateway.v1.ListApiGatewayRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## ApiGateway {#yandex.cloud.serverless.apigateway.v1.ApiGateway}

#|
||Field | Description ||
|| id | **string**

ID of the API gateway. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the API gateway belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the API-gateway. ||
|| name | **string**

Name of the API gateway. The name is unique within the folder. ||
|| description | **string**

Description of the API gateway. ||
|| labels | **string**

API gateway labels as `key:value` pairs. ||
|| status | enum **Status**

Status of the API gateway.

- `STATUS_UNSPECIFIED`
- `CREATING`: API gateway is being created.
- `ACTIVE`: API gateway is ready for use.
- `DELETING`: API gateway is being deleted.
- `ERROR`: API gateway failed. The only allowed action is delete.
- `UPDATING`: API gateway is being updated. ||
|| domain | **string**

Default domain for the API gateway. Generated at creation time. ||
|| log_group_id | **string**

ID of the log group for the API gateway. ||
|| attached_domains[] | **[AttachedDomain](#yandex.cloud.serverless.apigateway.v1.AttachedDomain)**

List of domains attached to API gateway. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.apigateway.v1.Connectivity)**

Network access. If specified the gateway will be attached to specified network/subnet(s). ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.apigateway.v1.LogOptions)**

Options for logging from the API gateway. ||
|| variables | **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**

Values of variables defined in the specification. ||
|| canary | **[Canary](#yandex.cloud.serverless.apigateway.v1.Canary)**

Canary release of the gateway. ||
|| execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for gateway call execution ||
|#

## AttachedDomain {#yandex.cloud.serverless.apigateway.v1.AttachedDomain}

#|
||Field | Description ||
|| domain_id | **string**

ID of the domain. ||
|| certificate_id | **string**

ID of the domain certificate. ||
|| enabled | **bool**

Enabling flag. ||
|| domain | **string**

Name of the domain. ||
|#

## Connectivity {#yandex.cloud.serverless.apigateway.v1.Connectivity}

Gateway connectivity specification.

#|
||Field | Description ||
|| network_id | **string**

Network the gateway will have access to.
It's essential to specify network with subnets in all availability zones. ||
|| subnet_id[] | **string**

Complete list of subnets (from the same network) the gateway can be attached to.
It's essential to specify at least one subnet for each availability zones. ||
|#

## LogOptions {#yandex.cloud.serverless.apigateway.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from API gateway disabled. ||
|| log_group_id | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| folder_id | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `log_group_id`, `folder_id`.

Log entries destination. ||
|| min_level | enum **Level**

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/grpc/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
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

## VariableInput {#yandex.cloud.serverless.apigateway.v1.VariableInput}

#|
||Field | Description ||
|| string_value | **string**

Includes only one of the fields `string_value`, `int_value`, `double_value`, `bool_value`.

Variable value that can has only primitive type ||
|| int_value | **int64**

Includes only one of the fields `string_value`, `int_value`, `double_value`, `bool_value`.

Variable value that can has only primitive type ||
|| double_value | **double**

Includes only one of the fields `string_value`, `int_value`, `double_value`, `bool_value`.

Variable value that can has only primitive type ||
|| bool_value | **bool**

Includes only one of the fields `string_value`, `int_value`, `double_value`, `bool_value`.

Variable value that can has only primitive type ||
|#

## Canary {#yandex.cloud.serverless.apigateway.v1.Canary}

#|
||Field | Description ||
|| weight | **int64**

It describes percentage of requests, which will be processed by canary. ||
|| variables | **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**

Values specification variables, associated with canary. ||
|#