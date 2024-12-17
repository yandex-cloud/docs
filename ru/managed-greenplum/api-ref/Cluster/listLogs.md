---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/Cluster/listLogs.md
---

# Managed Service for Greenplum® API, REST: Cluster.ListLogs

Retrieves logs for the specified Greenplum® cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}:logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum® cluster to request logs for.

To get the Greenplum® cluster ID, use a [ClusterService.List](/docs/managed-greenplum/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.greenplum.v1.ListClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from log table to request.
If no columns are specified, entire log records are returned. ||
|| serviceType | **enum** (ServiceType)

Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`: Type is not specified.
- `GREENPLUM`: Greenplum® activity logs.
- `GREENPLUM_POOLER`: Greenplum® pooler logs.
- `GREENPLUM_PXF`: Greenplum® PXF service logs. ||
|| fromTime | **string** (date-time)

Start timestamp for the logs request.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toTime | **string** (date-time)

End timestamp for the logs request.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse) returned by the previous list request. ||
|| alwaysNextPageToken | **boolean**

The service always returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse), even if the current page is empty. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:

1. A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname], [LogRecord.logs.message.error_severity] (for `GREENPLUM` service) and [LogRecord.logs.message.level] (for `GREENPLUM_POOLER` service) fields.

2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.

3. A value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`.

Examples of a filter:
* `message.hostname='node1.db.cloud.yandex.net'`;
* `message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`. ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse}

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
|| logs[] | **[LogRecord](#yandex.cloud.mdb.greenplum.v1.LogRecord)**

Requested log records. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterLogsRequest.pageSize](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsRequest), use the `nextPageToken` as the value for the [ListClusterLogsRequest.pageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsRequest) query parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results.

This value is interchangeable with the [StreamLogRecord.nextRecordToken](/docs/managed-greenplum/api-ref/Cluster/streamLogs#yandex.cloud.mdb.greenplum.v1.StreamLogRecord) from [StreamLogs](/docs/managed-greenplum/api-ref/Cluster/streamLogs#StreamLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.greenplum.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **string** (date-time)

Time when the log was recorded.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#