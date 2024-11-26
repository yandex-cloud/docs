---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Database/list.md
---

# Managed Service for ClickHouse API, gRPC: DatabaseService.List

Retrieves the list of ClickHouse Database resources in the specified cluster.

## gRPC request

**rpc List ([ListDatabasesRequest](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesRequest)) returns ([ListDatabasesResponse](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse))**

## ListDatabasesRequest {#yandex.cloud.mdb.clickhouse.v1.ListDatabasesRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the ClickHouse cluster to list databases in.
To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDatabasesResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.  to get the next page of results, set `page_token` to the [ListDatabasesResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse)
returned by the previous list request. ||
|#

## ListDatabasesResponse {#yandex.cloud.mdb.clickhouse.v1.ListDatabasesResponse}

```json
{
  "databases": [
    {
      "name": "string",
      "cluster_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| databases[] | **[Database](#yandex.cloud.mdb.clickhouse.v1.Database)**

List of ClickHouse databases. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDatabasesRequest.page_size](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesRequest), use the `next_page_token` as the value
for the [ListDatabasesRequest.page_token](#yandex.cloud.mdb.clickhouse.v1.ListDatabasesRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Database {#yandex.cloud.mdb.clickhouse.v1.Database}

A ClickHouse Database resource. For more information, see the
[Developer's Guide](/docs/managed-clickhouse/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| cluster_id | **string**

ID of the ClickHouse cluster that the database belongs to. ||
|#