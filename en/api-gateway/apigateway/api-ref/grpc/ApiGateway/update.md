---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/v1/apigateway/api-ref/grpc/ApiGateway/update.md
---

# API Gateway Service, gRPC: ApiGatewayService.Update

Updates the specified API gateway.

## gRPC request

**rpc Update ([UpdateApiGatewayRequest](#yandex.cloud.serverless.apigateway.v1.UpdateApiGatewayRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateApiGatewayRequest {#yandex.cloud.serverless.apigateway.v1.UpdateApiGatewayRequest}

```json
{
  "api_gateway_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  // Includes only one of the fields `openapi_spec`
  "openapi_spec": "string",
  // end of the list of possible fields
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
|| api_gateway_id | **string**

Required field. ID of the API gateway to update.

To get a API gateway ID make a [ApiGatewayService.List](/docs/functions/api-gateway/api-ref/grpc/ApiGateway/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the API gateway should be updated. ||
|| name | **string**

New name for the API gateway.
The name must be unique within the folder. ||
|| description | **string**

New description for the API gateway. ||
|| labels | **object** (map<**string**, **string**>)

API gateway labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label, request the current set of labels with a [yandex.cloud.serverless.apigateway.v1.ApiGatewayService.Get](/docs/functions/api-gateway/api-ref/grpc/ApiGateway/get#Get) request. ||
|| openapi_spec | **string**

The text of specification, JSON or YAML.

Includes only one of the fields `openapi_spec`.

New OpenAPI specification of API gateway. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.apigateway.v1.Connectivity)**

Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s). ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.apigateway.v1.LogOptions)**

Options for logging from the API gateway. ||
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**>)

Values of variables defined in the specification. ||
|| canary | **[Canary](#yandex.cloud.serverless.apigateway.v1.Canary)**

Canary release of the gateway. ||
|| execution_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for gateway call execution ||
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
    "api_gateway_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| metadata | **[UpdateApiGatewayMetadata](#yandex.cloud.serverless.apigateway.v1.UpdateApiGatewayMetadata)**

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
|| response | **[ApiGateway](#yandex.cloud.serverless.apigateway.v1.ApiGateway)**

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

## UpdateApiGatewayMetadata {#yandex.cloud.serverless.apigateway.v1.UpdateApiGatewayMetadata}

#|
||Field | Description ||
|| api_gateway_id | **string**

ID of the API gateway that is being updated. ||
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
|| connectivity | **[Connectivity](#yandex.cloud.serverless.apigateway.v1.Connectivity2)**

Network access. If specified the gateway will be attached to specified network/subnet(s). ||
|| log_options | **[LogOptions](#yandex.cloud.serverless.apigateway.v1.LogOptions2)**

Options for logging from the API gateway. ||
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput2)**>)

Values of variables defined in the specification. ||
|| canary | **[Canary](#yandex.cloud.serverless.apigateway.v1.Canary2)**

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

## Connectivity {#yandex.cloud.serverless.apigateway.v1.Connectivity2}

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

## LogOptions {#yandex.cloud.serverless.apigateway.v1.LogOptions2}

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

## VariableInput {#yandex.cloud.serverless.apigateway.v1.VariableInput2}

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

## Canary {#yandex.cloud.serverless.apigateway.v1.Canary2}

#|
||Field | Description ||
|| weight | **int64**

It describes percentage of requests, which will be processed by canary. ||
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput2)**>)

Values specification variables, associated with canary. ||
|#