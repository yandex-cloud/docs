---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/User/create.md
---

# Managed Service for MySQL API, gRPC: UserService.Create

Creates a user in a cluster.

## gRPC request

**rpc Create ([CreateUserRequest](#yandex.cloud.mdb.mysql.v1.CreateUserRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateUserRequest {#yandex.cloud.mdb.mysql.v1.CreateUserRequest}

```json
{
  "cluster_id": "string",
  "user_spec": {
    "name": "string",
    "password": "string",
    "permissions": [
      {
        "database_name": "string",
        "roles": [
          "Privilege"
        ]
      }
    ],
    "global_permissions": [
      "GlobalPermission"
    ],
    "connection_limits": {
      "max_questions_per_hour": "google.protobuf.Int64Value",
      "max_updates_per_hour": "google.protobuf.Int64Value",
      "max_connections_per_hour": "google.protobuf.Int64Value",
      "max_user_connections": "google.protobuf.Int64Value"
    },
    "authentication_plugin": "AuthPlugin",
    "generate_password": "google.protobuf.BoolValue"
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to create the user in.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/grpc/Cluster/list#List) request. ||
|| user_spec | **[UserSpec](#yandex.cloud.mdb.mysql.v1.UserSpec)**

Required field. Configuration of the user. ||
|#

## UserSpec {#yandex.cloud.mdb.mysql.v1.UserSpec}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the user. ||
|| password | **string**

Required field. Password of the user. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mysql.v1.Permission)**

Set of permissions granted to the user to access specific databases.
One permission per database.

When a permission for a database is set, the user will have access to the database. ||
|| global_permissions[] | enum **GlobalPermission**

Set of global permissions to grant to the user.

- `GLOBAL_PERMISSION_UNSPECIFIED`
- `REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.
- `REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server,
using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.
- `PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server).

  The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users.
You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.
- `FLUSH_OPTIMIZER_COSTS`: Enables use of the `FLUSH OPTIMIZER_COSTS` statement.
- `SHOW_ROUTINE`: Enables a user to access definitions and properties of all stored routines (stored procedures and functions), even those for which the user is not named as the routine DEFINER.
This access includes:
The contents of the Information Schema `ROUTINES` table.
The `SHOW CREATE FUNCTION` and `SHOW CREATE PROCEDURE` statements.
The `SHOW FUNCTION CODE` and `SHOW PROCEDURE CODE` statements.
The SHOW `FUNCTION STATUS` and `SHOW PROCEDURE STATUS` statements.
- `MDB_ADMIN`: Enables use of the KILL command, creating and dropping databases and users, granting privileges to tables and databases. ||
|| connection_limits | **[ConnectionLimits](#yandex.cloud.mdb.mysql.v1.ConnectionLimits)**

Set of user connection limits. ||
|| authentication_plugin | enum **AuthPlugin**

User authentication plugin.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
- `SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
- `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
- `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/). ||
|| generate_password | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Generate password using Connection Manager. ||
|#

## Permission {#yandex.cloud.mdb.mysql.v1.Permission}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|| roles[] | enum **Privilege**

Roles granted to the user within the database.

See [the documentation](/docs/managed-mysql/operations/grant) for details.

- `PRIVILEGE_UNSPECIFIED`
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

## ConnectionLimits {#yandex.cloud.mdb.mysql.v1.ConnectionLimits}

#|
||Field | Description ||
|| max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted number of user questions per hour. ||
|| max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted number of user updates per hour. ||
|| max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted number of simultaneous client connections per hour. ||
|| max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections permitted to any given MySQL user account. ||
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
    "user_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "cluster_id": "string",
    "permissions": [
      {
        "database_name": "string",
        "roles": [
          "Privilege"
        ]
      }
    ],
    "global_permissions": [
      "GlobalPermission"
    ],
    "connection_limits": {
      "max_questions_per_hour": "google.protobuf.Int64Value",
      "max_updates_per_hour": "google.protobuf.Int64Value",
      "max_connections_per_hour": "google.protobuf.Int64Value",
      "max_user_connections": "google.protobuf.Int64Value"
    },
    "authentication_plugin": "AuthPlugin",
    "connection_manager": {
      "connection_id": "string"
    }
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
|| metadata | **[CreateUserMetadata](#yandex.cloud.mdb.mysql.v1.CreateUserMetadata)**

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
|| response | **[User](#yandex.cloud.mdb.mysql.v1.User)**

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

## CreateUserMetadata {#yandex.cloud.mdb.mysql.v1.CreateUserMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the cluster the user is being created in. ||
|| user_name | **string**

Name of the user that is being created. ||
|#

## User {#yandex.cloud.mdb.mysql.v1.User}

An object that represents MySQL user.

See [the documentation](/docs/managed-mysql/operations/cluster-users) for details.

#|
||Field | Description ||
|| name | **string**

Name of the user. ||
|| cluster_id | **string**

ID of the cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mysql.v1.Permission2)**

Set of permissions granted to the user. ||
|| global_permissions[] | enum **GlobalPermission**

Set of global permissions to grant to the user.

- `GLOBAL_PERMISSION_UNSPECIFIED`
- `REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.
- `REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server,
using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.
- `PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server).

  The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users.
You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.
- `FLUSH_OPTIMIZER_COSTS`: Enables use of the `FLUSH OPTIMIZER_COSTS` statement.
- `SHOW_ROUTINE`: Enables a user to access definitions and properties of all stored routines (stored procedures and functions), even those for which the user is not named as the routine DEFINER.
This access includes:
The contents of the Information Schema `ROUTINES` table.
The `SHOW CREATE FUNCTION` and `SHOW CREATE PROCEDURE` statements.
The `SHOW FUNCTION CODE` and `SHOW PROCEDURE CODE` statements.
The SHOW `FUNCTION STATUS` and `SHOW PROCEDURE STATUS` statements.
- `MDB_ADMIN`: Enables use of the KILL command, creating and dropping databases and users, granting privileges to tables and databases. ||
|| connection_limits | **[ConnectionLimits](#yandex.cloud.mdb.mysql.v1.ConnectionLimits2)**

Set of user connection limits. ||
|| authentication_plugin | enum **AuthPlugin**

User authentication plugin.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
- `SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
- `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
- `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/). ||
|| connection_manager | **[ConnectionManager](#yandex.cloud.mdb.mysql.v1.ConnectionManager)**

Connection Manager Connection and settings associated with user. Read only field. ||
|#

## Permission {#yandex.cloud.mdb.mysql.v1.Permission2}

#|
||Field | Description ||
|| database_name | **string**

Name of the database that the permission grants access to. ||
|| roles[] | enum **Privilege**

Roles granted to the user within the database.

See [the documentation](/docs/managed-mysql/operations/grant) for details.

- `PRIVILEGE_UNSPECIFIED`
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

## ConnectionLimits {#yandex.cloud.mdb.mysql.v1.ConnectionLimits2}

#|
||Field | Description ||
|| max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted number of user questions per hour. ||
|| max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted number of user updates per hour. ||
|| max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum permitted number of simultaneous client connections per hour. ||
|| max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of simultaneous connections permitted to any given MySQL user account. ||
|#

## ConnectionManager {#yandex.cloud.mdb.mysql.v1.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

ID of Connection Manager Connection ||
|#