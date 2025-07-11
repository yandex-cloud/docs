---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Database/get.md
---

# Managed Service for PostgreSQL API, gRPC: DatabaseService.Get

Returns the specified PostgreSQL Database resource.

To get the list of available PostgreSQL Database resources, make a [List](/docs/managed-postgresql/api-ref/grpc/Database/list#List) request.

## gRPC request

**rpc Get ([GetDatabaseRequest](#yandex.cloud.mdb.postgresql.v1.GetDatabaseRequest)) returns ([Database](#yandex.cloud.mdb.postgresql.v1.Database))**

## GetDatabaseRequest {#yandex.cloud.mdb.postgresql.v1.GetDatabaseRequest}

```json
{
  "cluster_id": "string",
  "database_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster that the database belongs to.
To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| database_name | **string**

Required field. Name of the PostgreSQL Database resource to return.
To get the name of the database use a [DatabaseService.List](/docs/managed-postgresql/api-ref/grpc/Database/list#List) request. ||
|#

## Database {#yandex.cloud.mdb.postgresql.v1.Database}

```json
{
  "name": "string",
  "cluster_id": "string",
  "owner": "string",
  "lc_collate": "string",
  "lc_ctype": "string",
  "extensions": [
    {
      "name": "string",
      "version": "string"
    }
  ],
  "template_db": "string",
  "deletion_protection": "google.protobuf.BoolValue"
}
```

A PostgreSQL Database resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts).

#|
||Field | Description ||
|| name | **string**

Name of the database. ||
|| cluster_id | **string**

ID of the PostgreSQL cluster that the database belongs to. ||
|| owner | **string**

Name of the user assigned as the owner of the database. ||
|| lc_collate | **string**

POSIX locale for string sorting order.
Can only be set at creation time. ||
|| lc_ctype | **string**

POSIX locale for character classification.
Can only be set at creation time. ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.postgresql.v1.Extension)**

PostgreSQL extensions enabled for the database. ||
|| template_db | **string**

Name of the database template. ||
|| deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Deletion Protection inhibits deletion of the database

Default value: `unspecified` (inherits cluster's deletion_protection) ||
|#

## Extension {#yandex.cloud.mdb.postgresql.v1.Extension}

#|
||Field | Description ||
|| name | **string**

Name of the extension, e.g. `pg_trgm` or `pg_btree`.
Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/extensions/cluster-extensions). ||
|| version | **string**

Version of the extension. The setting is deprecated and has no effect. ||
|#