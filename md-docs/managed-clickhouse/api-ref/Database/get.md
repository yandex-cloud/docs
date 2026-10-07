[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for ClickHouse®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Database](index.md) > Get

# Managed Service for ClickHouse API, REST: Database.Get

Returns the specified ClickHouse Database resource.
To get the list of available ClickHouse Database resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster that the database belongs to.
To get the cluster ID, use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| databaseName | **string**

Required field. Name of the ClickHouse Database resource to return.
To get the name of the database, use a [DatabaseService.List](list.md#List) request.

The maximum string length in characters is 63. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "engine": "string",
  "deletionProtectionMode": "string"
}
```

A ClickHouse Database resource. For more information, see the
[Developer's Guide](../../concepts/index.md).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the database. ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster that the database belongs to. ||
|| engine | **enum** (DatabaseEngine)

Database engine. For details, see [ClickHouse documentation](https://clickhouse.com/docs/engines/database-engines).

- `DATABASE_ENGINE_ATOMIC`: Atomic database engine.
- `DATABASE_ENGINE_REPLICATED`: Replicated database engine. ||
|| deletionProtectionMode | **enum** (DeletionProtectionMode)

Deletion protection mode.
Default value: `DELETION_PROTECTION_MODE_DISABLED`.

- `DELETION_PROTECTION_MODE_DISABLED`: Deletion protection is disabled.
- `DELETION_PROTECTION_MODE_ENABLED`: Deletion protection is enabled.
- `DELETION_PROTECTION_MODE_INHERITED`: Deletion protection mode is inherited from the cluster. ||
|#