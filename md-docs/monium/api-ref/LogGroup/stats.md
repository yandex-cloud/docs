[Документация Yandex Cloud](../../../index.md) > [Monium](../../index.md) > Справочник API > Логи > [REST (англ.)](../index.md) > [LogGroup](index.md) > Stats

# Cloud Logging Service, REST: LogGroup.Stats

Returns stats for the specified log group.

## HTTP request

```
GET https://logging.api.cloud.yandex.net/logging/v1/logGroups/{logGroupId}/stats
```

## Path parameters

#|
||Field | Description ||
|| logGroupId | **string**

Required field. ID of the log group to return stats for.
To get a log group ID make a [LogGroupService.List](../../../logging/api-ref/LogGroup/list.md#List) request.

The maximum string length in characters is 64. ||
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