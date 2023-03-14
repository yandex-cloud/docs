---
editable: false
sourcePath: en/_api-ref/datatransfer/api-ref/Transfer/get.md
---

# Data Transfer API, REST: Transfer.get

 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-data-transfer }}/v1/transfer/{transferId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
transferId | 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "source": {
    "id": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "settings": {

      // `source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`
      "mysqlSource": {
        "connection": {

          // `source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`source.settings.mysqlSource.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`source.settings.mysqlSource.connection`

        },
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "serviceDatabase": "string",
        "user": "string",
        "password": {
          "raw": "string"
        },
        "includeTablesRegex": [
          "string"
        ],
        "excludeTablesRegex": [
          "string"
        ],
        "timezone": "string",
        "objectTransferSettings": {
          "view": "string",
          "routine": "string",
          "trigger": "string",
          "tables": "string"
        }
      },
      "postgresSource": {
        "connection": {

          // `source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`source.settings.postgresSource.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`source.settings.postgresSource.connection`

        },
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
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
          "sequenceSet": "string",
          "table": "string",
          "primaryKey": "string",
          "fkConstraint": "string",
          "defaultValues": "string",
          "constraint": "string",
          "index": "string",
          "view": "string",
          "materializedView": "string",
          "function": "string",
          "trigger": "string",
          "type": "string",
          "rule": "string",
          "collation": "string",
          "policy": "string",
          "cast": "string"
        }
      },
      "kafkaSource": {
        "connection": {

          // `source.settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`
          "clusterId": "string",
          "onPremise": {
            "brokerUrls": [
              "string"
            ],
            "tlsMode": {

              // `source.settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`source.settings.kafkaSource.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`source.settings.kafkaSource.connection`

        },
        "auth": {

          // `source.settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`
          "sasl": {
            "user": "string",
            "password": {
              "raw": "string"
            },
            "mechanism": "string"
          },
          "noAuth": {},
          // end of the list of possible fields`source.settings.kafkaSource.auth`

        },
        "securityGroups": [
          "string"
        ],
        "topicName": "string",
        "transformer": {
          "cloudFunction": "string",
          "serviceAccountId": "string",
          "numberOfRetries": "string",
          "bufferSize": "string",
          "bufferFlushInterval": "string",
          "invocationTimeout": "string"
        },
        "parser": {

          // `source.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`
          "jsonParser": {
            "dataSchema": {

              // `source.settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`
              "fields": {
                "fields": [
                  {
                    "name": "string",
                    "type": "string",
                    "key": true,
                    "required": true,
                    "path": "string"
                  }
                ]
              },
              "jsonFields": "string",
              // end of the list of possible fields`source.settings.kafkaSource.parser.jsonParser.dataSchema`

            },
            "nullKeysAllowed": true,
            "addRestColumn": true
          },
          "auditTrailsV1Parser": {},
          "cloudLoggingParser": {},
          "tskvParser": {
            "dataSchema": {

              // `source.settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`
              "fields": {
                "fields": [
                  {
                    "name": "string",
                    "type": "string",
                    "key": true,
                    "required": true,
                    "path": "string"
                  }
                ]
              },
              "jsonFields": "string",
              // end of the list of possible fields`source.settings.kafkaSource.parser.tskvParser.dataSchema`

            },
            "nullKeysAllowed": true,
            "addRestColumn": true
          },
          // end of the list of possible fields`source.settings.kafkaSource.parser`

        }
      },
      "mongoSource": {
        "connection": {
          "connectionOptions": {
            "user": "string",
            "password": {
              "raw": "string"
            },
            "authSource": "string",

            // `source.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
            "onPremise": {
              "hosts": [
                "string"
              ],
              "port": "string",
              "tlsMode": {

                // `source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode`

              },
              "replicaSet": "string"
            },
            // end of the list of possible fields`source.settings.mongoSource.connection.connectionOptions`

          }
        },
        "subnetId": "string",
        "securityGroups": [
          "string"
        ],
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
        "secondaryPreferredMode": true
      },
      "clickhouseSource": {
        "connection": {
          "connectionOptions": {
            "database": "string",
            "user": "string",
            "password": {
              "raw": "string"
            },

            // `source.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
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

                // `source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode`

              }
            },
            // end of the list of possible fields`source.settings.clickhouseSource.connection.connectionOptions`

          }
        },
        "subnetId": "string",
        "securityGroups": [
          "string"
        ],
        "includeTables": [
          "string"
        ],
        "excludeTables": [
          "string"
        ]
      },
      "mysqlTarget": {
        "connection": {

          // `source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`source.settings.mysqlTarget.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`source.settings.mysqlTarget.connection`

        },
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
        },
        "sqlMode": "string",
        "skipConstraintChecks": true,
        "timezone": "string",
        "cleanupPolicy": "string",
        "serviceDatabase": "string"
      },
      "postgresTarget": {
        "connection": {

          // `source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`source.settings.postgresTarget.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`source.settings.postgresTarget.connection`

        },
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
        },
        "cleanupPolicy": "string"
      },
      "clickhouseTarget": {
        "connection": {
          "connectionOptions": {
            "database": "string",
            "user": "string",
            "password": {
              "raw": "string"
            },

            // `source.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
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

                // `source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode`

              }
            },
            // end of the list of possible fields`source.settings.clickhouseTarget.connection.connectionOptions`

          }
        },
        "subnetId": "string",
        "securityGroups": [
          "string"
        ],
        "clickhouseClusterName": "string",
        "altNames": [
          {
            "fromName": "string",
            "toName": "string"
          }
        ],
        "sharding": {

          // `source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`
          "columnValueHash": {
            "columnName": "string"
          },
          "customMapping": {
            "columnName": "string",
            "mapping": [
              {
                "columnValue": {
                  "stringValue": "string"
                },
                "shardName": "string"
              }
            ]
          },
          "transferId": "object",
          // end of the list of possible fields`source.settings.clickhouseTarget.sharding`

        },
        "cleanupPolicy": "string"
      },
      "kafkaTarget": {
        "connection": {

          // `source.settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`
          "clusterId": "string",
          "onPremise": {
            "brokerUrls": [
              "string"
            ],
            "tlsMode": {

              // `source.settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`source.settings.kafkaTarget.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`source.settings.kafkaTarget.connection`

        },
        "auth": {

          // `source.settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`
          "sasl": {
            "user": "string",
            "password": {
              "raw": "string"
            },
            "mechanism": "string"
          },
          "noAuth": {},
          // end of the list of possible fields`source.settings.kafkaTarget.auth`

        },
        "securityGroups": [
          "string"
        ],
        "topicSettings": {

          // `source.settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`
          "topic": {
            "topicName": "string",
            "saveTxOrder": true
          },
          "topicPrefix": "string",
          // end of the list of possible fields`source.settings.kafkaTarget.topicSettings`

        }
      },
      "mongoTarget": {
        "connection": {
          "connectionOptions": {
            "user": "string",
            "password": {
              "raw": "string"
            },
            "authSource": "string",

            // `source.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
            "onPremise": {
              "hosts": [
                "string"
              ],
              "port": "string",
              "tlsMode": {

                // `source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode`

              },
              "replicaSet": "string"
            },
            // end of the list of possible fields`source.settings.mongoTarget.connection.connectionOptions`

          }
        },
        "subnetId": "string",
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "cleanupPolicy": "string"
      },
      // end of the list of possible fields`source.settings`

    }
  },
  "target": {
    "id": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "settings": {

      // `target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`
      "mysqlSource": {
        "connection": {

          // `target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`target.settings.mysqlSource.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`target.settings.mysqlSource.connection`

        },
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "serviceDatabase": "string",
        "user": "string",
        "password": {
          "raw": "string"
        },
        "includeTablesRegex": [
          "string"
        ],
        "excludeTablesRegex": [
          "string"
        ],
        "timezone": "string",
        "objectTransferSettings": {
          "view": "string",
          "routine": "string",
          "trigger": "string",
          "tables": "string"
        }
      },
      "postgresSource": {
        "connection": {

          // `target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`target.settings.postgresSource.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`target.settings.postgresSource.connection`

        },
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
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
          "sequenceSet": "string",
          "table": "string",
          "primaryKey": "string",
          "fkConstraint": "string",
          "defaultValues": "string",
          "constraint": "string",
          "index": "string",
          "view": "string",
          "materializedView": "string",
          "function": "string",
          "trigger": "string",
          "type": "string",
          "rule": "string",
          "collation": "string",
          "policy": "string",
          "cast": "string"
        }
      },
      "kafkaSource": {
        "connection": {

          // `target.settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`
          "clusterId": "string",
          "onPremise": {
            "brokerUrls": [
              "string"
            ],
            "tlsMode": {

              // `target.settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`target.settings.kafkaSource.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`target.settings.kafkaSource.connection`

        },
        "auth": {

          // `target.settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`
          "sasl": {
            "user": "string",
            "password": {
              "raw": "string"
            },
            "mechanism": "string"
          },
          "noAuth": {},
          // end of the list of possible fields`target.settings.kafkaSource.auth`

        },
        "securityGroups": [
          "string"
        ],
        "topicName": "string",
        "transformer": {
          "cloudFunction": "string",
          "serviceAccountId": "string",
          "numberOfRetries": "string",
          "bufferSize": "string",
          "bufferFlushInterval": "string",
          "invocationTimeout": "string"
        },
        "parser": {

          // `target.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`
          "jsonParser": {
            "dataSchema": {

              // `target.settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`
              "fields": {
                "fields": [
                  {
                    "name": "string",
                    "type": "string",
                    "key": true,
                    "required": true,
                    "path": "string"
                  }
                ]
              },
              "jsonFields": "string",
              // end of the list of possible fields`target.settings.kafkaSource.parser.jsonParser.dataSchema`

            },
            "nullKeysAllowed": true,
            "addRestColumn": true
          },
          "auditTrailsV1Parser": {},
          "cloudLoggingParser": {},
          "tskvParser": {
            "dataSchema": {

              // `target.settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`
              "fields": {
                "fields": [
                  {
                    "name": "string",
                    "type": "string",
                    "key": true,
                    "required": true,
                    "path": "string"
                  }
                ]
              },
              "jsonFields": "string",
              // end of the list of possible fields`target.settings.kafkaSource.parser.tskvParser.dataSchema`

            },
            "nullKeysAllowed": true,
            "addRestColumn": true
          },
          // end of the list of possible fields`target.settings.kafkaSource.parser`

        }
      },
      "mongoSource": {
        "connection": {
          "connectionOptions": {
            "user": "string",
            "password": {
              "raw": "string"
            },
            "authSource": "string",

            // `target.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
            "onPremise": {
              "hosts": [
                "string"
              ],
              "port": "string",
              "tlsMode": {

                // `target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode`

              },
              "replicaSet": "string"
            },
            // end of the list of possible fields`target.settings.mongoSource.connection.connectionOptions`

          }
        },
        "subnetId": "string",
        "securityGroups": [
          "string"
        ],
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
        "secondaryPreferredMode": true
      },
      "clickhouseSource": {
        "connection": {
          "connectionOptions": {
            "database": "string",
            "user": "string",
            "password": {
              "raw": "string"
            },

            // `target.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
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

                // `target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode`

              }
            },
            // end of the list of possible fields`target.settings.clickhouseSource.connection.connectionOptions`

          }
        },
        "subnetId": "string",
        "securityGroups": [
          "string"
        ],
        "includeTables": [
          "string"
        ],
        "excludeTables": [
          "string"
        ]
      },
      "mysqlTarget": {
        "connection": {

          // `target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`target.settings.mysqlTarget.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`target.settings.mysqlTarget.connection`

        },
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
        },
        "sqlMode": "string",
        "skipConstraintChecks": true,
        "timezone": "string",
        "cleanupPolicy": "string",
        "serviceDatabase": "string"
      },
      "postgresTarget": {
        "connection": {

          // `target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`target.settings.postgresTarget.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`target.settings.postgresTarget.connection`

        },
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
        },
        "cleanupPolicy": "string"
      },
      "clickhouseTarget": {
        "connection": {
          "connectionOptions": {
            "database": "string",
            "user": "string",
            "password": {
              "raw": "string"
            },

            // `target.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
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

                // `target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode`

              }
            },
            // end of the list of possible fields`target.settings.clickhouseTarget.connection.connectionOptions`

          }
        },
        "subnetId": "string",
        "securityGroups": [
          "string"
        ],
        "clickhouseClusterName": "string",
        "altNames": [
          {
            "fromName": "string",
            "toName": "string"
          }
        ],
        "sharding": {

          // `target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`
          "columnValueHash": {
            "columnName": "string"
          },
          "customMapping": {
            "columnName": "string",
            "mapping": [
              {
                "columnValue": {
                  "stringValue": "string"
                },
                "shardName": "string"
              }
            ]
          },
          "transferId": "object",
          // end of the list of possible fields`target.settings.clickhouseTarget.sharding`

        },
        "cleanupPolicy": "string"
      },
      "kafkaTarget": {
        "connection": {

          // `target.settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`
          "clusterId": "string",
          "onPremise": {
            "brokerUrls": [
              "string"
            ],
            "tlsMode": {

              // `target.settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`target.settings.kafkaTarget.connection.onPremise.tlsMode`

            },
            "subnetId": "string"
          },
          // end of the list of possible fields`target.settings.kafkaTarget.connection`

        },
        "auth": {

          // `target.settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`
          "sasl": {
            "user": "string",
            "password": {
              "raw": "string"
            },
            "mechanism": "string"
          },
          "noAuth": {},
          // end of the list of possible fields`target.settings.kafkaTarget.auth`

        },
        "securityGroups": [
          "string"
        ],
        "topicSettings": {

          // `target.settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`
          "topic": {
            "topicName": "string",
            "saveTxOrder": true
          },
          "topicPrefix": "string",
          // end of the list of possible fields`target.settings.kafkaTarget.topicSettings`

        }
      },
      "mongoTarget": {
        "connection": {
          "connectionOptions": {
            "user": "string",
            "password": {
              "raw": "string"
            },
            "authSource": "string",

            // `target.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
            "onPremise": {
              "hosts": [
                "string"
              ],
              "port": "string",
              "tlsMode": {

                // `target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode`

              },
              "replicaSet": "string"
            },
            // end of the list of possible fields`target.settings.mongoTarget.connection.connectionOptions`

          }
        },
        "subnetId": "string",
        "securityGroups": [
          "string"
        ],
        "database": "string",
        "cleanupPolicy": "string"
      },
      // end of the list of possible fields`target.settings`

    }
  },
  "status": "string",
  "type": "string",
  "warning": "string"
}
```
Transfer core entity
 
Field | Description
--- | ---
id | **string**
folderId | **string**
name | **string**
description | **string**
labels | **object**
source | **object**
source.<br>id | **string**
source.<br>folderId | **string**
source.<br>name | **string**
source.<br>description | **string**
source.<br>labels | **object**
source.<br>settings | **object**
source.<br>settings.<br>mysqlSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>mysqlSource.<br>connection | **object**<br><p>Database connection settings</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for MySQL cluster ID</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise MySQL <br>`source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
source.<br>settings.<br>mysqlSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
source.<br>settings.<br>mysqlSource.<br>serviceDatabase | **string**<br><p>Database for service tables</p> <p>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
source.<br>settings.<br>mysqlSource.<br>user | **string**<br><p>User for database access.</p> 
source.<br>settings.<br>mysqlSource.<br>password | **object**<br><p>Password for database access.</p> 
source.<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**
source.<br>settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**
source.<br>settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>tables | **string**<br><ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>postgresSource.<br>connection | **object**<br><p>Database connection settings</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for PostgreSQL cluster ID</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise PostgreSQL <br>`source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Will be used if the cluster ID is not specified.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
source.<br>settings.<br>postgresSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
source.<br>settings.<br>postgresSource.<br>user | **string**<br><p>User for database access.</p> 
source.<br>settings.<br>postgresSource.<br>password | **object**<br><p>Password for database access.</p> 
source.<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
source.<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
source.<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum lag of replication slot (in bytes); after exceeding this limit replication will be aborted.</p> 
source.<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service tables (__consumer_keeper, __data_transfer_mole_finder). Default is public</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br><p>Select database objects to be transferred during activation or deactivation.</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br><p>Sequences</p> <p>CREATE SEQUENCE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br><p>Owned sequences</p> <p>CREATE SEQUENCE ... OWNED BY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceSet | **string**<br><ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br><p>Tables</p> <p>CREATE TABLE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br><p>Primary keys</p> <p>ALTER TABLE ... ADD PRIMARY KEY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br><p>Foreign keys</p> <p>ALTER TABLE ... ADD FOREIGN KEY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br><p>Default values</p> <p>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br><p>Constraints</p> <p>ALTER TABLE ... ADD CONSTRAINT ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br><p>Indexes</p> <p>CREATE INDEX ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>materializedView | **string**<br><p>Materialized views</p> <p>CREATE MATERIALIZED VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br><p>Functions</p> <p>CREATE FUNCTION ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br><p>Types</p> <p>CREATE TYPE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br><p>Rules</p> <p>CREATE RULE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br><p>Collations</p> <p>CREATE COLLATION ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br><p>Policies</p> <p>CREATE POLICY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br><p>Casts</p> <p>CREATE CAST ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
source.<br>settings.<br>kafkaSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>kafkaSource.<br>connection | **object**<br><p>Connection settings</p> 
source.<br>settings.<br>kafkaSource.<br>connection.<br>clusterId | **string** <br>`source.settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`<br><br><p>Managed Service for Kafka cluster ID</p> 
source.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise Kafka <br>`source.settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`<br>
source.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>brokerUrls[] | **string**<br><p>Kafka broker URLs</p> 
source.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for broker connection. Disabled by default.</p> 
source.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
source.<br>settings.<br>kafkaSource.<br>auth | **object**<br><p>Authentication settings</p> 
source.<br>settings.<br>kafkaSource.<br>auth.<br>sasl | **object**<br>Authentication with SASL <br>`source.settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`<br>
source.<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>user | **string**<br><p>User name</p> 
source.<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>password | **object**<br><p>Password for user</p> 
source.<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>mechanism | **string**<br><p>SASL mechanism for authentication</p> 
source.<br>settings.<br>kafkaSource.<br>auth.<br>noAuth | **object**<br>No authentication <br>`source.settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`<br>
source.<br>settings.<br>kafkaSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>kafkaSource.<br>topicName | **string**<br><p>Full source topic name</p> 
source.<br>settings.<br>kafkaSource.<br>transformer | **object**<br><p>Data transformation rules</p> 
source.<br>settings.<br>kafkaSource.<br>transformer.<br>cloudFunction | **string**<br><p>Cloud function</p> 
source.<br>settings.<br>kafkaSource.<br>transformer.<br>serviceAccountId | **string**<br><p>Service account</p> 
source.<br>settings.<br>kafkaSource.<br>transformer.<br>numberOfRetries | **string** (int64)<br><p>Number of retries</p> 
source.<br>settings.<br>kafkaSource.<br>transformer.<br>bufferSize | **string**<br><p>Buffer size for function</p> 
source.<br>settings.<br>kafkaSource.<br>transformer.<br>bufferFlushInterval | **string**<br><p>Flush interval</p> 
source.<br>settings.<br>kafkaSource.<br>transformer.<br>invocationTimeout | **string**<br><p>Invocation timeout</p> 
source.<br>settings.<br>kafkaSource.<br>parser | **object**<br><p>Data parsing rules</p> 
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser | **object** <br>`source.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema | **object**
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields | **object** <br>`source.settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[] | **object**<br><p>Column schema</p> 
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>name | **string**
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>type | **string**
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>key | **boolean** (boolean)
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>required | **boolean** (boolean)
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>path | **string**
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>jsonFields | **string** <br>`source.settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>nullKeysAllowed | **boolean** (boolean)<br><p>Allow null keys, if no - null keys will be putted to unparsed data</p> 
source.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>addRestColumn | **boolean** (boolean)<br><p>Will add _rest column for all unknown fields</p> 
source.<br>settings.<br>kafkaSource.<br>parser.<br>auditTrailsV1Parser | **object** <br>`source.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
source.<br>settings.<br>kafkaSource.<br>parser.<br>cloudLoggingParser | **object** <br>`source.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser | **object** <br>`source.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema | **object**
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields | **object** <br>`source.settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[] | **object**<br><p>Column schema</p> 
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>name | **string**
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>type | **string**
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>key | **boolean** (boolean)
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>required | **boolean** (boolean)
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>path | **string**
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>jsonFields | **string** <br>`source.settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>nullKeysAllowed | **boolean** (boolean)<br><p>Allow null keys, if no - null keys will be putted to unparsed data</p> 
source.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>addRestColumn | **boolean** (boolean)<br><p>Will add _rest column for all unknown fields</p> 
source.<br>settings.<br>mongoSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>mongoSource.<br>connection | **object**
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions | **object**
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>user | **string**<br><p>User name</p> 
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>authSource | **string**<br><p>Database name associated with the credentials</p> 
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`source.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`source.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
source.<br>settings.<br>mongoSource.<br>subnetId | **string**
source.<br>settings.<br>mongoSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>mongoSource.<br>collections[] | **object**<br><p>List of collections for replication. Empty list implies replication of all tables on the deployment. Allowed to use * as collection name.</p> 
source.<br>settings.<br>mongoSource.<br>collections[].<br>databaseName | **string**
source.<br>settings.<br>mongoSource.<br>collections[].<br>collectionName | **string**
source.<br>settings.<br>mongoSource.<br>excludedCollections[] | **object**<br><p>List of forbidden collections for replication. Allowed to use * as collection name for forbid all collections of concrete schema.</p> 
source.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>databaseName | **string**
source.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>collectionName | **string**
source.<br>settings.<br>mongoSource.<br>secondaryPreferredMode | **boolean** (boolean)<br><p>Read mode for mongo client</p> 
source.<br>settings.<br>clickhouseSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>clickhouseSource.<br>connection | **object**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions | **object**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>database | **string**<br><p>Database</p> 
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>user | **string**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`source.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`source.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>clickhouseSource.<br>subnetId | **string**
source.<br>settings.<br>clickhouseSource.<br>securityGroups[] | **string**
source.<br>settings.<br>clickhouseSource.<br>includeTables[] | **string**<br><p>While list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns.</p> 
source.<br>settings.<br>clickhouseSource.<br>excludeTables[] | **string**<br><p>Exclude list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns.</p> 
source.<br>settings.<br>mysqlTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>mysqlTarget.<br>connection | **object**<br><p>Database connection settings</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for MySQL cluster ID</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise MySQL <br>`source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
source.<br>settings.<br>mysqlTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
source.<br>settings.<br>mysqlTarget.<br>user | **string**<br><p>User for database access.</p> 
source.<br>settings.<br>mysqlTarget.<br>password | **object**<br><p>Password for database access.</p> 
source.<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
source.<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
source.<br>settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
source.<br>settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> <ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
source.<br>settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
source.<br>settings.<br>postgresTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>postgresTarget.<br>connection | **object**<br><p>Database connection settings</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for PostgreSQL cluster ID</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise PostgreSQL <br>`source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Will be used if the cluster ID is not specified.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
source.<br>settings.<br>postgresTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
source.<br>settings.<br>postgresTarget.<br>user | **string**<br><p>User for database access.</p> 
source.<br>settings.<br>postgresTarget.<br>password | **object**<br><p>Password for database access.</p> 
source.<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy for activate, reactivate and reupload processes. Default is truncate.</p> <ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
source.<br>settings.<br>clickhouseTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>clickhouseTarget.<br>connection | **object**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions | **object**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>database | **string**<br><p>Database</p> 
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>user | **string**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`source.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`source.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>clickhouseTarget.<br>subnetId | **string**
source.<br>settings.<br>clickhouseTarget.<br>securityGroups[] | **string**
source.<br>settings.<br>clickhouseTarget.<br>clickhouseClusterName | **string**
source.<br>settings.<br>clickhouseTarget.<br>altNames[] | **object**<br><p>Alternative table names in target</p> 
source.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>fromName | **string**<br><p>Source table name</p> 
source.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>toName | **string**<br><p>Target table name</p> 
source.<br>settings.<br>clickhouseTarget.<br>sharding | **object**
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash | **object** <br>`source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash.<br>columnName | **string**
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping | **object** <br>`source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>columnName | **string**
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[] | **object**
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue | **object**
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue.<br>stringValue | **string**
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>shardName | **string**
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId | **object** <br>`source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId.<br>transferId | **object** <br>`source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>clickhouseTarget.<br>cleanupPolicy | **string**
source.<br>settings.<br>kafkaTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>kafkaTarget.<br>connection | **object**<br><p>Connection settings</p> 
source.<br>settings.<br>kafkaTarget.<br>connection.<br>clusterId | **string** <br>`source.settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`<br><br><p>Managed Service for Kafka cluster ID</p> 
source.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise Kafka <br>`source.settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`<br>
source.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>brokerUrls[] | **string**<br><p>Kafka broker URLs</p> 
source.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for broker connection. Disabled by default.</p> 
source.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
source.<br>settings.<br>kafkaTarget.<br>auth | **object**<br><p>Authentication settings</p> 
source.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl | **object**<br>Authentication with SASL <br>`source.settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`<br>
source.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>user | **string**<br><p>User name</p> 
source.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>password | **object**<br><p>Password for user</p> 
source.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>mechanism | **string**<br><p>SASL mechanism for authentication</p> 
source.<br>settings.<br>kafkaTarget.<br>auth.<br>noAuth | **object**<br>No authentication <br>`source.settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`<br>
source.<br>settings.<br>kafkaTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>kafkaTarget.<br>topicSettings | **object**<br><p>Target topic settings</p> 
source.<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic | **object**<br>Full topic name <br>`source.settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`<br>
source.<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic.<br>topicName | **string**<br><p>Topic name</p> 
source.<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic.<br>saveTxOrder | **boolean** (boolean)<br><p>Save transactions order Not to split events queue into separate per-table queues.</p> 
source.<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topicPrefix | **string** <br>`source.settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`<br><br><p>Topic prefix</p> <p>Analogue of the Debezium setting database.server.name. Messages will be sent to topic with name &lt;topic_prefix&gt;.<schema>.&lt;table_name&gt;.</p> 
source.<br>settings.<br>mongoTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
source.<br>settings.<br>mongoTarget.<br>connection | **object**
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions | **object**
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>user | **string**<br><p>User name</p> 
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>authSource | **string**<br><p>Database name associated with the credentials</p> 
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`source.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`source.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
source.<br>settings.<br>mongoTarget.<br>subnetId | **string**
source.<br>settings.<br>mongoTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>mongoTarget.<br>database | **string**<br><p>Database name</p> 
source.<br>settings.<br>mongoTarget.<br>cleanupPolicy | **string**<br><ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
target | **object**
target.<br>id | **string**
target.<br>folderId | **string**
target.<br>name | **string**
target.<br>description | **string**
target.<br>labels | **object**
target.<br>settings | **object**
target.<br>settings.<br>mysqlSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>mysqlSource.<br>connection | **object**<br><p>Database connection settings</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for MySQL cluster ID</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise MySQL <br>`target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
target.<br>settings.<br>mysqlSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
target.<br>settings.<br>mysqlSource.<br>serviceDatabase | **string**<br><p>Database for service tables</p> <p>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
target.<br>settings.<br>mysqlSource.<br>user | **string**<br><p>User for database access.</p> 
target.<br>settings.<br>mysqlSource.<br>password | **object**<br><p>Password for database access.</p> 
target.<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**
target.<br>settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**
target.<br>settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>tables | **string**<br><ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>postgresSource.<br>connection | **object**<br><p>Database connection settings</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for PostgreSQL cluster ID</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise PostgreSQL <br>`target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Will be used if the cluster ID is not specified.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
target.<br>settings.<br>postgresSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
target.<br>settings.<br>postgresSource.<br>user | **string**<br><p>User for database access.</p> 
target.<br>settings.<br>postgresSource.<br>password | **object**<br><p>Password for database access.</p> 
target.<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
target.<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
target.<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum lag of replication slot (in bytes); after exceeding this limit replication will be aborted.</p> 
target.<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service tables (__consumer_keeper, __data_transfer_mole_finder). Default is public</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br><p>Select database objects to be transferred during activation or deactivation.</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br><p>Sequences</p> <p>CREATE SEQUENCE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br><p>Owned sequences</p> <p>CREATE SEQUENCE ... OWNED BY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceSet | **string**<br><ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br><p>Tables</p> <p>CREATE TABLE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br><p>Primary keys</p> <p>ALTER TABLE ... ADD PRIMARY KEY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br><p>Foreign keys</p> <p>ALTER TABLE ... ADD FOREIGN KEY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br><p>Default values</p> <p>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br><p>Constraints</p> <p>ALTER TABLE ... ADD CONSTRAINT ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br><p>Indexes</p> <p>CREATE INDEX ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>materializedView | **string**<br><p>Materialized views</p> <p>CREATE MATERIALIZED VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br><p>Functions</p> <p>CREATE FUNCTION ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br><p>Types</p> <p>CREATE TYPE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br><p>Rules</p> <p>CREATE RULE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br><p>Collations</p> <p>CREATE COLLATION ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br><p>Policies</p> <p>CREATE POLICY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br><p>Casts</p> <p>CREATE CAST ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
target.<br>settings.<br>kafkaSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>kafkaSource.<br>connection | **object**<br><p>Connection settings</p> 
target.<br>settings.<br>kafkaSource.<br>connection.<br>clusterId | **string** <br>`target.settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`<br><br><p>Managed Service for Kafka cluster ID</p> 
target.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise Kafka <br>`target.settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`<br>
target.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>brokerUrls[] | **string**<br><p>Kafka broker URLs</p> 
target.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for broker connection. Disabled by default.</p> 
target.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
target.<br>settings.<br>kafkaSource.<br>auth | **object**<br><p>Authentication settings</p> 
target.<br>settings.<br>kafkaSource.<br>auth.<br>sasl | **object**<br>Authentication with SASL <br>`target.settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`<br>
target.<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>user | **string**<br><p>User name</p> 
target.<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>password | **object**<br><p>Password for user</p> 
target.<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>mechanism | **string**<br><p>SASL mechanism for authentication</p> 
target.<br>settings.<br>kafkaSource.<br>auth.<br>noAuth | **object**<br>No authentication <br>`target.settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`<br>
target.<br>settings.<br>kafkaSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>kafkaSource.<br>topicName | **string**<br><p>Full source topic name</p> 
target.<br>settings.<br>kafkaSource.<br>transformer | **object**<br><p>Data transformation rules</p> 
target.<br>settings.<br>kafkaSource.<br>transformer.<br>cloudFunction | **string**<br><p>Cloud function</p> 
target.<br>settings.<br>kafkaSource.<br>transformer.<br>serviceAccountId | **string**<br><p>Service account</p> 
target.<br>settings.<br>kafkaSource.<br>transformer.<br>numberOfRetries | **string** (int64)<br><p>Number of retries</p> 
target.<br>settings.<br>kafkaSource.<br>transformer.<br>bufferSize | **string**<br><p>Buffer size for function</p> 
target.<br>settings.<br>kafkaSource.<br>transformer.<br>bufferFlushInterval | **string**<br><p>Flush interval</p> 
target.<br>settings.<br>kafkaSource.<br>transformer.<br>invocationTimeout | **string**<br><p>Invocation timeout</p> 
target.<br>settings.<br>kafkaSource.<br>parser | **object**<br><p>Data parsing rules</p> 
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser | **object** <br>`target.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema | **object**
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields | **object** <br>`target.settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[] | **object**<br><p>Column schema</p> 
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>name | **string**
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>type | **string**
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>key | **boolean** (boolean)
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>required | **boolean** (boolean)
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>path | **string**
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>jsonFields | **string** <br>`target.settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>nullKeysAllowed | **boolean** (boolean)<br><p>Allow null keys, if no - null keys will be putted to unparsed data</p> 
target.<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>addRestColumn | **boolean** (boolean)<br><p>Will add _rest column for all unknown fields</p> 
target.<br>settings.<br>kafkaSource.<br>parser.<br>auditTrailsV1Parser | **object** <br>`target.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
target.<br>settings.<br>kafkaSource.<br>parser.<br>cloudLoggingParser | **object** <br>`target.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser | **object** <br>`target.settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema | **object**
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields | **object** <br>`target.settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[] | **object**<br><p>Column schema</p> 
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>name | **string**
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>type | **string**
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>key | **boolean** (boolean)
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>required | **boolean** (boolean)
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>path | **string**
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>jsonFields | **string** <br>`target.settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>nullKeysAllowed | **boolean** (boolean)<br><p>Allow null keys, if no - null keys will be putted to unparsed data</p> 
target.<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>addRestColumn | **boolean** (boolean)<br><p>Will add _rest column for all unknown fields</p> 
target.<br>settings.<br>mongoSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>mongoSource.<br>connection | **object**
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions | **object**
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>user | **string**<br><p>User name</p> 
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>authSource | **string**<br><p>Database name associated with the credentials</p> 
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`target.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`target.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
target.<br>settings.<br>mongoSource.<br>subnetId | **string**
target.<br>settings.<br>mongoSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>mongoSource.<br>collections[] | **object**<br><p>List of collections for replication. Empty list implies replication of all tables on the deployment. Allowed to use * as collection name.</p> 
target.<br>settings.<br>mongoSource.<br>collections[].<br>databaseName | **string**
target.<br>settings.<br>mongoSource.<br>collections[].<br>collectionName | **string**
target.<br>settings.<br>mongoSource.<br>excludedCollections[] | **object**<br><p>List of forbidden collections for replication. Allowed to use * as collection name for forbid all collections of concrete schema.</p> 
target.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>databaseName | **string**
target.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>collectionName | **string**
target.<br>settings.<br>mongoSource.<br>secondaryPreferredMode | **boolean** (boolean)<br><p>Read mode for mongo client</p> 
target.<br>settings.<br>clickhouseSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>clickhouseSource.<br>connection | **object**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions | **object**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>database | **string**<br><p>Database</p> 
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>user | **string**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`target.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`target.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>clickhouseSource.<br>subnetId | **string**
target.<br>settings.<br>clickhouseSource.<br>securityGroups[] | **string**
target.<br>settings.<br>clickhouseSource.<br>includeTables[] | **string**<br><p>While list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns.</p> 
target.<br>settings.<br>clickhouseSource.<br>excludeTables[] | **string**<br><p>Exclude list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns.</p> 
target.<br>settings.<br>mysqlTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>mysqlTarget.<br>connection | **object**<br><p>Database connection settings</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for MySQL cluster ID</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise MySQL <br>`target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
target.<br>settings.<br>mysqlTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
target.<br>settings.<br>mysqlTarget.<br>user | **string**<br><p>User for database access.</p> 
target.<br>settings.<br>mysqlTarget.<br>password | **object**<br><p>Password for database access.</p> 
target.<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
target.<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
target.<br>settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
target.<br>settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> <ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
target.<br>settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
target.<br>settings.<br>postgresTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>postgresTarget.<br>connection | **object**<br><p>Database connection settings</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for PostgreSQL cluster ID</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise PostgreSQL <br>`target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Will be used if the cluster ID is not specified.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
target.<br>settings.<br>postgresTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
target.<br>settings.<br>postgresTarget.<br>user | **string**<br><p>User for database access.</p> 
target.<br>settings.<br>postgresTarget.<br>password | **object**<br><p>Password for database access.</p> 
target.<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy for activate, reactivate and reupload processes. Default is truncate.</p> <ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
target.<br>settings.<br>clickhouseTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>clickhouseTarget.<br>connection | **object**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions | **object**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>database | **string**<br><p>Database</p> 
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>user | **string**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`target.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`target.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>clickhouseTarget.<br>subnetId | **string**
target.<br>settings.<br>clickhouseTarget.<br>securityGroups[] | **string**
target.<br>settings.<br>clickhouseTarget.<br>clickhouseClusterName | **string**
target.<br>settings.<br>clickhouseTarget.<br>altNames[] | **object**<br><p>Alternative table names in target</p> 
target.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>fromName | **string**<br><p>Source table name</p> 
target.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>toName | **string**<br><p>Target table name</p> 
target.<br>settings.<br>clickhouseTarget.<br>sharding | **object**
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash | **object** <br>`target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash.<br>columnName | **string**
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping | **object** <br>`target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>columnName | **string**
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[] | **object**
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue | **object**
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue.<br>stringValue | **string**
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>shardName | **string**
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId | **object** <br>`target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId.<br>transferId | **object** <br>`target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>clickhouseTarget.<br>cleanupPolicy | **string**
target.<br>settings.<br>kafkaTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>kafkaTarget.<br>connection | **object**<br><p>Connection settings</p> 
target.<br>settings.<br>kafkaTarget.<br>connection.<br>clusterId | **string** <br>`target.settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`<br><br><p>Managed Service for Kafka cluster ID</p> 
target.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise Kafka <br>`target.settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`<br>
target.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>brokerUrls[] | **string**<br><p>Kafka broker URLs</p> 
target.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for broker connection. Disabled by default.</p> 
target.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
target.<br>settings.<br>kafkaTarget.<br>auth | **object**<br><p>Authentication settings</p> 
target.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl | **object**<br>Authentication with SASL <br>`target.settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`<br>
target.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>user | **string**<br><p>User name</p> 
target.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>password | **object**<br><p>Password for user</p> 
target.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>mechanism | **string**<br><p>SASL mechanism for authentication</p> 
target.<br>settings.<br>kafkaTarget.<br>auth.<br>noAuth | **object**<br>No authentication <br>`target.settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`<br>
target.<br>settings.<br>kafkaTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>kafkaTarget.<br>topicSettings | **object**<br><p>Target topic settings</p> 
target.<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic | **object**<br>Full topic name <br>`target.settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`<br>
target.<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic.<br>topicName | **string**<br><p>Topic name</p> 
target.<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic.<br>saveTxOrder | **boolean** (boolean)<br><p>Save transactions order Not to split events queue into separate per-table queues.</p> 
target.<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topicPrefix | **string** <br>`target.settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`<br><br><p>Topic prefix</p> <p>Analogue of the Debezium setting database.server.name. Messages will be sent to topic with name &lt;topic_prefix&gt;.<schema>.&lt;table_name&gt;.</p> 
target.<br>settings.<br>mongoTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
target.<br>settings.<br>mongoTarget.<br>connection | **object**
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions | **object**
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>user | **string**<br><p>User name</p> 
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>authSource | **string**<br><p>Database name associated with the credentials</p> 
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`target.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`target.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
target.<br>settings.<br>mongoTarget.<br>subnetId | **string**
target.<br>settings.<br>mongoTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>mongoTarget.<br>database | **string**<br><p>Database name</p> 
target.<br>settings.<br>mongoTarget.<br>cleanupPolicy | **string**<br><ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
status | **string**<br><ul> <li>CREATING: Transfer does some work before running</li> <li>CREATED: Transfer created but not started by user</li> <li>RUNNING: Transfer currently doing replication work</li> <li>STOPPING: Transfer shutdown</li> <li>STOPPED: Transfer stopped by user</li> <li>ERROR: Transfer stopped by system</li> <li>SNAPSHOTTING: Transfer copy snapshot</li> <li>DONE: Transfer reach terminal phase</li> </ul> 
type | **string**<br><ul> <li>SNAPSHOT_AND_INCREMENT: Snapshot and increment</li> <li>SNAPSHOT_ONLY: Snapshot</li> <li>INCREMENT_ONLY: Increment</li> </ul> 
warning | **string**