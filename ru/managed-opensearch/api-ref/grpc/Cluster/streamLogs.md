---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/streamLogs.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.StreamLogs

Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.

## gRPC request

**rpc StreamLogs ([StreamClusterLogsRequest](#yandex.cloud.mdb.opensearch.v1.StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#yandex.cloud.mdb.opensearch.v1.StreamLogRecord))**

## StreamClusterLogsRequest {#yandex.cloud.mdb.opensearch.v1.StreamClusterLogsRequest}

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

Required field. ID of the OpenSearch cluster. ||
|| column_filter[] | **string**

Columns from log table to get in the response.
If no columns are specified, entire log records are returned. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request.

If this field is not set, all existing logs are sent as well as the new ones as they appear.

In essence it has `tail -f` semantics. ||
|| record_token | **string**

Record token. Set `record_token` to the `next_record_token` returned by the previous [StreamLogs](#StreamLogs)
request to start streaming from the next log record. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:

1. A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname] field.

2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.

3. A value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`.

Examples of a filter:
* `message.hostname='node1.db.cloud.yandex.net'`;
* `message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`. ||
|| service_type | enum **ServiceType**

Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`: Type is not specified.
- `OPENSEARCH`: OpenSearch logs.
- `DASHBOARDS`: Dashboards logs. ||
|#

## StreamLogRecord {#yandex.cloud.mdb.opensearch.v1.StreamLogRecord}

```json
{
  "record": {
    "timestamp": "google.protobuf.Timestamp",
    "message": "map<string, string>"
  },
  "next_record_token": "string"
}
```

#|
||Field | Description ||
|| record | **[LogRecord](#yandex.cloud.mdb.opensearch.v1.LogRecord)**

One of the requested log records. ||
|| next_record_token | **string**

This token allows you to continue streaming logs starting from the exact same record.

To do that, specify value of `next_record_token` as the value for [StreamLogs.record_token] parameter in the next [StreamLogs](#StreamLogs) request.

This value is interchangeable with [ListLogs.next_page_token] from [ListLogs](/docs/managed-opensearch/api-ref/grpc/Cluster/listLogs#ListLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.opensearch.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the log was recorded. ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#