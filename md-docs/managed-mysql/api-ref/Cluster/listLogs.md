[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for MySQL®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Cluster](index.md) > ListLogs

# Managed Service for MySQL API, REST: Cluster.ListLogs

Retrieves logs for a cluster.
Alternatively, logs can be streamed using [StreamLogs](streamLogs.md#StreamLogs).

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}:logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to request logs for.
To get this ID, make a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.mdb.mysql.v1.ListClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from the logs table to request.
If no columns are specified, complete log records are returned. ||
|| serviceType | **enum** (ServiceType)

The log type.

- `MYSQL_ERROR`: MySQL error log.
- `MYSQL_GENERAL`: MySQL general query log.
- `MYSQL_SLOW_QUERY`: MySQL slow query log.
- `MYSQL_AUDIT`: MySQL audit log. ||
|| fromTime | **string** (date-time)

Start timestamp for the logs request.
The logs in the response will be within `fromTime` to `toTime` range.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toTime | **string** (date-time)

End timestamp for the logs request.
The logs in the response will be within `fromTime` to `toTime` range.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.
If the number of available results is larger than `pageSize`, the API returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListLogs](#ListLogs) requests.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token that can be used to iterate through multiple pages of results.
To get the next page of results, set `pageToken` to the [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) returned by the previous [ClusterService.ListLogs](#ListLogs) request.

The maximum string length in characters is 100. ||
|| alwaysNextPageToken | **boolean**

Option that controls the behavior of result pagination.
If it is set to `true`, then [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) will always be returned, even if the current page is empty. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse}

**HTTP Code: 200 - OK**

```json
{
  "logs": [
    {
      "timestamp": "string",
      "message": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| logs[] | **[LogRecord](#yandex.cloud.mdb.mysql.v1.LogRecord)**

Requested log records. ||
|| nextPageToken | **string**

The token that can be used to get the next page of results.
If the number of results is larger than [ListClusterLogsRequest.pageSize](#yandex.cloud.mdb.mysql.v1.ListClusterLogsRequest), use the `nextPageToken` as the value for the [ListClusterLogsRequest.pageToken](#yandex.cloud.mdb.mysql.v1.ListClusterLogsRequest) in the subsequent [ClusterService.ListLogs](#ListLogs) request to iterate through multiple pages of results.
Each of the subsequent [ClusterService.ListLogs](#ListLogs) requests should use the `nextPageToken` value returned by the previous request to continue paging through the results.
This value is interchangeable with [StreamLogRecord.nextRecordToken](streamLogs.md#yandex.cloud.mdb.mysql.v1.StreamLogRecord) from [ClusterService.StreamLogs](streamLogs.md#StreamLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.mysql.v1.LogRecord}

A single log record.

#|
||Field | Description ||
|| timestamp | **string** (date-time)

Timestamp of the log record.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#