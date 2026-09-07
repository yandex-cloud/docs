[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [User](index.md) > List

# Managed Service for Greenplum® API, REST: User.List

List all users

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/{clusterId}/users
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum® cluster.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.ListUsersResponse}

**HTTP Code: 200 - OK**

```json
{
  "users": [
    {
      "name": "string",
      "password": "string",
      "login": "boolean",
      "resourceGroup": "string",
      "settings": {
        "poolMode": "string",
        "poolSize": "string",
        "poolClientIdleTimeout": "string",
        "poolIdleInTransactionTimeout": "string"
      }
    }
  ]
}
```

#|
||Field | Description ||
|| users[] | **[User](#yandex.cloud.mdb.greenplum.v1.User)**

List of cluster users. ||
|#

## User {#yandex.cloud.mdb.greenplum.v1.User}

#|
||Field | Description ||
|| name | **string**

Required field. User name

The string length in characters must be 1-63. Value must match the regular expression ` ^[a-zA-Z_][a-zA-Z0-9_]{0,62}$ `. ||
|| password | **string**

User password. Used only in create and update requests

The maximum string length in characters is 128. ||
|| login | **boolean**

Is user allowed to login. Corresponds LOGIN user privilege. Default value: True ||
|| resourceGroup | **string**

Resource group for user's queries

Value must match the regular expression ``` ^([^\|/*?.,;'<>]+|)$ ```. ||
|| settings | **[UserSettingsConfig](#yandex.cloud.mdb.greenplum.v1.UserSettingsConfig)**

DB and Pooler specific settings ||
|#

## UserSettingsConfig {#yandex.cloud.mdb.greenplum.v1.UserSettingsConfig}

#|
||Field | Description ||
|| poolMode | **enum** (PoolMode)

Odyssey® route [server pool mode](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool).
When POOL_MODE_UNSPECIFIED, uses the cluster-level pool.mode setting.

- `SESSION`: Assign server connection to a client until it disconnects.
- `TRANSACTION`: Assign server connection to a client for a transaction processing. ||
|| poolSize | **string** (int64)

Odyssey® server [pool size](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_size).
The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.
Set to zero to disable the limit.
If not set, uses the cluster-level pool.size setting.

The minimum value is 0. ||
|| poolClientIdleTimeout | **string** (int64)

Odyssey® [client pool idle timeout](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_client_idle_timeout), in seconds.
Drop stale client connection after this much seconds of idleness, which is not in transaction.
Set to zero to disable.
If not set, uses the cluster-level pool.client_idle_timeout setting.

The minimum value is 0. ||
|| poolIdleInTransactionTimeout | **string** (int64)

Odyssey® [client pool idle in transaction timeout](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_idle_in_transaction_timeout), in seconds.
Drop client connection in transaction after this much seconds of idleness.
Set to zero to disable.
If not set, uses the cluster-level pool.idle_in_transaction_timeout setting.

The minimum value is 0. ||
|#