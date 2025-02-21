---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/User/get.md
---

# Managed Service for MySQL API, REST: User.Get

Retrieves information about the specified user.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/users/{userName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster the user belongs to.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/Cluster/list#List) request. ||
|| userName | **string**

Required field. Name of the user to return information about.

To get this name, make a [UserService.List](/docs/managed-mysql/api-ref/User/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.User}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string",
      "roles": [
        "string"
      ]
    }
  ],
  "globalPermissions": [
    "string"
  ],
  "connectionLimits": {
    "maxQuestionsPerHour": "string",
    "maxUpdatesPerHour": "string",
    "maxConnectionsPerHour": "string",
    "maxUserConnections": "string"
  },
  "authenticationPlugin": "string",
  "connectionManager": {
    "connectionId": "string"
  }
}
```

An object that represents MySQL user.

See [the documentation](/docs/managed-mysql/operations/cluster-users) for details.

#|
||Field | Description ||
|| name | **string**

Name of the user. ||
|| clusterId | **string**

ID of the cluster the user belongs to. ||
|| permissions[] | **[Permission](#yandex.cloud.mdb.mysql.v1.Permission)**

Set of permissions granted to the user. ||
|| globalPermissions[] | **enum** (GlobalPermission)

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
|| connectionLimits | **[ConnectionLimits](#yandex.cloud.mdb.mysql.v1.ConnectionLimits)**

Set of user connection limits. ||
|| authenticationPlugin | **enum** (AuthPlugin)

User authentication plugin.

- `AUTH_PLUGIN_UNSPECIFIED`
- `MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).
- `CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).
- `SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).
- `MYSQL_NO_LOGIN`: Use [MYSQL_NO_LOGIN Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/no-login-pluggable-authentication.html).
- `MDB_IAMPROXY_AUTH`: Use [IAM Pluggable Authentication](https://yandex.cloud/en/docs/iam/concepts/authorization/). ||
|| connectionManager | **[ConnectionManager](#yandex.cloud.mdb.mysql.v1.ConnectionManager)**

Connection Manager Connection and settings associated with user. Read only field. ||
|#

## Permission {#yandex.cloud.mdb.mysql.v1.Permission}

#|
||Field | Description ||
|| databaseName | **string**

Name of the database that the permission grants access to. ||
|| roles[] | **enum** (Privilege)

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
|| maxQuestionsPerHour | **string** (int64)

The maximum permitted number of user questions per hour. ||
|| maxUpdatesPerHour | **string** (int64)

The maximum permitted number of user updates per hour. ||
|| maxConnectionsPerHour | **string** (int64)

The maximum permitted number of simultaneous client connections per hour. ||
|| maxUserConnections | **string** (int64)

The maximum number of simultaneous connections permitted to any given MySQL user account. ||
|#

## ConnectionManager {#yandex.cloud.mdb.mysql.v1.ConnectionManager}

#|
||Field | Description ||
|| connectionId | **string**

ID of Connection Manager Connection ||
|#