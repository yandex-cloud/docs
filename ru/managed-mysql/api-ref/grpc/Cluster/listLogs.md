---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/Cluster/listLogs.md
---

# Managed Service for MySQL API, gRPC: ClusterService.ListLogs

Retrieves logs for a cluster.

Alternatively, logs can be streamed using [StreamLogs](/docs/managed-mysql/api-ref/grpc/Cluster/streamLogs#StreamLogs).

## gRPC request

**rpc ListLogs ([ListClusterLogsRequest](#yandex.cloud.mdb.mysql.v1.ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse))**

## ListClusterLogsRequest {#yandex.cloud.mdb.mysql.v1.ListClusterLogsRequest}

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
  "page_token": "string",
  "always_next_page_token": "bool"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to request logs for.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/grpc/Cluster/list#List) request. ||
|| column_filter[] | **string**

Columns from the logs table to request.
If no columns are specified, complete log records are returned. ||
|| service_type | enum **ServiceType**

The log type.

- `SERVICE_TYPE_UNSPECIFIED`
- `MYSQL_ERROR`: MySQL error log.
- `MYSQL_GENERAL`: MySQL general query log.
- `MYSQL_SLOW_QUERY`: MySQL slow query log.
- `MYSQL_AUDIT`: MySQL audit log. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request.
The logs in the response will be within `from_time` to `to_time` range. ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request.
The logs in the response will be within `from_time` to `to_time` range. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the API returns a [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListLogs](#ListLogs) requests. ||
|| page_token | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `page_token` to the [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) returned by the previous [ClusterService.ListLogs](#ListLogs) request. ||
|| always_next_page_token | **bool**

Option that controls the behavior of result pagination.
If it is set to `true`, then [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse) will always be returned, even if the current page is empty. ||
|#

## ListClusterLogsResponse {#yandex.cloud.mdb.mysql.v1.ListClusterLogsResponse}

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
|| logs[] | **[LogRecord](#yandex.cloud.mdb.mysql.v1.LogRecord)**

Requested log records. ||
|| next_page_token | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListClusterLogsRequest.page_size](#yandex.cloud.mdb.mysql.v1.ListClusterLogsRequest), use the `next_page_token` as the value for the [ListClusterLogsRequest.page_token](#yandex.cloud.mdb.mysql.v1.ListClusterLogsRequest) in the subsequent [ClusterService.ListLogs](#ListLogs) request to iterate through multiple pages of results.

Each of the subsequent [ClusterService.ListLogs](#ListLogs) requests should use the `next_page_token` value returned by the previous request to continue paging through the results.

This value is interchangeable with [StreamLogRecord.next_record_token](/docs/managed-mysql/api-ref/grpc/Cluster/streamLogs#yandex.cloud.mdb.mysql.v1.StreamLogRecord) from [ClusterService.StreamLogs](/docs/managed-mysql/api-ref/grpc/Cluster/streamLogs#StreamLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.mysql.v1.LogRecord}

A single log record.

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the log record. ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#