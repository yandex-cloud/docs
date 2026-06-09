# Managed Service for MySQL API, REST: User.RevokePermission

Revokes permission to access a database from a user in a cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/users/{userName}:revokePermission
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to revoke permission from the user in.
To get this ID, make a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| userName | **string**

Required field. Name of the user to revoke permission from.
To get this name, make a [UserService.List](list.md#List) request.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_@.-]* `. ||
|#

## Body parameters {#yandex.cloud.mdb.mysql.v1.RevokeUserPermissionRequest}

```json
{
  "permission": {
    "databaseName": "string",
    "roles": [
      "string"
    ]
  }
}
```

#|
||Field | Description ||
|| permission | **[Permission](#yandex.cloud.mdb.mysql.v1.Permission)**

Required field. Permission that should be revoked from the user. ||
|#

## Permission {#yandex.cloud.mdb.mysql.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **enum** (Privilege)

Roles granted to the user within the database.
See [the documentation](../../operations/grant.md) for details.

The minimum number of elements is 1.

- `ALL_PRIVILEGES`: All privileges that can be made available to the user.
- `ALTER`: Altering tables.
- `ALTER_ROUTINE`: Altering stored routines and functions.
- `CREATE`: Creating tables or indexes.
- `CREATE_ROUTINE`: Creating stored routines.
- `CREATE_TEMPORARY_TABLES`: Creating temporary tables.
- `CREATE_VIEW`: Creating views.
- `DELETE`: Deleting tables.
- `DROP`: Removing tables or views.
- `EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.
- `EXECUTE`: Executing stored routines.
- `INDEX`: Creating and removing indexes.
- `INSERT`: Inserting rows into the database.
- `LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.
- `SELECT`: Selecting rows from tables.
Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege.
See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.
- `SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.
- `TRIGGER`: Creating, removing, executing, or displaying triggers for a table.
- `UPDATE`: Updating rows in the database.
- `REFERENCES`: Creation of a foreign key constraint for the parent table. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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
|| metadata | **object**

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
|| response | **object**

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