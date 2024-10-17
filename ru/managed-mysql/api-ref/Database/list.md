---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Database/list.md
---

# Managed Service for MySQL API, REST: Database.List {#List}

Retrieves the list of databases in a cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/databases
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to list databases in.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.mysql.v1.ListDatabasesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the API returns a [ListDatabasesResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse) that can be used to get the next page of results in the subsequent [DatabaseService.List](#List) requests. ||
|| pageToken | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `pageToken` to the [ListDatabasesResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse) returned by the previous [DatabaseService.List](#List) request. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.ListDatabasesResponse}

**HTTP Code: 200 - OK**

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
|| databases[] | **[Database](#yandex.cloud.mdb.mysql.v1.Database)**

List of databases. ||
|| nextPageToken | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListDatabasesRequest.pageSize](#yandex.cloud.mdb.mysql.v1.ListDatabasesRequest), use the `nextPageToken` as the value for the [ListDatabasesRequest.pageToken](#yandex.cloud.mdb.mysql.v1.ListDatabasesRequest) in the subsequent [DatabaseService.List](#List) request to iterate through multiple pages of results.

Each of the subsequent [DatabaseService.List](#List) requests should use the `nextPageToken` value returned by the previous request to continue paging through the results. ||
|#

## Database {#yandex.cloud.mdb.mysql.v1.Database}

An object that represents MySQL database.

See [the documentation](/docs/managed-mysql/operations/databases) for details.

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the cluster that the database belongs to. ||
|#