---
editable: false
apiPlayground:
  - url: https://connman.{{ api-host }}/v1/connections
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: '**string**'
          type: string
        mdbClusterId:
          description: '**string**'
          type: string
        pageSize:
          description: '**string** (int64)'
          type: string
          format: int64
        pageToken:
          description: '**string**'
          type: string
        namePatternOrId:
          description: '**string**'
          type: string
        authorId:
          description: '**string**'
          type: string
        withCanUse:
          description: '**boolean**'
          type: boolean
        isOnpremise:
          description: '**boolean**'
          type: boolean
        isManual:
          description: '**boolean**'
          type: boolean
        dbType:
          description: |-
            **enum** (DBType)
            - `DB_TYPE_UNSPECIFIED`
            - `POSTGRESQL`
            - `MYSQL`
            - `CLICKHOUSE`
            - `MONGODB`
            - `REDIS`
            - `OPENSEARCH`
            - `TRINO`
            - `VALKEY`
            - `GREENPLUM`
          type: string
          enum:
            - DB_TYPE_UNSPECIFIED
            - POSTGRESQL
            - MYSQL
            - CLICKHOUSE
            - MONGODB
            - REDIS
            - OPENSEARCH
            - TRINO
            - VALKEY
            - GREENPLUM
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/connectionmanager/v1/api-ref/Connection/list.md
---

# Connection Manager API, REST: Connection.List

List connections in specified folder.

## HTTP request

```
GET https://connman.{{ api-host }}/v1/connections
```

## Query parameters {#yandex.cloud.connectionmanager.v1.ListConnectionRequest}

#|
||Field | Description ||
|| folderId | **string** ||
|| mdbClusterId | **string** ||
|| pageSize | **string** (int64) ||
|| pageToken | **string** ||
|| namePatternOrId | **string** ||
|| authorId | **string** ||
|| withCanUse | **boolean** ||
|| isOnpremise | **boolean** ||
|| isManual | **boolean** ||
|| dbType | **enum** (DBType)

- `DB_TYPE_UNSPECIFIED`
- `POSTGRESQL`
- `MYSQL`
- `CLICKHOUSE`
- `MONGODB`
- `REDIS`
- `OPENSEARCH`
- `TRINO`
- `VALKEY`
- `GREENPLUM` ||
|#

## Response {#yandex.cloud.connectionmanager.v1.ListConnectionResponse}

**HTTP Code: 200 - OK**

```json
{
  "connection": [
    {
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| connection[] | **[Connection](#yandex.cloud.connectionmanager.v1.Connection)** ||
|| nextPageToken | **string** ||
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
|| params | **[ConnectionParams](#yandex.cloud.connectionmanager.v1.ConnectionParams)** ||
|| lockboxSecret | **[LockboxSecret](#yandex.cloud.connectionmanager.v1.LockboxSecret)**

Includes only one of the fields `lockboxSecret`. ||
|| isManaged | **boolean** ||
|| canUse | **boolean** ||
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

## LockboxSecret {#yandex.cloud.connectionmanager.v1.LockboxSecret}

#|
||Field | Description ||
|| id | **string** ||
|| version | **string** ||
|| newestVersion | **string** ||
|#