---
editable: false
apiPlayground:
  - url: https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/buses
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a bus in.
          type: string
        name:
          description: |-
            **string**
            Name of the bus.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            Description of the bus.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Labels for the bus.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        deletionProtection:
          description: |-
            **boolean**
            Flag that disallow deletion of the bus.
          type: boolean
        loggingEnabled:
          description: |-
            **boolean**
            Is logging from the bus enabled.
          type: boolean
        logOptions:
          description: |-
            **[LogOptions](#yandex.cloud.serverless.eventrouter.v1.LogOptions)**
            Options for logging from the bus.
          $ref: '#/definitions/LogOptions'
      required:
        - folderId
      additionalProperties: false
    definitions:
      LogOptions:
        type: object
        properties:
          logGroupId:
            description: |-
              **string**
              Entry will be written to log group resolved by ID.
              Includes only one of the fields `logGroupId`, `folderId`.
              Log entries destination.
            type: string
          folderId:
            description: |-
              **string**
              Entry will be written to default log group for specified folder.
              Includes only one of the fields `logGroupId`, `folderId`.
              Log entries destination.
            type: string
          minLevel:
            description: |-
              **enum** (Level)
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
                May be used to alert about unrecoverable failures and events.
            type: string
            enum:
              - LEVEL_UNSPECIFIED
              - TRACE
              - DEBUG
              - INFO
              - WARN
              - ERROR
              - FATAL
        oneOf:
          - required:
              - logGroupId
          - required:
              - folderId
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Bus/create.md
---

# EventRouter Service, REST: Bus.Create

Creates a bus in the specified folder.

## HTTP request

```
POST https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/buses
```

## Body parameters {#yandex.cloud.serverless.eventrouter.v1.CreateBusRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "deletionProtection": "boolean",
  "loggingEnabled": "boolean",
  "logOptions": {
    // Includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields
    "minLevel": "string"
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a bus in. ||
|| name | **string**

Name of the bus. ||
|| description | **string**

Description of the bus. ||
|| labels | **object** (map<**string**, **string**>)

Labels for the bus. ||
|| deletionProtection | **boolean**

Flag that disallow deletion of the bus. ||
|| loggingEnabled | **boolean**

Is logging from the bus enabled. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.eventrouter.v1.LogOptions)**

Options for logging from the bus. ||
|#

## LogOptions {#yandex.cloud.serverless.eventrouter.v1.LogOptions}

#|
||Field | Description ||
|| logGroupId | **string**

Entry will be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry will be written to default log group for specified folder.

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
    "busId": "string",
    "folderId": "string"
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
    "cloudId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "deletionProtection": "boolean",
    "status": "string",
    "loggingEnabled": "boolean",
    "logOptions": {
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "minLevel": "string"
    }
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
|| metadata | **[CreateBusMetadata](#yandex.cloud.serverless.eventrouter.v1.CreateBusMetadata)**

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
|| response | **[Bus](#yandex.cloud.serverless.eventrouter.v1.Bus)**

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

## CreateBusMetadata {#yandex.cloud.serverless.eventrouter.v1.CreateBusMetadata}

#|
||Field | Description ||
|| busId | **string**

ID of the bus that is being created. ||
|| folderId | **string**

ID of the folder that the bus is being created in. ||
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

## Bus {#yandex.cloud.serverless.eventrouter.v1.Bus}

#|
||Field | Description ||
|| id | **string**

ID of the bus. ||
|| folderId | **string**

ID of the folder that the bus belongs to. ||
|| cloudId | **string**

ID of the cloud that the bus resides in. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the bus. ||
|| description | **string**

Description of the bus. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| deletionProtection | **boolean**

Deletion protection. ||
|| status | **enum** (Status)

Status of the bus.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `ACTIVE`
- `DELETING` ||
|| loggingEnabled | **boolean**

Is logging from the bus enabled. ||
|| logOptions | **[LogOptions](#yandex.cloud.serverless.eventrouter.v1.LogOptions2)**

Options for logging from the bus. ||
|#

## LogOptions {#yandex.cloud.serverless.eventrouter.v1.LogOptions2}

#|
||Field | Description ||
|| logGroupId | **string**

Entry will be written to log group resolved by ID.

Includes only one of the fields `logGroupId`, `folderId`.

Log entries destination. ||
|| folderId | **string**

Entry will be written to default log group for specified folder.

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