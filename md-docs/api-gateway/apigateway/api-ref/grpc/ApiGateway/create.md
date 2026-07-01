# API Gateway Service, gRPC: ApiGatewayService.Create

Creates an API gateway in the specified folder.

## gRPC request

**rpc Create ([CreateApiGatewayRequest](#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateApiGatewayRequest {#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest}

```json
{
  "folder_id": "string",
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
|| folder_id | **string**

Required field. ID of the folder to create an API gateway in.
To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request. ||
|| name | **string**

Name of the API gateway.
The name must be unique within the folder.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

Description of the API gateway.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| openapi_spec | **string**

The text of specification, JSON or YAML.

Includes only one of the fields `openapi_spec`.

OpenAPI specification of API gateway. ||
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
See [LogLevel.Level](../../../../../logging/api-ref/grpc/Export/get.md#yandex.cloud.logging.v1.LogLevel.Level) for details.

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

It describes percentage of requests, which will be processed by canary.

Acceptable values are 0 to 99, inclusive. ||
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**>)

Values specification variables, associated with canary.

More than 0 per resource. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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