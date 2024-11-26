---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Database/create.md
---

# Managed Service for PostgreSQL API, gRPC: DatabaseService.Create

Creates a new PostgreSQL database in the specified cluster.

## gRPC request

**rpc Create ([CreateDatabaseRequest](#yandex.cloud.mdb.postgresql.v1.CreateDatabaseRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateDatabaseRequest {#yandex.cloud.mdb.postgresql.v1.CreateDatabaseRequest}

```json
{
  "cluster_id": "string",
  "database_spec": {
    "name": "string",
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
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster to create a database in.
To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| database_spec | **[DatabaseSpec](#yandex.cloud.mdb.postgresql.v1.DatabaseSpec)**

Required field. Configuration of the database to create. ||
|#

## DatabaseSpec {#yandex.cloud.mdb.postgresql.v1.DatabaseSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the PostgreSQL database. 1-63 characters long. ||
|| owner | **string**

Required field. Name of the user to be assigned as the owner of the database.
To get the list of available PostgreSQL users, make a [UserService.List](/docs/managed-postgresql/api-ref/grpc/User/list#List) request. ||
|| lc_collate | **string**

POSIX locale for string sorting order.
Can only be set at creation time. ||
|| lc_ctype | **string**

POSIX locale for character classification.
Can only be set at creation time. ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.postgresql.v1.Extension)**

PostgreSQL extensions to be enabled for the database. ||
|| template_db | **string**

Name of the PostgreSQL database template. ||
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

Version of the extension. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "database_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateDatabaseMetadata](#yandex.cloud.mdb.postgresql.v1.CreateDatabaseMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Database](#yandex.cloud.mdb.postgresql.v1.Database)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateDatabaseMetadata {#yandex.cloud.mdb.postgresql.v1.CreateDatabaseMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the PostgreSQL cluster where a database is being created. ||
|| database_name | **string**

Name of the PostgreSQL database that is being created. ||
|#

## Database {#yandex.cloud.mdb.postgresql.v1.Database}

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
|| extensions[] | **[Extension](#yandex.cloud.mdb.postgresql.v1.Extension2)**

PostgreSQL extensions enabled for the database. ||
|| template_db | **string**

Name of the database template. ||
|| deletion_protection | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Deletion Protection inhibits deletion of the database

Default value: `unspecified` (inherits cluster's deletion_protection) ||
|#

## Extension {#yandex.cloud.mdb.postgresql.v1.Extension2}

#|
||Field | Description ||
|| name | **string**

Name of the extension, e.g. `pg_trgm` or `pg_btree`.
Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/extensions/cluster-extensions). ||
|| version | **string**

Version of the extension. ||
|#