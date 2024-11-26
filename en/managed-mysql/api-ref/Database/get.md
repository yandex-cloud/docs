---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Database/get.md
---

# Managed Service for MySQL API, REST: Database.Get

Retrieves information about the specified database.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the database belongs to.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/Cluster/list#List) request. ||
|| databaseName | **string**

Required field. Name of the database to return information about.

To get this name, make a [DatabaseService.List](/docs/managed-mysql/api-ref/Database/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string"
}
```

An object that represents MySQL database.

See [the documentation](/docs/managed-mysql/operations/databases) for details.

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the cluster that the database belongs to. ||
|#