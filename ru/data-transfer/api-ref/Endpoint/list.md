---
editable: false
apiPlayground:
  - url: https://{{ api-host-data-transfer }}/v1/endpoints/list/{folderId}
    method: get
    path:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Identifier of the folder containing the endpoints to be listed.
          type: string
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of endpoints to be sent in the response message. If the
            folder contains more endpoints than `page_size`, `next_page_token` will be
            included
            in the response message. Include it into the subsequent `ListEndpointRequest` to
            fetch the next page. Defaults to `100` if not specified. The maximum allowed
            value
            for this field is `1000`.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Opaque value identifying the endpoints page to be fetched. Should be empty in
            the first `ListEndpointsRequest`. Subsequent requests should have this field
            filled
            with the `next_page_token` from the previous `ListEndpointsResponse`.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Data Transfer API, REST: Endpoint.List

Lists endpoints in the specified folder.

## HTTP request

```
GET https://{{ api-host-data-transfer }}/v1/endpoints/list/{folderId}
```

## Path parameters

#|
||Field | Description ||
|| folderId | **string**

Required field. Identifier of the folder containing the endpoints to be listed. ||
|#

## Query parameters {#yandex.cloud.datatransfer.v1.ListEndpointsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of endpoints to be sent in the response message. If the
folder contains more endpoints than `page_size`, `next_page_token` will be
included
in the response message. Include it into the subsequent `ListEndpointRequest` to
fetch the next page. Defaults to `100` if not specified. The maximum allowed
value
for this field is `1000`. ||
|| pageToken | **string**

Opaque value identifying the endpoints page to be fetched. Should be empty in
the first `ListEndpointsRequest`. Subsequent requests should have this field
filled
with the `next_page_token` from the previous `ListEndpointsResponse`. ||
|#

## Response {#yandex.cloud.datatransfer.v1.ListEndpointsResponse}

**HTTP Code: 200 - OK**

