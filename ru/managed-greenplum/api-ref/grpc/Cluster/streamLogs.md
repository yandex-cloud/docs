---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Cluster/streamLogs.md
---

# Managed Service for Greenplum® API, gRPC: ClusterService.StreamLogs

Same as [ListLogs](/docs/managed-greenplum/api-ref/grpc/Cluster/listLogs#ListLogs) but using server-side streaming. Also allows for `tail -f` semantics.

## gRPC request

**rpc StreamLogs ([StreamClusterLogsRequest](#yandex.cloud.mdb.greenplum.v1.StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#yandex.cloud.mdb.greenplum.v1.StreamLogRecord))**

## StreamClusterLogsRequest {#yandex.cloud.mdb.greenplum.v1.StreamClusterLogsRequest}

```json
{
  "cluster_id": "string",
  "column_filter": [
    "string"
  ],
  "service_type": "ServiceType",
  "from_time": "google.protobuf.Timestamp",
  "to_time": "google.protobuf.Timestamp",
  "record_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Greenplum® cluster. ||
|| column_filter[] | **string**

Columns from log table to get in the response.
If no columns are specified, entire log records are returned. ||
|| service_type | enum **ServiceType**

Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`: Type is not specified.
- `GREENPLUM`: Greenplum® activity logs.
- `GREENPLUM_POOLER`: Greenplum® pooler logs.
- `GREENPLUM_PXF`: Greenplum® PXF service logs. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request.

If this field is not set, all existing logs are sent as well as the new ones as they appear.

In essence it has `tail -f` semantics. ||
|| record_token | **string**

Record token. Set `record_token` to the [StreamLogs.next_record_token] returned by the previous [StreamLogs](#StreamLogs) request to start streaming from the next log record. ||
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

## StreamLogRecord {#yandex.cloud.mdb.greenplum.v1.StreamLogRecord}

```json
{
  "record": {
    "timestamp": "google.protobuf.Timestamp",
    "message": "string"
  },
  "next_record_token": "string"
}
```

#|
||Field | Description ||
|| record | **[LogRecord](#yandex.cloud.mdb.greenplum.v1.LogRecord)**

One of the requested log records. ||
|| next_record_token | **string**

This token allows you to continue streaming logs starting from the exact same record.

To do that, specify value of `next_record_token` as the value for [StreamLogs.record_token] parameter in the next [StreamLogs](#StreamLogs) request.

This value is interchangeable with [ListLogs.next_page_token] from [ListLogs](/docs/managed-greenplum/api-ref/grpc/Cluster/listLogs#ListLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.greenplum.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the log was recorded. ||
|| message | **string**

Contents of the log record. ||
|#