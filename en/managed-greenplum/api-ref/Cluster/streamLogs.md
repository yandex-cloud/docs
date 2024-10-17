---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/Cluster/streamLogs.md
---

# Managed Service for Greenplum® API, REST: Cluster.StreamLogs {#StreamLogs}

Same as [ListLogs](/docs/managed-greenplum/api-ref/Cluster/listLogs#ListLogs) but using server-side streaming. Also allows for `tail -f` semantics.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}:stream_logs
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum® cluster. ||
|#

## Query parameters {#yandex.cloud.mdb.greenplum.v1.StreamClusterLogsRequest}

#|
||Field | Description ||
|| columnFilter[] | **string**

Columns from log table to get in the response.
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

If this field is not set, all existing logs are sent as well as the new ones as they appear.

In essence it has `tail -f` semantics.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| recordToken | **string**

Record token. Set `recordToken` to the [StreamLogs.nextRecordToken](#yandex.cloud.mdb.greenplum.v1.StreamLogRecord) returned by the previous [StreamLogs](#StreamLogs) request to start streaming from the next log record. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:

1. A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname], [LogRecord.logs.message.error_severity] (for GREENPLUM service), [LogRecord.logs.message.level] (for POOLER service) fields.

2. An `=` operator.

3. A value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`.

Examples of a filter:

* `message.hostname='node1.db.cloud.yandex.net'`;
* `message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`. ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.StreamLogRecord}

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

#|
||Field | Description ||
|| record | **[LogRecord](#yandex.cloud.mdb.greenplum.v1.LogRecord)**

One of the requested log records. ||
|| nextRecordToken | **string**

This token allows you to continue streaming logs starting from the exact same record.

To do that, specify value of `nextRecordToken` as the value for [StreamLogs.recordToken](#yandex.cloud.mdb.greenplum.v1.StreamClusterLogsRequest) parameter in the next [StreamLogs](#StreamLogs) request.

This value is interchangeable with [ListLogs.nextPageToken](/docs/managed-greenplum/api-ref/Backup/list#yandex.cloud.mdb.greenplum.v1.ListBackupsResponse) from [ListLogs](/docs/managed-greenplum/api-ref/Cluster/listLogs#ListLogs) method. ||
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
|| message | **string**

Contents of the log record. ||
|#