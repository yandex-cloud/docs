---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/listLogs.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.ListLogs

Retrieves logs for the specified OpenSearch cluster.

## gRPC request

**rpc ListLogs ([ListClusterLogsRequest](#yandex.cloud.mdb.opensearch.v1.ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse))**

## ListClusterLogsRequest {#yandex.cloud.mdb.opensearch.v1.ListClusterLogsRequest}

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
  "filter": "string",
  "service_type": "ServiceType"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the OpenSearch cluster to request logs for.

To get the OpenSearch cluster ID use a [ClusterService.List](/docs/managed-opensearch/api-ref/grpc/Cluster/list#List) request. ||
|| column_filter[] | **string**

Columns from log table to request.
If no columns are specified, entire log records are returned. ||
|| from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse) returned by the previous list request. ||
|| always_next_page_token | **bool**

The service always returns a [ListClusterLogsResponse.next_page_token](#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse), even if the current page is empty. ||
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

## ListClusterLogsResponse {#yandex.cloud.mdb.opensearch.v1.ListClusterLogsResponse}

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
|| logs[] | **[LogRecord](#yandex.cloud.mdb.opensearch.v1.LogRecord)**

Requested log records. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterLogsRequest.page_size](#yandex.cloud.mdb.opensearch.v1.ListClusterLogsRequest), use the `next_page_token` as the value
for the [ListClusterLogsRequest.page_token](#yandex.cloud.mdb.opensearch.v1.ListClusterLogsRequest) query parameter in the next list request.

Each subsequent list request has its own `next_page_token` to continue paging through the results.

This value is interchangeable with the [StreamLogRecord.next_record_token](/docs/managed-opensearch/api-ref/grpc/Cluster/streamLogs#yandex.cloud.mdb.opensearch.v1.StreamLogRecord) from [StreamLogs](/docs/managed-opensearch/api-ref/grpc/Cluster/streamLogs#StreamLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.opensearch.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the log was recorded. ||
|| message | **object** (map<**string**, **string**>)

Contents of the log record. ||
|#