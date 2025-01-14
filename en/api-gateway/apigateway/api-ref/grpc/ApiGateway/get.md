---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/v1/apigateway/api-ref/grpc/ApiGateway/get.md
---

# API Gateway Service, gRPC: ApiGatewayService.Get

Returns the specified API gateway. Note that only API gateway basic attributes are returned.
To get associated openapi specification, make a [GetOpenapiSpec](/docs/api-gateway/apigateway/api-ref/grpc/ApiGateway/getOpenapiSpec#GetOpenapiSpec) request.

To get the list of all available API gateways, make a [List](/docs/api-gateway/apigateway/api-ref/grpc/ApiGateway/list#List) request.

## gRPC request

**rpc Get ([GetApiGatewayRequest](#yandex.cloud.serverless.apigateway.v1.GetApiGatewayRequest)) returns ([ApiGateway](#yandex.cloud.serverless.apigateway.v1.ApiGateway))**

## GetApiGatewayRequest {#yandex.cloud.serverless.apigateway.v1.GetApiGatewayRequest}

```json
{
  "api_gateway_id": "string"
}
```

#|
||Field | Description ||
|| api_gateway_id | **string**

Required field. ID of the API gateway to return.

To get a API gateway ID make a [ApiGatewayService.List](/docs/api-gateway/apigateway/api-ref/grpc/ApiGateway/list#List) request. ||
|#

## ApiGateway {#yandex.cloud.serverless.apigateway.v1.ApiGateway}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
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
  "variables": "map<string, VariableInput>",
  "canary": {
    "weight": "int64",
    "variables": "map<string, VariableInput>"
  },
  "execution_timeout": "google.protobuf.Duration"
}
```

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
|| labels | **object** (map<**string**, **string**>)

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
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**>)

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
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**>)

Values specification variables, associated with canary. ||
|#