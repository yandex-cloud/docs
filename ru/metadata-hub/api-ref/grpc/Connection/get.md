---
editable: false
sourcePath: en/_api-ref-grpc/connectionmanager/v1/api-ref/grpc/Connection/get.md
---

# Connection Manager API, gRPC: ConnectionService.Get

Returns connection.

## gRPC request

**rpc Get ([GetConnectionRequest](#yandex.cloud.connectionmanager.v1.GetConnectionRequest)) returns ([Connection](#yandex.cloud.connectionmanager.v1.Connection))**

## GetConnectionRequest {#yandex.cloud.connectionmanager.v1.GetConnectionRequest}

```json
{
  "connection_id": "string"
}
```

#|
||Field | Description ||
|| connection_id | **string** ||
|#

## Connection {#yandex.cloud.connectionmanager.v1.Connection}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "created_by": "string",
  "params": {
    // Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`
    "postgresql": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "int64",
            "role": "Role",
            "replica_type": "ReplicaType",
            "health": "Health"
          }
        ],
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managed_cluster_id": "string",
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "string"
      ]
    },
    "mysql": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "int64",
            "role": "Role",
            "health": "Health"
          }
        ],
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managed_cluster_id": "string",
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "string"
      ]
    },
    "mongodb": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "int64",
            "role": "Role",
            "health": "Health",
            "type": "Type"
          }
        ],
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managed_cluster_id": "string",
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "string"
      ]
    },
    "clickhouse": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "http_port": "int64",
            "tcp_port": "int64",
            "shard_name": "string",
            "health": "Health"
          }
        ],
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managed_cluster_id": "string",
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "string"
      ]
    },
    "redis": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "int64",
            "role": "Role",
            "health": "Health",
            "shard_name": "string"
          }
        ],
        "sentinel_port": "int64",
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "int64"
      ]
    },
    "opensearch": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "int64",
            "health": "Health",
            "roles": [
              "GroupRole"
            ]
          }
        ],
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managed_cluster_id": "string",
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      }
    },
    "trino": {
      "cluster": {
        "coordinator": {
          "host": "string",
          "port": "int64"
        },
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      }
    },
    "valkey": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "int64",
            "role": "Role",
            "health": "Health",
            "shard_name": "string"
          }
        ],
        "sentinel_port": "int64",
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managed_cluster_id": "string",
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "int64"
      ]
    },
    "greenplum": {
      "cluster": {
        "coordinator_hosts": [
          {
            "host": "string",
            "port": "int64",
            "role": "Role",
            "health": "Health"
          }
        ],
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managed_cluster_id": "string",
      "auth": {
        // Includes only one of the fields `user_password`
        "user_password": {
          "user": "string",
          "password": {
            "raw": "string",
            "password_generation_options": {
              "cookie": "string",
              // Includes only one of the fields `lockbox_password_generation_options`
              "lockbox_password_generation_options": {
                "length": "int64",
                "include_uppercase": "google.protobuf.BoolValue",
                "include_lowercase": "google.protobuf.BoolValue",
                "include_digits": "google.protobuf.BoolValue",
                "include_punctuation": "google.protobuf.BoolValue",
                "included_punctuation": "string",
                "excluded_punctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockbox_secret_key`
            "lockbox_secret_key": "string"
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "string"
      ]
    }
    // end of the list of possible fields
  },
  // Includes only one of the fields `lockbox_secret`
  "lockbox_secret": {
    "id": "string",
    "version": "string",
    "newest_version": "string"
  },
  // end of the list of possible fields
  "is_managed": "bool",
  "can_use": "google.protobuf.BoolValue"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| folder_id | **string** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| created_by | **string** ||
|| params | **[ConnectionParams](#yandex.cloud.connectionmanager.v1.ConnectionParams)** ||
|| lockbox_secret | **[LockboxSecret](#yandex.cloud.connectionmanager.v1.LockboxSecret)**

Includes only one of the fields `lockbox_secret`. ||
|| is_managed | **bool** ||
|| can_use | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|#

## ConnectionParams {#yandex.cloud.connectionmanager.v1.ConnectionParams}

#|
||Field | Description ||
|| postgresql | **[PostgreSQLConnection](#yandex.cloud.connectionmanager.v1.PostgreSQLConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| mysql | **[MySQLConnection](#yandex.cloud.connectionmanager.v1.MySQLConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| mongodb | **[MongoDBConnection](#yandex.cloud.connectionmanager.v1.MongoDBConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| clickhouse | **[ClickHouseConnection](#yandex.cloud.connectionmanager.v1.ClickHouseConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| redis | **[RedisConnection](#yandex.cloud.connectionmanager.v1.RedisConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| opensearch | **[OpenSearchConnection](#yandex.cloud.connectionmanager.v1.OpenSearchConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| trino | **[TrinoConnection](#yandex.cloud.connectionmanager.v1.TrinoConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| valkey | **[ValkeyConnection](#yandex.cloud.connectionmanager.v1.ValkeyConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| greenplum | **[GreenplumConnection](#yandex.cloud.connectionmanager.v1.GreenplumConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|#

## PostgreSQLConnection {#yandex.cloud.connectionmanager.v1.PostgreSQLConnection}

#|
||Field | Description ||
|| cluster | **[PostgreSQLCluster](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[PostgreSQLAuth](#yandex.cloud.connectionmanager.v1.PostgreSQLAuth)** ||
|| databases[] | **string** ||
|#

## PostgreSQLCluster {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| replica_type | enum **ReplicaType**

- `REPLICA_TYPE_UNSPECIFIED`
- `ASYNC`
- `SYNC`
- `QUORUM` ||
|| health | enum **Health**

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|#

## TLSParams {#yandex.cloud.connectionmanager.v1.TLSParams}

#|
||Field | Description ||
|| disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Includes only one of the fields `disabled`, `tls`. ||
|| tls | **[TLSConfig](#yandex.cloud.connectionmanager.v1.TLSConfig)**

Includes only one of the fields `disabled`, `tls`. ||
|#

## TLSConfig {#yandex.cloud.connectionmanager.v1.TLSConfig}

#|
||Field | Description ||
|| ca_certificate | **string** ||
|#

## PostgreSQLAuth {#yandex.cloud.connectionmanager.v1.PostgreSQLAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## UserPasswordAuth {#yandex.cloud.connectionmanager.v1.UserPasswordAuth}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password)** ||
|#

## Password {#yandex.cloud.connectionmanager.v1.Password}

#|
||Field | Description ||
|| raw | **string**

When creating/updating Password, the field "raw" is mutually exclusive
with "password_generation_options". In order to switch to the "raw"
password you have to explicitly clear the "password_generation_options"
field. ||
|| password_generation_options | **[PasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions)**

When creating/updating Password, the field "password_generation_options"
is mutually exclusive with "raw". In order to switch to the
"password_generation_options" you have to explicitly clear the "raw"
field. ||
|| lockbox_secret_key | **string**

Read-only. Do not fill this field in create/update requests.

Includes only one of the fields `lockbox_secret_key`. ||
|#

## PasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions}

#|
||Field | Description ||
|| cookie | **string**

Cookie is an arbitrary non-sensitive string that is saved with the
password. When updating PasswordGenerationOptions, if the cookie passed
in the update request differs from the cookie in the current
PasswordGenerationOptions, the password will be re-generated. If the
same cookie is passed, the password will not change. ||
|| lockbox_password_generation_options | **[LockboxPasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions)**

Includes only one of the fields `lockbox_password_generation_options`. ||
|#

## LockboxPasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions}

#|
||Field | Description ||
|| length | **int64**

password length; by default, a reasonable length will be decided ||
|| include_uppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| include_lowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| include_digits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| include_punctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| included_punctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use ||
|| excluded_punctuation | **string**

a string of punctuation characters to exclude from the default ||
|#

## MySQLConnection {#yandex.cloud.connectionmanager.v1.MySQLConnection}

#|
||Field | Description ||
|| cluster | **[MySQLCluster](#yandex.cloud.connectionmanager.v1.MySQLCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[MySQLAuth](#yandex.cloud.connectionmanager.v1.MySQLAuth)** ||
|| databases[] | **string** ||
|#

## MySQLCluster {#yandex.cloud.connectionmanager.v1.MySQLCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MySQLCluster.Host)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MySQLCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|#

## MySQLAuth {#yandex.cloud.connectionmanager.v1.MySQLAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## MongoDBConnection {#yandex.cloud.connectionmanager.v1.MongoDBConnection}

#|
||Field | Description ||
|| cluster | **[MongoDBCluster](#yandex.cloud.connectionmanager.v1.MongoDBCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[MongoDBAuth](#yandex.cloud.connectionmanager.v1.MongoDBAuth)** ||
|| databases[] | **string** ||
|#

## MongoDBCluster {#yandex.cloud.connectionmanager.v1.MongoDBCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MongoDBCluster.Host)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MongoDBCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `ROLE_UNSPECIFIED`
- `PRIMARY`
- `SECONDARY` ||
|| health | enum **Health**

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## MongoDBAuth {#yandex.cloud.connectionmanager.v1.MongoDBAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## ClickHouseConnection {#yandex.cloud.connectionmanager.v1.ClickHouseConnection}

#|
||Field | Description ||
|| cluster | **[ClickHouseCluster](#yandex.cloud.connectionmanager.v1.ClickHouseCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[ClickHouseAuth](#yandex.cloud.connectionmanager.v1.ClickHouseAuth)** ||
|| databases[] | **string** ||
|#

## ClickHouseCluster {#yandex.cloud.connectionmanager.v1.ClickHouseCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| http_port | **int64**

depends on tls params may vary as http or https ||
|| tcp_port | **int64** ||
|| shard_name | **string** ||
|| health | enum **Health**

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|#

## ClickHouseAuth {#yandex.cloud.connectionmanager.v1.ClickHouseAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## RedisConnection {#yandex.cloud.connectionmanager.v1.RedisConnection}

#|
||Field | Description ||
|| cluster | **[RedisCluster](#yandex.cloud.connectionmanager.v1.RedisCluster)** ||
|| auth | **[RedisAuth](#yandex.cloud.connectionmanager.v1.RedisAuth)** ||
|| databases[] | **int64** ||
|#

## RedisCluster {#yandex.cloud.connectionmanager.v1.RedisCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.RedisCluster.Host)** ||
|| sentinel_port | **int64** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.RedisCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| shard_name | **string** ||
|#

## RedisAuth {#yandex.cloud.connectionmanager.v1.RedisAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.RedisAuth.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## UserPasswordAuth {#yandex.cloud.connectionmanager.v1.RedisAuth.UserPasswordAuth}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password)** ||
|#

## OpenSearchConnection {#yandex.cloud.connectionmanager.v1.OpenSearchConnection}

#|
||Field | Description ||
|| cluster | **[OpenSearchCluster](#yandex.cloud.connectionmanager.v1.OpenSearchCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[OpenSearchAuth](#yandex.cloud.connectionmanager.v1.OpenSearchAuth)** ||
|#

## OpenSearchCluster {#yandex.cloud.connectionmanager.v1.OpenSearchCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.OpenSearchCluster.Host)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.OpenSearchCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| health | enum **Health**

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|| roles[] | enum **GroupRole**

- `GROUP_ROLE_UNSPECIFIED`
- `DATA`
- `MANAGER` ||
|#

## OpenSearchAuth {#yandex.cloud.connectionmanager.v1.OpenSearchAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## TrinoConnection {#yandex.cloud.connectionmanager.v1.TrinoConnection}

#|
||Field | Description ||
|| cluster | **[TrinoCluster](#yandex.cloud.connectionmanager.v1.TrinoCluster)** ||
|| auth | **[TrinoAuth](#yandex.cloud.connectionmanager.v1.TrinoAuth)** ||
|#

## TrinoCluster {#yandex.cloud.connectionmanager.v1.TrinoCluster}

#|
||Field | Description ||
|| coordinator | **[Coordinator](#yandex.cloud.connectionmanager.v1.TrinoCluster.Coordinator)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Coordinator {#yandex.cloud.connectionmanager.v1.TrinoCluster.Coordinator}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|#

## TrinoAuth {#yandex.cloud.connectionmanager.v1.TrinoAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## ValkeyConnection {#yandex.cloud.connectionmanager.v1.ValkeyConnection}

#|
||Field | Description ||
|| cluster | **[ValkeyCluster](#yandex.cloud.connectionmanager.v1.ValkeyCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[ValkeyAuth](#yandex.cloud.connectionmanager.v1.ValkeyAuth)** ||
|| databases[] | **int64** ||
|#

## ValkeyCluster {#yandex.cloud.connectionmanager.v1.ValkeyCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ValkeyCluster.Host)** ||
|| sentinel_port | **int64** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.ValkeyCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| shard_name | **string** ||
|#

## ValkeyAuth {#yandex.cloud.connectionmanager.v1.ValkeyAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.ValkeyAuth.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## UserPasswordAuth {#yandex.cloud.connectionmanager.v1.ValkeyAuth.UserPasswordAuth}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password)** ||
|#

## GreenplumConnection {#yandex.cloud.connectionmanager.v1.GreenplumConnection}

#|
||Field | Description ||
|| cluster | **[GreenplumCluster](#yandex.cloud.connectionmanager.v1.GreenplumCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[GreenplumAuth](#yandex.cloud.connectionmanager.v1.GreenplumAuth)** ||
|| databases[] | **string** ||
|#

## GreenplumCluster {#yandex.cloud.connectionmanager.v1.GreenplumCluster}

#|
||Field | Description ||
|| coordinator_hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.GreenplumCluster.Host)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.GreenplumCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `UNBALANCED` ||
|#

## GreenplumAuth {#yandex.cloud.connectionmanager.v1.GreenplumAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## LockboxSecret {#yandex.cloud.connectionmanager.v1.LockboxSecret}

#|
||Field | Description ||
|| id | **string** ||
|| version | **string** ||
|| newest_version | **string** ||
|#