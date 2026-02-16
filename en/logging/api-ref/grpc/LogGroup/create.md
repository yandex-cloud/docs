---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/LogGroup/create.md
---

# Cloud Logging Service, gRPC: LogGroupService.Create

Creates a log group in the specified folder.

## gRPC request

**rpc Create ([CreateLogGroupRequest](#yandex.cloud.logging.v1.CreateLogGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateLogGroupRequest {#yandex.cloud.logging.v1.CreateLogGroupRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "retention_period": "google.protobuf.Duration",
  "data_stream": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a log group in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the log group.
The name must be unique within the folder. ||
|| description | **string**

Description of the log group. ||
|| labels | **object** (map<**string**, **string**>)

Log group labels as `key:value` pairs. ||
|| retention_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Log group entry retention period.

Entries will be present in group during this period.
If specified, must be non-negative.
Empty or zero value is treated as no limit. ||
|| data_stream | **string**

If specified, all log records will be written to this data stream ||
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
    "labels": "map<string, string>",
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
|| metadata | **[CreateLogGroupMetadata](#yandex.cloud.logging.v1.CreateLogGroupMetadata)**

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

## CreateLogGroupMetadata {#yandex.cloud.logging.v1.CreateLogGroupMetadata}

#|
||Field | Description ||
|| log_group_id | **string**

ID of the log group being created. ||
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
|| labels | **object** (map<**string**, **string**>)

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