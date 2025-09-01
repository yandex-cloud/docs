---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/Cluster/streamLogs.md
---

# Managed Service for MongoDB API, gRPC: ClusterService.StreamLogs

Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics.

## gRPC request

**rpc StreamLogs ([StreamClusterLogsRequest](#yandex.cloud.mdb.mongodb.v1.StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#yandex.cloud.mdb.mongodb.v1.StreamLogRecord))**

## StreamClusterLogsRequest {#yandex.cloud.mdb.mongodb.v1.StreamClusterLogsRequest}

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

Required field. Required. ID of the MongoDB cluster. ||
|| column_filter[] | **string**

Columns from logs table to get in the response. ||
|| service_type | enum **ServiceType**

- `SERVICE_TYPE_UNSPECIFIED`
- `MONGOD`: Logs of MongoDB activity.
- `MONGOS`
- `MONGOCFG`
- `AUDIT`: MongoDB Enterprise audit logs ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request.
If this field is not set, all existing logs will be sent and then the new ones as
they appear. In essence it has 'tail -f' semantics. ||
|| record_token | **string**

Record token. Set `record_token` to the `next_record_token` returned by a previous StreamLogs
request to start streaming from next log record. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname], [LogRecord.logs.message.severity] fields.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`.
Examples of a filter: `message.hostname='node1.db.cloud.yandex.net'`, `message.severity IN ('E', 'F')` ||
|#

## StreamLogRecord {#yandex.cloud.mdb.mongodb.v1.StreamLogRecord}

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
|| record | **[LogRecord](#yandex.cloud.mdb.mongodb.v1.LogRecord)**

One of the requested log records. ||
|| next_record_token | **string**

This token allows you to continue streaming logs starting from the exact
same record. To continue streaming, specify value of `next_record_token`
as value for `record_token` parameter in the next StreamLogs request.
This value is interchangeable with `next_page_token` from ListLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.mongodb.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#