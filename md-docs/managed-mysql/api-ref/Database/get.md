[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for MySQL®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Database](index.md) > Get

# Managed Service for MySQL API, REST: Database.Get

Retrieves information about the specified database.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster that the database belongs to.
To get this ID, make a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| databaseName | **string**

Required field. Name of the database to return information about.
To get this name, make a [DatabaseService.List](list.md#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "deletionProtectionMode": "string"
}
```

An object that represents MySQL database.
See [the documentation](../../operations/databases.md) for details.

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the cluster that the database belongs to. ||
|| deletionProtectionMode | **enum** (DeletionProtectionMode)

Deletion Protection inhibits deletion of the database
Default value: `DELETION_PROTECTION_MODE_DISABLED` (protection is disabled)

- `DELETION_PROTECTION_MODE_DISABLED`: Deletion protection is disabled
- `DELETION_PROTECTION_MODE_ENABLED`: Deletion protection is enabled
- `DELETION_PROTECTION_MODE_INHERITED`: Deletion protection mode is inherited from the cluster ||
|#