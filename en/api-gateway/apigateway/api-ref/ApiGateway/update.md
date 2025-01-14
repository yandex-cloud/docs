---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/v1/apigateway/api-ref/ApiGateway/update.md
---

# API Gateway Service, REST: ApiGateway.Update

Updates the specified API gateway.

## HTTP request

```
PATCH https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways/{apiGatewayId}
```

## Path parameters

#|
||Field | Description ||
|| apiGatewayId | **string**

Required field. ID of the API gateway to update.

To get a API gateway ID make a [ApiGatewayService.List](/docs/api-gateway/apigateway/api-ref/ApiGateway/list#List) request. ||
|#

## Body parameters {#yandex.cloud.serverless.apigateway.v1.UpdateApiGatewayRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
    "disabled": "boolean",
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields
    "minLevel": "string"
  },
  "variables": "object",
  "canary": {
    "weight": "string",
    "variables": "object"
  },
  "executionTimeout": "string"
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name for the API gateway.
The name must be unique within the folder. ||
|| description | **string**

New description for the API gateway. ||
|| labels | **object** (map<**string**, **string**>)

API gateway labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label, request the current set of labels with a [yandex.cloud.serverless.apigateway.v1.ApiGatewayService.Get](/docs/api-gateway/apigateway/api-ref/ApiGateway/get#Get) request. ||
|| openapiSpec | **string**

The text of specification, JSON or YAML.

Includes only one of the fields `openapiSpec`.

New OpenAPI specification of API gateway. ||
|| connectivity | **[Connectivity](#yandex.cloud.serverless.apigateway.v1.Connectivity)**

Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s). ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.apigateway.v1.LogOptions)**

Options for logging from the API gateway. ||
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**>)

Values of variables defined in the specification. ||
|| canary | **[Canary](#yandex.cloud.serverless.apigateway.v1.Canary)**

Canary release of the gateway. ||
|| executionTimeout | **string** (duration)

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
|| disabled | **boolean**

Is logging from API gateway disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | **enum** (Level)

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

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
|| intValue | **string** (int64)

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| doubleValue | **string**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| boolValue | **boolean**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|#

## Canary {#yandex.cloud.serverless.apigateway.v1.Canary}

#|
||Field | Description ||
|| weight | **string** (int64)

It describes percentage of requests, which will be processed by canary. ||
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput)**>)

Values specification variables, associated with canary. ||
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
    "apiGatewayId": "string"
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
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "status": "string",
    "domain": "string",
    "logGroupId": "string",
    "attachedDomains": [
      {
        "domainId": "string",
        "certificateId": "string",
        "enabled": "boolean",
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
      "disabled": "boolean",
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "minLevel": "string"
    },
    "variables": "object",
    "canary": {
      "weight": "string",
      "variables": "object"
    },
    "executionTimeout": "string"
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
|| metadata | **[UpdateApiGatewayMetadata](#yandex.cloud.serverless.apigateway.v1.UpdateApiGatewayMetadata)**

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
|| apiGatewayId | **string**

ID of the API gateway that is being updated. ||
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

## ApiGateway {#yandex.cloud.serverless.apigateway.v1.ApiGateway}

#|
||Field | Description ||
|| id | **string**

ID of the API gateway. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the API gateway belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp for the API-gateway.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the API gateway. The name is unique within the folder. ||
|| description | **string**

Description of the API gateway. ||
|| labels | **object** (map<**string**, **string**>)

API gateway labels as `key:value` pairs. ||
|| status | **enum** (Status)

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
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput2)**>)

Values of variables defined in the specification. ||
|| canary | **[Canary](#yandex.cloud.serverless.apigateway.v1.Canary2)**

Canary release of the gateway. ||
|| executionTimeout | **string** (duration)

Timeout for gateway call execution ||
|#

## AttachedDomain {#yandex.cloud.serverless.apigateway.v1.AttachedDomain}

#|
||Field | Description ||
|| domainId | **string**

ID of the domain. ||
|| certificateId | **string**

ID of the domain certificate. ||
|| enabled | **boolean**

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
|| disabled | **boolean**

Is logging from API gateway disabled. ||
|| logGroupId | **string**

Entry should be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry should be written to default log group for specified folder.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| minLevel | **enum** (Level)

Minimum log entry level.

See [LogLevel.Level](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.LogLevel.Level) for details.

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
|| intValue | **string** (int64)

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| doubleValue | **string**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|| boolValue | **boolean**

Includes only one of the fields `stringValue`, `intValue`, `doubleValue`, `boolValue`.

Variable value that can has only primitive type ||
|#

## Canary {#yandex.cloud.serverless.apigateway.v1.Canary2}

#|
||Field | Description ||
|| weight | **string** (int64)

It describes percentage of requests, which will be processed by canary. ||
|| variables | **object** (map<**string**, **[VariableInput](#yandex.cloud.serverless.apigateway.v1.VariableInput2)**>)

Values specification variables, associated with canary. ||
|#