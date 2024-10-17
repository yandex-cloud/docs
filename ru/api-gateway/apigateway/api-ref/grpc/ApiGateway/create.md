---
editable: false
sourcePath: en/_api-ref-grpc/serverless/apigateway/v1/apigateway/api-ref/grpc/ApiGateway/create.md
---

# API Gateway Service, gRPC: ApiGatewayService.Create {#Create}

Creates an API gateway in the specified folder.

## gRPC request

**rpc Create ([CreateApiGatewayRequest](#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateApiGatewayRequest {#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  // Includes only one of the fields `openapiSpec`
  "openapiSpec": "string",
  // end of the list of possible fields
  "connectivity": {
    "networkId": "string",
    "subnetId": [
      "string"
    ]
  },
  "logOptions": {
    "disabled": "bool",
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields
    "minLevel": "Level"
  },
  "variables": {
    // Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`
    "stringValue": "string",
    "intValue": "int64",
    "doubleValue": "double",
    "boolValue": "bool"
    // end of the list of possible fields
  },
  "canary": {
    "weight": "int64",
    "variables": {
      // Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`
      "stringValue": "string",
      "intValue": "int64",
      "doubleValue": "double",
      "boolValue": "bool"
      // end of the list of possible fields
    }
  },
  "executionTimeout": "google.protobuf.Duration"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create an API gateway in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the API gateway.
The name must be unique within the folder. ||
|| description | **string**

Description of the API gateway. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| openapiSpec | **string**

The text of specification, JSON or YAML.

Includes only one of the fields `openapiSpec`.

OpenAPI specification of API gateway. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.apigateway.v1.Connectivity)**

Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s). ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.apigateway.v1.LogOptions)**

Options for logging from the API gateway. ||
|| variables | **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**

Values of variables defined in the specification. ||
|| canary | **[Canary](#yandex.cloud.serverless.apigateway.v1.Canary)**

Canary release of the gateway. ||
|| executionTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for gateway call execution ||
|#

## Connectivity {#yandex.cloud.serverless.apigateway.v1.Connectivity}

Gateway connectivity specification.

#|
||Field | Description ||
|| networkId | **string**

Network the gateway will have access to.
It's essential to specify network with subnets in all availability zones. ||
|| subnetId[] | **string**

Complete list of subnets (from the same network) the gateway can be attached to.
It's essential to specify at least one subnet for each availability zones. ||
|#

## LogOptions {#yandex.cloud.serverless.apigateway.v1.LogOptions}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from API gateway disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | enum **Level**

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
|| stringValue | **string**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| intValue | **int64**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| doubleValue | **double**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| boolValue | **bool**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "apiGatewayId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "status": "Status",
    "domain": "string",
    "logGroupId": "string",
    "attachedDomains": [
      {
        "domainId": "string",
        "certificateId": "string",
        "enabled": "bool",
        "domain": "string"
      }
    ],
    "connectivity": {
      "networkId": "string",
      "subnetId": [
        "string"
      ]
    },
    "logOptions": {
      "disabled": "bool",
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "minLevel": "Level"
    },
    "variables": {
      // Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`
      "stringValue": "string",
      "intValue": "int64",
      "doubleValue": "double",
      "boolValue": "bool"
      // end of the list of possible fields
    },
    "canary": {
      "weight": "int64",
      "variables": {
        // Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`
        "stringValue": "string",
        "intValue": "int64",
        "doubleValue": "double",
        "boolValue": "bool"
        // end of the list of possible fields
      }
    },
    "executionTimeout": "google.protobuf.Duration"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateApiGatewayMetadata](#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayMetadata)**

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

## CreateApiGatewayMetadata {#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayMetadata}

#|
||Field | Description ||
|| apiGatewayId | **string**

ID of the API gateway that is being created. ||
|#

## ApiGateway {#yandex.cloud.serverless.apigateway.v1.ApiGateway}

#|
||Field | Description ||
|| id | **string**

ID of the API gateway. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the API gateway belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| logGroupId | **string**

ID of the log group for the API gateway. ||
|| attachedDomains[] | **[AttachedDomain](#yandex.cloud.serverless.apigateway.v1.AttachedDomain)**

List of domains attached to API gateway. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.apigateway.v1.Connectivity2)**

Network access. If specified the gateway will be attached to specified network/subnet(s). ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.apigateway.v1.LogOptions2)**

Options for logging from the API gateway. ||
|| variables | **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput2)**

Values of variables defined in the specification. ||
|| canary | **[Canary](#yandex.cloud.serverless.apigateway.v1.Canary2)**

Canary release of the gateway. ||
|| executionTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for gateway call execution ||
|#

## AttachedDomain {#yandex.cloud.serverless.apigateway.v1.AttachedDomain}

#|
||Field | Description ||
|| domainId | **string**

ID of the domain. ||
|| certificateId | **string**

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
|| networkId | **string**

Network the gateway will have access to.
It's essential to specify network with subnets in all availability zones. ||
|| subnetId[] | **string**

Complete list of subnets (from the same network) the gateway can be attached to.
It's essential to specify at least one subnet for each availability zones. ||
|#

## LogOptions {#yandex.cloud.serverless.apigateway.v1.LogOptions2}

#|
||Field | Description ||
|| disabled | **bool**

Is logging from API gateway disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | enum **Level**

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
|| stringValue | **string**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| intValue | **int64**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| doubleValue | **double**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| boolValue | **bool**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|#

## Canary {#yandex.cloud.serverless.apigateway.v1.Canary2}

#|
||Field | Description ||
|| weight | **int64**

It describes percentage of requests, which will be processed by canary. ||
|| variables | **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput2)**

Values specification variables, associated with canary. ||
|#