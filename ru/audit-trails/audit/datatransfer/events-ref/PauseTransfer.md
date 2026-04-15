---
editable: false
---

# Data Transfer Audit Trails Events: PauseTransfer

## Event JSON schema {#yandex.cloud.audit.datatransfer.PauseTransfer2-schema}

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
    "transferId": "string",
    "transferName": "string",
    "transfer": {
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
                "connectionId": "string",
                "subnetId": "string"
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
                "connectionId": "string",
                "subnetId": "string"
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
              // Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`
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
              },
              "connectionManagerConnection": {
                "connectionId": "string",
                "subnetId": "string"
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
                  "connectionId": "string",
                  "subnetId": "string"
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
                "connectionId": "string",
                "subnetId": "string"
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
                "connectionId": "string",
                "subnetId": "string"
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
                  "connectionId": "string",
                  "subnetId": "string"
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
              // Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`
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
              },
              "connectionManagerConnection": {
                "connectionId": "string",
                "subnetId": "string"
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
      },
      "target": {
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
                "connectionId": "string",
                "subnetId": "string"
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
                "connectionId": "string",
                "subnetId": "string"
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
              // Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`
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
              },
              "connectionManagerConnection": {
                "connectionId": "string",
                "subnetId": "string"
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
                  "connectionId": "string",
                  "subnetId": "string"
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
                "connectionId": "string",
                "subnetId": "string"
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
                "connectionId": "string",
                "subnetId": "string"
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
                  "connectionId": "string",
                  "subnetId": "string"
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
              // Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`
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
              },
              "connectionManagerConnection": {
                "connectionId": "string",
                "subnetId": "string"
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
      },
      "runtime": {
        // Includes only one of the fields `ycRuntime`
        "ycRuntime": {
          "jobCount": "string",
          "flavor": "string",
          "uploadShardParams": {
            "jobCount": "string",
            "processCount": "string"
          }
        }
        // end of the list of possible fields
      },
      "status": "string",
      "type": "string",
      "warning": "string",
      "regularSnapshot": {
        // Includes only one of the fields `settings`, `disabled`
        "settings": {
          "schedule": "string",
          "tables": [
            {
              "tableNamespace": "string",
              "tableName": "string",
              "cursorColumn": "string",
              "initialState": "string"
            }
          ],
          "cronExpression": "string",
          "incrementDelaySeconds": "string",
          "retryConfig": {
            "maxAttempts": "string"
          }
        },
        "disabled": "object"
        // end of the list of possible fields
      },
      "transformation": {
        "transformers": [
          {
            // Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`
            "maskField": {
              "tables": {
                "includeTables": [
                  "string"
                ],
                "excludeTables": [
                  "string"
                ]
              },
              "columns": [
                "string"
              ],
              "function": {
                // Includes only one of the fields `maskFunctionHash`
                "maskFunctionHash": {
                  "userDefinedSalt": "string"
                }
                // end of the list of possible fields
              }
            },
            "filterColumns": {
              "tables": {
                "includeTables": [
                  "string"
                ],
                "excludeTables": [
                  "string"
                ]
              },
              "columns": {
                "includeColumns": [
                  "string"
                ],
                "excludeColumns": [
                  "string"
                ]
              }
            },
            "renameTables": {
              "renameTables": [
                {
                  "originalName": {
                    "nameSpace": "string",
                    "name": "string"
                  },
                  "newName": {
                    "nameSpace": "string",
                    "name": "string"
                  }
                }
              ]
            },
            "replacePrimaryKey": {
              "tables": {
                "includeTables": [
                  "string"
                ],
                "excludeTables": [
                  "string"
                ]
              },
              "keys": [
                "string"
              ]
            },
            "convertToString": {
              "tables": {
                "includeTables": [
                  "string"
                ],
                "excludeTables": [
                  "string"
                ]
              },
              "columns": {
                "includeColumns": [
                  "string"
                ],
                "excludeColumns": [
                  "string"
                ]
              }
            },
            "sharderTransformer": {
              // Includes only one of the fields `columns`, `random`
              "columns": {
                "includeColumns": [
                  "string"
                ],
                "excludeColumns": [
                  "string"
                ]
              },
              "random": "object",
              // end of the list of possible fields
              "tables": {
                "includeTables": [
                  "string"
                ],
                "excludeTables": [
                  "string"
                ]
              },
              "shardsCount": "string"
            },
            "tableSplitterTransformer": {
              "tables": {
                "includeTables": [
                  "string"
                ],
                "excludeTables": [
                  "string"
                ]
              },
              "columns": [
                "string"
              ],
              "splitter": "string"
            },
            "filterRows": {
              "tables": {
                "includeTables": [
                  "string"
                ],
                "excludeTables": [
                  "string"
                ]
              },
              "filter": "string",
              "filters": [
                "string"
              ]
            }
            // end of the list of possible fields
          }
        ]
      },
      "dataObjects": {
        "includeObjects": [
          "string"
        ]
      },
      "prestable": "boolean",
      "replicationRuntime": {
        // Includes only one of the fields `ycRuntime`
        "ycRuntime": {
          "jobCount": "string",
          "flavor": "string",
          "uploadShardParams": {
            "jobCount": "string",
            "processCount": "string"
          }
        }
        // end of the list of possible fields
      }
    }
  },
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.datatransfer.PauseTransfer2}

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
|| details | **[TransferEventDetails](#yandex.cloud.audit.datatransfer.TransferEventDetails)** ||
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

## TransferEventDetails {#yandex.cloud.audit.datatransfer.TransferEventDetails}

#|
||Field | Description ||
|| transferId | **string**

The maximum string length in characters is 50. ||
|| transferName | **string** ||
|| transfer | **[Transfer](#yandex.cloud.datatransfer.v1.Transfer)** ||
|#

## Transfer {#yandex.cloud.datatransfer.v1.Transfer}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| source | **[Endpoint](#yandex.cloud.datatransfer.v1.Endpoint)** ||
|| target | **[Endpoint](#yandex.cloud.datatransfer.v1.Endpoint)** ||
|| runtime | **[Runtime](#yandex.cloud.datatransfer.v1.Runtime)** ||
|| status | **enum** (TransferStatus)

- `CREATING`
- `CREATED`
- `RUNNING`
- `STOPPING`
- `STOPPED`
- `ERROR`
- `SNAPSHOTTING`
- `DONE`
- `PAUSED`
- `PREPARING` ||
|| type | **enum** (TransferType)

- `SNAPSHOT_AND_INCREMENT`
- `SNAPSHOT_ONLY`
- `INCREMENT_ONLY` ||
|| warning | **string** ||
|| regularSnapshot | **[RegularSnapshot](#yandex.cloud.datatransfer.v1.RegularSnapshot)** ||
|| transformation | **[Transformation](#yandex.cloud.datatransfer.v1.Transformation)** ||
|| dataObjects | **[DataObjects](#yandex.cloud.datatransfer.v1.DataObjects)** ||
|| prestable | **boolean** ||
|| replicationRuntime | **[Runtime](#yandex.cloud.datatransfer.v1.Runtime)** ||
|#

## Endpoint {#yandex.cloud.datatransfer.v1.Endpoint}

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
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)** ||
|| database | **string** ||
|| user | **string** ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| timezone | **string** ||
|| objectTransferSettings | **[MysqlObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings)** ||
|| includeTablesRegex[] | **string** ||
|| excludeTablesRegex[] | **string** ||
|| securityGroups[] | **string** ||
|| serviceDatabase | **string** ||
|#

## MysqlConnection {#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection}

#|
||Field | Description ||
|| mdbClusterId | **string**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseMysql](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremiseMysql {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql}

#|
||Field | Description ||
|| port | **string** (int64) ||
|| subnetId | **string** ||
|| hosts[] | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
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
|| caCertificate | **string** ||
|#

## ConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection}

#|
||Field | Description ||
|| connectionId | **string** ||
|| subnetId | **string** ||
|#

## Secret {#yandex.cloud.datatransfer.v1.endpoint.Secret}

#|
||Field | Description ||
|| raw | **string**

Includes only one of the fields `raw`. ||
|#

## MysqlObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings}

#|
||Field | Description ||
|| view | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| routine | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| trigger | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| tables | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|#

## PostgresSource {#yandex.cloud.datatransfer.v1.endpoint.PostgresSource}

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)** ||
|| database | **string** ||
|| user | **string** ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| includeTables[] | **string** ||
|| excludeTables[] | **string** ||
|| slotByteLagLimit | **string** (int64) ||
|| serviceSchema | **string** ||
|| objectTransferSettings | **[PostgresObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings)** ||
|| securityGroups[] | **string** ||
|#

## PostgresConnection {#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection}

#|
||Field | Description ||
|| mdbClusterId | **string**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremisePostgres](#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremisePostgres {#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres}

#|
||Field | Description ||
|| port | **string** (int64) ||
|| subnetId | **string** ||
|| hosts[] | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
|#

## PostgresObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings}

#|
||Field | Description ||
|| sequence | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| sequenceOwnedBy | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| table | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| primaryKey | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| fkConstraint | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| defaultValues | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| constraint | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| index | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| view | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| function | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| trigger | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| type | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| rule | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| collation | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| policy | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| cast | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| materializedView | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|| sequenceSet | **enum** (ObjectTransferStage)

- `BEFORE_DATA`
- `AFTER_DATA`
- `NEVER` ||
|#

## YdbSource {#yandex.cloud.datatransfer.v1.endpoint.YdbSource}

#|
||Field | Description ||
|| database | **string** ||
|| instance | **string** ||
|| paths[] | **string** ||
|| serviceAccountId | **string** ||
|| subnetId | **string** ||
|| saKeyContent | **string** ||
|| securityGroups[] | **string** ||
|| changefeedCustomName | **string** ||
|| changefeedCustomConsumerName | **string** ||
|#

## YDSSource {#yandex.cloud.datatransfer.v1.endpoint.YDSSource}

#|
||Field | Description ||
|| database | **string** ||
|| stream | **string** ||
|| serviceAccountId | **string** ||
|| supportedCodecs[] | **enum** (YdsCompressionCodec)

- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)** ||
|| allowTtlRewind | **boolean** ||
|| endpoint | **string** ||
|| subnetId | **string** ||
|| securityGroups[] | **string** ||
|| consumer | **string** ||
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
|| nullKeysAllowed | **boolean** ||
|| addRestColumn | **boolean** ||
|| unescapeStringValues | **boolean** ||
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
|| fields[] | **[ColSchema](#yandex.cloud.datatransfer.v1.endpoint.ColSchema)** ||
|#

## ColSchema {#yandex.cloud.datatransfer.v1.endpoint.ColSchema}

#|
||Field | Description ||
|| name | **string** ||
|| type | **enum** (ColumnType)

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
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)** ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)** ||
|| securityGroups[] | **string** ||
|| topicName | **string** ||
|| transformer | **[DataTransformationOptions](#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions)** ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)** ||
|| topicNames[] | **string** ||
|#

## KafkaConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions}

#|
||Field | Description ||
|| clusterId | **string**

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseKafka](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka)**

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremiseKafka {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka}

#|
||Field | Description ||
|| brokerUrls[] | **string** ||
|| subnetId | **string** ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)** ||
|#

## KafkaAuth {#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth}

#|
||Field | Description ||
|| sasl | **[KafkaSaslSecurity](#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity)**

Includes only one of the fields `sasl`, `noAuth`. ||
|| noAuth | **object**

Includes only one of the fields `sasl`, `noAuth`. ||
|#

## KafkaSaslSecurity {#yandex.cloud.datatransfer.v1.endpoint.KafkaSaslSecurity}

#|
||Field | Description ||
|| user | **string** ||
|| mechanism | **enum** (KafkaMechanism)

- `KAFKA_MECHANISM_SHA256`
- `KAFKA_MECHANISM_SHA512` ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|#

## DataTransformationOptions {#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions}

#|
||Field | Description ||
|| cloudFunction | **string** ||
|| numberOfRetries | **string** (int64) ||
|| bufferSize | **string** ||
|| bufferFlushInterval | **string** ||
|| invocationTimeout | **string** ||
|| serviceAccountId | **string** ||
|#

## MongoSource {#yandex.cloud.datatransfer.v1.endpoint.MongoSource}

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)** ||
|| subnetId | **string** ||
|| collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)** ||
|| excludedCollections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)** ||
|| secondaryPreferredMode | **boolean** ||
|| securityGroups[] | **string** ||
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
|| user | **string** ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| authSource | **string** ||
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
|| replicaSet | **string** ||
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
|| includeTables[] | **string** ||
|| excludeTables[] | **string** ||
|| subnetId | **string** ||
|| securityGroups[] | **string** ||
|| clickhouseClusterName | **string** ||
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
|| database | **string** ||
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
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)** ||
|| database | **string** ||
|| user | **string** ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| sqlMode | **string** ||
|| skipConstraintChecks | **boolean** ||
|| timezone | **string** ||
|| cleanupPolicy | **enum** (CleanupPolicy)

