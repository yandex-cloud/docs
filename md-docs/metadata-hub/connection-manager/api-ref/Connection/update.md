[Документация Yandex Cloud](../../../../index.md) > [Yandex MetaData Hub](../../../index.md) > Connection Manager > Справочник API > [REST (англ.)](../index.md) > [Connection](index.md) > Update

# Connection Manager API, REST: Connection.Update

Updates the specified connection.

## HTTP request

```
PATCH https://connman.api.cloud.yandex.net/v1/connection/{connectionId}
```

## Path parameters

Request message for updating an existing connection.

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to update. ||
|#

## Body parameters {#yandex.cloud.connectionmanager.v1.UpdateConnectionRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "params": {
    // Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`
    "postgresql": {
      "cluster": {
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        },
        "hosts": [
          {
            "host": "string",
            "port": "string",
            "role": "string",
            "replicaType": "string",
            "health": "string"
          }
        ]
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
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
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        },
        "hosts": [
          {
            "host": "string",
            "port": "string",
            "role": "string",
            "health": "string"
          }
        ]
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
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
            "port": "string",
            "role": "string",
            "health": "string",
            "type": "string"
          }
        ],
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
          }
        },
        // end of the list of possible fields
        "authSource": "string"
      },
      "databases": [
        "string"
      ]
    },
    "clickhouse": {
      "cluster": {
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        },
        "hosts": [
          {
            "host": "string",
            "httpPort": "string",
            "tcpPort": "string",
            "shardName": "string",
            "health": "string"
          }
        ],
        "shardGroups": [
          {
            "name": "string",
            "shardNames": [
              "string"
            ]
          }
        ]
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
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
            "port": "string",
            "health": "string"
          }
        ],
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `sasl`
        "sasl": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
          },
          "supportedMechanisms": [
            "string"
          ]
        }
        // end of the list of possible fields
      }
    },
    "redis": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "string",
            "role": "string",
            "health": "string",
            "shardName": "string"
          }
        ],
        "sentinelPort": "string",
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "string"
      ]
    },
    "opensearch": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "string",
            "health": "string",
            "roles": [
              "string"
            ]
          }
        ],
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
          }
        }
        // end of the list of possible fields
      }
    },
    "trino": {
      "cluster": {
        "coordinator": {
          "host": "string",
          "port": "string"
        },
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
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
            "port": "string",
            "role": "string",
            "health": "string",
            "shardName": "string"
          }
        ],
        "sentinelPort": "string",
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
          }
        }
        // end of the list of possible fields
      },
      "databases": [
        "string"
      ]
    },
    "greenplum": {
      "cluster": {
        "coordinatorHosts": [
          {
            "host": "string",
            "port": "string",
            "role": "string",
            "health": "string"
          }
        ],
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
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
            "port": "string",
            "role": "string",
            "health": "string",
            "type": "string"
          }
        ],
        "tlsParams": {
          // Includes only one of the fields `tls`
          "tls": {
            "caCertificate": "string"
          }
          // end of the list of possible fields
        }
      },
      "managedClusterId": "string",
      "auth": {
        // Includes only one of the fields `userPassword`
        "userPassword": {
          "user": "string",
          "password": {
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string",
            // end of the list of possible fields
            "raw": "string",
            "passwordGenerationOptions": {
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              },
              // end of the list of possible fields
              "cookie": "string"
            }
          }
        },
        // end of the list of possible fields
        "authSource": "string"
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
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
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
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[PostgreSQLAuth](#yandex.cloud.connectionmanager.v1.PostgreSQLAuth)** ||
|| databases[] | **string** ||
|#

## PostgreSQLCluster {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster}

#|
||Field | Description ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host)** ||
|#

## TLSParams {#yandex.cloud.connectionmanager.v1.TLSParams}

