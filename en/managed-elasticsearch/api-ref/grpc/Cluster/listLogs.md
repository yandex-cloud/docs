---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Cluster/listLogs.md
---

# Managed Service for Elasticsearch API, gRPC: ClusterService.ListLogs {#ListLogs}

Retrieves logs for the specified Elasticsearch cluster.

For more information about logs, see the [Logs](/docs/managed-elasticsearch/operations/cluster-logs) section in the documentation.

## gRPC request

**rpc ListLogs ([ListClusterLogsRequest](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse))**

## ListClusterLogsRequest {#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsRequest}

```json
{
  "clusterId": "string",
  "columnFilter": [
    "string"
  ],
  "fromTime": "google.protobuf.Timestamp",
  "toTime": "google.protobuf.Timestamp",
  "pageSize": "int64",
  "pageToken": "string",
  "alwaysNextPageToken": "bool",
  "filter": "string",
  "serviceType": "ServiceType"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster to request logs for.

To get the Elasticsearch cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/grpc/Cluster/list#List) request. ||
|| columnFilter[] | **string**

Columns from the logs table to request.

If no columns are specified, full log records are returned. ||
|| fromTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| toTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `page_token` to the [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse) returned by the previous list request. ||
|| alwaysNextPageToken | **bool**

The flag that defines behavior of providing the next page token.

If this flag is set to `true`, this API method will always return [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse), even if current page is empty. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name to filter by. Currently filtering can be applied to the `hostname` field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-63 characters long and match the regular expression `[a-z0-9.-]{1,61}`.

Example of a filter: `message.hostname='node1.db.cloud.yandex.net'` ||
|| serviceType | enum **ServiceType**

Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`
- `ELASTICSEARCH`
- `KIBANA` ||
|#

## ListClusterLogsResponse {#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsResponse}

```json
{
  "logs": [
    {
      "timestamp": "google.protobuf.Timestamp",
      "message": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| logs[] | **[LogRecord](#yandex.cloud.mdb.elasticsearch.v1.LogRecord)**

Requested log records. ||
|| nextPageToken | **string**

Token that allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterLogsRequest.pageSize](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsRequest), use `next_page_token` as the value for the [ListClusterLogsRequest.pageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterLogsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results.

This value is interchangeable with [StreamLogRecord.nextRecordToken](/docs/managed-elasticsearch/api-ref/grpc/Cluster/streamLogs#yandex.cloud.mdb.elasticsearch.v1.StreamLogRecord) from StreamLogs method. ||
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