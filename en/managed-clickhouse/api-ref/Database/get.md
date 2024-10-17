---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Database/get.md
---

# Managed Service for ClickHouse API, REST: Database.Get {#Get}

Returns the specified ClickHouse Database resource.

To get the list of available ClickHouse Database resources, make a [List](/docs/managed-clickhouse/api-ref/Database/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster that the database belongs to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request. ||
|| databaseName | **string**

Required field. Name of the ClickHouse Database resource to return.
To get the name of the database, use a [DatabaseService.List](/docs/managed-clickhouse/api-ref/Database/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string"
}
```

A ClickHouse Database resource. For more information, see the
[Developer's Guide](/docs/managed-clickhouse/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the ClickHouse cluster that the database belongs to. ||
|#