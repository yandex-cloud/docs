---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Cluster/listLogs.md
---

# Managed Service for Apache Kafka® API, gRPC: ClusterService.ListLogs

Retrieves logs for the specified Apache Kafka® cluster.

For more information about logs, see the [Logs](/docs/managed-kafka/operations/cluster-logs) section in the documentation.

## gRPC request

**rpc ListLogs ([ListClusterLogsRequest](#yandex.cloud.mdb.kafka.v1.ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse))**

## ListClusterLogsRequest {#yandex.cloud.mdb.kafka.v1.ListClusterLogsRequest}

```json
{
  "cluster_id": "string",
  "column_filter": [
    "string"
  ],
  "from_time": "google.protobuf.Timestamp",
  "to_time": "google.protobuf.Timestamp",
  "page_size": "int64",
  "page_token": "string",
  "always_next_page_token": "bool",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Apache Kafka® cluster to request logs for.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| column_filter[] | **string**

Columns from the logs table to request.

If no columns are specified, full log records are returned. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.

To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse) returned by the previous list request. ||
|| always_next_page_token | **bool**

The flag that defines behavior of providing the next page token.

If this flag is set to `true`, this API method will always return [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse), even if current page is empty. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name to filter by. Currently filtering can be applied to the `hostname` field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`.

Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` ||
|#

## ListClusterLogsResponse {#yandex.cloud.mdb.kafka.v1.ListClusterLogsResponse}

```json
{
  "logs": [
    {
      "timestamp": "google.protobuf.Timestamp",
      "message": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| logs[] | **[LogRecord](#yandex.cloud.mdb.kafka.v1.LogRecord)**

Requested log records. ||
|| next_page_token | **string**

Token that allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterLogsRequest.page_size](#yandex.cloud.mdb.kafka.v1.ListClusterLogsRequest), use `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#yandex.cloud.mdb.kafka.v1.ListClusterLogsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results.
This value is interchangeable with [StreamLogRecord.next_record_token](/docs/managed-kafka/api-ref/grpc/Cluster/streamLogs#yandex.cloud.mdb.kafka.v1.StreamLogRecord) from StreamLogs method. ||
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