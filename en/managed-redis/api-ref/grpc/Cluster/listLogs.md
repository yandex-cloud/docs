---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/Cluster/listLogs.md
---

# Managed Service for Redis API, gRPC: ClusterService.ListLogs {#ListLogs}

Retrieves logs for the specified Redis cluster.

## gRPC request

**rpc ListLogs ([ListClusterLogsRequest](#yandex.cloud.mdb.redis.v1.ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#yandex.cloud.mdb.redis.v1.ListClusterLogsResponse))**

## ListClusterLogsRequest {#yandex.cloud.mdb.redis.v1.ListClusterLogsRequest}

```json
{
  "clusterId": "string",
  "columnFilter": [
    "string"
  ],
  "serviceType": "ServiceType",
  "fromTime": "google.protobuf.Timestamp",
  "toTime": "google.protobuf.Timestamp",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster to request logs for.
To get the Redis cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request. ||
|| columnFilter[] | **string**

Columns from the logs table to request.
If no columns are specified, entire log records are returned. ||
|| serviceType | enum **ServiceType**

- `SERVICE_TYPE_UNSPECIFIED`
- `REDIS`: Logs of Redis activity. ||
|| fromTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| toTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListClusterLogsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListClusterLogsResponse) returned by the previous list request. ||
|#

## ListClusterLogsResponse {#yandex.cloud.mdb.redis.v1.ListClusterLogsResponse}

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
|| logs[] | **[LogRecord](#yandex.cloud.mdb.redis.v1.LogRecord)**

Requested log records. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterLogsRequest.pageSize](#yandex.cloud.mdb.redis.v1.ListClusterLogsRequest), use the `nextPageToken` as the value
for the [ListClusterLogsRequest.pageToken](#yandex.cloud.mdb.redis.v1.ListClusterLogsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results.
This value is interchangeable with `next_record_token` from StreamLogs method. ||
|#

## LogRecord {#yandex.cloud.mdb.redis.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log record timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| message | **string**

Contents of the log record. ||
|#