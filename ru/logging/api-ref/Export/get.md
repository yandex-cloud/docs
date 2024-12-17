---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Export/get.md
---

# Cloud Logging Service, REST: Export.Get

Returns the specified export.

To get the list of all available exports, make a [List](/docs/logging/api-ref/Export/list#List) request.

## HTTP request

```
GET https://logging.{{ api-host }}/logging/v1/exports/{exportId}
```

## Path parameters

#|
||Field | Description ||
|| exportId | **string**

Required field. ID of the export to return.

To get a export ID make a [ExportService.List](/docs/logging/api-ref/Export/list#List) request. ||
|#

## Response {#yandex.cloud.logging.v1.Export}

**HTTP Code: 200 - OK**

```json
{
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
```

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
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams)**

Parameters of logs filtration. ||
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