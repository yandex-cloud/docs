---
editable: false
---

# Managed Service for Greenplum® API, gRPC: UserService.List

List all users

## gRPC request

**rpc List ([ListUsersRequest](#yandex.cloud.mdb.greenplum.v1.ListUsersRequest)) returns ([ListUsersResponse](#yandex.cloud.mdb.greenplum.v1.ListUsersResponse))**

## ListUsersRequest {#yandex.cloud.mdb.greenplum.v1.ListUsersRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Greenplum® cluster.

The maximum string length in characters is 50. ||
|#

## ListUsersResponse {#yandex.cloud.mdb.greenplum.v1.ListUsersResponse}

```json
{
  "users": [
    {
      "name": "string",
      "password": "string",
      "login": "google.protobuf.BoolValue",
      "resource_group": "string",
      "settings": {
        "pool_mode": "PoolMode",
        "pool_size": "google.protobuf.Int64Value",
        "pool_client_idle_timeout": "google.protobuf.Int64Value",
        "pool_idle_in_transaction_timeout": "google.protobuf.Int64Value"
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
|| login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Is user allowed to login. Corresponds LOGIN user privilege. Default value: True ||
|| resource_group | **string**

Resource group for user's queries

Value must match the regular expression ``` ^([^\|/*?.,;'<>]+|)$ ```. ||
|| settings | **[UserSettingsConfig](#yandex.cloud.mdb.greenplum.v1.UserSettingsConfig)**

DB and Pooler specific settings ||
|#

## UserSettingsConfig {#yandex.cloud.mdb.greenplum.v1.UserSettingsConfig}

#|
||Field | Description ||
|| pool_mode | enum **PoolMode**

Odyssey® route [server pool mode](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool).
When POOL_MODE_UNSPECIFIED, uses the cluster-level pool.mode setting.

- `SESSION`: Assign server connection to a client until it disconnects.
- `TRANSACTION`: Assign server connection to a client for a transaction processing. ||
|| pool_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Odyssey® server [pool size](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_size).
The number of servers in the server pool. Clients are placed in a wait queue when all servers are busy.
Set to zero to disable the limit.
If not set, uses the cluster-level pool.size setting.

The minimum value is 0. ||
|| pool_client_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Odyssey® [client pool idle timeout](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_client_idle_timeout), in seconds.
Drop stale client connection after this much seconds of idleness, which is not in transaction.
Set to zero to disable.
If not set, uses the cluster-level pool.client_idle_timeout setting.

The minimum value is 0. ||
|| pool_idle_in_transaction_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Odyssey® [client pool idle in transaction timeout](https://github.com/yandex/odyssey/blob/master/docs/configuration/rules.md#pool_idle_in_transaction_timeout), in seconds.
Drop client connection in transaction after this much seconds of idleness.
Set to zero to disable.
If not set, uses the cluster-level pool.idle_in_transaction_timeout setting.

The minimum value is 0. ||
|#