#|
||Field | Description ||
|| tls | **[TLSConfig](#yandex.cloud.connectionmanager.v1.TLSConfig)**

Includes only one of the fields `tls`. ||
|#

## TLSConfig {#yandex.cloud.connectionmanager.v1.TLSConfig}

#|
||Field | Description ||
|| caCertificate | **string** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `MASTER`
- `REPLICA` ||
|| replicaType | **enum** (ReplicaType)

- `ASYNC`
- `SYNC`
- `QUORUM` ||
|| health | **enum** (Health)

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|#

## PostgreSQLAuth {#yandex.cloud.connectionmanager.v1.PostgreSQLAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
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
|| lockboxSecretKey | **string**

Read-only. Do not fill this field in create/update requests.

Includes only one of the fields `lockboxSecretKey`. ||
|| raw | **string**

When creating/updating Password, the field "raw" is mutually exclusive
with "password_generation_options". In order to switch to the "raw"
password you have to explicitly clear the "password_generation_options"
field. ||
|| passwordGenerationOptions | **[PasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions)**

When creating/updating Password, the field "password_generation_options"
is mutually exclusive with "raw". In order to switch to the
"password_generation_options" you have to explicitly clear the "raw"
field. ||
|#

## PasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions}

#|
||Field | Description ||
|| lockboxPasswordGenerationOptions | **[LockboxPasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions)**

Includes only one of the fields `lockboxPasswordGenerationOptions`. ||
|| cookie | **string**

Cookie is an arbitrary non-sensitive string that is saved with the
password. When updating PasswordGenerationOptions, if the cookie passed
in the update request differs from the cookie in the current
PasswordGenerationOptions, the password will be re-generated. If the
same cookie is passed, the password will not change. ||
|#

## LockboxPasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions}

#|
||Field | Description ||
|| length | **string** (int64)

password length; by default, a reasonable length will be decided ||
|| includeUppercase | **boolean**

whether at least one A..Z character is included in the password, true by default ||
|| includeLowercase | **boolean**

whether at least one a..z character is included in the password, true by default ||
|| includeDigits | **boolean**

whether at least one 0..9 character is included in the password, true by default ||
|| includePunctuation | **boolean**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default: !"#$%&'()*+,-./:;&lt;=&gt;?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| includedPunctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use ||
|| excludedPunctuation | **string**

a string of punctuation characters to exclude from the default ||
|#

## MySQLConnection {#yandex.cloud.connectionmanager.v1.MySQLConnection}

#|
||Field | Description ||
|| cluster | **[MySQLCluster](#yandex.cloud.connectionmanager.v1.MySQLCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[MySQLAuth](#yandex.cloud.connectionmanager.v1.MySQLAuth)** ||
|| databases[] | **string** ||
|#

## MySQLCluster {#yandex.cloud.connectionmanager.v1.MySQLCluster}

#|
||Field | Description ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MySQLCluster.Host)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MySQLCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|#

## MySQLAuth {#yandex.cloud.connectionmanager.v1.MySQLAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
|#

## MongoDBConnection {#yandex.cloud.connectionmanager.v1.MongoDBConnection}

#|
||Field | Description ||
|| cluster | **[MongoDBCluster](#yandex.cloud.connectionmanager.v1.MongoDBCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[MongoDBAuth](#yandex.cloud.connectionmanager.v1.MongoDBAuth)** ||
|| databases[] | **string** ||
|#

## MongoDBCluster {#yandex.cloud.connectionmanager.v1.MongoDBCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MongoDBCluster.Host)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MongoDBCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `PRIMARY`
- `SECONDARY` ||
|| health | **enum** (Health)

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | **enum** (Type)

- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## MongoDBAuth {#yandex.cloud.connectionmanager.v1.MongoDBAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
|| authSource | **string** ||
|#

## ClickHouseConnection {#yandex.cloud.connectionmanager.v1.ClickHouseConnection}

#|
||Field | Description ||
|| cluster | **[ClickHouseCluster](#yandex.cloud.connectionmanager.v1.ClickHouseCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[ClickHouseAuth](#yandex.cloud.connectionmanager.v1.ClickHouseAuth)** ||
|| databases[] | **string** ||
|#

## ClickHouseCluster {#yandex.cloud.connectionmanager.v1.ClickHouseCluster}

#|
||Field | Description ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host)** ||
|| shardGroups[] | **[ShardGroup](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.ShardGroup)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| httpPort | **string** (int64)

depends on tls params may vary as http or https ||
|| tcpPort | **string** (int64) ||
|| shardName | **string** ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|#

## ShardGroup {#yandex.cloud.connectionmanager.v1.ClickHouseCluster.ShardGroup}

#|
||Field | Description ||
|| name | **string** ||
|| shardNames[] | **string** ||
|#

## ClickHouseAuth {#yandex.cloud.connectionmanager.v1.ClickHouseAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
|#

## KafkaConnection {#yandex.cloud.connectionmanager.v1.KafkaConnection}

#|
||Field | Description ||
|| cluster | **[KafkaCluster](#yandex.cloud.connectionmanager.v1.KafkaCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[KafkaAuth](#yandex.cloud.connectionmanager.v1.KafkaAuth)** ||
|#

## KafkaCluster {#yandex.cloud.connectionmanager.v1.KafkaCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.KafkaCluster.Host)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.KafkaCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| health | **enum** (Health)

- `ALIVE`: Host is alive and well (all services are alive)
- `DEAD`: Host is inoperable (it cannot perform any of its essential functions)
- `DEGRADED`: Host is partially alive (it can perform some of its essential functions) ||
|#

## KafkaAuth {#yandex.cloud.connectionmanager.v1.KafkaAuth}

#|
||Field | Description ||
|| sasl | **[KafkaSaslSecurity](#yandex.cloud.connectionmanager.v1.KafkaSaslSecurity)**

Includes only one of the fields `sasl`. ||
|#

## KafkaSaslSecurity {#yandex.cloud.connectionmanager.v1.KafkaSaslSecurity}

#|
||Field | Description ||
|| user | **string** ||
|| password | **[Password](#yandex.cloud.connectionmanager.v1.Password)** ||
|| supportedMechanisms[] | **enum** (Mechanism)

- `PLAIN`
- `SCRAM_SHA256`
- `SCRAM_SHA512` ||
|#

## RedisConnection {#yandex.cloud.connectionmanager.v1.RedisConnection}

#|
||Field | Description ||
|| cluster | **[RedisCluster](#yandex.cloud.connectionmanager.v1.RedisCluster)** ||
|| auth | **[RedisAuth](#yandex.cloud.connectionmanager.v1.RedisAuth)** ||
|| databases[] | **string** (int64) ||
|#

## RedisCluster {#yandex.cloud.connectionmanager.v1.RedisCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.RedisCluster.Host)** ||
|| sentinelPort | **string** (int64) ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.RedisCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| shardName | **string** ||
|#

## RedisAuth {#yandex.cloud.connectionmanager.v1.RedisAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.RedisAuth.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
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
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[OpenSearchAuth](#yandex.cloud.connectionmanager.v1.OpenSearchAuth)** ||
|#

## OpenSearchCluster {#yandex.cloud.connectionmanager.v1.OpenSearchCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.OpenSearchCluster.Host)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.OpenSearchCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| health | **enum** (Health)

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|| roles[] | **enum** (GroupRole)

- `DATA`
- `MANAGER` ||
|#

## OpenSearchAuth {#yandex.cloud.connectionmanager.v1.OpenSearchAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
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
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Coordinator {#yandex.cloud.connectionmanager.v1.TrinoCluster.Coordinator}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|#

## TrinoAuth {#yandex.cloud.connectionmanager.v1.TrinoAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
|#

## ValkeyConnection {#yandex.cloud.connectionmanager.v1.ValkeyConnection}

#|
||Field | Description ||
|| cluster | **[ValkeyCluster](#yandex.cloud.connectionmanager.v1.ValkeyCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[ValkeyAuth](#yandex.cloud.connectionmanager.v1.ValkeyAuth)** ||
|| databases[] | **string** (int64) ||
|#

## ValkeyCluster {#yandex.cloud.connectionmanager.v1.ValkeyCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ValkeyCluster.Host)** ||
|| sentinelPort | **string** (int64) ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.ValkeyCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| shardName | **string** ||
|#

## ValkeyAuth {#yandex.cloud.connectionmanager.v1.ValkeyAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.ValkeyAuth.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
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
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[GreenplumAuth](#yandex.cloud.connectionmanager.v1.GreenplumAuth)** ||
|| databases[] | **string** ||
|#

## GreenplumCluster {#yandex.cloud.connectionmanager.v1.GreenplumCluster}

#|
||Field | Description ||
|| coordinatorHosts[] | **[Host](#yandex.cloud.connectionmanager.v1.GreenplumCluster.Host)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.GreenplumCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `ALIVE`
- `DEAD`
- `DEGRADED`
- `UNBALANCED` ||
|#

## GreenplumAuth {#yandex.cloud.connectionmanager.v1.GreenplumAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
|#

## StoreDocConnection {#yandex.cloud.connectionmanager.v1.StoreDocConnection}

#|
||Field | Description ||
|| cluster | **[StoreDocCluster](#yandex.cloud.connectionmanager.v1.StoreDocCluster)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is mutually
exclusive with "cluster". ||
|| auth | **[StoreDocAuth](#yandex.cloud.connectionmanager.v1.StoreDocAuth)** ||
|| databases[] | **string** ||
|#

## StoreDocCluster {#yandex.cloud.connectionmanager.v1.StoreDocCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.StoreDocCluster.Host)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.StoreDocCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `PRIMARY`
- `SECONDARY` ||
|| health | **enum** (Health)

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | **enum** (Type)

- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## StoreDocAuth {#yandex.cloud.connectionmanager.v1.StoreDocAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
|| authSource | **string** ||
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

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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