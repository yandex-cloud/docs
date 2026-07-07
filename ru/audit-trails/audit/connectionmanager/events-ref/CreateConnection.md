---
editable: false
---

# Connection Manager Audit Trails Events: CreateConnection

## Event JSON schema {#yandex.cloud.audit.connectionmanager.CreateConnection2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "connectionId": "string",
    // Includes only one of the fields `connectionName`
    "connectionName": "string",
    // end of the list of possible fields
    "connection": {
      // Includes only one of the fields `lockboxSecret`
      "lockboxSecret": {
        "id": "string",
        "version": "string",
        "newestVersion": "string"
      },
      // end of the list of possible fields
      // Includes only one of the fields `lockboxSecretSpec`
      "lockboxSecretSpec": {
        "folderId": "string"
      },
      // end of the list of possible fields
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "createdBy": "string",
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
      },
      "isManaged": "boolean",
      "canUse": "boolean"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.connectionmanager.CreateConnection2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ConnectionEventDetails](#yandex.cloud.audit.connectionmanager.ConnectionEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## ConnectionEventDetails {#yandex.cloud.audit.connectionmanager.ConnectionEventDetails}

#|
||Field | Description ||
|| connectionId | **string**

The maximum string length in characters is 50. ||
|| connectionName | **string**

Includes only one of the fields `connectionName`. ||
|| connection | **[Connection](#yandex.cloud.connectionmanager.v1.Connection)** ||
|#

## Connection {#yandex.cloud.connectionmanager.v1.Connection}

#|
||Field | Description ||
|| lockboxSecret | **[LockboxSecret](#yandex.cloud.connectionmanager.v1.LockboxSecret)**

Includes only one of the fields `lockboxSecret`. ||
|| lockboxSecretSpec | **[LockboxSecretSpec](#yandex.cloud.connectionmanager.v1.LockboxSecretSpec)**

Includes only one of the fields `lockboxSecretSpec`. ||
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
|| isManaged | **boolean** ||
|| canUse | **boolean** ||
|#

## LockboxSecret {#yandex.cloud.connectionmanager.v1.LockboxSecret}

#|
||Field | Description ||
|| id | **string** ||
|| version | **string** ||
|| newestVersion | **string** ||
|#

## LockboxSecretSpec {#yandex.cloud.connectionmanager.v1.LockboxSecretSpec}

#|
||Field | Description ||
|| folderId | **string** ||
|#

## ConnectionParams {#yandex.cloud.connectionmanager.v1.ConnectionParams}

#|
||Field | Description ||
|| postgresql | **[PostgreSQLConnection](#yandex.cloud.connectionmanager.v1.PostgreSQLConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| mysql | **[MySQLConnection](#yandex.cloud.connectionmanager.v1.MySQLConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| mongodb | **[MongoDBConnection](#yandex.cloud.connectionmanager.v1.MongoDBConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| clickhouse | **[ClickHouseConnection](#yandex.cloud.connectionmanager.v1.ClickHouseConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| kafka | **[KafkaConnection](#yandex.cloud.connectionmanager.v1.KafkaConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| redis | **[RedisConnection](#yandex.cloud.connectionmanager.v1.RedisConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| opensearch | **[OpenSearchConnection](#yandex.cloud.connectionmanager.v1.OpenSearchConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| trino | **[TrinoConnection](#yandex.cloud.connectionmanager.v1.TrinoConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| valkey | **[ValkeyConnection](#yandex.cloud.connectionmanager.v1.ValkeyConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| greenplum | **[GreenplumConnection](#yandex.cloud.connectionmanager.v1.GreenplumConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|| storedoc | **[StoreDocConnection](#yandex.cloud.connectionmanager.v1.StoreDocConnection)**

Includes only one of the fields `postgresql`, `mysql`, `mongodb`, `clickhouse`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `storedoc`. ||
|#

## PostgreSQLConnection {#yandex.cloud.connectionmanager.v1.PostgreSQLConnection}

#|
||Field | Description ||
|| cluster | **[PostgreSQLCluster](#yandex.cloud.connectionmanager.v1.PostgreSQLCluster)** ||
|| managedClusterId | **string** ||
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

Includes only one of the fields `lockboxSecretKey`. ||
|| raw | **string** ||
|| passwordGenerationOptions | **[PasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions)** ||
|#

## PasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.PasswordGenerationOptions}

#|
||Field | Description ||
|| lockboxPasswordGenerationOptions | **[LockboxPasswordGenerationOptions](#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions)**

Includes only one of the fields `lockboxPasswordGenerationOptions`. ||
|| cookie | **string** ||
|#

## LockboxPasswordGenerationOptions {#yandex.cloud.connectionmanager.v1.LockboxPasswordGenerationOptions}

#|
||Field | Description ||
|| length | **string** (int64) ||
|| includeUppercase | **boolean** ||
|| includeLowercase | **boolean** ||
|| includeDigits | **boolean** ||
|| includePunctuation | **boolean** ||
|| includedPunctuation | **string** ||
|| excludedPunctuation | **string** ||
|#

## MySQLConnection {#yandex.cloud.connectionmanager.v1.MySQLConnection}

#|
||Field | Description ||
|| cluster | **[MySQLCluster](#yandex.cloud.connectionmanager.v1.MySQLCluster)** ||
|| managedClusterId | **string** ||
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
|| cluster | **[MongoDBCluster](#yandex.cloud.connectionmanager.v1.MongoDBCluster)** ||
|| managedClusterId | **string** ||
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
|| cluster | **[ClickHouseCluster](#yandex.cloud.connectionmanager.v1.ClickHouseCluster)** ||
|| managedClusterId | **string** ||
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
|| httpPort | **string** (int64) ||
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
|| cluster | **[KafkaCluster](#yandex.cloud.connectionmanager.v1.KafkaCluster)** ||
|| managedClusterId | **string** ||
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

- `ALIVE`
- `DEAD`
- `DEGRADED` ||
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
|| cluster | **[OpenSearchCluster](#yandex.cloud.connectionmanager.v1.OpenSearchCluster)** ||
|| managedClusterId | **string** ||
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
|| cluster | **[ValkeyCluster](#yandex.cloud.connectionmanager.v1.ValkeyCluster)** ||
|| managedClusterId | **string** ||
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
|| cluster | **[GreenplumCluster](#yandex.cloud.connectionmanager.v1.GreenplumCluster)** ||
|| managedClusterId | **string** ||
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
|| cluster | **[StoreDocCluster](#yandex.cloud.connectionmanager.v1.StoreDocCluster)** ||
|| managedClusterId | **string** ||
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