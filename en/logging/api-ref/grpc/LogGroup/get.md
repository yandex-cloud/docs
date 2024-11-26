---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/LogGroup/get.md
---

# Cloud Logging Service, gRPC: LogGroupService.Get

Returns the specified log group.

To get the list of all available log groups, make a [List](/docs/logging/api-ref/grpc/LogGroup/list#List) request.

## gRPC request

**rpc Get ([GetLogGroupRequest](#yandex.cloud.logging.v1.GetLogGroupRequest)) returns ([LogGroup](#yandex.cloud.logging.v1.LogGroup))**

## GetLogGroupRequest {#yandex.cloud.logging.v1.GetLogGroupRequest}

```json
{
  "log_group_id": "string"
}
```

#|
||Field | Description ||
|| log_group_id | **string**

Required field. ID of the log group to return.

To get a log group ID make a [LogGroupService.List](/docs/logging/api-ref/grpc/LogGroup/list#List) request. ||
|#

## LogGroup {#yandex.cloud.logging.v1.LogGroup}

```json
{
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
```

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