- `DISABLED`
- `DROP`
- `TRUNCATE` ||
|| serviceDatabase | **string** ||
|| securityGroups[] | **string** ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## PostgresTarget {#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget}

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)** ||
|| database | **string** ||
|| user | **string** ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)** ||
|| cleanupPolicy | **enum** (CleanupPolicy)

- `DISABLED`
- `DROP`
- `TRUNCATE` ||
|| securityGroups[] | **string** ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## ClickhouseTarget {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget}

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)** ||
|| subnetId | **string** ||
|| altNames[] | **[AltName](#yandex.cloud.datatransfer.v1.endpoint.AltName)** ||
|| cleanupPolicy | **enum** (ClickhouseCleanupPolicy)

- `CLICKHOUSE_CLEANUP_POLICY_DISABLED`
- `CLICKHOUSE_CLEANUP_POLICY_DROP`
- `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` ||
|| sharding | **[ClickhouseSharding](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding)** ||
|| isSchemaMigrationDisabled | **boolean** ||
|| clickhouseClusterName | **string** ||
|| securityGroups[] | **string** ||
|#

## AltName {#yandex.cloud.datatransfer.v1.endpoint.AltName}

#|
||Field | Description ||
|| fromName | **string** ||
|| toName | **string** ||
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
|| database | **string** ||
|| instance | **string** ||
|| path | **string** ||
|| serviceAccountId | **string** ||
|| cleanupPolicy | **enum** (YdbCleanupPolicy)

- `YDB_CLEANUP_POLICY_DISABLED`
- `YDB_CLEANUP_POLICY_DROP` ||
|| subnetId | **string** ||
|| saKeyContent | **string** ||
|| securityGroups[] | **string** ||
|| isTableColumnOriented | **boolean** ||
|| defaultCompression | **enum** (YdbDefaultCompression)

- `YDB_DEFAULT_COMPRESSION_DISABLED`
- `YDB_DEFAULT_COMPRESSION_LZ4` ||
|| isSchemaMigrationDisabled | **boolean** ||
|#

## KafkaTarget {#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget}

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)** ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)** ||
|| securityGroups[] | **string** ||
|| topicSettings | **[KafkaTargetTopicSettings](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings)** ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)** ||
|#

