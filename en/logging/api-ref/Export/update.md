---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Export/update.md
---

# Cloud Logging Service, REST: Export.Update

Updates the specified export.

## HTTP request

```
PATCH https://logging.{{ api-host }}/logging/v1/exports/{exportId}
```

## Path parameters

#|
||Field | Description ||
|| exportId | **string**

Required field. ID of the export to update.

To get a export ID make a [ExportService.List](/docs/logging/api-ref/Export/list#List) request. ||
|#

## Body parameters {#yandex.cloud.logging.v1.UpdateExportRequest}

```json
{
  "updateMask": "object",
  "name": "string",
  "description": "string",
  "labels": "object",
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
  }
}
```

#|
||Field | Description ||
|| updateMask | **object** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name of the export.
The name must be unique within the folder. ||
|| description | **string**

New Description of the export. ||
|| labels | **object** (map<**string**, **string**>)

New export labels as `key:value` pairs. ||
|| groupId | **string**

Required field. New logging Group ID logs exported from ||
|| sinkId | **string**

Required field. New logging Sink ID logs exported to ||
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams)**

Required field. New parameters for logs filtration ||
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
    "exportId": "string"
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
|| metadata | **[UpdateExportMetadata](#yandex.cloud.logging.v1.UpdateExportMetadata)**

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
|| response | **[Export](#yandex.cloud.logging.v1.Export)**

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

## UpdateExportMetadata {#yandex.cloud.logging.v1.UpdateExportMetadata}

#|
||Field | Description ||
|| exportId | **string**

ID of the export being updated. ||
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

## Export {#yandex.cloud.logging.v1.Export}

#|
||Field | Description ||
|| id | **string**

Export ID. ||
|| folderId | **string**

Export folder ID. ||
|| cloudId | **string**

Export cloud ID. ||
|| createdAt | **string** (date-time)

Export creation time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Export name. ||
|| description | **string**

Export description. ||
|| labels | **object** (map<**string**, **string**>)

Export lables. ||
|| groupId | **string**

Group logs are exported from. ||
|| sinkId | **string**

Sink logs are exported to. ||
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams2)**

Parameters of logs filtration. ||
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