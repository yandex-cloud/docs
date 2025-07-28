---
editable: false
sourcePath: en/_api-ref/connectionmanager/v1/api-ref/Connection/update.md
---

# Connection Manager API, REST: Connection.Update

Updates specified connection.

## HTTP request

```
PATCH https://connman.{{ api-host }}/v1/connection/{connectionId}
```

## Path parameters

#|
||Field | Description ||
|| connectionId | **string**

Required field.  ||
|#

## Body parameters {#yandex.cloud.connectionmanager.v1.UpdateConnectionRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "params": {
    // Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`
    "postgresql": {
      "cluster": {
        "hosts": [
          {
            "host": "string",
            "port": "string",
            "role": "string",
            "replicaType": "string",
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
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
            "httpPort": "string",
            "tcpPort": "string",
            "shardName": "string",
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
            // end of the list of possible fields
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
            // end of the list of possible fields
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
            "raw": "string",
            "passwordGenerationOptions": {
              "cookie": "string",
              // Includes only one of the fields `lockboxPasswordGenerationOptions`
              "lockboxPasswordGenerationOptions": {
                "length": "string",
                "includeUppercase": "boolean",
                "includeLowercase": "boolean",
                "includeDigits": "boolean",
                "includePunctuation": "boolean",
                "includedPunctuation": "string",
                "excludedPunctuation": "string"
              }
              // end of the list of possible fields
            },
            // Includes only one of the fields `lockboxSecretKey`
            "lockboxSecretKey": "string"
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
  }
}
```

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
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| params | **[ConnectionParams](#yandex.cloud.connectionmanager.v1.ConnectionParams)** ||
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
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[PostgreSQLAuth](#yandex.cloud.connectionmanager.v1.PostgreSQLAuth)** ||
|| databases[] | **string** ||
|#

## PostgreSQLCluster {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| replicaType | **enum** (ReplicaType)

- `REPLICA_TYPE_UNSPECIFIED`
- `ASYNC`
- `SYNC`
- `QUORUM` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
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
|| lockboxSecretKey | **string**

Read-only. Do not fill this field in create/update requests.

Includes only one of the fields `lockboxSecretKey`. ||
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
|| lockboxPasswordGenerationOptions | **[LockboxPasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions)**

Includes only one of the fields `lockboxPasswordGenerationOptions`. ||
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
punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
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
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MySQLCluster.Host)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MySQLCluster.Host}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
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

- `ROLE_UNSPECIFIED`
- `PRIMARY`
- `SECONDARY` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | **enum** (Type)

- `TYPE_UNSPECIFIED`
- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## MongoDBAuth {#yandex.cloud.connectionmanager.v1.MongoDBAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
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
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams)** ||
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

## ClickHouseAuth {#yandex.cloud.connectionmanager.v1.ClickHouseAuth}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth)**

Includes only one of the fields `userPassword`. ||
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

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
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

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|| roles[] | **enum** (GroupRole)

- `GROUP_ROLE_UNSPECIFIED`
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

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
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

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
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
    "connectionId": "string"
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
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "updatedAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "createdBy": "string",
    "params": {
      // Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`
      "postgresql": {
        "cluster": {
          "hosts": [
            {
              "host": "string",
              "port": "string",
              "role": "string",
              "replicaType": "string",
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
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
              "httpPort": "string",
              "tcpPort": "string",
              "shardName": "string",
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
              // end of the list of possible fields
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
              // end of the list of possible fields
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
              "raw": "string",
              "passwordGenerationOptions": {
                "cookie": "string",
                // Includes only one of the fields `lockboxPasswordGenerationOptions`
                "lockboxPasswordGenerationOptions": {
                  "length": "string",
                  "includeUppercase": "boolean",
                  "includeLowercase": "boolean",
                  "includeDigits": "boolean",
                  "includePunctuation": "boolean",
                  "includedPunctuation": "string",
                  "excludedPunctuation": "string"
                }
                // end of the list of possible fields
              },
              // Includes only one of the fields `lockboxSecretKey`
              "lockboxSecretKey": "string"
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
    // Includes only one of the fields `lockboxSecret`
    "lockboxSecret": {
      "id": "string",
      "version": "string",
      "newestVersion": "string"
    },
    // end of the list of possible fields
    "isManaged": "boolean",
    "canUse": "boolean"
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
|| metadata | **[UpdateConnectionMetadata](#yandex.cloud.connectionmanager.v1.UpdateConnectionMetadata)**

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

#|
||Field | Description ||
|| connectionId | **string** ||
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

## Connection {#yandex.cloud.connectionmanager.v1.Connection}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| createdBy | **string** ||
|| params | **[ConnectionParams](#yandex.cloud.connectionmanager.v1.ConnectionParams2)** ||
|| lockboxSecret | **[LockboxSecret](#yandex.cloud.connectionmanager.v1.LockboxSecret)**

Includes only one of the fields `lockboxSecret`. ||
|| isManaged | **boolean** ||
|| canUse | **boolean** ||
|#

## ConnectionParams {#yandex.cloud.connectionmanager.v1.ConnectionParams2}

#|
||Field | Description ||
|| postgresql | **[PostgreSQLConnection](#yandex.cloud.connectionmanager.v1.PostgreSQLConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| mysql | **[MySQLConnection](#yandex.cloud.connectionmanager.v1.MySQLConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| mongodb | **[MongoDBConnection](#yandex.cloud.connectionmanager.v1.MongoDBConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| clickhouse | **[ClickHouseConnection](#yandex.cloud.connectionmanager.v1.ClickHouseConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| redis | **[RedisConnection](#yandex.cloud.connectionmanager.v1.RedisConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| opensearch | **[OpenSearchConnection](#yandex.cloud.connectionmanager.v1.OpenSearchConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| trino | **[TrinoConnection](#yandex.cloud.connectionmanager.v1.TrinoConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| valkey | **[ValkeyConnection](#yandex.cloud.connectionmanager.v1.ValkeyConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|| greenplum | **[GreenplumConnection](#yandex.cloud.connectionmanager.v1.GreenplumConnection2)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`. ||
|#

## PostgreSQLConnection {#yandex.cloud.connectionmanager.v1.PostgreSQLConnection2}

#|
||Field | Description ||
|| cluster | **[PostgreSQLCluster](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[PostgreSQLAuth](#yandex.cloud.connectionmanager.v1.PostgreSQLAuth2)** ||
|| databases[] | **string** ||
|#

## PostgreSQLCluster {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host2)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.PostgreSQLCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| replicaType | **enum** (ReplicaType)

- `REPLICA_TYPE_UNSPECIFIED`
- `ASYNC`
- `SYNC`
- `QUORUM` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|#

## TLSParams {#yandex.cloud.connectionmanager.v1.TLSParams2}

#|
||Field | Description ||
|| tls | **[TLSConfig](#yandex.cloud.connectionmanager.v1.TLSConfig2)**

Includes only one of the fields `tls`. ||
|#

## TLSConfig {#yandex.cloud.connectionmanager.v1.TLSConfig2}

#|
||Field | Description ||
|| caCertificate | **string** ||
|#

## PostgreSQLAuth {#yandex.cloud.connectionmanager.v1.PostgreSQLAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
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
|| passwordGenerationOptions | **[PasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions2)**

When creating/updating Password, the field "password_generation_options"
is mutually exclusive with "raw". In order to switch to the
"password_generation_options" you have to explicitly clear the "raw"
field. ||
|| lockboxSecretKey | **string**

Read-only. Do not fill this field in create/update requests.

Includes only one of the fields `lockboxSecretKey`. ||
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
|| lockboxPasswordGenerationOptions | **[LockboxPasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions2)**

Includes only one of the fields `lockboxPasswordGenerationOptions`. ||
|#

## LockboxPasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions2}

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
punctuation characters by default: !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| includedPunctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use ||
|| excludedPunctuation | **string**

a string of punctuation characters to exclude from the default ||
|#

## MySQLConnection {#yandex.cloud.connectionmanager.v1.MySQLConnection2}

#|
||Field | Description ||
|| cluster | **[MySQLCluster](#yandex.cloud.connectionmanager.v1.MySQLCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[MySQLAuth](#yandex.cloud.connectionmanager.v1.MySQLAuth2)** ||
|| databases[] | **string** ||
|#

## MySQLCluster {#yandex.cloud.connectionmanager.v1.MySQLCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MySQLCluster.Host2)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MySQLCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|#

## MySQLAuth {#yandex.cloud.connectionmanager.v1.MySQLAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
|#

## MongoDBConnection {#yandex.cloud.connectionmanager.v1.MongoDBConnection2}

#|
||Field | Description ||
|| cluster | **[MongoDBCluster](#yandex.cloud.connectionmanager.v1.MongoDBCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[MongoDBAuth](#yandex.cloud.connectionmanager.v1.MongoDBAuth2)** ||
|| databases[] | **string** ||
|#

## MongoDBCluster {#yandex.cloud.connectionmanager.v1.MongoDBCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.MongoDBCluster.Host2)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.MongoDBCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `ROLE_UNSPECIFIED`
- `PRIMARY`
- `SECONDARY` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| type | **enum** (Type)

- `TYPE_UNSPECIFIED`
- `MONGOD`
- `MONGOS`
- `MONGOINFRA` ||
|#

## MongoDBAuth {#yandex.cloud.connectionmanager.v1.MongoDBAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
|#

## ClickHouseConnection {#yandex.cloud.connectionmanager.v1.ClickHouseConnection2}

#|
||Field | Description ||
|| cluster | **[ClickHouseCluster](#yandex.cloud.connectionmanager.v1.ClickHouseCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[ClickHouseAuth](#yandex.cloud.connectionmanager.v1.ClickHouseAuth2)** ||
|| databases[] | **string** ||
|#

## ClickHouseCluster {#yandex.cloud.connectionmanager.v1.ClickHouseCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host2)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.ClickHouseCluster.Host2}

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

## ClickHouseAuth {#yandex.cloud.connectionmanager.v1.ClickHouseAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
|#

## RedisConnection {#yandex.cloud.connectionmanager.v1.RedisConnection2}

#|
||Field | Description ||
|| cluster | **[RedisCluster](#yandex.cloud.connectionmanager.v1.RedisCluster2)** ||
|| auth | **[RedisAuth](#yandex.cloud.connectionmanager.v1.RedisAuth2)** ||
|| databases[] | **string** (int64) ||
|#

## RedisCluster {#yandex.cloud.connectionmanager.v1.RedisCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.RedisCluster.Host2)** ||
|| sentinelPort | **string** (int64) ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.RedisCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| shardName | **string** ||
|#

## RedisAuth {#yandex.cloud.connectionmanager.v1.RedisAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.RedisAuth.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
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
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[OpenSearchAuth](#yandex.cloud.connectionmanager.v1.OpenSearchAuth2)** ||
|#

## OpenSearchCluster {#yandex.cloud.connectionmanager.v1.OpenSearchCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.OpenSearchCluster.Host2)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.OpenSearchCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `READONLY` ||
|| roles[] | **enum** (GroupRole)

- `GROUP_ROLE_UNSPECIFIED`
- `DATA`
- `MANAGER` ||
|#

## OpenSearchAuth {#yandex.cloud.connectionmanager.v1.OpenSearchAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
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
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Coordinator {#yandex.cloud.connectionmanager.v1.TrinoCluster.Coordinator2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|#

## TrinoAuth {#yandex.cloud.connectionmanager.v1.TrinoAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
|#

## ValkeyConnection {#yandex.cloud.connectionmanager.v1.ValkeyConnection2}

#|
||Field | Description ||
|| cluster | **[ValkeyCluster](#yandex.cloud.connectionmanager.v1.ValkeyCluster2)**

When creating/updating Connection, the field "cluster" is mutually
exclusive with "managed_cluster_id". ||
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[ValkeyAuth](#yandex.cloud.connectionmanager.v1.ValkeyAuth2)** ||
|| databases[] | **string** (int64) ||
|#

## ValkeyCluster {#yandex.cloud.connectionmanager.v1.ValkeyCluster2}

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.connectionmanager.v1.ValkeyCluster.Host2)** ||
|| sentinelPort | **string** (int64) ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.ValkeyCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| shardName | **string** ||
|#

## ValkeyAuth {#yandex.cloud.connectionmanager.v1.ValkeyAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.ValkeyAuth.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
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
|| managedClusterId | **string**

When creating/updating Connection, the field "managed_cluster_id" is
mutually exclusive with "cluster". ||
|| auth | **[GreenplumAuth](#yandex.cloud.connectionmanager.v1.GreenplumAuth2)** ||
|| databases[] | **string** ||
|#

## GreenplumCluster {#yandex.cloud.connectionmanager.v1.GreenplumCluster2}

#|
||Field | Description ||
|| coordinatorHosts[] | **[Host](#yandex.cloud.connectionmanager.v1.GreenplumCluster.Host2)** ||
|| tlsParams | **[TLSParams](#yandex.cloud.connectionmanager.v1.TLSParams2)** ||
|#

## Host {#yandex.cloud.connectionmanager.v1.GreenplumCluster.Host2}

#|
||Field | Description ||
|| host | **string** ||
|| port | **string** (int64) ||
|| role | **enum** (Role)

- `ROLE_UNSPECIFIED`
- `MASTER`
- `REPLICA` ||
|| health | **enum** (Health)

- `HEALTH_UNSPECIFIED`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `UNBALANCED` ||
|#

## GreenplumAuth {#yandex.cloud.connectionmanager.v1.GreenplumAuth2}

#|
||Field | Description ||
|| userPassword | **[UserPasswordAuth](#yandex.cloud.connectionmanager.v1.UserPasswordAuth2)**

Includes only one of the fields `userPassword`. ||
|#

## LockboxSecret {#yandex.cloud.connectionmanager.v1.LockboxSecret}

#|
||Field | Description ||
|| id | **string** ||
|| version | **string** ||
|| newestVersion | **string** ||
|#