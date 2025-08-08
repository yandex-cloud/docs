---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/databases
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the PostgreSQL cluster to create a database in.
            To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        databaseSpec:
          description: |-
            **[DatabaseSpec](/docs/managed-postgresql/api-ref/Cluster/create#yandex.cloud.mdb.postgresql.v1.DatabaseSpec)**
            Required field. Configuration of the database to create.
          $ref: '#/definitions/DatabaseSpec'
      required:
        - databaseSpec
      additionalProperties: false
    definitions:
      Extension:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the extension, e.g. `pg_trgm` or `pg_btree`.
              Extensions supported by Managed Service for PostgreSQL are [listed in the Developer's Guide](/docs/managed-postgresql/operations/extensions/cluster-extensions).
            type: string
          version:
            description: |-
              **string**
              Version of the extension. The setting is deprecated and has no effect.
            deprecated: true
            type: string
      DatabaseSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the PostgreSQL database. 1-63 characters long.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          owner:
            description: |-
              **string**
              Required field. Name of the user to be assigned as the owner of the database.
              To get the list of available PostgreSQL users, make a [UserService.List](/docs/managed-postgresql/api-ref/User/list#List) request.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          lcCollate:
            description: |-
              **string**
              POSIX locale for string sorting order.
              Can only be set at creation time.
            pattern: '|[a-zA-Z_]+.UTF-8|C'
            type: string
          lcCtype:
            description: |-
              **string**
              POSIX locale for character classification.
              Can only be set at creation time.
            pattern: '|[a-zA-Z_]+.UTF-8|C'
            type: string
          extensions:
            description: |-
              **[Extension](/docs/managed-postgresql/api-ref/Cluster/create#yandex.cloud.mdb.postgresql.v1.Extension)**
              PostgreSQL extensions to be enabled for the database.
            type: array
            items:
              $ref: '#/definitions/Extension'
          templateDb:
            description: |-
              **string**
              Name of the PostgreSQL database template.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
          deletionProtection:
            description: |-
              **boolean**
              Deletion Protection inhibits deletion of the database
              Default value: `unspecified` (inherits cluster's deletion_protection)
            type: boolean
        required:
          - name
          - owner
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/Database/create.md
---

# Managed Service for PostgreSQL API, REST: Database.Create

Creates a new PostgreSQL database in the specified cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/databases
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster to create a database in.
To get the cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.postgresql.v1.CreateDatabaseRequest}

```json
{
  "databaseSpec": {
    "name": "string",
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
}
```

#|
||Field | Description ||
|| databaseSpec | **[DatabaseSpec](#yandex.cloud.mdb.postgresql.v1.DatabaseSpec)**

Required field. Configuration of the database to create. ||
|#

## DatabaseSpec {#yandex.cloud.mdb.postgresql.v1.DatabaseSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the PostgreSQL database. 1-63 characters long. ||
|| owner | **string**

Required field. Name of the user to be assigned as the owner of the database.
To get the list of available PostgreSQL users, make a [UserService.List](/docs/managed-postgresql/api-ref/User/list#List) request. ||
|| lcCollate | **string**

POSIX locale for string sorting order.
Can only be set at creation time. ||
|| lcCtype | **string**

POSIX locale for character classification.
Can only be set at creation time. ||
|| extensions[] | **[Extension](#yandex.cloud.mdb.postgresql.v1.Extension)**

PostgreSQL extensions to be enabled for the database. ||
|| templateDb | **string**

Name of the PostgreSQL database template. ||
|| deletionProtection | **boolean**

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "databaseName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateDatabaseMetadata](#yandex.cloud.mdb.postgresql.v1.CreateDatabaseMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| clusterId | **string**

ID of the PostgreSQL cluster where a database is being created. ||
|| databaseName | **string**

Name of the PostgreSQL database that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## Database {#yandex.cloud.mdb.postgresql.v1.Database}

A PostgreSQL Database resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts).

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
|| extensions[] | **[Extension](#yandex.cloud.mdb.postgresql.v1.Extension2)**

PostgreSQL extensions enabled for the database. ||
|| templateDb | **string**

Name of the database template. ||
|| deletionProtection | **boolean**

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

Version of the extension. The setting is deprecated and has no effect. ||
|#