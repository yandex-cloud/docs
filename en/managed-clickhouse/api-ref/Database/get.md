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
            The maximum string length in characters is 50.
          type: string
        databaseName:
          description: |-
            **string**
            Required field. Name of the ClickHouse Database resource to return.
            To get the name of the database, use a [DatabaseService.List](/docs/managed-clickhouse/api-ref/Database/list#List) request.
            The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
      required:
        - clusterId
        - databaseName
      additionalProperties: false
    query: null
    body: null
    definitions: null
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
To get the cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| databaseName | **string**

Required field. Name of the ClickHouse Database resource to return.
To get the name of the database, use a [DatabaseService.List](/docs/managed-clickhouse/api-ref/Database/list#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
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

- `DATABASE_ENGINE_ATOMIC`
- `DATABASE_ENGINE_REPLICATED` ||
|#