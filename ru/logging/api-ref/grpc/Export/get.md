---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/Export/get.md
---

# Cloud Logging Service, gRPC: ExportService.Get {#Get}

Returns the specified export.

To get the list of all available exports, make a [List](/docs/logging/api-ref/grpc/Export/list#List) request.

## gRPC request

**rpc Get ([GetExportRequest](#yandex.cloud.logging.v1.GetExportRequest)) returns ([Export](#yandex.cloud.logging.v1.Export))**

## GetExportRequest {#yandex.cloud.logging.v1.GetExportRequest}

```json
{
  "exportId": "string"
}
```

#|
||Field | Description ||
|| exportId | **string**

Required field. ID of the export to return.

To get a export ID make a [ExportService.List](/docs/logging/api-ref/grpc/Export/list#List) request. ||
|#

## Export {#yandex.cloud.logging.v1.Export}

```json
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
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
      "Level"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Export creation time. ||
|| name | **string**

Export name. ||
|| description | **string**

Export description. ||
|| labels | **string**

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
|| levels[] | enum **Level**

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