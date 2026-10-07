[Документация Yandex Cloud](../../../index.md) > [Yandex StoreDoc](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Database](index.md) > Get

# Managed Service for MongoDB API, REST: Database.Get

Returns the specified StoreDoc Database resource.
To get the list of available StoreDoc Database resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the StoreDoc cluster that the database belongs to.
To get the cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| databaseName | **string**

Required field. Name of the StoreDoc database to return.
To get the name of the database use a [DatabaseService.List](list.md#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "deletionProtection": "boolean"
}
```

A StoreDoc Database resource. For more information, see the
[Developer's Guide](../../concepts/index.md).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the StoreDoc cluster that the database belongs to. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the database. ||
|#