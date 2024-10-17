---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Cluster/streamLogs.md
---

# Managed Service for MySQL API, REST: Cluster.StreamLogs {#StreamLogs}

Retrieves a log stream for a cluster.

This method is similar to [ListLogs](/docs/managed-mysql/api-ref/Cluster/listLogs#ListLogs), but uses server-side streaming, which allows for the `tail -f` command semantics.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}:stream_logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to stream logs for.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.mysql.v1.StreamClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from the logs table to request.
If no columns are specified, complete log records are returned. ||
|| serviceType | **enum** (ServiceType)

The log type.

- `SERVICE_TYPE_UNSPECIFIED`
- `MYSQL_ERROR`: MySQL error log.
- `MYSQL_GENERAL`: MySQL general query log.
- `MYSQL_SLOW_QUERY`: MySQL slow query log.
- `MYSQL_AUDIT`: MySQL audit log. ||
|| fromTime | **string** (date-time)

Start timestamp for the logs request.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toTime | **string** (date-time)

End timestamp for the logs request.
If this field is not set, all existing log records beginning from `fromTime` will be returned first, and then the new records will be returned as they appear.

In essence it has `tail -f` command semantics.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| recordToken | **string**

Record token that can be used to control logs streaming.

Set `recordToken` to the [StreamLogRecord.nextRecordToken](#yandex.cloud.mdb.mysql.v1.StreamLogRecord), returned by the previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from the next log record. ||
|| filter | **string**

A filter expression that selects clusters logs listed in the response.

The expression must specify:
1. The field name. Currently filtering can be applied to the [LogRecord.logs.hostname](/docs/compute/api-ref/Instance/create#yandex.cloud.compute.v1.CreateInstanceRequest) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'` ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.StreamLogRecord}

**HTTP Code: 200 - OK**

```json
{
  "record": {
    "timestamp": "string",
    "message": "string"
  },
  "nextRecordToken": "string"
}
```

A single log record in the logs stream.

#|
||Field | Description ||
|| record | **[LogRecord](#yandex.cloud.mdb.mysql.v1.LogRecord)**

One of the requested log records. ||
|| nextRecordToken | **string**

The token that can be used to continue streaming logs starting from the exact same record.
To continue streaming, specify value of `nextRecordToken` as the [StreamClusterLogsRequest.recordToken](#yandex.cloud.mdb.mysql.v1.StreamClusterLogsRequest) value in the next [ClusterService.StreamLogs](#StreamLogs) request.

This value is interchangeable with [ListClusterLogsResponse.nextPageToken](/docs/managed-mysql/api-ref/Cluster/listLogs#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) from [ClusterService.ListLogs](/docs/managed-mysql/api-ref/Cluster/listLogs#ListLogs) method. ||
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
|| message | **string**

Contents of the log record. ||
|#