```json
{
  "endpoints": [
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
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| endpoints[] | **[Endpoint](#yandex.cloud.datatransfer.v1.Endpoint)**

The list of endpoints. If there are more endpoints in the folder, then
`next_page_token` is a non-empty string to be included into the subsequent
`ListEndpointsRequest` to fetch the next endpoints page. ||
|| nextPageToken | **string**

Opaque value identifying the next endpoints page. This field is empty if there
are no more endpoints in the folder. Otherwise, it is non-empty and should be
included in the subsequent `ListEndpointsRequest` to fetch the next endpoints
page. ||
|#

## Endpoint {#yandex.cloud.datatransfer.v1.Endpoint}

Data Transfer endpoint. For more information, see [the official
documentation](https://yandex.cloud/docs/data-transfer/)

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| settings | **[EndpointSettings](#yandex.cloud.datatransfer.v1.EndpointSettings)**

DataTransfer Endpoint Settings block ||
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

Settings specific to the MySQL source endpoint

#|
||Field | Description ||
|| connection | **[MysqlConnection](#yandex.cloud.datatransfer.v1.endpoint.MysqlConnection)**

Database connection settings ||
|| database | **string**

Name of the database to transfer

You can leave it empty, then it will be possible to transfer tables from several
databases at the same time from this source. ||
|| user | **string**

User for database access. Required unless connection manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| objectTransferSettings | **[MysqlObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.MysqlObjectTransferSettings)**

Schema migration
Defines which database schema objects should be transferred, e.g. views,
routines, etc.
All of the attrubutes in the block are optional and should be either
`BEFORE_DATA`, `AFTER_DATA` or `NEVER`." ||
|| includeTablesRegex[] | **string**

List of regular expressions of table names which should be transferred. A table
name is formatted as schemaname.tablename. For example, a single regular
expression may look like `^mydb.employees$` ||
|| excludeTablesRegex[] | **string**

Opposite of `include_table_regex`. The tables matching the specified regular
expressions will not be transferred ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Get Mysql installation params and credentials from Connection Manager

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremiseMysql {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMysql}

#|
||Field | Description ||
|| port | **string** (int64)

Port for the database connection ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| hosts[] | **string**

List of host names of the MySQL server. Exactly one host is expected ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## TLSMode {#yandex.cloud.datatransfer.v1.endpoint.TLSMode}

TLS configuration

#|
||Field | Description ||
|| enabled | **[TLSConfig](#yandex.cloud.datatransfer.v1.endpoint.TLSConfig)**

TLS is used for the server connection

Includes only one of the fields `enabled`. ||
|#

## TLSConfig {#yandex.cloud.datatransfer.v1.endpoint.TLSConfig}

#|
||Field | Description ||
|| caCertificate | **string**

CA certificate

X.509 certificate of the certificate authority which issued the server's
certificate, in PEM format. When CA certificate is specified, TLS is used to
connect to the server. If CA certificate is empty, the server's certificate must
be signed by a well-known CA ||
|#

## ConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection}

Use Connection Manager connection

#|
||Field | Description ||
|| connectionId | **string**

ID of connection in Connection Manager with installation params and credetials ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
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

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| routine | **enum** (ObjectTransferStage)

Routines

CREATE PROCEDURE ... ; CREATE FUNCTION ... ;

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | **enum** (ObjectTransferStage)

Triggers

CREATE TRIGGER ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| tables | **enum** (ObjectTransferStage)

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## PostgresSource {#yandex.cloud.datatransfer.v1.endpoint.PostgresSource}

Settings specific to the PostgreSQL source endpoint.

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Name of the database to transfer ||
|| user | **string**

User for database access. Required unless Connection Manager connection is used. ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| includeTables[] | **string**

List of tables to transfer, formatted as `schemaname.tablename`.
If omitted or an empty list is specified, all tables will be transferred.
Can contain schema_name.* patterns. ||
|| excludeTables[] | **string**

List of tables which will not be transfered, formatted as `schemaname.tablename`
If omitted or empty list is specified, all tables are replicated.
Can contain schema_name.* patterns. ||
|| slotByteLagLimit | **string** (int64)

Maximum WAL size held by the replication slot (API - in bytes, terraform - in
gigabytes);
Exceeding this limit will result in a replication failure and deletion of the
replication slot.
Default is 50 gigabytes ||
|| serviceSchema | **string**

Name of the database schema in which auxiliary tables needed for the transfer
will be created (__consumer_keeper, __data_transfer_mole_finder).
Empty `service_schema` implies schema `public` ||
|| objectTransferSettings | **[PostgresObjectTransferSettings](#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings)**

Defines which database schema objects should be transferred, e.g. views,
functions, etc.
All of the attributes in this block are optional and should be either
`BEFORE_DATA`, `AFTER_DATA` or `NEVER` ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Get Postgres installation params and credentials from Connection Manager

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremisePostgres {#yandex.cloud.datatransfer.v1.endpoint.OnPremisePostgres}

#|
||Field | Description ||
|| port | **string** (int64)

PG port. Will be used if the cluster ID is not specified. ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| hosts[] | **string**

PG installation hosts ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default. ||
|#

## PostgresObjectTransferSettings {#yandex.cloud.datatransfer.v1.endpoint.PostgresObjectTransferSettings}

#|
||Field | Description ||
|| sequence | **enum** (ObjectTransferStage)

Sequences

CREATE SEQUENCE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequenceOwnedBy | **enum** (ObjectTransferStage)

Owned sequences

CREATE SEQUENCE ... OWNED BY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| table | **enum** (ObjectTransferStage)

Tables

CREATE TABLE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| primaryKey | **enum** (ObjectTransferStage)

Primary keys

ALTER TABLE ... ADD PRIMARY KEY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| fkConstraint | **enum** (ObjectTransferStage)

Foreign keys

ALTER TABLE ... ADD FOREIGN KEY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| defaultValues | **enum** (ObjectTransferStage)

Default values

ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| constraint | **enum** (ObjectTransferStage)

Constraints

ALTER TABLE ... ADD CONSTRAINT ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| index | **enum** (ObjectTransferStage)

Indexes

CREATE INDEX ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| view | **enum** (ObjectTransferStage)

Views

CREATE VIEW ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| function | **enum** (ObjectTransferStage)

Functions

CREATE FUNCTION ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| trigger | **enum** (ObjectTransferStage)

Triggers

CREATE TRIGGER ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| type | **enum** (ObjectTransferStage)

Types

CREATE TYPE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| rule | **enum** (ObjectTransferStage)

Rules

CREATE RULE ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| collation | **enum** (ObjectTransferStage)

Collations

CREATE COLLATION ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| policy | **enum** (ObjectTransferStage)

Policies

CREATE POLICY ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| cast | **enum** (ObjectTransferStage)

Casts

CREATE CAST ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| materializedView | **enum** (ObjectTransferStage)

Materialized views

CREATE MATERIALIZED VIEW ...

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|| sequenceSet | **enum** (ObjectTransferStage)

- `BEFORE_DATA`: Before data transfer
- `AFTER_DATA`: After data transfer
- `NEVER`: Don't copy ||
|#

## YdbSource {#yandex.cloud.datatransfer.v1.endpoint.YdbSource}

Settings specific to the YDB source endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB where tables are stored.
Example: `/ru/transfer_manager/prod/data-transfer-yt` ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
If not specified, will be determined by database ||
|| paths[] | **string**

A list of paths which should be uploaded. When not specified, all available
tables are uploaded ||
|| serviceAccountId | **string**

Service account ID for interaction with database ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| saKeyContent | **string**

Authorization Key ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| changefeedCustomName | **string**

Pre-created change feed if any ||
|| changefeedCustomConsumerName | **string**

Consumer for pre-created change feed if any ||
|#

## YDSSource {#yandex.cloud.datatransfer.v1.endpoint.YDSSource}

Settings specific to the YDS source endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB for streams
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| stream | **string**

Stream to read ||
|| serviceAccountId | **string**

Service account ID which has read access to the stream. ||
|| supportedCodecs[] | **enum** (YdsCompressionCodec)

List of supported compression codecs
Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
YDS_COMPRESSION_CODEC_GZIP

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

YDS Endpoint for dedicated db ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| consumer | **string**

Custom consumer - for important streams ||
|#

## Parser {#yandex.cloud.datatransfer.v1.endpoint.Parser}

#|
||Field | Description ||
|| jsonParser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Parse data in json format

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| auditTrailsV1Parser | **object**

Parse Audit Trails data. Empty struct

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| cloudLoggingParser | **object**

Parse Cloud Logging data. Empty struct

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|| tskvParser | **[GenericParserCommon](#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon)**

Parse data in tskv format

Includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`. ||
|#

