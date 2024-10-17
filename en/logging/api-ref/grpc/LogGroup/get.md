---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/LogGroup/get.md
---

# Cloud Logging Service, gRPC: LogGroupService.Get {#Get}

Returns the specified log group.

To get the list of all available log groups, make a [List](/docs/logging/api-ref/grpc/LogGroup/list#List) request.

## gRPC request

**rpc Get ([GetLogGroupRequest](#yandex.cloud.logging.v1.GetLogGroupRequest)) returns ([LogGroup](#yandex.cloud.logging.v1.LogGroup))**

## GetLogGroupRequest {#yandex.cloud.logging.v1.GetLogGroupRequest}

```json
{
  "logGroupId": "string"
}
```

#|
||Field | Description ||
|| logGroupId | **string**

Required field. ID of the log group to return.

To get a log group ID make a [LogGroupService.List](/docs/logging/api-ref/grpc/LogGroup/list#List) request. ||
|#

## LogGroup {#yandex.cloud.logging.v1.LogGroup}

```json
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "status": "Status",
  "retentionPeriod": "google.protobuf.Duration",
  "dataStream": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Log group ID. ||
|| folderId | **string**

Log group folder ID. ||
|| cloudId | **string**

Log group cloud ID. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| retentionPeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Log group entry retention period.

Entries will be present in group during this period. ||
|| dataStream | **string**

Data stream name ||
|#