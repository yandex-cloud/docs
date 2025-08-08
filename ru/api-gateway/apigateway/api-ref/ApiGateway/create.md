---
editable: false
apiPlayground:
  - url: https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create an API gateway in.
            To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the API gateway.
            The name must be unique within the folder.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the API gateway.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
          pattern: '[a-z][-_./\@0-9a-z]*'
          type: string
        openapiSpec:
          description: |-
            **string**
            The text of specification, JSON or YAML.
            Includes only one of the fields `openapiSpec`.
            OpenAPI specification of API gateway.
          type: string
        connectivity:
          description: |-
            **[Connectivity](/docs/api-gateway/apigateway/api-ref/ApiGateway/get#yandex.cloud.serverless.apigateway.v1.Connectivity)**
            Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s).
          $ref: '#/definitions/Connectivity'
        logOptions:
          description: |-
            **[LogOptions](/docs/api-gateway/apigateway/api-ref/ApiGateway/get#yandex.cloud.serverless.apigateway.v1.LogOptions)**
            Options for logging from the API gateway.
          oneOf:
            - type: object
              properties:
                logGroupId:
                  description: |-
                    **string**
                    Entry should be written to log group resolved by ID.
                    Includes only one of the fields `logGroupId`, `folderId`.
                    Log entries destination.
                  type: string
                folderId:
                  description: |-
                    **string**
                    Entry should be written to default log group for specified folder.
                    Includes only one of the fields `logGroupId`, `folderId`.
                    Log entries destination.
                  type: string
        variables:
          description: |-
            **object** (map<**string**, **[VariableInput](/docs/api-gateway/apigateway/api-ref/ApiGateway/get#yandex.cloud.serverless.apigateway.v1.VariableInput)**>)
            Values of variables defined in the specification.
          type: object
          additionalProperties:
            type: string
        canary:
          description: |-
            **[Canary](/docs/api-gateway/apigateway/api-ref/ApiGateway/get#yandex.cloud.serverless.apigateway.v1.Canary)**
            Canary release of the gateway.
          $ref: '#/definitions/Canary'
        executionTimeout:
          description: |-
            **string** (duration)
            Timeout for gateway call execution
          type: string
          format: duration
      required:
        - folderId
      additionalProperties: false
    definitions:
      Connectivity:
        type: object
        properties:
          networkId:
            description: |-
              **string**
              Network the gateway will have access to.
              It's essential to specify network with subnets in all availability zones.
            type: string
          subnetId:
            description: |-
              **string**
              Complete list of subnets (from the same network) the gateway can be attached to.
              It's essential to specify at least one subnet for each availability zones.
            type: array
            items:
              type: string
      Canary:
        type: object
        properties:
          weight:
            description: |-
              **string** (int64)
              It describes percentage of requests, which will be processed by canary.
            type: string
            format: int64
          variables:
            description: |-
              **object** (map<**string**, **[VariableInput](/docs/api-gateway/apigateway/api-ref/ApiGateway/get#yandex.cloud.serverless.apigateway.v1.VariableInput)**>)
              Values specification variables, associated with canary.
            type: object
            additionalProperties:
              type: string
sourcePath: en/_api-ref/serverless/apigateway/v1/apigateway/api-ref/ApiGateway/create.md
---

# API Gateway Service, REST: ApiGateway.Create

Creates an API gateway in the specified folder.

## HTTP request

```
POST https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways
```

## Body parameters {#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayRequest}

```json
{
  "folderId": "string",
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
|| folderId | **string**

Required field. ID of the folder to create an API gateway in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the API gateway.
The name must be unique within the folder. ||
|| description | **string**

Description of the API gateway. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| openapiSpec | **string**

The text of specification, JSON or YAML.

Includes only one of the fields `openapiSpec`.

OpenAPI specification of API gateway. ||
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
|| metadata | **[CreateApiGatewayMetadata](#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayMetadata)**

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

## CreateApiGatewayMetadata {#yandex.cloud.serverless.apigateway.v1.CreateApiGatewayMetadata}

#|
||Field | Description ||
|| apiGatewayId | **string**

ID of the API gateway that is being created. ||
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