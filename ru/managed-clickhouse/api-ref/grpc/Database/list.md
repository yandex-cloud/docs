---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Database/list.md
---

# Managed Service for ClickHouse API, gRPC: DatabaseService.List {#List}

Retrieves the list of ClickHouse Database resources in the specified cluster.

## gRPC request

**rpc List ([ListDatabasesRequest](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesRequest)) returns ([ListDatabasesResponse](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse))**

## ListDatabasesRequest {#yandex.cloud.mdb.clickhouse.v1.ListDatabasesRequest}

```json
{
  "clusterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster to list databases in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListDatabasesResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.  to get the next page of results, set `pageToken` to the [ListDatabasesResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse)
returned by the previous list request. ||
|#

## ListDatabasesResponse {#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse}

```json
{
  "databases": [
    {
      "name": "string",
      "clusterId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| databases[] | **[Database](#yandex.cloud.mdb.clickhouse.v1.Database)**

List of ClickHouse databases. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDatabasesRequest.pageSize](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesRequest), use the `nextPageToken` as the value
for the [ListDatabasesRequest.pageToken](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Database {#yandex.cloud.mdb.clickhouse.v1.Database}

A ClickHouse Database resource. For more information, see the
[Developer's Guide](/docs/managed-clickhouse/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the ClickHouse cluster that the database belongs to. ||
|#