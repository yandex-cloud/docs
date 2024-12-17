---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/listLogs.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.ListLogs

Retrieves logs for the specified ClickHouse cluster.

## gRPC request

**rpc ListLogs ([ListClusterLogsRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse))**

## ListClusterLogsRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsRequest}

```json
{
  "cluster_id": "string",
  "column_filter": [
    "string"
  ],
  "service_type": "ServiceType",
  "from_time": "google.protobuf.Timestamp",
  "to_time": "google.protobuf.Timestamp",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the ClickHouse cluster to request logs for.
To get the ClickHouse cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| column_filter[] | **string**

Columns from logs table to request.
If no columns are specified, entire log records are returned. ||
|| service_type | enum **ServiceType**

Required field. Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`
- `CLICKHOUSE`: Logs of ClickHouse activity. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.  To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse)
returned by the previous list request. ||
|#

## ListClusterLogsResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsResponse}

```json
{
  "logs": [
    {
      "timestamp": "google.protobuf.Timestamp",
      "message": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| logs[] | **[LogRecord](#yandex.cloud.mdb.clickhouse.v1.LogRecord)**

Requested log records. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterLogsRequest.page_size](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsRequest), use the `next_page_token` as the value
for the [ListClusterLogsRequest.page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterLogsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results.
This value is interchangeable with the [StreamLogRecord.next_record_token](/docs/managed-clickhouse/api-ref/grpc/Cluster/streamLogs#yandex.cloud.mdb.clickhouse.v1.StreamLogRecord) from StreamLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.clickhouse.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#