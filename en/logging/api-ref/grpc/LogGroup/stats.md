---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/LogGroup/stats.md
---

# Cloud Logging Service, gRPC: LogGroupService.Stats

Returns stats for the specified log group.

## gRPC request

**rpc Stats ([GetLogGroupStatsRequest](#yandex.cloud.logging.v1.GetLogGroupStatsRequest)) returns ([GetLogGroupStatsResponse](#yandex.cloud.logging.v1.GetLogGroupStatsResponse))**

## GetLogGroupStatsRequest {#yandex.cloud.logging.v1.GetLogGroupStatsRequest}

```json
{
  "log_group_id": "string"
}
```

#|
||Field | Description ||
|| log_group_id | **string**

Required field. ID of the log group to return stats for.

To get a log group ID make a [LogGroupService.List](/docs/logging/api-ref/grpc/LogGroup/list#List) request. ||
|#

## GetLogGroupStatsResponse {#yandex.cloud.logging.v1.GetLogGroupStatsResponse}

```json
{
  "log_group_id": "string",
  "bytes": "int64",
  "records": "int64"
}
```

#|
||Field | Description ||
|| log_group_id | **string**

Log group ID the stats are returned for. ||
|| bytes | **int64**

Size of data in log group in bytes. ||
|| records | **int64**

Amount of records in log group. ||
|#