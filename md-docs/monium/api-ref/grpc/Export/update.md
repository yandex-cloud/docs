# Cloud Logging Service, gRPC: ExportService.Update

Updates the specified export.

## gRPC request

**rpc Update ([UpdateExportRequest](#yandex.cloud.logging.v1.UpdateExportRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateExportRequest {#yandex.cloud.logging.v1.UpdateExportRequest}

```json
{
  "export_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
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
|| export_id | **string**

Required field. ID of the export to update.
To get a export ID make a [ExportService.List](../../../../logging/api-ref/grpc/Export/list.md#List) request.

The maximum string length in characters is 64. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the function should be updated. ||
|| name | **string**

New name of the export.
The name must be unique within the folder.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| description | **string**

New Description of the export.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

New export labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| group_id | **string**

Required field. New logging Group ID logs exported from

The maximum string length in characters is 64. ||
|| sink_id | **string**

Required field. New logging Sink ID logs exported to

The maximum string length in characters is 64. ||
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams)**

Required field. New parameters for logs filtration ||
|#

## ExportParams {#yandex.cloud.logging.v1.ExportParams}

#|
||Field | Description ||
|| resource_types[] | **string**

The maximum string length in characters for each value is 63. The maximum number of elements is 100. ||
|| resource_ids[] | **string**

The maximum string length in characters for each value is 63. The maximum number of elements is 100. ||
|| stream_names[] | **string**

The maximum string length in characters for each value is 63. The maximum number of elements is 100. ||
|| levels[] | enum **Level**

The maximum number of elements is 10.

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
|| filter | **string**

The maximum string length in characters is 1000. ||
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

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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