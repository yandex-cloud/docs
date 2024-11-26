---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/Database/list.md
---

# Managed Service for MySQL API, gRPC: DatabaseService.List

Retrieves the list of databases in a cluster.

## gRPC request

**rpc List ([ListDatabasesRequest](#yandex.cloud.mdb.mysql.v1.ListDatabasesRequest)) returns ([ListDatabasesResponse](#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse))**

## ListDatabasesRequest {#yandex.cloud.mdb.mysql.v1.ListDatabasesRequest}

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

Required field. ID of the cluster to list databases in.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the API returns a [ListDatabasesResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse) that can be used to get the next page of results in the subsequent [DatabaseService.List](#List) requests. ||
|| page_token | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `page_token` to the [ListDatabasesResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse) returned by the previous [DatabaseService.List](#List) request. ||
|#

## ListDatabasesResponse {#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse}

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
|| databases[] | **[Database](#yandex.cloud.mdb.mysql.v1.Database)**

List of databases. ||
|| next_page_token | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListDatabasesRequest.page_size](#yandex.cloud.mdb.mysql.v1.ListDatabasesRequest), use the `next_page_token` as the value for the [ListDatabasesRequest.page_token](#yandex.cloud.mdb.mysql.v1.ListDatabasesRequest) in the subsequent [DatabaseService.List](#List) request to iterate through multiple pages of results.

Each of the subsequent [DatabaseService.List](#List) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. ||
|#

## Database {#yandex.cloud.mdb.mysql.v1.Database}

An object that represents MySQL database.

See [the documentation](/docs/managed-mysql/operations/databases) for details.

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| cluster_id | **string**

ID of the cluster that the database belongs to. ||
|#