---
editable: false
sourcePath: en/_api-ref/datatransfer/v1/api-ref/Endpoint/get.md
---

# Data Transfer API, REST: Endpoint.Get

Returns the specified endpoint.

To get the list of all available endpoints, make a [List](/docs/data-transfer/api-ref/Endpoint/list#List) request.

## HTTP request

```
GET https://{{ api-host-data-transfer }}/v1/endpoint/{endpointId}
```

## Path parameters

#|
||Field | Description ||
|| endpointId | **string**

Required field. Identifier of the endpoint to return.

To get the endpoint ID, make an [EndpointService.List](/docs/data-transfer/api-ref/Endpoint/list#List) request. ||
|#

## Response {#yandex.cloud.datatransfer.v1.Endpoint}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "settings": {
    // Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`
    "mysqlSource": {
      "connection": {
        // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
        "mdbClusterId": "string",
        "onPremise": {
          "port": "string",
          "subnetId": "string",
          "hosts": [
            "string"
          ],
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connectionManagerConnection": {
          "connectionId": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "timezone": "string",
      "objectTransferSettings": {
        "view": "string",
        "routine": "string",
        "trigger": "string",
        "tables": "string"
      },
      "includeTablesRegex": [
        "string"
      ],
      "excludeTablesRegex": [
        "string"
      ],
      "securityGroups": [
        "string"
      ],
      "serviceDatabase": "string"
    },
    "postgresSource": {
      "connection": {
        // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
        "mdbClusterId": "string",
        "onPremise": {
          "port": "string",
          "subnetId": "string",
          "hosts": [
            "string"
          ],
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connectionManagerConnection": {
          "connectionId": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "includeTables": [
        "string"
      ],
      "excludeTables": [
        "string"
      ],
      "slotByteLagLimit": "string",
      "serviceSchema": "string",
      "objectTransferSettings": {
        "sequence": "string",
        "sequenceOwnedBy": "string",
        "table": "string",
        "primaryKey": "string",
        "fkConstraint": "string",
        "defaultValues": "string",
        "constraint": "string",
        "index": "string",
        "view": "string",
        "function": "string",
        "trigger": "string",
        "type": "string",
        "rule": "string",
        "collation": "string",
        "policy": "string",
        "cast": "string",
        "materializedView": "string",
        "sequenceSet": "string"
      },
      "securityGroups": [
        "string"
      ]
    },
    "ydbSource": {
      "database": "string",
      "instance": "string",
      "paths": [
        "string"
      ],
      "serviceAccountId": "string",
      "subnetId": "string",
      "saKeyContent": "string",
      "securityGroups": [
        "string"
      ],
      "changefeedCustomName": "string",
      "changefeedCustomConsumerName": "string"
    },
    "ydsSource": {
      "database": "string",
      "stream": "string",
      "serviceAccountId": "string",
      "supportedCodecs": [
        "string"
      ],
      "parser": {
        // Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`
        "jsonParser": {
          "dataSchema": {
            // Includes only one of the fields `jsonFields`, `fields`
            "jsonFields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "string",
                  "key": "boolean",
                  "required": "boolean",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "nullKeysAllowed": "boolean",
          "addRestColumn": "boolean",
          "unescapeStringValues": "boolean"
        },
        "auditTrailsV1Parser": "object",
        "cloudLoggingParser": "object",
        "tskvParser": {
          "dataSchema": {
            // Includes only one of the fields `jsonFields`, `fields`
            "jsonFields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "string",
                  "key": "boolean",
                  "required": "boolean",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "nullKeysAllowed": "boolean",
          "addRestColumn": "boolean",
          "unescapeStringValues": "boolean"
        }
        // end of the list of possible fields
      },
      "allowTtlRewind": "boolean",
      "endpoint": "string",
      "subnetId": "string",
      "securityGroups": [
        "string"
      ],
      "consumer": "string"
    },
    "kafkaSource": {
      "connection": {
        // Includes only one of the fields `clusterId`, `onPremise`
        "clusterId": "string",
        "onPremise": {
          "brokerUrls": [
            "string"
          ],
          "subnetId": "string",
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "auth": {
        // Includes only one of the fields `sasl`, `noAuth`
        "sasl": {
          "user": "string",
          "mechanism": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          }
        },
        "noAuth": "object"
        // end of the list of possible fields
      },
      "securityGroups": [
        "string"
      ],
      "topicName": "string",
      "transformer": {
        "cloudFunction": "string",
        "numberOfRetries": "string",
        "bufferSize": "string",
        "bufferFlushInterval": "string",
        "invocationTimeout": "string",
        "serviceAccountId": "string"
      },
      "parser": {
        // Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`
        "jsonParser": {
          "dataSchema": {
            // Includes only one of the fields `jsonFields`, `fields`
            "jsonFields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "string",
                  "key": "boolean",
                  "required": "boolean",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "nullKeysAllowed": "boolean",
          "addRestColumn": "boolean",
          "unescapeStringValues": "boolean"
        },
        "auditTrailsV1Parser": "object",
        "cloudLoggingParser": "object",
        "tskvParser": {
          "dataSchema": {
            // Includes only one of the fields `jsonFields`, `fields`
            "jsonFields": "string",
            "fields": {
              "fields": [
                {
                  "name": "string",
                  "type": "string",
                  "key": "boolean",
                  "required": "boolean",
                  "path": "string"
                }
              ]
            }
            // end of the list of possible fields
          },
          "nullKeysAllowed": "boolean",
          "addRestColumn": "boolean",
          "unescapeStringValues": "boolean"
        }
        // end of the list of possible fields
      },
      "topicNames": [
        "string"
      ]
    },
    "mongoSource": {
      "connection": {
        // Includes only one of the fields `connectionOptions`
        "connectionOptions": {
          // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "replicaSet": "string",
            "tlsMode": {
              // Includes only one of the fields `enabled`
              "enabled": {
                "caCertificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connectionManagerConnection": {
            "connectionId": "string",
            "replicaSet": "string"
          },
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "authSource": "string"
        }
        // end of the list of possible fields
      },
      "subnetId": "string",
      "collections": [
        {
          "databaseName": "string",
          "collectionName": "string"
        }
      ],
      "excludedCollections": [
        {
          "databaseName": "string",
          "collectionName": "string"
        }
      ],
      "secondaryPreferredMode": "boolean",
      "securityGroups": [
        "string"
      ]
    },
    "clickhouseSource": {
      "connection": {
        // Includes only one of the fields `connectionOptions`
        "connectionOptions": {
          // Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`
          "onPremise": {
            "shards": [
              {
                "name": "string",
                "hosts": [
                  "string"
                ]
              }
            ],
            "httpPort": "string",
            "nativePort": "string",
            "tlsMode": {
              // Includes only one of the fields `enabled`
              "enabled": {
                "caCertificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connectionManagerConnection": {
            "connectionId": "string"
          },
          "mdbClusterId": "string",
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "database": "string"
        }
        // end of the list of possible fields
      },
      "includeTables": [
        "string"
      ],
      "excludeTables": [
        "string"
      ],
      "subnetId": "string",
      "securityGroups": [
        "string"
      ],
      "clickhouseClusterName": "string"
    },
    "mysqlTarget": {
      "connection": {
        // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
        "mdbClusterId": "string",
        "onPremise": {
          "port": "string",
          "subnetId": "string",
          "hosts": [
            "string"
          ],
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connectionManagerConnection": {
          "connectionId": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "sqlMode": "string",
      "skipConstraintChecks": "boolean",
      "timezone": "string",
      "cleanupPolicy": "string",
      "serviceDatabase": "string",
      "securityGroups": [
        "string"
      ],
      "isSchemaMigrationDisabled": "boolean"
    },
    "postgresTarget": {
      "connection": {
        // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
        "mdbClusterId": "string",
        "onPremise": {
          "port": "string",
          "subnetId": "string",
          "hosts": [
            "string"
          ],
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        },
        "connectionManagerConnection": {
          "connectionId": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "user": "string",
      "password": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "cleanupPolicy": "string",
      "securityGroups": [
        "string"
      ],
      "isSchemaMigrationDisabled": "boolean"
    },
    "clickhouseTarget": {
      "connection": {
        // Includes only one of the fields `connectionOptions`
        "connectionOptions": {
          // Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`
          "onPremise": {
            "shards": [
              {
                "name": "string",
                "hosts": [
                  "string"
                ]
              }
            ],
            "httpPort": "string",
            "nativePort": "string",
            "tlsMode": {
              // Includes only one of the fields `enabled`
              "enabled": {
                "caCertificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connectionManagerConnection": {
            "connectionId": "string"
          },
          "mdbClusterId": "string",
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "database": "string"
        }
        // end of the list of possible fields
      },
      "subnetId": "string",
      "altNames": [
        {
          "fromName": "string",
          "toName": "string"
        }
      ],
      "cleanupPolicy": "string",
      "sharding": {
        // Includes only one of the fields `columnValueHash`, `customMapping`
        "columnValueHash": {
          "columnName": "string"
        },
        "customMapping": {
          "columnName": "string",
          "mapping": [
            {
              "columnValue": {
                // Includes only one of the fields `stringValue`
                "stringValue": "string"
                // end of the list of possible fields
              },
              "shardName": "string"
            }
          ]
        }
        // end of the list of possible fields
      },
      "isSchemaMigrationDisabled": "boolean",
      "clickhouseClusterName": "string",
      "securityGroups": [
        "string"
      ]
    },
    "ydbTarget": {
      "database": "string",
      "instance": "string",
      "path": "string",
      "serviceAccountId": "string",
      "cleanupPolicy": "string",
      "subnetId": "string",
      "saKeyContent": "string",
      "securityGroups": [
        "string"
      ],
      "isTableColumnOriented": "boolean",
      "defaultCompression": "string",
      "isSchemaMigrationDisabled": "boolean"
    },
    "kafkaTarget": {
      "connection": {
        // Includes only one of the fields `clusterId`, `onPremise`
        "clusterId": "string",
        "onPremise": {
          "brokerUrls": [
            "string"
          ],
          "subnetId": "string",
          "tlsMode": {
            // Includes only one of the fields `enabled`
            "enabled": {
              "caCertificate": "string"
            }
            // end of the list of possible fields
          }
        }
        // end of the list of possible fields
      },
      "auth": {
        // Includes only one of the fields `sasl`, `noAuth`
        "sasl": {
          "user": "string",
          "mechanism": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          }
        },
        "noAuth": "object"
        // end of the list of possible fields
      },
      "securityGroups": [
        "string"
      ],
      "topicSettings": {
        // Includes only one of the fields `topic`, `topicPrefix`
        "topic": {
          "topicName": "string",
          "saveTxOrder": "boolean"
        },
        "topicPrefix": "string"
        // end of the list of possible fields
      },
      "serializer": {
        // Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`
        "serializerAuto": "object",
        "serializerJson": "object",
        "serializerDebezium": {
          "serializerParameters": [
            {
              "key": "string",
              "value": "string"
            }
          ]
        }
        // end of the list of possible fields
      }
    },
    "mongoTarget": {
      "connection": {
        // Includes only one of the fields `connectionOptions`
        "connectionOptions": {
          // Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "replicaSet": "string",
            "tlsMode": {
              // Includes only one of the fields `enabled`
              "enabled": {
                "caCertificate": "string"
              }
              // end of the list of possible fields
            }
          },
          "connectionManagerConnection": {
            "connectionId": "string",
            "replicaSet": "string"
          },
          // end of the list of possible fields
          "user": "string",
          "password": {
            // Includes only one of the fields `raw`
            "raw": "string"
            // end of the list of possible fields
          },
          "authSource": "string"
        }
        // end of the list of possible fields
      },
      "database": "string",
      "cleanupPolicy": "string",
      "subnetId": "string",
      "securityGroups": [
        "string"
      ]
    },
    "metrikaSource": {
      "counterIds": [
        "string"
      ],
      "token": {
        // Includes only one of the fields `raw`
        "raw": "string"
        // end of the list of possible fields
      },
      "streams": [
        {
          "type": "string",
          "columns": [
            "string"
          ]
        }
      ]
    },
    "ydsTarget": {
      "database": "string",
      "stream": "string",
      "serviceAccountId": "string",
      "saveTxOrder": "boolean",
      "compressionCodec": "string",
      "serializer": {
        // Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`
        "serializerAuto": "object",
        "serializerJson": "object",
        "serializerDebezium": {
          "serializerParameters": [
            {
              "key": "string",
              "value": "string"
            }
          ]
        }
        // end of the list of possible fields
      },
      "endpoint": "string",
      "subnetId": "string",
      "securityGroups": [
        "string"
      ]
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| settings | **[EndpointSettings](#yandex.cloud.datatransfer.v1.EndpointSettings)** ||
|#

## EndpointSettings {#yandex.cloud.datatransfer.v1.EndpointSettings}

#|
||Field | Description ||
|| mysqlSource | **[MysqlSource](#yandex.cloud.datatransfer.v1.endpoint.MysqlSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| postgresSource | **[PostgresSource](#yandex.cloud.datatransfer.v1.endpoint.PostgresSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| ydbSource | **[YdbSource](#yandex.cloud.datatransfer.v1.endpoint.YdbSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| ydsSource | **[YDSSource](#yandex.cloud.datatransfer.v1.endpoint.YDSSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| kafkaSource | **[KafkaSource](#yandex.cloud.datatransfer.v1.endpoint.KafkaSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| mongoSource | **[MongoSource](#yandex.cloud.datatransfer.v1.endpoint.MongoSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| clickhouseSource | **[ClickhouseSource](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| mysqlTarget | **[MysqlTarget](#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| postgresTarget | **[PostgresTarget](#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| clickhouseTarget | **[ClickhouseTarget](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| ydbTarget | **[YdbTarget](#yandex.cloud.datatransfer.v1.endpoint.YdbTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| kafkaTarget | **[KafkaTarget](#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| mongoTarget | **[MongoTarget](#yandex.cloud.datatransfer.v1.endpoint.MongoTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| metrikaSource | **[MetrikaSource](#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|| ydsTarget | **[YDSTarget](#yandex.cloud.datatransfer.v1.endpoint.YDSTarget)**

Includes only one of the fields `mysqlSource`, `postgresSource`, `ydbSource`, `ydsSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `ydbTarget`, `kafkaTarget`, `mongoTarget`, `metrikaSource`, `ydsTarget`. ||
|#

## MysqlSource {#yandex.cloud.datatransfer.v1.endpoint.MysqlSource}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Database name

You can leave it empty, then it will be possible to transfer tables from several
databases at the same time from this source. ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| objectTransferSettings | **[MysqlObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings)**

Schema migration

Select database objects to be transferred during activation or deactivation. ||
|| includeTablesRegex[] | **string** ||
|| excludeTablesRegex[] | **string** ||
|| securityGroups[] | **string**

Security groups ||
|| serviceDatabase | **string**

Database for service tables

Default: data source database. Here created technical tables (__tm_keeper,
__tm_gtid_keeper). ||
|#

## MysqlConnection {#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection}

#|
||Field | Description ||
|| mdbClusterId | **string**

Managed Service for MySQL cluster ID

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseMysql](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql)**

Connection options for on-premise MySQL

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremiseMysql {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql}

#|
||Field | Description ||
|| port | **string** (int64)

Database port ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| hosts[] | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## TLSMode {#yandex.cloud.datatransfer.v1.endpoint.TLSMode}

#|
||Field | Description ||
|| enabled | **[TLSConfig](#yandex.cloud.datatransfer.v1.endpoint.TLSConfig)**

Includes only one of the fields `enabled`. ||
|#

## TLSConfig {#yandex.cloud.datatransfer.v1.endpoint.TLSConfig}

#|
||Field | Description ||
|| caCertificate | **string**

CA certificate

X.509 certificate of the certificate authority which issued the server's
certificate, in PEM format. When CA certificate is specified TLS is used to
connect to the server. ||
|#

## ConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection}

#|
||Field | Description ||
|| connectionId | **string** ||
|#

## Secret {#yandex.cloud.datatransfer.v1.endpoint.Secret}

#|
||Field | Description ||
|| raw | **string**

Raw secret value

Includes only one of the fields `raw`. ||
|#

## MysqlObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings}

#|
||Field | Description ||
|| view | **enum** (ObjectTransferStage)

Views

CREATE VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| routine | **enum** (ObjectTransferStage)

Routines

CREATE PROCEDURE ... ; CREATE FUNCTION ... ;

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | **enum** (ObjectTransferStage)

Triggers

CREATE TRIGGER ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| tables | **enum** (ObjectTransferStage)

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## PostgresSource {#yandex.cloud.datatransfer.v1.endpoint.PostgresSource}

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Database name ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| includeTables[] | **string**

Included tables

If none or empty list is presented, all tables are replicated. Full table name
with schema. Can contain schema_name.* patterns. ||
|| excludeTables[] | **string**

Excluded tables

If none or empty list is presented, all tables are replicated. Full table name
with schema. Can contain schema_name.* patterns. ||
|| slotByteLagLimit | **string** (int64)

Maximum lag of replication slot (in bytes); after exceeding this limit
replication will be aborted. ||
|| serviceSchema | **string**

Database schema for service tables (__consumer_keeper,
__data_transfer_mole_finder). Default is public ||
|| objectTransferSettings | **[PostgresObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings)**

Select database objects to be transferred during activation or deactivation. ||
|| securityGroups[] | **string**

Security groups ||
|#

## PostgresConnection {#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection}

#|
||Field | Description ||
|| mdbClusterId | **string**

Managed Service for PostgreSQL cluster ID

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremisePostgres](#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres)**

Connection options for on-premise PostgreSQL

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremisePostgres {#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres}

#|
||Field | Description ||
|| port | **string** (int64)

Will be used if the cluster ID is not specified. ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| hosts[] | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## PostgresObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings}

#|
||Field | Description ||
|| sequence | **enum** (ObjectTransferStage)

Sequences

CREATE SEQUENCE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequenceOwnedBy | **enum** (ObjectTransferStage)

Owned sequences

CREATE SEQUENCE ... OWNED BY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| table | **enum** (ObjectTransferStage)

Tables

CREATE TABLE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| primaryKey | **enum** (ObjectTransferStage)

Primary keys

ALTER TABLE ... ADD PRIMARY KEY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| fkConstraint | **enum** (ObjectTransferStage)

Foreign keys

ALTER TABLE ... ADD FOREIGN KEY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| defaultValues | **enum** (ObjectTransferStage)

Default values

ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| constraint | **enum** (ObjectTransferStage)

Constraints

ALTER TABLE ... ADD CONSTRAINT ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| index | **enum** (ObjectTransferStage)

Indexes

CREATE INDEX ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| view | **enum** (ObjectTransferStage)

Views

CREATE VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| function | **enum** (ObjectTransferStage)

Functions

CREATE FUNCTION ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | **enum** (ObjectTransferStage)

Triggers

CREATE TRIGGER ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| type | **enum** (ObjectTransferStage)

Types

CREATE TYPE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| rule | **enum** (ObjectTransferStage)

Rules

CREATE RULE ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| collation | **enum** (ObjectTransferStage)

Collations

CREATE COLLATION ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| policy | **enum** (ObjectTransferStage)

Policies

CREATE POLICY ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| cast | **enum** (ObjectTransferStage)

Casts

CREATE CAST ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| materializedView | **enum** (ObjectTransferStage)

Materialized views

CREATE MATERIALIZED VIEW ...

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequenceSet | **enum** (ObjectTransferStage)

- `OBJECT_TRANSFER_STAGE_UNSPECIFIED`
- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## YdbSource {#yandex.cloud.datatransfer.v1.endpoint.YdbSource}

#|
||Field | Description ||
|| database | **string**

Path in YDB where to store tables ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 ||
|| paths[] | **string** ||
|| serviceAccountId | **string** ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| saKeyContent | **string**

Authorization Key ||
|| securityGroups[] | **string**

Security groups ||
|| changefeedCustomName | **string**

Pre-created change feed ||
|| changefeedCustomConsumerName | **string** ||
|#

## YDSSource {#yandex.cloud.datatransfer.v1.endpoint.YDSSource}

#|
||Field | Description ||
|| database | **string**

Database ||
|| stream | **string**

Stream ||
|| serviceAccountId | **string**

SA which has read access to the stream. ||
|| supportedCodecs[] | **enum** (YdsCompressionCodec)

Compression codec

- `YDS_COMPRESSION_CODEC_UNSPECIFIED`
- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing rules ||
|| allowTtlRewind | **boolean**

Should continue working, if consumer read lag exceed TTL of topic
False: stop the transfer in error state, if detected lost data. True: continue
working with losing part of data ||
|| endpoint | **string**

for dedicated db ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| securityGroups[] | **string**

Security groups ||
|| consumer | **string**

for important streams ||
|#

## Parser {#yandex.cloud.datatransfer.v1.endpoint.Parser}

#|
||Field | Description ||
|| jsonParser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| auditTrailsV1Parser | **object**

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| cloudLoggingParser | **object**

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| tskvParser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|#

## GenericParserCommon {#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon}

#|
||Field | Description ||
|| dataSchema | **[DataSchema](#yandex.cloud.datatransfer.v1.endpoint.DataSchema)** ||
|| nullKeysAllowed | **boolean**

Allow null keys, if no - null keys will be putted to unparsed data ||
|| addRestColumn | **boolean**

Will add _rest column for all unknown fields ||
|| unescapeStringValues | **boolean**

Unescape string values ||
|#

## DataSchema {#yandex.cloud.datatransfer.v1.endpoint.DataSchema}

#|
||Field | Description ||
|| jsonFields | **string**

Includes only one of the fields `jsonFields`, `fields`. ||
|| fields | **[FieldList](#yandex.cloud.datatransfer.v1.endpoint.FieldList)**

Includes only one of the fields `jsonFields`, `fields`. ||
|#

## FieldList {#yandex.cloud.datatransfer.v1.endpoint.FieldList}

#|
||Field | Description ||
|| fields[] | **[ColSchema](#yandex.cloud.datatransfer.v1.endpoint.ColSchema)**

Column schema ||
|#

## ColSchema {#yandex.cloud.datatransfer.v1.endpoint.ColSchema}

#|
||Field | Description ||
|| name | **string** ||
|| type | **enum** (ColumnType)

- `COLUMN_TYPE_UNSPECIFIED`
- `INT32`
- `INT16`
- `INT8`
- `UINT64`
- `UINT32`
- `UINT16`
- `UINT8`
- `DOUBLE`
- `BOOLEAN`
- `STRING`
- `UTF8`
- `ANY`
- `DATETIME`
- `INT64` ||
|| key | **boolean** ||
|| required | **boolean** ||
|| path | **string** ||
|#

## KafkaSource {#yandex.cloud.datatransfer.v1.endpoint.KafkaSource}

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| securityGroups[] | **string**

Security groups ||
|| topicName | **string**

Full source topic name
Deprecated in favor of topic names ||
|| transformer | **[DataTransformationOptions](#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions)**

Data transformation rules ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing rules ||
|| topicNames[] | **string**

List of topic names to read ||
|#

## KafkaConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions}

#|
||Field | Description ||
|| clusterId | **string**

Managed Service for Kafka cluster ID

Includes only one of the fields `clusterId`, `onPremise`. ||
|| onPremise | **[OnPremiseKafka](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka)**

Connection options for on-premise Kafka

Includes only one of the fields `clusterId`, `onPremise`. ||
|#

## OnPremiseKafka {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka}

#|
||Field | Description ||
|| brokerUrls[] | **string**

Kafka broker URLs ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for broker connection. Disabled by default. ||
|#

## KafkaAuth {#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth}

#|
||Field | Description ||
|| sasl | **[KafkaSaslSecurity](#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity)**

Authentication with SASL

Includes only one of the fields `sasl`, `noAuth`. ||
|| noAuth | **object**

No authentication

Includes only one of the fields `sasl`, `noAuth`. ||
|#

## KafkaSaslSecurity {#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity}

#|
||Field | Description ||
|| user | **string**

User name ||
|| mechanism | **enum** (KafkaMechanism)

SASL mechanism for authentication

- `KAFKA_MECHANISM_UNSPECIFIED`
- `KAFKA_MECHANISM_SHA256`
- `KAFKA_MECHANISM_SHA512` ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|#

## DataTransformationOptions {#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions}

#|
||Field | Description ||
|| cloudFunction | **string**

Cloud function ||
|| numberOfRetries | **string** (int64)

Number of retries ||
|| bufferSize | **string**

Buffer size for function ||
|| bufferFlushInterval | **string**

Flush interval ||
|| invocationTimeout | **string**

Invocation timeout ||
|| serviceAccountId | **string**

Service account ||
|#

## MongoSource {#yandex.cloud.datatransfer.v1.endpoint.MongoSource}

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)** ||
|| subnetId | **string** ||
|| collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of collections for replication. Empty list implies replication of all
tables on the deployment. Allowed to use * as collection name. ||
|| excludedCollections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of forbidden collections for replication. Allowed to use * as collection
name for forbid all collections of concrete schema. ||
|| secondaryPreferredMode | **boolean**

Read mode for mongo client ||
|| securityGroups[] | **string**

Security groups ||
|#

## MongoConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnection}

#|
||Field | Description ||
|| connectionOptions | **[MongoConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionOptions)**

Includes only one of the fields `connectionOptions`. ||
|#

## MongoConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionOptions}

#|
||Field | Description ||
|| mdbClusterId | **string**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseMongo](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[MongoConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| user | **string**

User name ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|| authSource | **string**

Database name associated with the credentials ||
|#

## OnPremiseMongo {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo}

#|
||Field | Description ||
|| hosts[] | **string** ||
|| port | **string** (int64) ||
|| replicaSet | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
|#

## MongoConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection}

#|
||Field | Description ||
|| connectionId | **string** ||
|| replicaSet | **string**

Used only for on-premise connections ||
|#

## MongoCollection {#yandex.cloud.datatransfer.v1.endpoint.MongoCollection}

#|
||Field | Description ||
|| databaseName | **string** ||
|| collectionName | **string** ||
|#

## ClickhouseSource {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)** ||
|| includeTables[] | **string**

White list of tables for replication. If none or empty list is presented - will
replicate all tables. Can contain * patterns. ||
|| excludeTables[] | **string**

Exclude list of tables for replication. If none or empty list is presented -
will replicate all tables. Can contain * patterns. ||
|| subnetId | **string** ||
|| securityGroups[] | **string** ||
|| clickhouseClusterName | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup. ||
|#

## ClickhouseConnection {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection}

#|
||Field | Description ||
|| connectionOptions | **[ClickhouseConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnectionOptions)**

Includes only one of the fields `connectionOptions`. ||
|#

## ClickhouseConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnectionOptions}

#|
||Field | Description ||
|| onPremise | **[OnPremiseClickhouse](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse)**

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| mdbClusterId | **string**

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| user | **string** ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| database | **string**

Database ||
|#

## OnPremiseClickhouse {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse}

#|
||Field | Description ||
|| shards[] | **[ClickhouseShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard)** ||
|| httpPort | **string** (int64) ||
|| nativePort | **string** (int64) ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
|#

## ClickhouseShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard}

#|
||Field | Description ||
|| name | **string** ||
|| hosts[] | **string** ||
|#

## MysqlTarget {#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget}

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Database name

Allowed to leave it empty, then the tables will be created in databases with the
same names as on the source. If this field is empty, then you must fill below db
schema for service table. ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| sqlMode | **string**

Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. ||
|| skipConstraintChecks | **boolean**

Disable constraints checks

Recommend to disable for increase replication speed, but if schema contain
cascading operations we don't recommend to disable. This option set
FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Cleanup policy

Cleanup policy for activate, reactivate and reupload processes. Default is
DISABLED.

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| serviceDatabase | **string**

Database schema for service table

Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). ||
|| securityGroups[] | **string**

Security groups ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## PostgresTarget {#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget}

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Database name ||
|| user | **string**

User for database access. not required as may be in connection ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Cleanup policy for activate, reactivate and reupload processes. Default is
truncate.

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| securityGroups[] | **string**

Security groups ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## ClickhouseTarget {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)** ||
|| subnetId | **string** ||
|| altNames[] | **[AltName](#yandex.cloud.datatransfer.v1.endpoint.AltName)**

Alternative table names in target ||
|| cleanupPolicy | **enum** (ClickhouseCleanupPolicy)

- `CLICKHOUSE_CLEANUP_POLICY_UNSPECIFIED`
- `CLICKHOUSE_CLEANUP_POLICY_DISABLED`
- `CLICKHOUSE_CLEANUP_POLICY_DROP`
- `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` ||
|| sharding | **[ClickhouseSharding](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding)** ||
|| isSchemaMigrationDisabled | **boolean** ||
|| clickhouseClusterName | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup. ||
|| securityGroups[] | **string** ||
|#

## AltName {#yandex.cloud.datatransfer.v1.endpoint.AltName}

#|
||Field | Description ||
|| fromName | **string**

Source table name ||
|| toName | **string**

Target table name ||
|#

## ClickhouseSharding {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding}

#|
||Field | Description ||
|| columnValueHash | **[ColumnValueHash](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash)**

Includes only one of the fields `columnValueHash`, `customMapping`. ||
|| customMapping | **[ColumnValueMapping](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping)**

Includes only one of the fields `columnValueHash`, `customMapping`. ||
|#

## ColumnValueHash {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash}

#|
||Field | Description ||
|| columnName | **string** ||
|#

## ColumnValueMapping {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping}

#|
||Field | Description ||
|| columnName | **string** ||
|| mapping[] | **[ValueToShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard)** ||
|#

## ValueToShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard}

#|
||Field | Description ||
|| columnValue | **[ColumnValue](#yandex.cloud.datatransfer.v1.endpoint.ColumnValue)** ||
|| shardName | **string** ||
|#

## ColumnValue {#yandex.cloud.datatransfer.v1.endpoint.ColumnValue}

#|
||Field | Description ||
|| stringValue | **string**

Includes only one of the fields `stringValue`. ||
|#

## YdbTarget {#yandex.cloud.datatransfer.v1.endpoint.YdbTarget}

#|
||Field | Description ||
|| database | **string**

Path in YDB where to store tables ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 ||
|| path | **string**

Path extension for database, each table will be layouted into this path ||
|| serviceAccountId | **string** ||
|| cleanupPolicy | **enum** (YdbCleanupPolicy)

Cleanup policy

- `YDB_CLEANUP_POLICY_UNSPECIFIED`
- `YDB_CLEANUP_POLICY_DISABLED`
- `YDB_CLEANUP_POLICY_DROP` ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| saKeyContent | **string**

SA content ||
|| securityGroups[] | **string**

Security groups ||
|| isTableColumnOriented | **boolean**

Should create column-oriented table (OLAP). By default it creates row-oriented
(OLTP) ||
|| defaultCompression | **enum** (YdbDefaultCompression)

Compression that will be used for default columns family on YDB table creation

- `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`
- `YDB_DEFAULT_COMPRESSION_DISABLED`
- `YDB_DEFAULT_COMPRESSION_LZ4` ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## KafkaTarget {#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget}

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| securityGroups[] | **string**

Security groups ||
|| topicSettings | **[KafkaTargetTopicSettings](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings)**

Target topic settings ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format settings ||
|#

## KafkaTargetTopicSettings {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings}

#|
||Field | Description ||
|| topic | **[KafkaTargetTopic](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic)**

Full topic name

Includes only one of the fields `topic`, `topicPrefix`. ||
|| topicPrefix | **string**

Topic prefix

Analogue of the Debezium setting database.server.name.
Messages will be sent to topic with name <topic_prefix>.<schema>.<table_name>.

Includes only one of the fields `topic`, `topicPrefix`. ||
|#

## KafkaTargetTopic {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic}

#|
||Field | Description ||
|| topicName | **string**

Topic name ||
|| saveTxOrder | **boolean**

Save transactions order
Not to split events queue into separate per-table queues. ||
|#

## Serializer {#yandex.cloud.datatransfer.v1.endpoint.Serializer}

Data serialization format

#|
||Field | Description ||
|| serializerAuto | **object**

Select the serialization format automatically

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerJson | **object**

Serialize data in json format

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerDebezium | **[SerializerDebezium](#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium)**

Serialize data in debezium format

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|#

## SerializerDebezium {#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium}

#|
||Field | Description ||
|| serializerParameters[] | **[DebeziumSerializerParameter](#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter)**

Settings of sterilization parameters as key-value pairs ||
|#

## DebeziumSerializerParameter {#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter}

#|
||Field | Description ||
|| key | **string**

Name of the serializer parameter ||
|| value | **string**

Value of the serializer parameter ||
|#

## MongoTarget {#yandex.cloud.datatransfer.v1.endpoint.MongoTarget}

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)** ||
|| database | **string**

Database name ||
|| cleanupPolicy | **enum** (CleanupPolicy)

- `CLEANUP_POLICY_UNSPECIFIED`
- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| subnetId | **string** ||
|| securityGroups[] | **string**

Security groups ||
|#

## MetrikaSource {#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource}

#|
||Field | Description ||
|| counterIds[] | **string** (int64) ||
|| token | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| streams[] | **[MetrikaStream](#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream)** ||
|#

## MetrikaStream {#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream}

#|
||Field | Description ||
|| type | **enum** (MetrikaStreamType)

- `METRIKA_STREAM_TYPE_UNSPECIFIED`
- `METRIKA_STREAM_TYPE_HITS`
- `METRIKA_STREAM_TYPE_VISITS`
- `METRIKA_STREAM_TYPE_HITS_V2` ||
|| columns[] | **string** ||
|#

## YDSTarget {#yandex.cloud.datatransfer.v1.endpoint.YDSTarget}

#|
||Field | Description ||
|| database | **string**

Database ||
|| stream | **string**

Stream ||
|| serviceAccountId | **string**

SA which has read access to the stream. ||
|| saveTxOrder | **boolean**

Save transaction order
Not to split events queue into separate per-table queues.
Incompatible with setting Topic prefix, only with Topic full name. ||
|| compressionCodec | **enum** (YdsCompressionCodec)

- `YDS_COMPRESSION_CODEC_UNSPECIFIED`
- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format ||
|| endpoint | **string**

for dedicated db ||
|| subnetId | **string**

Network interface for endpoint. If none will assume public ipv4 ||
|| securityGroups[] | **string**

Security groups ||
|#