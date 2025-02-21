---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/User/list.md
---

# Managed Service for MySQL API, gRPC: UserService.List

Retrieves the list of users in a cluster.

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.mdb.mysql.v1.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.mdb.mysql.v1.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.mdb.mysql.v1.ListUsersRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the cluster to list the users in.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the API returns a [ListUsersResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListUsersResponse) that can be used to get the next page of results in the subsequent [UserService.List](#List) requests. ||
|| page_token | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListUsersResponse) returned by the previous [UserService.List](#List) request. ||
|#

## ListUsersResponse {#yandex.cloud.mdb.mysql.v1.ListUsersResponse}

```json
{
  "users": [
    {
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.mysql.v1.User)**

List of users. ||
|| next_page_token | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListUsersRequest.page_size](#yandex.cloud.mdb.mysql.v1.ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#yandex.cloud.mdb.mysql.v1.ListUsersRequest) in the subsequent [UserService.List](#List) request to iterate through multiple pages of results.

Each of the subsequent [UserService.List](#List) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. ||
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
|| permissions[] | **[Permission](#yandex.cloud.mdb.mysql.v1.Permission)**

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
The SHOW `FUNCTION STATUS` and `SHOW PROCEDURE STATUS` statements. ||
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
|| connection_manager | **[ConnectionManager](#yandex.cloud.mdb.mysql.v1.ConnectionManager)**

Connection Manager Connection and settings associated with user. Read only field. ||
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

## ConnectionManager {#yandex.cloud.mdb.mysql.v1.ConnectionManager}

#|
||Field | Description ||
|| connection_id | **string**

ID of Connection Manager Connection ||
|#