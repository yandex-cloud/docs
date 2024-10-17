---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/Cluster/streamLogs.md
---

# Managed Service for MySQL API, gRPC: ClusterService.StreamLogs {#StreamLogs}

Retrieves a log stream for a cluster.

This method is similar to [ListLogs](/docs/managed-mysql/api-ref/grpc/Cluster/listLogs#ListLogs), but uses server-side streaming, which allows for the `tail -f` command semantics.

## gRPC request

**rpc StreamLogs ([StreamClusterLogsRequest](#yandex.cloud.mdb.mysql.v1.StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#yandex.cloud.mdb.mysql.v1.StreamLogRecord))**

## StreamClusterLogsRequest {#yandex.cloud.mdb.mysql.v1.StreamClusterLogsRequest}

```json
{
  "clusterId": "string",
  "columnFilter": [
    "string"
  ],
  "serviceType": "ServiceType",
  "fromTime": "google.protobuf.Timestamp",
  "toTime": "google.protobuf.Timestamp",
  "recordToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to stream logs for.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/grpc/Cluster/list#List) request. ||
|| columnFilter[] | **string**

Columns from the logs table to request.
If no columns are specified, complete log records are returned. ||
|| serviceType | enum **ServiceType**

The log type.

- `SERVICE_TYPE_UNSPECIFIED`
- `MYSQL_ERROR`: MySQL error log.
- `MYSQL_GENERAL`: MySQL general query log.
- `MYSQL_SLOW_QUERY`: MySQL slow query log.
- `MYSQL_AUDIT`: MySQL audit log. ||
|| fromTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| toTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request.
If this field is not set, all existing log records beginning from `fromTime` will be returned first, and then the new records will be returned as they appear.

In essence it has `tail -f` command semantics. ||
|| recordToken | **string**

Record token that can be used to control logs streaming.

Set `recordToken` to the [StreamLogRecord.nextRecordToken](#yandex.cloud.mdb.mysql.v1.StreamLogRecord), returned by the previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from the next log record. ||
|| filter | **string**

A filter expression that selects clusters logs listed in the response.

The expression must specify:
1. The field name. Currently filtering can be applied to the [LogRecord.logs.hostname](/docs/compute/api-ref/grpc/Instance/create#yandex.cloud.compute.v1.CreateInstanceRequest) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'` ||
|#

## StreamLogRecord {#yandex.cloud.mdb.mysql.v1.StreamLogRecord}

```json
{
  "record": {
    "timestamp": "google.protobuf.Timestamp",
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

This value is interchangeable with [ListClusterLogsResponse.nextPageToken](/docs/managed-mysql/api-ref/grpc/Cluster/listLogs#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) from [ClusterService.ListLogs](/docs/managed-mysql/api-ref/grpc/Cluster/listLogs#ListLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.mysql.v1.LogRecord}

A single log record.

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the log record. ||
|| message | **string**

Contents of the log record. ||
|#