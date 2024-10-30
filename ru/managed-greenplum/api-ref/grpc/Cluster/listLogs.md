---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Cluster/listLogs.md
---

# Managed Service for Greenplum® API, gRPC: ClusterService.ListLogs {#ListLogs}

Retrieves logs for the specified Greenplum® cluster.

## gRPC request

**rpc ListLogs ([ListClusterLogsRequest](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse))**

## ListClusterLogsRequest {#yandex.cloud.mdb.greenplum.v1.ListClusterLogsRequest}

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
  "pageToken": "string",
  "alwaysNextPageToken": "bool",
  "filter": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum® cluster to request logs for.

To get the Greenplum® cluster ID, use a [ClusterService.List](/docs/managed-greenplum/api-ref/grpc/Cluster/list#List) request. ||
|| columnFilter[] | **string**

Columns from log table to request.
If no columns are specified, entire log records are returned. ||
|| serviceType | enum **ServiceType**

Type of the service to request logs about.

- `SERVICE_TYPE_UNSPECIFIED`: Type is not specified.
- `GREENPLUM`: Greenplum® activity logs.
- `GREENPLUM_POOLER`: Greenplum® pooler logs.
- `GREENPLUM_PXF`: Greenplum® PXF service logs. ||
|| fromTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp for the logs request. ||
|| toTime | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End timestamp for the logs request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse) returned by the previous list request. ||
|| alwaysNextPageToken | **bool**

The service always returns a [ListClusterLogsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse), even if the current page is empty. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:

1. A field name. Currently filtering can be applied to the [LogRecord.logs.message.hostname], [LogRecord.logs.message.error_severity] (for `GREENPLUM` service) and [LogRecord.logs.message.level] (for `GREENPLUM_POOLER` service) fields.

2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.

3. A value. Must be 1-63 characters long and match the regular expression `^[a-z0-9.-]{1,61}$`.

Examples of a filter:
* `message.hostname='node1.db.cloud.yandex.net'`;
* `message.error_severity IN ("ERROR", "FATAL", "PANIC") AND message.hostname = "node1.db.cloud.yandex.net"`. ||
|#

## ListClusterLogsResponse {#yandex.cloud.mdb.greenplum.v1.ListClusterLogsResponse}

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
|| logs[] | **[LogRecord](#yandex.cloud.mdb.greenplum.v1.LogRecord)**

Requested log records. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterLogsRequest.pageSize](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsRequest), use the `nextPageToken` as the value for the [ListClusterLogsRequest.pageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterLogsRequest) query parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results.

This value is interchangeable with the [StreamLogRecord.nextRecordToken](/docs/managed-greenplum/api-ref/grpc/Cluster/streamLogs#yandex.cloud.mdb.greenplum.v1.StreamLogRecord) from [StreamLogs](/docs/managed-greenplum/api-ref/grpc/Cluster/streamLogs#StreamLogs) method. ||
|#

## LogRecord {#yandex.cloud.mdb.greenplum.v1.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the log was recorded. ||
|| message | **string**

Contents of the log record. ||
|#