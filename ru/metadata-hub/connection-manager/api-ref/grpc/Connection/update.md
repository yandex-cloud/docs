---
editable: false
---

# Connection Manager API, gRPC: ConnectionService.Update

Updates the specified connection.

## gRPC request

**rpc Update ([UpdateConnectionRequest](#yandex.cloud.connectionmanager.v1.UpdateConnectionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateConnectionRequest {#yandex.cloud.connectionmanager.v1.UpdateConnectionRequest}

```json
{
  "connection_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "params": {
    // Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`
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
        },
        // end of the list of possible fields
        "auth_source": "string"
      },
      "databases": [
        "string"
      ]
    },
    "clickhouse": {
      "cluster": {
        "tls_params": {
          // Includes only one of the fields `disabled`, `tls`
          "disabled": "google.protobuf.Empty",
          "tls": {
            "ca_certificate": "string"
          }
          // end of the list of possible fields
        },
        "hosts": [
          {
            "host": "string",
            "http_port": "int64",
            "tcp_port": "int64",
            "shard_name": "string",
            "health": "Health"
          }
        ],
        "shard_groups": [
          {
            "name": "string",
            "shard_names": [
              "string"
            ]
          }
        ]
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
    "kafka": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "int64",
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
        // Includes only one of the fields `sasl`, `disabled`
        "sasl": {
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
          },
          "supported_mechanisms": [
            "Mechanism"
          ]
        },
        "disabled": "google.protobuf.Empty"
        // end of the list of possible fields
      }
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
    },
    "storedoc": {
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
        },
        // end of the list of possible fields
        "auth_source": "string"
      },
      "databases": [
        "string"
      ]
    }
    // end of the list of possible fields
  }
}
```

Request message for updating an existing connection.

#|
||Field | Description ||
|| connection_id | **string**

ID of the connection to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask specifying which fields to update. ||
|| name | **string**

New name for the connection. ||
|| description | **string**

New description for the connection. ||
|| labels | **object** (map<**string**, **string**>)

New connection labels as `key:value` pairs. ||
|| params | **[ConnectionParams](#yandex.cloud.connectionmanager.v1.ConnectionParams)**

New connection parameters specific to the database or service type. ||
|#

## ConnectionParams {#yandex.cloud.connectionmanager.v1.ConnectionParams}

Connection parameters for various database and service types.

#|
||Field | Description ||
|| postgresql | **[PostgreSQLConnection](#yandex.cloud.connectionmanager.v1.PostgreSQLConnection)**

PostgreSQL database connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| mysql | **[MySQLConnection](#yandex.cloud.connectionmanager.v1.MySQLConnection)**

MySQL database connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| mongodb | **[MongoDBConnection](#yandex.cloud.connectionmanager.v1.MongoDBConnection)**

MongoDB database connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| clickhouse | **[ClickHouseConnection](#yandex.cloud.connectionmanager.v1.ClickHouseConnection)**

ClickHouse database connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| kafka | **[KafkaConnection](#yandex.cloud.connectionmanager.v1.KafkaConnection)**

Apache Kafka message broker connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| redis | **[RedisConnection](#yandex.cloud.connectionmanager.v1.RedisConnection)**

Redis in-memory data store connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| opensearch | **[OpenSearchConnection](#yandex.cloud.connectionmanager.v1.OpenSearchConnection)**

OpenSearch search engine connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| trino | **[TrinoConnection](#yandex.cloud.connectionmanager.v1.TrinoConnection)**

Trino distributed SQL query engine connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| valkey | **[ValkeyConnection](#yandex.cloud.connectionmanager.v1.ValkeyConnection)**

Valkey in-memory data store connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| greenplum | **[GreenplumConnection](#yandex.cloud.connectionmanager.v1.GreenplumConnection)**

Greenplum data warehouse connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| storedoc | **[StoreDocConnection](#yandex.cloud.connectionmanager.v1.StoreDocConnection)**

StoreDoc document store connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
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

- `MASTER`
- `REPLICA` ||
|| replica_type | enum **ReplicaType**

- `ASYNC`
- `SYNC`
- `QUORUM` ||
|| health | enum **Health**

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
punctuation characters by default: !"#$%&'()*+,-./:;&lt;=&gt;?@[\]^_`{\|}~
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

- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

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

- `PRIMARY`
- `SECONDARY` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | enum **Type**

- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## MongoDBAuth {#yandex.cloud.connectionmanager.v1.MongoDBAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|| auth_source | **string** ||
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
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host)** ||
|| shard_groups[] | **[ShardGroup](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.ShardGroup)** ||
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

## ShardGroup {#yandex.cloud.connectionmanager.v1.ClickHouseCluster.ShardGroup}

#|
||Field | Description ||
|| name | **string** ||
|| shard_names[] | **string** ||
|#

## ClickHouseAuth {#yandex.cloud.connectionmanager.v1.ClickHouseAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|#

## KafkaConnection {#yandex.cloud.connectionmanager.v1.KafkaConnection}

#|
||Field | Description ||
|| cluster | **[KafkaCluster](#yandex.cloud.connectionmanager.v1.KafkaCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[KafkaAuth](#yandex.cloud.connectionmanager.v1.KafkaAuth)** ||
|#

## KafkaCluster {#yandex.cloud.connectionmanager.v1.KafkaCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.KafkaCluster.Host)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.KafkaCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| health | enum **Health**

- `ALIVE`: Host is alive and well (all services are alive)
- `DEAD`: Host is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Host is partially alive (it can perform some of its essential functions) ||
|#

## KafkaAuth {#yandex.cloud.connectionmanager.v1.KafkaAuth}

#|
||Field | Description ||
|| sasl | **[KafkaSaslSecurity](#yandex.cloud.connectionmanager.v1.KafkaSaslSecurity)**

Includes only one of the fields `sasl`, `disabled`. ||
|| disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Includes only one of the fields `sasl`, `disabled`. ||
|#

## KafkaSaslSecurity {#yandex.cloud.connectionmanager.v1.KafkaSaslSecurity}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password)** ||
|| supported_mechanisms[] | enum **Mechanism**

- `PLAIN`
- `SCRAM_SHA256`
- `SCRAM_SHA512` ||
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

- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

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

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|| roles[] | enum **GroupRole**

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

- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

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

- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

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

## StoreDocConnection {#yandex.cloud.connectionmanager.v1.StoreDocConnection}

#|
||Field | Description ||
|| cluster | **[StoreDocCluster](#yandex.cloud.connectionmanager.v1.StoreDocCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is mutually
exclusive with "cluster". ||
|| auth | **[StoreDocAuth](#yandex.cloud.connectionmanager.v1.StoreDocAuth)** ||
|| databases[] | **string** ||
|#

## StoreDocCluster {#yandex.cloud.connectionmanager.v1.StoreDocCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.StoreDocCluster.Host)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.StoreDocCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `PRIMARY`
- `SECONDARY` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | enum **Type**

- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## StoreDocAuth {#yandex.cloud.connectionmanager.v1.StoreDocAuth}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `user_password`. ||
|| auth_source | **string** ||
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
    "connection_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "created_by": "string",
    "params": {
      // Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`
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
          },
          // end of the list of possible fields
          "auth_source": "string"
        },
        "databases": [
          "string"
        ]
      },
      "clickhouse": {
        "cluster": {
          "tls_params": {
            // Includes only one of the fields `disabled`, `tls`
            "disabled": "google.protobuf.Empty",
            "tls": {
              "ca_certificate": "string"
            }
            // end of the list of possible fields
          },
          "hosts": [
            {
              "host": "string",
              "http_port": "int64",
              "tcp_port": "int64",
              "shard_name": "string",
              "health": "Health"
            }
          ],
          "shard_groups": [
            {
              "name": "string",
              "shard_names": [
                "string"
              ]
            }
          ]
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
      "kafka": {
        "cluster": {
          "hosts": [
            {
              "host": "string",
              "port": "int64",
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
          // Includes only one of the fields `sasl`, `disabled`
          "sasl": {
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
            },
            "supported_mechanisms": [
              "Mechanism"
            ]
          },
          "disabled": "google.protobuf.Empty"
          // end of the list of possible fields
        }
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
      },
      "storedoc": {
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
          },
          // end of the list of possible fields
          "auth_source": "string"
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
    // Includes only one of the fields `lockbox_secret_spec`
    "lockbox_secret_spec": {
      "folder_id": "string"
    },
    // end of the list of possible fields
    "is_managed": "bool",
    "can_use": "google.protobuf.BoolValue"
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
|| metadata | **[UpdateConnectionMetadata](#yandex.cloud.connectionmanager.v1.UpdateConnectionMetadata)**

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
|| response | **[Connection](#yandex.cloud.connectionmanager.v1.Connection)**

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

## UpdateConnectionMetadata {#yandex.cloud.connectionmanager.v1.UpdateConnectionMetadata}

Metadata for the connection update operation.

#|
||Field | Description ||
|| connection_id | **string**

ID of the connection being updated. ||
|#

## Connection {#yandex.cloud.connectionmanager.v1.Connection}

A Connection resource represents a configured connection to a database or service.

#|
||Field | Description ||
|| id | **string**

ID of the connection. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the connection belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last update timestamp. ||
|| name | **string**

Name of the connection. ||
|| description | **string**

Description of the connection. ||
|| labels | **object** (map<**string**, **string**>)

Connection labels as `key:value` pairs. ||
|| created_by | **string**

ID of the subject which created the connection. ||
|| params | **[ConnectionParams](#yandex.cloud.connectionmanager.v1.ConnectionParams2)**

Connection parameters specific to the database or service type. ||
|| lockbox_secret | **[LockboxSecret](#yandex.cloud.connectionmanager.v1.LockboxSecret)**

Reference to the Lockbox secret containing connection credentials.

Includes only one of the fields `lockbox_secret`.

Secret configuration for authentication. ||
|| lockbox_secret_spec | **[LockboxSecretSpec](#yandex.cloud.connectionmanager.v1.LockboxSecretSpec)**

Specification for creating a new Lockbox secret.

Includes only one of the fields `lockbox_secret_spec`.

Secret specification for creating a new secret. ||
|| is_managed | **bool**

Whether this connection is managed by the system (e.g. an MDB cluster). ||
|| can_use | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether the current user can use this connection. Filled only when `with_can_use` has been requested in ListConnectionRequest. ||
|#

## ConnectionParams {#yandex.cloud.connectionmanager.v1.ConnectionParams2}

Connection parameters for various database and service types.

#|
||Field | Description ||
|| postgresql | **[PostgreSQLConnection](#yandex.cloud.connectionmanager.v1.PostgreSQLConnection2)**

PostgreSQL database connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| mysql | **[MySQLConnection](#yandex.cloud.connectionmanager.v1.MySQLConnection2)**

MySQL database connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| mongodb | **[MongoDBConnection](#yandex.cloud.connectionmanager.v1.MongoDBConnection2)**

MongoDB database connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| clickhouse | **[ClickHouseConnection](#yandex.cloud.connectionmanager.v1.ClickHouseConnection2)**

ClickHouse database connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| kafka | **[KafkaConnection](#yandex.cloud.connectionmanager.v1.KafkaConnection2)**

Apache Kafka message broker connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| redis | **[RedisConnection](#yandex.cloud.connectionmanager.v1.RedisConnection2)**

Redis in-memory data store connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| opensearch | **[OpenSearchConnection](#yandex.cloud.connectionmanager.v1.OpenSearchConnection2)**

OpenSearch search engine connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| trino | **[TrinoConnection](#yandex.cloud.connectionmanager.v1.TrinoConnection2)**

Trino distributed SQL query engine connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| valkey | **[ValkeyConnection](#yandex.cloud.connectionmanager.v1.ValkeyConnection2)**

Valkey in-memory data store connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| greenplum | **[GreenplumConnection](#yandex.cloud.connectionmanager.v1.GreenplumConnection2)**

Greenplum data warehouse connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|| storedoc | **[StoreDocConnection](#yandex.cloud.connectionmanager.v1.StoreDocConnection2)**

StoreDoc document store connection parameters.

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`.

Database or service connection configuration. ||
|#

## PostgreSQLConnection {#yandex.cloud.connectionmanager.v1.PostgreSQLConnection2}

#|
||Field | Description ||
|| cluster | **[PostgreSQLCluster](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[PostgreSQLAuth](#yandex.cloud.connectionmanager.v1.PostgreSQLAuth2)** ||
|| databases[] | **string** ||
|#

## PostgreSQLCluster {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host2)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `MASTER`
- `REPLICA` ||
|| replica_type | enum **ReplicaType**

- `ASYNC`
- `SYNC`
- `QUORUM` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|#

## TLSParams {#yandex.cloud.connectionmanager.v1.TLSParams2}

#|
||Field | Description ||
|| disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Includes only one of the fields `disabled`, `tls`. ||
|| tls | **[TLSConfig](#yandex.cloud.connectionmanager.v1.TLSConfig2)**

Includes only one of the fields `disabled`, `tls`. ||
|#

## TLSConfig {#yandex.cloud.connectionmanager.v1.TLSConfig2}

#|
||Field | Description ||
|| ca_certificate | **string** ||
|#

## PostgreSQLAuth {#yandex.cloud.connectionmanager.v1.PostgreSQLAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|#

## UserPasswordAuth {#yandex.cloud.connectionmanager.v1.UserPasswordAuth2}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password2)** ||
|#

## Password {#yandex.cloud.connectionmanager.v1.Password2}

#|
||Field | Description ||
|| raw | **string**

When creating/updating Password, the field "raw" is mutually exclusive
with "password_generation_options". In order to switch to the "raw"
password you have to explicitly clear the "password_generation_options"
field. ||
|| password_generation_options | **[PasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions2)**

When creating/updating Password, the field "password_generation_options"
is mutually exclusive with "raw". In order to switch to the
"password_generation_options" you have to explicitly clear the "raw"
field. ||
|| lockbox_secret_key | **string**

Read-only. Do not fill this field in create/update requests.

Includes only one of the fields `lockbox_secret_key`. ||
|#

## PasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions2}

#|
||Field | Description ||
|| cookie | **string**

Cookie is an arbitrary non-sensitive string that is saved with the
password. When updating PasswordGenerationOptions, if the cookie passed
in the update request differs from the cookie in the current
PasswordGenerationOptions, the password will be re-generated. If the
same cookie is passed, the password will not change. ||
|| lockbox_password_generation_options | **[LockboxPasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions2)**

Includes only one of the fields `lockbox_password_generation_options`. ||
|#

## LockboxPasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions2}

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
punctuation characters by default: !"#$%&'()*+,-./:;&lt;=&gt;?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| included_punctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use ||
|| excluded_punctuation | **string**

a string of punctuation characters to exclude from the default ||
|#

## MySQLConnection {#yandex.cloud.connectionmanager.v1.MySQLConnection2}

#|
||Field | Description ||
|| cluster | **[MySQLCluster](#yandex.cloud.connectionmanager.v1.MySQLCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[MySQLAuth](#yandex.cloud.connectionmanager.v1.MySQLAuth2)** ||
|| databases[] | **string** ||
|#

## MySQLCluster {#yandex.cloud.connectionmanager.v1.MySQLCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MySQLCluster.Host2)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MySQLCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|#

## MySQLAuth {#yandex.cloud.connectionmanager.v1.MySQLAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|#

## MongoDBConnection {#yandex.cloud.connectionmanager.v1.MongoDBConnection2}

#|
||Field | Description ||
|| cluster | **[MongoDBCluster](#yandex.cloud.connectionmanager.v1.MongoDBCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[MongoDBAuth](#yandex.cloud.connectionmanager.v1.MongoDBAuth2)** ||
|| databases[] | **string** ||
|#

## MongoDBCluster {#yandex.cloud.connectionmanager.v1.MongoDBCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MongoDBCluster.Host2)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MongoDBCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `PRIMARY`
- `SECONDARY` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | enum **Type**

- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## MongoDBAuth {#yandex.cloud.connectionmanager.v1.MongoDBAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|| auth_source | **string** ||
|#

## ClickHouseConnection {#yandex.cloud.connectionmanager.v1.ClickHouseConnection2}

#|
||Field | Description ||
|| cluster | **[ClickHouseCluster](#yandex.cloud.connectionmanager.v1.ClickHouseCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[ClickHouseAuth](#yandex.cloud.connectionmanager.v1.ClickHouseAuth2)** ||
|| databases[] | **string** ||
|#

## ClickHouseCluster {#yandex.cloud.connectionmanager.v1.ClickHouseCluster2}

#|
||Field | Description ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host2)** ||
|| shard_groups[] | **[ShardGroup](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.ShardGroup2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host2}

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

## ShardGroup {#yandex.cloud.connectionmanager.v1.ClickHouseCluster.ShardGroup2}

#|
||Field | Description ||
|| name | **string** ||
|| shard_names[] | **string** ||
|#

## ClickHouseAuth {#yandex.cloud.connectionmanager.v1.ClickHouseAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|#

## KafkaConnection {#yandex.cloud.connectionmanager.v1.KafkaConnection2}

#|
||Field | Description ||
|| cluster | **[KafkaCluster](#yandex.cloud.connectionmanager.v1.KafkaCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[KafkaAuth](#yandex.cloud.connectionmanager.v1.KafkaAuth2)** ||
|#

## KafkaCluster {#yandex.cloud.connectionmanager.v1.KafkaCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.KafkaCluster.Host2)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.KafkaCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| health | enum **Health**

- `ALIVE`: Host is alive and well (all services are alive)
- `DEAD`: Host is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Host is partially alive (it can perform some of its essential functions) ||
|#

## KafkaAuth {#yandex.cloud.connectionmanager.v1.KafkaAuth2}

#|
||Field | Description ||
|| sasl | **[KafkaSaslSecurity](#yandex.cloud.connectionmanager.v1.KafkaSaslSecurity2)**

Includes only one of the fields `sasl`, `disabled`. ||
|| disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

Includes only one of the fields `sasl`, `disabled`. ||
|#

## KafkaSaslSecurity {#yandex.cloud.connectionmanager.v1.KafkaSaslSecurity2}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password2)** ||
|| supported_mechanisms[] | enum **Mechanism**

- `PLAIN`
- `SCRAM_SHA256`
- `SCRAM_SHA512` ||
|#

## RedisConnection {#yandex.cloud.connectionmanager.v1.RedisConnection2}

#|
||Field | Description ||
|| cluster | **[RedisCluster](#yandex.cloud.connectionmanager.v1.RedisCluster2)** ||
|| auth | **[RedisAuth](#yandex.cloud.connectionmanager.v1.RedisAuth2)** ||
|| databases[] | **int64** ||
|#

## RedisCluster {#yandex.cloud.connectionmanager.v1.RedisCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.RedisCluster.Host2)** ||
|| sentinel_port | **int64** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.RedisCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| shard_name | **string** ||
|#

## RedisAuth {#yandex.cloud.connectionmanager.v1.RedisAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.RedisAuth.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|#

## UserPasswordAuth {#yandex.cloud.connectionmanager.v1.RedisAuth.UserPasswordAuth2}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password2)** ||
|#

## OpenSearchConnection {#yandex.cloud.connectionmanager.v1.OpenSearchConnection2}

#|
||Field | Description ||
|| cluster | **[OpenSearchCluster](#yandex.cloud.connectionmanager.v1.OpenSearchCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[OpenSearchAuth](#yandex.cloud.connectionmanager.v1.OpenSearchAuth2)** ||
|#

## OpenSearchCluster {#yandex.cloud.connectionmanager.v1.OpenSearchCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.OpenSearchCluster.Host2)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.OpenSearchCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|| roles[] | enum **GroupRole**

- `DATA`
- `MANAGER` ||
|#

## OpenSearchAuth {#yandex.cloud.connectionmanager.v1.OpenSearchAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|#

## TrinoConnection {#yandex.cloud.connectionmanager.v1.TrinoConnection2}

#|
||Field | Description ||
|| cluster | **[TrinoCluster](#yandex.cloud.connectionmanager.v1.TrinoCluster2)** ||
|| auth | **[TrinoAuth](#yandex.cloud.connectionmanager.v1.TrinoAuth2)** ||
|#

## TrinoCluster {#yandex.cloud.connectionmanager.v1.TrinoCluster2}

#|
||Field | Description ||
|| coordinator | **[Coordinator](#yandex.cloud.connectionmanager.v1.TrinoCluster.Coordinator2)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Coordinator {#yandex.cloud.connectionmanager.v1.TrinoCluster.Coordinator2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|#

## TrinoAuth {#yandex.cloud.connectionmanager.v1.TrinoAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|#

## ValkeyConnection {#yandex.cloud.connectionmanager.v1.ValkeyConnection2}

#|
||Field | Description ||
|| cluster | **[ValkeyCluster](#yandex.cloud.connectionmanager.v1.ValkeyCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[ValkeyAuth](#yandex.cloud.connectionmanager.v1.ValkeyAuth2)** ||
|| databases[] | **int64** ||
|#

## ValkeyCluster {#yandex.cloud.connectionmanager.v1.ValkeyCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ValkeyCluster.Host2)** ||
|| sentinel_port | **int64** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.ValkeyCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| shard_name | **string** ||
|#

## ValkeyAuth {#yandex.cloud.connectionmanager.v1.ValkeyAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.ValkeyAuth.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|#

## UserPasswordAuth {#yandex.cloud.connectionmanager.v1.ValkeyAuth.UserPasswordAuth2}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password2)** ||
|#

## GreenplumConnection {#yandex.cloud.connectionmanager.v1.GreenplumConnection2}

#|
||Field | Description ||
|| cluster | **[GreenplumCluster](#yandex.cloud.connectionmanager.v1.GreenplumCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[GreenplumAuth](#yandex.cloud.connectionmanager.v1.GreenplumAuth2)** ||
|| databases[] | **string** ||
|#

## GreenplumCluster {#yandex.cloud.connectionmanager.v1.GreenplumCluster2}

#|
||Field | Description ||
|| coordinator_hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.GreenplumCluster.Host2)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.GreenplumCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `MASTER`
- `REPLICA` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `UNBALANCED` ||
|#

## GreenplumAuth {#yandex.cloud.connectionmanager.v1.GreenplumAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|#

## StoreDocConnection {#yandex.cloud.connectionmanager.v1.StoreDocConnection2}

#|
||Field | Description ||
|| cluster | **[StoreDocCluster](#yandex.cloud.connectionmanager.v1.StoreDocCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managed_cluster_id | **string**

When creating/updating Connection, the field "managed_cluster_id" is mutually
exclusive with "cluster". ||
|| auth | **[StoreDocAuth](#yandex.cloud.connectionmanager.v1.StoreDocAuth2)** ||
|| databases[] | **string** ||
|#

## StoreDocCluster {#yandex.cloud.connectionmanager.v1.StoreDocCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.StoreDocCluster.Host2)** ||
|| tls_params | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.StoreDocCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **int64** ||
|| role | enum **Role**

- `PRIMARY`
- `SECONDARY` ||
|| health | enum **Health**

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | enum **Type**

- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## StoreDocAuth {#yandex.cloud.connectionmanager.v1.StoreDocAuth2}

#|
||Field | Description ||
|| user_password | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `user_password`. ||
|| auth_source | **string** ||
|#

## LockboxSecret {#yandex.cloud.connectionmanager.v1.LockboxSecret}

Reference to a Lockbox secret.

#|
||Field | Description ||
|| id | **string**

ID of the Lockbox secret. ||
|| version | **string**

Lockbox secret version. ||
|| newest_version | **string**

The newest available version of the Lockbox secret. ||
|#

## LockboxSecretSpec {#yandex.cloud.connectionmanager.v1.LockboxSecretSpec}

Specification for creating a new Lockbox secret.

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder where the Lockbox secret will be created. If omitted, the secret will be created in the connection's folder. ||
|#