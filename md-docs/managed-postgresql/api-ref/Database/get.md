[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for PostgreSQL](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Database](index.md) > Get

# Managed Service for PostgreSQL API, REST: Database.Get

Returns the specified PostgreSQL Database resource.

To get the list of available PostgreSQL Database resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/databases/{databaseName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster that the database belongs to.
To get the cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| databaseName | **string**

Required field. Name of the PostgreSQL Database resource to return.
To get the name of the database use a [DatabaseService.List](list.md#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.Database}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "owner": "string",
  "lcCollate": "string",
  "lcCtype": "string",
  "extensions": [
    {
      "name": "string",
      "version": "string"
    }
  ],
  "templateDb": "string",
  "deletionProtection": "boolean"
}
```

A PostgreSQL Database resource. For more information, see
the [Developer's Guide](../../concepts/index.md).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| clusterId | **string**

ID of the PostgreSQL cluster that the database belongs to. ||
|| owner | **string**

Name of the user assigned as the owner of the database. ||
|| lcCollate | **string**

POSIX locale for string sorting order.
Can only be set at creation time. ||
|| lcCtype | **string**

POSIX locale for character classification.
Can only be set at creation time. ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.postgresql.v1.Extension)**

PostgreSQL extensions enabled for the database. ||
|| templateDb | **string**

Name of the database template. ||
|| deletionProtection | **boolean**

Deletion Protection inhibits deletion of the database

Default value: `unspecified` (inherits cluster's deletion_protection) ||
|#

## Extension {#yandex.cloud.mdb.postgresql.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension, e.g. `pg_trgm` or `pg_btree`.
Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](../../operations/extensions/cluster-extensions.md). ||
|| version | **string**

Version of the extension. The setting is deprecated and has no effect. ||
|#