## KafkaTargetTopicSettings {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings}

#|
||Field | Description ||
|| topic | **[KafkaTargetTopic](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic)**

Includes only one of the fields `topic`, `topicPrefix`. ||
|| topicPrefix | **string**

Includes only one of the fields `topic`, `topicPrefix`. ||
|#

## KafkaTargetTopic {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic}

#|
||Field | Description ||
|| topicName | **string** ||
|| saveTxOrder | **boolean** ||
|#

## Serializer {#yandex.cloud.datatransfer.v1.endpoint.Serializer}

#|
||Field | Description ||
|| serializerAuto | **object**

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerJson | **object**

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerDebezium | **[SerializerDebezium](#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium)**

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|#

## SerializerDebezium {#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium}

#|
||Field | Description ||
|| serializerParameters[] | **[DebeziumSerializerParameter](#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter)** ||
|#

## DebeziumSerializerParameter {#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter}

#|
||Field | Description ||
|| key | **string** ||
|| value | **string** ||
|#

## MongoTarget {#yandex.cloud.datatransfer.v1.endpoint.MongoTarget}

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)** ||
|| database | **string** ||
|| cleanupPolicy | **enum** (CleanupPolicy)

- `DISABLED`
- `DROP`
- `TRUNCATE` ||
|| subnetId | **string** ||
|| securityGroups[] | **string** ||
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

- `METRIKA_STREAM_TYPE_HITS`
- `METRIKA_STREAM_TYPE_VISITS`
- `METRIKA_STREAM_TYPE_HITS_V2` ||
|| columns[] | **string** ||
|#

## YDSTarget {#yandex.cloud.datatransfer.v1.endpoint.YDSTarget}

#|
||Field | Description ||
|| database | **string** ||
|| stream | **string** ||
|| serviceAccountId | **string** ||
|| saveTxOrder | **boolean** ||
|| compressionCodec | **enum** (YdsCompressionCodec)

- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)** ||
|| endpoint | **string** ||
|| subnetId | **string** ||
|| securityGroups[] | **string** ||
|#

