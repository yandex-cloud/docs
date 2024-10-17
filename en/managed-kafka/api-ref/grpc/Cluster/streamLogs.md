---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Cluster/streamLogs.md
---

# Managed Service for Apache Kafka® API, gRPC: ClusterService.StreamLogs {#StreamLogs}

Same as [ListLogs](/docs/managed-kafka/api-ref/grpc/Cluster/listLogs#ListLogs) but using server-side streaming. Also allows for `tail -f` semantics.

## gRPC request

**rpc StreamLogs ([StreamClusterLogsRequest](#yandex.cloud.mdb.kafka.v1.StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#yandex.cloud.mdb.kafka.v1.StreamLogRecord))**

## StreamClusterLogsRequest {#yandex.cloud.mdb.kafka.v1.StreamClusterLogsRequest}

```json
{
  "clusterId": "string",
  "columnFilter": [
    "string"
  ],
  "fromTime": "google.protobuf.Timestamp",
  "toTime": "google.protobuf.Timestamp",
  "recordToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| columnFilter[] | **string**

Columns from logs table to get in the response.

If no columns are specified, full log records are returned. ||
|| fromTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| toTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request.

If this field is not set, all existing logs will be sent and then the new ones as they appear.
In essence it has `tail -f` semantics. ||
|| recordToken | **string**

Record token.

Set `recordToken` to the [StreamLogRecord.nextRecordToken](#yandex.cloud.mdb.kafka.v1.StreamLogRecord) returned by a previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from next log record. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name to filter by. Currently filtering can be applied to the `hostname` field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.

Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` ||
|#

## StreamLogRecord {#yandex.cloud.mdb.kafka.v1.StreamLogRecord}

```json
{
  "record": {
    "timestamp": "google.protobuf.Timestamp",
    "message": "string"
  },
  "nextRecordToken": "string"
}
```

#|
||Field | Description ||
|| record | **[LogRecord](#yandex.cloud.mdb.kafka.v1.LogRecord)**

One of the requested log records. ||
|| nextRecordToken | **string**

This token allows you to continue streaming logs starting from the exact same record.

To continue streaming, specify value of `nextRecordToken` as value for [StreamClusterLogsRequest.recordToken](#yandex.cloud.mdb.kafka.v1.StreamClusterLogsRequest) parameter in the next StreamLogs request.

This value is interchangeable with [ListClusterLogsResponse.nextPageToken](/docs/managed-kafka/api-ref/grpc/Cluster/listLogs#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse) from ListLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.kafka.v1.LogRecord}

A single log record.

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log record timestamp. ||
|| message | **string**

Contents of the log record. ||
|#