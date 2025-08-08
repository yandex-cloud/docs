---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/databases/{databaseName}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster that the database belongs to.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.
          type: string
        databaseName:
          description: |-
            **string**
            Required field. Name of the ClickHouse Database resource to return.
            To get the name of the database, use a [DatabaseService.List](/docs/managed-clickhouse/api-ref/Database/list#List) request.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
      required:
        - clusterId
        - databaseName
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Database/get.md
---

# Managed Service for ClickHouse API, REST: Database.Get

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
  "clusterId": "string",
  "engine": "string"
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
|| engine | **enum** (DatabaseEngine)

Database engine. For details, see [ClickHouse documentation](https://clickhouse.com/docs/engines/database-engines).

- `DATABASE_ENGINE_UNSPECIFIED`
- `DATABASE_ENGINE_ATOMIC`
- `DATABASE_ENGINE_REPLICATED` ||
|#