## Runtime {#yandex.cloud.datatransfer.v1.Runtime}

#|
||Field | Description ||
|| ycRuntime | **[YcRuntime](#yandex.cloud.datatransfer.v1.YcRuntime)**

Includes only one of the fields `ycRuntime`. ||
|#

## YcRuntime {#yandex.cloud.datatransfer.v1.YcRuntime}

#|
||Field | Description ||
|| jobCount | **string** (int64) ||
|| flavor | **enum** (Flavor)

- `SMALL`
- `MEDIUM`
- `LARGE`
- `TINY` ||
|| uploadShardParams | **[ShardingUploadParams](#yandex.cloud.datatransfer.v1.ShardingUploadParams)** ||
|#

## ShardingUploadParams {#yandex.cloud.datatransfer.v1.ShardingUploadParams}

#|
||Field | Description ||
|| jobCount | **string** (int64) ||
|| processCount | **string** (int64) ||
|#

## RegularSnapshot {#yandex.cloud.datatransfer.v1.RegularSnapshot}

#|
||Field | Description ||
|| settings | **[RegularSnapshotSettings](#yandex.cloud.datatransfer.v1.RegularSnapshotSettings)**

Includes only one of the fields `settings`, `disabled`. ||
|| disabled | **object**

Includes only one of the fields `settings`, `disabled`. ||
|#

## RegularSnapshotSettings {#yandex.cloud.datatransfer.v1.RegularSnapshotSettings}

#|
||Field | Description ||
|| schedule | **enum** (RegularSnapshotScheduleInterval)

- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_15MIN`
- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_30MIN`
- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_HOUR`
- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_2HOUR`
- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_3HOUR`
- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_6HOUR`
- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_8HOUR`
- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_12HOUR`
- `REGULAR_SNAPSHOT_SCHEDULE_INTERVAL_DAY` ||
|| tables[] | **[IncrementalTable](#yandex.cloud.datatransfer.v1.IncrementalTable)** ||
|| cronExpression | **string** ||
|| incrementDelaySeconds | **string** (int64) ||
|| retryConfig | **[RetryConfig](#yandex.cloud.datatransfer.v1.RegularSnapshotSettings.RetryConfig)** ||
|#

## IncrementalTable {#yandex.cloud.datatransfer.v1.IncrementalTable}

#|
||Field | Description ||
|| tableNamespace | **string** ||
|| tableName | **string** ||
|| cursorColumn | **string** ||
|| initialState | **string** ||
|#

## RetryConfig {#yandex.cloud.datatransfer.v1.RegularSnapshotSettings.RetryConfig}

#|
||Field | Description ||
|| maxAttempts | **string** (int64) ||
|#

## Transformation {#yandex.cloud.datatransfer.v1.Transformation}

#|
||Field | Description ||
|| transformers[] | **[Transformer](#yandex.cloud.datatransfer.v1.Transformer)** ||
|#

## Transformer {#yandex.cloud.datatransfer.v1.Transformer}

#|
||Field | Description ||
|| maskField | **[MaskFieldTransformer](#yandex.cloud.datatransfer.v1.MaskFieldTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| filterColumns | **[FilterColumnsTransformer](#yandex.cloud.datatransfer.v1.FilterColumnsTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| renameTables | **[RenameTablesTransformer](#yandex.cloud.datatransfer.v1.RenameTablesTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| replacePrimaryKey | **[ReplacePrimaryKeyTransformer](#yandex.cloud.datatransfer.v1.ReplacePrimaryKeyTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| convertToString | **[ToStringTransformer](#yandex.cloud.datatransfer.v1.ToStringTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| sharderTransformer | **[SharderTransformer](#yandex.cloud.datatransfer.v1.SharderTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| tableSplitterTransformer | **[TableSplitterTransformer](#yandex.cloud.datatransfer.v1.TableSplitterTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|| filterRows | **[FilterRowsTransformer](#yandex.cloud.datatransfer.v1.FilterRowsTransformer)**

Includes only one of the fields `maskField`, `filterColumns`, `renameTables`, `replacePrimaryKey`, `convertToString`, `sharderTransformer`, `tableSplitterTransformer`, `filterRows`. ||
|#

## MaskFieldTransformer {#yandex.cloud.datatransfer.v1.MaskFieldTransformer}

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)** ||
|| columns[] | **string** ||
|| function | **[MaskFunction](#yandex.cloud.datatransfer.v1.MaskFunction)** ||
|#

## TablesFilter {#yandex.cloud.datatransfer.v1.TablesFilter}

#|
||Field | Description ||
|| includeTables[] | **string** ||
|| excludeTables[] | **string** ||
|#

## MaskFunction {#yandex.cloud.datatransfer.v1.MaskFunction}

#|
||Field | Description ||
|| maskFunctionHash | **[MaskFunctionHash](#yandex.cloud.datatransfer.v1.MaskFunctionHash)**

Includes only one of the fields `maskFunctionHash`. ||
|#

## MaskFunctionHash {#yandex.cloud.datatransfer.v1.MaskFunctionHash}

#|
||Field | Description ||
|| userDefinedSalt | **string** ||
|#

## FilterColumnsTransformer {#yandex.cloud.datatransfer.v1.FilterColumnsTransformer}

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)** ||
|| columns | **[ColumnsFilter](#yandex.cloud.datatransfer.v1.ColumnsFilter)** ||
|#

## ColumnsFilter {#yandex.cloud.datatransfer.v1.ColumnsFilter}

#|
||Field | Description ||
|| includeColumns[] | **string** ||
|| excludeColumns[] | **string** ||
|#

## RenameTablesTransformer {#yandex.cloud.datatransfer.v1.RenameTablesTransformer}

#|
||Field | Description ||
|| renameTables[] | **[RenameTable](#yandex.cloud.datatransfer.v1.RenameTable)** ||
|#

## RenameTable {#yandex.cloud.datatransfer.v1.RenameTable}

#|
||Field | Description ||
|| originalName | **[Table](#yandex.cloud.datatransfer.v1.Table)** ||
|| newName | **[Table](#yandex.cloud.datatransfer.v1.Table)** ||
|#

## Table {#yandex.cloud.datatransfer.v1.Table}

#|
||Field | Description ||
|| nameSpace | **string** ||
|| name | **string** ||
|#

## ReplacePrimaryKeyTransformer {#yandex.cloud.datatransfer.v1.ReplacePrimaryKeyTransformer}

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)** ||
|| keys[] | **string** ||
|#

## ToStringTransformer {#yandex.cloud.datatransfer.v1.ToStringTransformer}

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)** ||
|| columns | **[ColumnsFilter](#yandex.cloud.datatransfer.v1.ColumnsFilter)** ||
|#

## SharderTransformer {#yandex.cloud.datatransfer.v1.SharderTransformer}

#|
||Field | Description ||
|| columns | **[ColumnsFilter](#yandex.cloud.datatransfer.v1.ColumnsFilter)**

Includes only one of the fields `columns`, `random`. ||
|| random | **object**

Includes only one of the fields `columns`, `random`. ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)** ||
|| shardsCount | **string** (int64) ||
|#

## TableSplitterTransformer {#yandex.cloud.datatransfer.v1.TableSplitterTransformer}

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)** ||
|| columns[] | **string** ||
|| splitter | **string** ||
|#

## FilterRowsTransformer {#yandex.cloud.datatransfer.v1.FilterRowsTransformer}

#|
||Field | Description ||
|| tables | **[TablesFilter](#yandex.cloud.datatransfer.v1.TablesFilter)** ||
|| filter | **string** ||
|| filters[] | **string** ||
|#

## DataObjects {#yandex.cloud.datatransfer.v1.DataObjects}

#|
||Field | Description ||
|| includeObjects[] | **string** ||
|#