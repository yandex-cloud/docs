---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/Export/create.md
---

# Cloud Logging Service, gRPC: ExportService.Create

Creates a export in the specified folder.

## gRPC request

**rpc Create ([CreateExportRequest](#yandex.cloud.logging.v1.CreateExportRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateExportRequest {#yandex.cloud.logging.v1.CreateExportRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "group_id": "string",
  "sink_id": "string",
  "params": {
    "resource_types": [
      "string"
    ],
    "resource_ids": [
      "string"
    ],
    "stream_names": [
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
|| folder_id | **string**

Required field. ID of the folder to create a export in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the export.
The name must be unique within the folder. ||
|| description | **string**

Description of the export. ||
|| labels | **string**

Export labels as `key:value` pairs. ||
|| group_id | **string**

Required field. Logging Group ID logs exported from ||
|| sink_id | **string**

Required field. Logging Sink ID logs exported to ||
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams)**

Required field. Parameters for logs filtration ||
|#

## ExportParams {#yandex.cloud.logging.v1.ExportParams}

#|
||Field | Description ||
|| resource_types[] | **string** ||
|| resource_ids[] | **string** ||
|| stream_names[] | **string** ||
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
    "export_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "cloud_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "group_id": "string",
    "sink_id": "string",
    "params": {
      "resource_types": [
        "string"
      ],
      "resource_ids": [
        "string"
      ],
      "stream_names": [
        "string"
      ],
      "levels": [
        "Level"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateExportMetadata](#yandex.cloud.logging.v1.CreateExportMetadata)**

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

## CreateExportMetadata {#yandex.cloud.logging.v1.CreateExportMetadata}

#|
||Field | Description ||
|| export_id | **string**

ID of the export being created. ||
|#

## Export {#yandex.cloud.logging.v1.Export}

#|
||Field | Description ||
|| id | **string**

Export ID. ||
|| folder_id | **string**

Export folder ID. ||
|| cloud_id | **string**

Export cloud ID. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Export creation time. ||
|| name | **string**

Export name. ||
|| description | **string**

Export description. ||
|| labels | **string**

Export lables. ||
|| group_id | **string**

Group logs are exported from. ||
|| sink_id | **string**

Sink logs are exported to. ||
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams2)**

Parameters of logs filtration. ||
|#

## ExportParams {#yandex.cloud.logging.v1.ExportParams2}

#|
||Field | Description ||
|| resource_types[] | **string** ||
|| resource_ids[] | **string** ||
|| stream_names[] | **string** ||
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