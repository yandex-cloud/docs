---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/LogGroup/update.md
---

# Cloud Logging Service, gRPC: LogGroupService.Update

Updates the specified log group.

## gRPC request

**rpc Update ([UpdateLogGroupRequest](#yandex.cloud.logging.v1.UpdateLogGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateLogGroupRequest {#yandex.cloud.logging.v1.UpdateLogGroupRequest}

```json
{
  "log_group_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string",
  "retention_period": "google.protobuf.Duration",
  "data_stream": "string"
}
```

#|
||Field | Description ||
|| log_group_id | **string**

Required field. ID of the log group to update.

To get a log group ID make a [LogGroupService.List](/docs/logging/api-ref/grpc/LogGroup/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the function should be updated. ||
|| name | **string**

New name of the log group.
The name must be unique within the folder. ||
|| description | **string**

New Description of the log group. ||
|| labels | **string**

New log group labels as `key:value` pairs. ||
|| retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

New log group entry retention period.

Entries will be present in group during this period.
If specified, must be non-negative.
Empty or zero value is treated as no limit. ||
|| data_stream | **string**

If specified, log records will be written to this data stream ||
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
    "log_group_id": "string"
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
    "status": "Status",
    "retention_period": "google.protobuf.Duration",
    "data_stream": "string"
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
|| metadata | **[UpdateLogGroupMetadata](#yandex.cloud.logging.v1.UpdateLogGroupMetadata)**

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
|| response | **[LogGroup](#yandex.cloud.logging.v1.LogGroup)**

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

## UpdateLogGroupMetadata {#yandex.cloud.logging.v1.UpdateLogGroupMetadata}

#|
||Field | Description ||
|| log_group_id | **string**

ID of the log group being updated. ||
|#

## LogGroup {#yandex.cloud.logging.v1.LogGroup}

#|
||Field | Description ||
|| id | **string**

Log group ID. ||
|| folder_id | **string**

Log group folder ID. ||
|| cloud_id | **string**

Log group cloud ID. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log group creation time. ||
|| name | **string**

Log group name. ||
|| description | **string**

Log group description. ||
|| labels | **string**

Log group labels. ||
|| status | enum **Status**

Status of the log group.

- `STATUS_UNSPECIFIED`: Unknown status.

  Should never occur.
- `CREATING`: Log group is creating.
- `ACTIVE`: Log group is ready to accept messages,
- `DELETING`: Log group is being deleted.

  No messages will be accepted.
- `ERROR`: Log group is in failed state. ||
|| retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Log group entry retention period.

Entries will be present in group during this period. ||
|| data_stream | **string**

Data stream name ||
|#