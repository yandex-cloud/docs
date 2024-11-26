---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Cluster/streamLogs.md
---

# Managed Service for Elasticsearch API, gRPC: ClusterService.StreamLogs

Same as [ListLogs](/docs/managed-elasticsearch/api-ref/grpc/Cluster/listLogs#ListLogs) but using server-side streaming. Also supports `tail -f` semantics.

## gRPC request

**rpc StreamLogs ([StreamClusterLogsRequest](#yandex.cloud.mdb.elasticsearch.v1.StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#yandex.cloud.mdb.elasticsearch.v1.StreamLogRecord))**

## StreamClusterLogsRequest {#yandex.cloud.mdb.elasticsearch.v1.StreamClusterLogsRequest}

```json
{
  "cluster_id": "string",
  "column_filter": [
    "string"
  ],
  "from_time": "google.protobuf.Timestamp",
  "to_time": "google.protobuf.Timestamp",
  "record_token": "string",
  "filter": "string",
  "service_type": "ServiceType"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Elasticsearch cluster.

To get the Elasticsearch cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/grpc/Cluster/list#List) request. ||
|| column_filter[] | **string**

Columns from logs table to get in the response.

If no columns are specified, full log records are returned. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request.

If this field is not set, all existing logs will be sent and then the new ones asthey appear.
In essence it has `tail -f` semantics. ||
|| record_token | **string**

Record token.

Set `record_token` to the [StreamLogRecord.next_record_token](#yandex.cloud.mdb.elasticsearch.v1.StreamLogRecord) returned by a previous [ClusterService.StreamLogs](#StreamLogs) request to start streaming from next log record. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name to filter by. Currently filtering can be applied to the `hostname` field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.

Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` ||
|| service_type | enum **ServiceType**

Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`
- `ELASTICSEARCH`
- `KIBANA` ||
|#

## StreamLogRecord {#yandex.cloud.mdb.elasticsearch.v1.StreamLogRecord}

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
|| record | **[LogRecord](#yandex.cloud.mdb.elasticsearch.v1.LogRecord)**

One of the requested log records. ||
|| next_record_token | **string**

This token allows you to continue streaming logs starting from the exact same record.

To continue streaming, specify value of `next_record_token` as value for [StreamClusterLogsRequest.record_token](#yandex.cloud.mdb.elasticsearch.v1.StreamClusterLogsRequest) parameter in the next StreamLogs request.

This value is interchangeable with [ListClusterLogsResponse.next_page_token](/docs/managed-elasticsearch/api-ref/grpc/Cluster/listLogs#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse) from ListLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.elasticsearch.v1.LogRecord}

A single log record.

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log record timestamp. ||
|| message | **string**

Contents of the log record. ||
|#