## GenericParserCommon {#yandex.cloud.datatransfer.v1.endpoint.GenericParserCommon}

#|
||Field | Description ||
|| dataSchema | **[DataSchema](#yandex.cloud.datatransfer.v1.endpoint.DataSchema)**

Data parsing scheme ||
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

Description of the data schema as JSON specification

Includes only one of the fields `jsonFields`, `fields`. ||
|| fields | **[FieldList](#yandex.cloud.datatransfer.v1.endpoint.FieldList)**

Description of the data schema in the array of `fields` structure

Includes only one of the fields `jsonFields`, `fields`. ||
|#

## FieldList {#yandex.cloud.datatransfer.v1.endpoint.FieldList}

#|
||Field | Description ||
|| fields[] | **[ColSchema](#yandex.cloud.datatransfer.v1.endpoint.ColSchema)**

Description of the column schema in the array of `fields` structure ||
|#

## ColSchema {#yandex.cloud.datatransfer.v1.endpoint.ColSchema}

#|
||Field | Description ||
|| name | **string**

Field name ||
|| type | **enum** (ColumnType)

Field type, one of: `INT64`, `INT32`, `INT16`, `INT8`, `UINT64`, `UINT32`,
`UINT16`, `UINT8`, `DOUBLE`, `BOOLEAN`, `STRING`, `UTF8`, `ANY`, `DATETIME`.

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
|| key | **boolean**

Mark field as Primary Key ||
|| required | **boolean**

Mark field as required ||
|| path | **string**

Path to the field ||
|#

## KafkaSource {#yandex.cloud.datatransfer.v1.endpoint.KafkaSource}

Settings specific to the Kafka source endpoint

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| topicName | **string**

*Deprecated**. Please use `topic_names` instead
Full source topic name ||
|| transformer | **[DataTransformationOptions](#yandex.cloud.datatransfer.v1.endpoint.DataTransformationOptions)**

Transform data with a custom Cloud Function ||
|| parser | **[Parser](#yandex.cloud.datatransfer.v1.endpoint.Parser)**

Data parsing parameters. If not set, the source messages are read in raw ||
|| topicNames[] | **string**

List of full source topic names to read ||
|#

## KafkaConnectionOptions {#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions}

#|
||Field | Description ||
|| clusterId | **string**

Managed Service for Kafka cluster ID.
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseKafka](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka)**

Connection options for on-premise Kafka
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Get Kafka installation params and credentials from Connection Manager
Set only one of: cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `clusterId`, `onPremise`, `connectionManagerConnection`. ||
|#

## OnPremiseKafka {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseKafka}

On-premise Kafka installation options

#|
||Field | Description ||
|| brokerUrls[] | **string**

Kafka broker URLs ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
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

SASL mechanism for authentication, use one of: KAFKA_MECHANISM_SHA256,
KAFKA_MECHANISM_SHA512

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

Buffer size for function. Maximum 4 GB.  Use value with units, i.e. 10 B, 20 kB,
2.0 MB, 30 MB, 1.0 GB ||
|| bufferFlushInterval | **string**

Flush interval ||
|| invocationTimeout | **string**

Invocation timeout ||
|| serviceAccountId | **string**

Service account ||
|#

## MongoSource {#yandex.cloud.datatransfer.v1.endpoint.MongoSource}

Settings specific to the MongoDB source endpoint

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)**

Connection settings ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| collections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of collections for replication. Empty list implies replication of all
tables on the deployment. Allowed to use * as collection name. ||
|| excludedCollections[] | **[MongoCollection](#yandex.cloud.datatransfer.v1.endpoint.MongoCollection)**

List of forbidden collections for replication. Allowed to use * as collection
name for forbid all collections of concrete schema. ||
|| secondaryPreferredMode | **boolean**

Read mode for mongo client: whether the secondary server should be preferred to
the primary when copying data ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Identifier of the Yandex StoreDoc cluster
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| onPremise | **[OnPremiseMongo](#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo)**

Connection settings of the on-premise MongoDB server
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| connectionManagerConnection | **[MongoConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection)**

Get StoreDoc/MongoDB installation params and credentials from Connection Manager
Use one of:  mdb_cluster_id/on_premise/connection_manager_connection

Includes only one of the fields `mdbClusterId`, `onPremise`, `connectionManagerConnection`. ||
|| user | **string**

User name, required unless connection_manager_connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for user ||
|| authSource | **string**

Database name associated with the credentials ||
|#

## OnPremiseMongo {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseMongo}

#|
||Field | Description ||
|| hosts[] | **string**

Host names of the replica set ||
|| port | **string** (int64)

TCP Port number ||
|| replicaSet | **string**

Replica set name ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for the server connection. Empty implies plaintext connection ||
|#

## MongoConnectionManagerConnection {#yandex.cloud.datatransfer.v1.endpoint.MongoConnectionManagerConnection}

#|
||Field | Description ||
|| connectionId | **string**

ID of connectionmanager connection with mongodb/Yandex Storedoc installation
parameters and credentials ||
|| replicaSet | **string**

Replica set name, used only for on-premise mongodb installations ||
|#

## MongoCollection {#yandex.cloud.datatransfer.v1.endpoint.MongoCollection}

#|
||Field | Description ||
|| databaseName | **string** ||
|| collectionName | **string** ||
|#

## ClickhouseSource {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSource}

Settings specific to the ClickHouse source endpoint

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)**

Connection settings ||
|| includeTables[] | **string**

White list of tables for replication. If none or empty list is presented - will
replicate all tables. Can contain * patterns. ||
|| excludeTables[] | **string**

Exclude list of tables for replication. If none or empty list is presented -
will replicate all tables. Can contain * patterns. ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| clickhouseClusterName | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup or managed cluster ID by default ||
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

Connection settings of the on-premise ClickHouse server

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| connectionManagerConnection | **[ConnectionManagerConnection](#yandex.cloud.datatransfer.v1.endpoint.ConnectionManagerConnection)**

Get ClickHouse installation params and credentials from Connection Manager

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| mdbClusterId | **string**

Identifier of the Managed ClickHouse cluster

Includes only one of the fields `onPremise`, `connectionManagerConnection`, `mdbClusterId`. ||
|| user | **string**

User for database access. Required unless connection_manager_connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for the database access ||
|| database | **string**

Database name ||
|#

## OnPremiseClickhouse {#yandex.cloud.datatransfer.v1.endpoint.OnPremiseClickhouse}

#|
||Field | Description ||
|| shards[] | **[ClickhouseShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard)** ||
|| httpPort | **string** (int64) ||
|| nativePort | **string** (int64) ||
|| tlsMode | **[TLSMode](#yandex.cloud.datatransfer.v1.endpoint.TLSMode)**

TLS settings for server connection. Disabled by default ||
|#

## ClickhouseShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseShard}

#|
||Field | Description ||
|| name | **string** ||
|| hosts[] | **string** ||
|#

## MysqlTarget {#yandex.cloud.datatransfer.v1.endpoint.MysqlTarget}

Settings specific to the MySQL target endpoint

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

User for database access. Required unless connection manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| sqlMode | **string**

[sql_mode](https://dev.mysql.com/doc/refman/5.7/en/sql-mode.html) to use when
interacting with the server.
Defaults to `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION` ||
|| skipConstraintChecks | **boolean**

Disable constraints checks
When `true`, disables foreign key checks and unique checks. `False` by default.
See
[foreign_key_checks](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_foreign_key_checks).
Recommend to disable for increase replication speed unless schema contains
cascading operations ||
|| timezone | **string**

Database timezone

Is used for parsing timestamps for saving source timezones. Accepts values from
IANA timezone database. Default: local timezone. ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Cleanup policy for activate, reactivate and reupload processes.
One of `DISABLED`, `DROP` or `TRUNCATE` Default is `DISABLED`.

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| serviceDatabase | **string**

Database schema for service table
Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| isSchemaMigrationDisabled | **boolean**

Whether can change table schema if schema changed on source ||
|#

## PostgresTarget {#yandex.cloud.datatransfer.v1.endpoint.PostgresTarget}

Settings specific to the PostgreSQL target endpoint

#|
||Field | Description ||
|| connection | **[PostgresConnection](#yandex.cloud.datatransfer.v1.endpoint.PostgresConnection)**

Database connection settings ||
|| database | **string**

Target database name ||
|| user | **string**

User for database access. Required unless Connection Manager connection is used ||
|| password | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Password for database access. ||
|| cleanupPolicy | **enum** (CleanupPolicy)

Cleanup policy for activate, reactivate and reupload processes.
One of: DISABLED, DROP, TRUNCATE. Default is TRUNCATE

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| isSchemaMigrationDisabled | **boolean**

Whether can change table schema if schema changed on source ||
|#

## ClickhouseTarget {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseTarget}

Settings specific to the ClickHouse target endpoint

#|
||Field | Description ||
|| connection | **[ClickhouseConnection](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseConnection)**

Connection settings ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| altNames[] | **[AltName](#yandex.cloud.datatransfer.v1.endpoint.AltName)**

Table renaming rules in target ||
|| cleanupPolicy | **enum** (ClickhouseCleanupPolicy)

How to clean collections when activating the transfer. One of
`CLICKHOUSE_CLEANUP_POLICY_DISABLED` or `CLICKHOUSE_CLEANUP_POLICY_DROP`

- `CLICKHOUSE_CLEANUP_POLICY_DISABLED`
- `CLICKHOUSE_CLEANUP_POLICY_DROP`
- `CLICKHOUSE_CLEANUP_POLICY_TRUNCATE` ||
|| sharding | **[ClickhouseSharding](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding)**

Shard selection rules for the data being transferred ||
|| isSchemaMigrationDisabled | **boolean**

Whether can change table schema if schema changed on source ||
|| clickhouseClusterName | **string**

Name of the ClickHouse cluster. For Managed ClickHouse that is name of
ShardGroup or managed cluster ID by default. ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
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

Shard data by the hash value of the specified column

Includes only one of the fields `columnValueHash`, `customMapping`. ||
|| customMapping | **[ColumnValueMapping](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping)**

A custom shard mapping by the value of the specified column

Includes only one of the fields `columnValueHash`, `customMapping`. ||
|#

## ColumnValueHash {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueHash}

#|
||Field | Description ||
|| columnName | **string**

The name of the column to calculate hash from ||
|#

## ColumnValueMapping {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping}

#|
||Field | Description ||
|| columnName | **string**

The name of the column to inspect when deciding the shard to chose for an
incoming row ||
|| mapping[] | **[ValueToShard](#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard)**

The mapping of the specified column values to the shard names ||
|#

## ValueToShard {#yandex.cloud.datatransfer.v1.endpoint.ClickhouseSharding.ColumnValueMapping.ValueToShard}

#|
||Field | Description ||
|| columnValue | **[ColumnValue](#yandex.cloud.datatransfer.v1.endpoint.ColumnValue)**

The value of the column. Currently only the string columns are supported ||
|| shardName | **string**

The name of the shard into which all the rows with the specified `column_value`
will be written ||
|#

## ColumnValue {#yandex.cloud.datatransfer.v1.endpoint.ColumnValue}

#|
||Field | Description ||
|| stringValue | **string**

Includes only one of the fields `stringValue`. ||
|#

## YdbTarget {#yandex.cloud.datatransfer.v1.endpoint.YdbTarget}

Settings specific to the YDB target endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB where tables are stored.
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| instance | **string**

Instance of YDB. example: ydb-ru-prestable.yandex.net:2135.
If not specified, will be determined by database ||
|| path | **string**

Path extension for database, each table will be layouted into this path ||
|| serviceAccountId | **string**

Service account ID for interaction with database ||
|| cleanupPolicy | **enum** (YdbCleanupPolicy)

Cleanup policy determine how to clean collections when activating the transfer.
One of `YDB_CLEANUP_POLICY_DISABLED` or `YDB_CLEANUP_POLICY_DROP`

- `YDB_CLEANUP_POLICY_DISABLED`
- `YDB_CLEANUP_POLICY_DROP` ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| saKeyContent | **string**

Authentication key ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| isTableColumnOriented | **boolean**

Whether a column-oriented (i.e. OLAP) tables should be created.
Default is `false` (create row-oriented OLTP tables) ||
|| defaultCompression | **enum** (YdbDefaultCompression)

Compression that will be used for default columns family on YDB table creation.
One of `YDB_DEFAULT_COMPRESSION_UNSPECIFIED`,
`YDB_DEFAULT_COMPRESSION_DISABLED`, `YDB_DEFAULT_COMPRESSION_LZ4`

- `YDB_DEFAULT_COMPRESSION_DISABLED`
- `YDB_DEFAULT_COMPRESSION_LZ4` ||
|| isSchemaMigrationDisabled | **boolean**

Whether can change table schema if schema changed on source ||
|#

## KafkaTarget {#yandex.cloud.datatransfer.v1.endpoint.KafkaTarget}

Settings specific to the Kafka target endpoint

#|
||Field | Description ||
|| connection | **[KafkaConnectionOptions](#yandex.cloud.datatransfer.v1.endpoint.KafkaConnectionOptions)**

Connection settings ||
|| auth | **[KafkaAuth](#yandex.cloud.datatransfer.v1.endpoint.KafkaAuth)**

Authentication settings ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|| topicSettings | **[KafkaTargetTopicSettings](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings)**

Target topic settings ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format settings ||
|#

## KafkaTargetTopicSettings {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopicSettings}

#|
||Field | Description ||
|| topic | **[KafkaTargetTopic](#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic)**

All messages will be sent to one topic

Includes only one of the fields `topic`, `topicPrefix`. ||
|| topicPrefix | **string**

Topic prefix
Messages will be sent to topic with name &lt;topic_prefix&gt;.&lt;schema&gt;.&lt;table_name&gt;.
Analogue of the Debezium setting database.server.name.

Includes only one of the fields `topic`, `topicPrefix`. ||
|#

## KafkaTargetTopic {#yandex.cloud.datatransfer.v1.endpoint.KafkaTargetTopic}

#|
||Field | Description ||
|| topicName | **string**

Full topic name ||
|| saveTxOrder | **boolean**

Save transactions order
Not to split events queue into separate per-table queues. ||
|#

## Serializer {#yandex.cloud.datatransfer.v1.endpoint.Serializer}

Data serialization format

#|
||Field | Description ||
|| serializerAuto | **object**

Empty block. Select the serialization format automatically

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerJson | **object**

Empty block. Serialize data in json format

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|| serializerDebezium | **[SerializerDebezium](#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium)**

Serialize data in debezium json format

Includes only one of the fields `serializerAuto`, `serializerJson`, `serializerDebezium`. ||
|#

## SerializerDebezium {#yandex.cloud.datatransfer.v1.endpoint.SerializerDebezium}

Serialize data in json format

#|
||Field | Description ||
|| serializerParameters[] | **[DebeziumSerializerParameter](#yandex.cloud.datatransfer.v1.endpoint.DebeziumSerializerParameter)**

A list of Debezium parameters set by the structure of the `key` and `value`
string fields ||
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

Settings specific to the MongoDB target endpoint

#|
||Field | Description ||
|| connection | **[MongoConnection](#yandex.cloud.datatransfer.v1.endpoint.MongoConnection)**

Connection settings ||
|| database | **string**

Database name. If not empty, then all the data will be written to the database
with the specified name; otherwise the database name is the same as in the
source endpoint ||
|| cleanupPolicy | **enum** (CleanupPolicy)

How to clean collections when activating the transfer. One of `DISABLED`, `DROP`
or `TRUNCATE`

- `DISABLED`: Don't cleanup
- `DROP`: Drop
- `TRUNCATE`: Truncate ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database.
If omitted, the server has to be accessible via Internet ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|#

## MetrikaSource {#yandex.cloud.datatransfer.v1.endpoint.MetrikaSource}

Settings specific to the Yandex Metrika source endpoint

#|
||Field | Description ||
|| counterIds[] | **string** (int64)

Counter IDs ||
|| token | **[Secret](#yandex.cloud.datatransfer.v1.endpoint.Secret)**

Authentication token ||
|| streams[] | **[MetrikaStream](#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream)**

Streams ||
|#

## MetrikaStream {#yandex.cloud.datatransfer.v1.endpoint.MetrikaStream}

#|
||Field | Description ||
|| type | **enum** (MetrikaStreamType)

Stream type, one of: METRIKA_STREAM_TYPE_HITS, METRIKA_STREAM_TYPE_VISITS,
METRIKA_STREAM_TYPE_HITS_V2

- `METRIKA_STREAM_TYPE_HITS`
- `METRIKA_STREAM_TYPE_VISITS`
- `METRIKA_STREAM_TYPE_HITS_V2` ||
|| columns[] | **string**

Column names ||
|#

## YDSTarget {#yandex.cloud.datatransfer.v1.endpoint.YDSTarget}

Settings specific to the YDS target endpoint

#|
||Field | Description ||
|| database | **string**

Database path in YDB for streams
Example: `/ru/transfer_manager/prod/data-transfer` ||
|| stream | **string**

Stream to write to ||
|| serviceAccountId | **string**

Service account ID which has read access to the stream ||
|| saveTxOrder | **boolean**

Save transaction order
Not to split events queue into separate per-table queues.
Incompatible with setting Topic prefix, only with Topic full name. ||
|| compressionCodec | **enum** (YdsCompressionCodec)

Codec to use for output data compression. If not specified, no compression will
be done
Options: YDS_COMPRESSION_CODEC_RAW, YDS_COMPRESSION_CODEC_ZSTD,
YDS_COMPRESSION_CODEC_GZIP

- `YDS_COMPRESSION_CODEC_RAW`
- `YDS_COMPRESSION_CODEC_GZIP`
- `YDS_COMPRESSION_CODEC_ZSTD` ||
|| serializer | **[Serializer](#yandex.cloud.datatransfer.v1.endpoint.Serializer)**

Data serialization format ||
|| endpoint | **string**

YDS Endpoint for dedicated db ||
|| subnetId | **string**

Identifier of the Yandex Cloud VPC subnetwork to user for accessing the
database. If omitted, the server has to be accessible via Internet ||
|| securityGroups[] | **string**

List of security groups that the transfer associated with this endpoint should
use ||
|#