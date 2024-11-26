---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/LogGroup/stats.md
---

# Cloud Logging Service, REST: LogGroup.Stats

Returns stats for the specified log group.

## HTTP request

```
GET https://logging.{{ api-host }}/logging/v1/logGroups/{logGroupId}/stats
```

## Path parameters

#|
||Field | Description ||
|| logGroupId | **string**

Required field. ID of the log group to return stats for.

To get a log group ID make a [LogGroupService.List](/docs/logging/api-ref/LogGroup/list#List) request. ||
|#

## Response {#yandex.cloud.logging.v1.GetLogGroupStatsResponse}

**HTTP Code: 200 - OK**

```json
{
  "logGroupId": "string",
  "bytes": "string",
  "records": "string"
}
```

#|
||Field | Description ||
|| logGroupId | **string**

Log group ID the stats are returned for. ||
|| bytes | **string** (int64)

Size of data in log group in bytes. ||
|| records | **string** (int64)

Amount of records in log group. ||
|#