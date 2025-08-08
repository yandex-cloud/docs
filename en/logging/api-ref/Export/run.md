---
editable: false
apiPlayground:
  - url: https://logging.{{ api-host }}/logging/v1/run-export
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        groupId:
          description: |-
            **string**
            Required field. 
          type: string
        sinkId:
          description: |-
            **string**
            Required field. 
          type: string
        params:
          description: |-
            **[ExportParams](/docs/logging/api-ref/Export/run#yandex.cloud.logging.v1.ExportParams)**
            Required field. 
          $ref: '#/definitions/ExportParams'
        resultFilename:
          description: |-
            **string**
            Required field. 
          type: string
        since:
          description: |-
            **string** (date-time)
            Required field. String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
        until:
          description: |-
            **string** (date-time)
            Required field. String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
      required:
        - groupId
        - sinkId
        - params
        - resultFilename
        - since
        - until
      additionalProperties: false
    definitions:
      ExportParams:
        type: object
        properties:
          resourceTypes:
            description: '**string**'
            type: array
            items:
              type: string
          resourceIds:
            description: '**string**'
            type: array
            items:
              type: string
          streamNames:
            description: '**string**'
            type: array
            items:
              type: string
          levels:
            description: |-
              **enum** (Level)
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
            type: array
            items:
              type: string
              enum:
                - LEVEL_UNSPECIFIED
                - TRACE
                - DEBUG
                - INFO
                - WARN
                - ERROR
                - FATAL
          filter:
            description: '**string**'
            type: string
sourcePath: en/_api-ref/logging/v1/api-ref/Export/run.md
---

# Cloud Logging Service, REST: Export.Run

Run new logs export from log group to sink

## HTTP request

```
POST https://logging.{{ api-host }}/logging/v1/run-export
```

## Body parameters {#yandex.cloud.logging.v1.RunExportRequest}

```json
{
  "groupId": "string",
  "sinkId": "string",
  "params": {
    "resourceTypes": [
      "string"
    ],
    "resourceIds": [
      "string"
    ],
    "streamNames": [
      "string"
    ],
    "levels": [
      "string"
    ],
    "filter": "string"
  },
  "resultFilename": "string",
  "since": "string",
  "until": "string"
}
```

#|
||Field | Description ||
|| groupId | **string**

Required field.  ||
|| sinkId | **string**

Required field.  ||
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams)**

Required field.  ||
|| resultFilename | **string**

Required field.  ||
|| since | **string** (date-time)

Required field. String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| until | **string** (date-time)

Required field. String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## ExportParams {#yandex.cloud.logging.v1.ExportParams}

#|
||Field | Description ||
|| resourceTypes[] | **string** ||
|| resourceIds[] | **string** ||
|| streamNames[] | **string** ||
|| levels[] | **enum** (Level)

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
|| filter | **string** ||
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
    "groupId": "string",
    "sinkId": "string",
    "resultFilename": "string"
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
    "groupId": "string",
    "sinkId": "string",
    "params": {
      "resourceTypes": [
        "string"
      ],
      "resourceIds": [
        "string"
      ],
      "streamNames": [
        "string"
      ],
      "levels": [
        "string"
      ],
      "filter": "string"
    },
    "resultFilename": "string",
    "since": "string",
    "until": "string"
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
|| metadata | **[RunExportMetadata](#yandex.cloud.logging.v1.RunExportMetadata)**

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
|| response | **[RunExportDetails](#yandex.cloud.logging.v1.RunExportDetails)**

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

## RunExportMetadata {#yandex.cloud.logging.v1.RunExportMetadata}

#|
||Field | Description ||
|| groupId | **string** ||
|| sinkId | **string** ||
|| resultFilename | **string** ||
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

## RunExportDetails {#yandex.cloud.logging.v1.RunExportDetails}

#|
||Field | Description ||
|| groupId | **string** ||
|| sinkId | **string** ||
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams2)** ||
|| resultFilename | **string** ||
|| since | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| until | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## ExportParams {#yandex.cloud.logging.v1.ExportParams2}

#|
||Field | Description ||
|| resourceTypes[] | **string** ||
|| resourceIds[] | **string** ||
|| streamNames[] | **string** ||
|| levels[] | **enum** (Level)

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
|| filter | **string** ||
|#