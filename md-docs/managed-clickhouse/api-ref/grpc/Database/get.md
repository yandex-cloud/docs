[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for ClickHouse®](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Database](index.md) > Get

# Managed Service for ClickHouse API, gRPC: DatabaseService.Get

Returns the specified ClickHouse Database resource.
To get the list of available ClickHouse Database resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetDatabaseRequest](#yandex.cloud.mdb.clickhouse.v1.GetDatabaseRequest)) returns ([Database](#yandex.cloud.mdb.clickhouse.v1.Database))**

## GetDatabaseRequest {#yandex.cloud.mdb.clickhouse.v1.GetDatabaseRequest}

```json
{
  "cluster_id": "string",
  "database_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the ClickHouse cluster that the database belongs to.
To get the cluster ID, use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| database_name | **string**

Required field. Name of the ClickHouse Database resource to return.
To get the name of the database, use a [DatabaseService.List](list.md#List) request.

The maximum string length in characters is 63. ||
|#

## Database {#yandex.cloud.mdb.clickhouse.v1.Database}

```json
{
  "name": "string",
  "cluster_id": "string",
  "engine": "DatabaseEngine"
}
```

A ClickHouse Database resource. For more information, see the
[Developer's Guide](../../../concepts/index.md).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the database. ||
|| cluster_id | **string**

Required field. ID of the ClickHouse cluster that the database belongs to. ||
|| engine | enum **DatabaseEngine**

Database engine. For details, see [ClickHouse documentation](https://clickhouse.com/docs/engines/database-engines).

- `DATABASE_ENGINE_ATOMIC`: Atomic database engine.
- `DATABASE_ENGINE_REPLICATED`: Replicated database engine. ||
|#