---
editable: false
sourcePath: en/_api-ref/datatransfer/api-ref/Endpoint/list.md
---

# Data Transfer API, REST: Endpoint.list

 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-data-transfer }}/v1/endpoints/list/{folderId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
folderId | <p>Identifier of the folder containing the endpoints to be listed.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of endpoints to be sent in the response message. If the folder contains more endpoints than ``page_size``, ``next_page_token`` will be included in the response message. Include it into the subsequent ``ListEndpointRequest`` to fetch the next page. Defaults to ``100`` if not specified. The maximum allowed value for this field is ``500``.</p> 
pageToken | <p>Opaque value identifying the endpoints page to be fetched. Should be empty in the first ``ListEndpointsRequest``. Subsequent requests should have this field filled with the ``next_page_token`` from the previous ``ListEndpointsResponse``.</p> 
 
## Response {#responses}
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

        // `endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`
        "mysqlSource": {
          "connection": {

            // `endpoints[].settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
            "onPremise": {
              "hosts": [
                "string"
              ],
              "port": "string",
              "tlsMode": {

                // `endpoints[].settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`endpoints[].settings.mysqlSource.connection.onPremise.tlsMode`

              },
              "subnetId": "string"
            },
            // end of the list of possible fields`endpoints[].settings.mysqlSource.connection`

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

            // `endpoints[].settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
            "onPremise": {
              "hosts": [
                "string"
              ],
              "port": "string",
              "tlsMode": {

                // `endpoints[].settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`endpoints[].settings.postgresSource.connection.onPremise.tlsMode`

              },
              "subnetId": "string"
            },
            // end of the list of possible fields`endpoints[].settings.postgresSource.connection`

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

            // `endpoints[].settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`
            "clusterId": "string",
            "onPremise": {
              "brokerUrls": [
                "string"
              ],
              "tlsMode": {

                // `endpoints[].settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`endpoints[].settings.kafkaSource.connection.onPremise.tlsMode`

              },
              "subnetId": "string"
            },
            // end of the list of possible fields`endpoints[].settings.kafkaSource.connection`

          },
          "auth": {

            // `endpoints[].settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`
            "sasl": {
              "user": "string",
              "password": {
                "raw": "string"
              },
              "mechanism": "string"
            },
            "noAuth": {},
            // end of the list of possible fields`endpoints[].settings.kafkaSource.auth`

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

            // `endpoints[].settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`
            "jsonParser": {
              "dataSchema": {

                // `endpoints[].settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`
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
                // end of the list of possible fields`endpoints[].settings.kafkaSource.parser.jsonParser.dataSchema`

              },
              "nullKeysAllowed": true,
              "addRestColumn": true
            },
            "auditTrailsV1Parser": {},
            "cloudLoggingParser": {},
            "tskvParser": {
              "dataSchema": {

                // `endpoints[].settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`
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
                // end of the list of possible fields`endpoints[].settings.kafkaSource.parser.tskvParser.dataSchema`

              },
              "nullKeysAllowed": true,
              "addRestColumn": true
            },
            // end of the list of possible fields`endpoints[].settings.kafkaSource.parser`

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

              // `endpoints[].settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `endpoints[].settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`endpoints[].settings.mongoSource.connection.connectionOptions.onPremise.tlsMode`

                },
                "replicaSet": "string"
              },
              // end of the list of possible fields`endpoints[].settings.mongoSource.connection.connectionOptions`

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

              // `endpoints[].settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
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

                  // `endpoints[].settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`endpoints[].settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode`

                }
              },
              // end of the list of possible fields`endpoints[].settings.clickhouseSource.connection.connectionOptions`

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

            // `endpoints[].settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
            "onPremise": {
              "hosts": [
                "string"
              ],
              "port": "string",
              "tlsMode": {

                // `endpoints[].settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`endpoints[].settings.mysqlTarget.connection.onPremise.tlsMode`

              },
              "subnetId": "string"
            },
            // end of the list of possible fields`endpoints[].settings.mysqlTarget.connection`

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

            // `endpoints[].settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
            "mdbClusterId": "string",
            "onPremise": {
              "hosts": [
                "string"
              ],
              "port": "string",
              "tlsMode": {

                // `endpoints[].settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`endpoints[].settings.postgresTarget.connection.onPremise.tlsMode`

              },
              "subnetId": "string"
            },
            // end of the list of possible fields`endpoints[].settings.postgresTarget.connection`

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

              // `endpoints[].settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
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

                  // `endpoints[].settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`endpoints[].settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode`

                }
              },
              // end of the list of possible fields`endpoints[].settings.clickhouseTarget.connection.connectionOptions`

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

            // `endpoints[].settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`
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
            // end of the list of possible fields`endpoints[].settings.clickhouseTarget.sharding`

          },
          "cleanupPolicy": "string"
        },
        "kafkaTarget": {
          "connection": {

            // `endpoints[].settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`
            "clusterId": "string",
            "onPremise": {
              "brokerUrls": [
                "string"
              ],
              "tlsMode": {

                // `endpoints[].settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                "disabled": "object",
                "enabled": {
                  "caCertificate": "string"
                },
                // end of the list of possible fields`endpoints[].settings.kafkaTarget.connection.onPremise.tlsMode`

              },
              "subnetId": "string"
            },
            // end of the list of possible fields`endpoints[].settings.kafkaTarget.connection`

          },
          "auth": {

            // `endpoints[].settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`
            "sasl": {
              "user": "string",
              "password": {
                "raw": "string"
              },
              "mechanism": "string"
            },
            "noAuth": {},
            // end of the list of possible fields`endpoints[].settings.kafkaTarget.auth`

          },
          "securityGroups": [
            "string"
          ],
          "topicSettings": {

            // `endpoints[].settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`
            "topic": {
              "topicName": "string",
              "saveTxOrder": true
            },
            "topicPrefix": "string",
            // end of the list of possible fields`endpoints[].settings.kafkaTarget.topicSettings`

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

              // `endpoints[].settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `endpoints[].settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`endpoints[].settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode`

                },
                "replicaSet": "string"
              },
              // end of the list of possible fields`endpoints[].settings.mongoTarget.connection.connectionOptions`

            }
          },
          "subnetId": "string",
          "securityGroups": [
            "string"
          ],
          "database": "string",
          "cleanupPolicy": "string"
        },
        // end of the list of possible fields`endpoints[].settings`

      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
endpoints[] | **object**<br><p>The list of endpoints. If there are more endpoints in the folder, then ``next_page_token`` is a non-empty string to be included into the subsequent ``ListEndpointsRequest`` to fetch the next endpoints page.</p> 
endpoints[].<br>id | **string**
endpoints[].<br>folderId | **string**
endpoints[].<br>name | **string**
endpoints[].<br>description | **string**
endpoints[].<br>labels | **object**
endpoints[].<br>settings | **object**
endpoints[].<br>settings.<br>mysqlSource | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>mysqlSource.<br>connection | **object**<br><p>Database connection settings</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`endpoints[].settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for MySQL cluster ID</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise MySQL <br>`endpoints[].settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>serviceDatabase | **string**<br><p>Database for service tables</p> <p>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>user | **string**<br><p>User for database access.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>password | **object**<br><p>Password for database access.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**
endpoints[].<br>settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**
endpoints[].<br>settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
endpoints[].<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>tables | **string**<br><ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>postgresSource.<br>connection | **object**<br><p>Database connection settings</p> 
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`endpoints[].settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for PostgreSQL cluster ID</p> 
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise PostgreSQL <br>`endpoints[].settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Will be used if the cluster ID is not specified.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
endpoints[].<br>settings.<br>postgresSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
endpoints[].<br>settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
endpoints[].<br>settings.<br>postgresSource.<br>user | **string**<br><p>User for database access.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>password | **object**<br><p>Password for database access.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum lag of replication slot (in bytes); after exceeding this limit replication will be aborted.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service tables (__consumer_keeper, __data_transfer_mole_finder). Default is public</p> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br><p>Select database objects to be transferred during activation or deactivation.</p> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br><p>Sequences</p> <p>CREATE SEQUENCE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br><p>Owned sequences</p> <p>CREATE SEQUENCE ... OWNED BY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceSet | **string**<br><ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br><p>Tables</p> <p>CREATE TABLE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br><p>Primary keys</p> <p>ALTER TABLE ... ADD PRIMARY KEY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br><p>Foreign keys</p> <p>ALTER TABLE ... ADD FOREIGN KEY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br><p>Default values</p> <p>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br><p>Constraints</p> <p>ALTER TABLE ... ADD CONSTRAINT ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br><p>Indexes</p> <p>CREATE INDEX ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>materializedView | **string**<br><p>Materialized views</p> <p>CREATE MATERIALIZED VIEW ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br><p>Functions</p> <p>CREATE FUNCTION ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br><p>Types</p> <p>CREATE TYPE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br><p>Rules</p> <p>CREATE RULE ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br><p>Collations</p> <p>CREATE COLLATION ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br><p>Policies</p> <p>CREATE POLICY ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br><p>Casts</p> <p>CREATE CAST ...</p> <ul> <li>BEFORE_DATA: Before data transfer</li> <li>AFTER_DATA: After data transfer</li> <li>NEVER: Don't copy</li> </ul> 
endpoints[].<br>settings.<br>kafkaSource | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>connection | **object**<br><p>Connection settings</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>clusterId | **string** <br>`endpoints[].settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`<br><br><p>Managed Service for Kafka cluster ID</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise Kafka <br>`endpoints[].settings.kafkaSource.connection` includes only one of the fields `clusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>brokerUrls[] | **string**<br><p>Kafka broker URLs</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for broker connection. Disabled by default.</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.kafkaSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>auth | **object**<br><p>Authentication settings</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>auth.<br>sasl | **object**<br>Authentication with SASL <br>`endpoints[].settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>user | **string**<br><p>User name</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>password | **object**<br><p>Password for user</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>auth.<br>sasl.<br>mechanism | **string**<br><p>SASL mechanism for authentication</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>auth.<br>noAuth | **object**<br>No authentication <br>`endpoints[].settings.kafkaSource.auth` includes only one of the fields `sasl`, `noAuth`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>topicName | **string**<br><p>Full source topic name</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>transformer | **object**<br><p>Data transformation rules</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>transformer.<br>cloudFunction | **string**<br><p>Cloud function</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>transformer.<br>serviceAccountId | **string**<br><p>Service account</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>transformer.<br>numberOfRetries | **string** (int64)<br><p>Number of retries</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>transformer.<br>bufferSize | **string**<br><p>Buffer size for function</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>transformer.<br>bufferFlushInterval | **string**<br><p>Flush interval</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>transformer.<br>invocationTimeout | **string**<br><p>Invocation timeout</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>parser | **object**<br><p>Data parsing rules</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser | **object** <br>`endpoints[].settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema | **object**
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields | **object** <br>`endpoints[].settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[] | **object**<br><p>Column schema</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>name | **string**
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>type | **string**
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>key | **boolean** (boolean)
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>required | **boolean** (boolean)
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>fields.<br>fields[].<br>path | **string**
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>dataSchema.<br>jsonFields | **string** <br>`endpoints[].settings.kafkaSource.parser.jsonParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>nullKeysAllowed | **boolean** (boolean)<br><p>Allow null keys, if no - null keys will be putted to unparsed data</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>jsonParser.<br>addRestColumn | **boolean** (boolean)<br><p>Will add _rest column for all unknown fields</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>auditTrailsV1Parser | **object** <br>`endpoints[].settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>cloudLoggingParser | **object** <br>`endpoints[].settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser | **object** <br>`endpoints[].settings.kafkaSource.parser` includes only one of the fields `jsonParser`, `auditTrailsV1Parser`, `cloudLoggingParser`, `tskvParser`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema | **object**
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields | **object** <br>`endpoints[].settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[] | **object**<br><p>Column schema</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>name | **string**
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>type | **string**
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>key | **boolean** (boolean)
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>required | **boolean** (boolean)
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>fields.<br>fields[].<br>path | **string**
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>dataSchema.<br>jsonFields | **string** <br>`endpoints[].settings.kafkaSource.parser.tskvParser.dataSchema` includes only one of the fields `fields`, `jsonFields`<br>
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>nullKeysAllowed | **boolean** (boolean)<br><p>Allow null keys, if no - null keys will be putted to unparsed data</p> 
endpoints[].<br>settings.<br>kafkaSource.<br>parser.<br>tskvParser.<br>addRestColumn | **boolean** (boolean)<br><p>Will add _rest column for all unknown fields</p> 
endpoints[].<br>settings.<br>mongoSource | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>mongoSource.<br>connection | **object**
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions | **object**
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>user | **string**<br><p>User name</p> 
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>authSource | **string**<br><p>Database name associated with the credentials</p> 
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`endpoints[].settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`endpoints[].settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
endpoints[].<br>settings.<br>mongoSource.<br>subnetId | **string**
endpoints[].<br>settings.<br>mongoSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
endpoints[].<br>settings.<br>mongoSource.<br>collections[] | **object**<br><p>List of collections for replication. Empty list implies replication of all tables on the deployment. Allowed to use * as collection name.</p> 
endpoints[].<br>settings.<br>mongoSource.<br>collections[].<br>databaseName | **string**
endpoints[].<br>settings.<br>mongoSource.<br>collections[].<br>collectionName | **string**
endpoints[].<br>settings.<br>mongoSource.<br>excludedCollections[] | **object**<br><p>List of forbidden collections for replication. Allowed to use * as collection name for forbid all collections of concrete schema.</p> 
endpoints[].<br>settings.<br>mongoSource.<br>excludedCollections[].<br>databaseName | **string**
endpoints[].<br>settings.<br>mongoSource.<br>excludedCollections[].<br>collectionName | **string**
endpoints[].<br>settings.<br>mongoSource.<br>secondaryPreferredMode | **boolean** (boolean)<br><p>Read mode for mongo client</p> 
endpoints[].<br>settings.<br>clickhouseSource | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>clickhouseSource.<br>connection | **object**
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions | **object**
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>database | **string**<br><p>Database</p> 
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>user | **string**
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`endpoints[].settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`endpoints[].settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>clickhouseSource.<br>subnetId | **string**
endpoints[].<br>settings.<br>clickhouseSource.<br>securityGroups[] | **string**
endpoints[].<br>settings.<br>clickhouseSource.<br>includeTables[] | **string**<br><p>While list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns.</p> 
endpoints[].<br>settings.<br>clickhouseSource.<br>excludeTables[] | **string**<br><p>Exclude list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns.</p> 
endpoints[].<br>settings.<br>mysqlTarget | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>mysqlTarget.<br>connection | **object**<br><p>Database connection settings</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`endpoints[].settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for MySQL cluster ID</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise MySQL <br>`endpoints[].settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>user | **string**<br><p>User for database access.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>password | **object**<br><p>Password for database access.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
endpoints[].<br>settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> <ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
endpoints[].<br>settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
endpoints[].<br>settings.<br>postgresTarget | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>postgresTarget.<br>connection | **object**<br><p>Database connection settings</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`endpoints[].settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed Service for PostgreSQL cluster ID</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise PostgreSQL <br>`endpoints[].settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Will be used if the cluster ID is not specified.</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for server connection. Disabled by default.</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>user | **string**<br><p>User for database access.</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>password | **object**<br><p>Password for database access.</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy for activate, reactivate and reupload processes. Default is truncate.</p> <ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
endpoints[].<br>settings.<br>clickhouseTarget | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection | **object**
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions | **object**
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>database | **string**<br><p>Database</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>user | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`endpoints[].settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`endpoints[].settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>subnetId | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>securityGroups[] | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>clickhouseClusterName | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>altNames[] | **object**<br><p>Alternative table names in target</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>altNames[].<br>fromName | **string**<br><p>Source table name</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>altNames[].<br>toName | **string**<br><p>Target table name</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding | **object**
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash | **object** <br>`endpoints[].settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash.<br>columnName | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping | **object** <br>`endpoints[].settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>columnName | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[] | **object**
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue | **object**
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue.<br>stringValue | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>shardName | **string**
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId | **object** <br>`endpoints[].settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId.<br>transferId | **object** <br>`endpoints[].settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>clickhouseTarget.<br>cleanupPolicy | **string**
endpoints[].<br>settings.<br>kafkaTarget | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>kafkaTarget.<br>connection | **object**<br><p>Connection settings</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>clusterId | **string** <br>`endpoints[].settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`<br><br><p>Managed Service for Kafka cluster ID</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise | **object**<br>Connection options for on-premise Kafka <br>`endpoints[].settings.kafkaTarget.connection` includes only one of the fields `clusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>brokerUrls[] | **string**<br><p>Kafka broker URLs</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS settings for broker connection. Disabled by default.</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.kafkaTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint. If none will assume public ipv4</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>auth | **object**<br><p>Authentication settings</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>auth.<br>sasl | **object**<br>Authentication with SASL <br>`endpoints[].settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`<br>
endpoints[].<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>user | **string**<br><p>User name</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>password | **object**<br><p>Password for user</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>auth.<br>sasl.<br>mechanism | **string**<br><p>SASL mechanism for authentication</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>auth.<br>noAuth | **object**<br>No authentication <br>`endpoints[].settings.kafkaTarget.auth` includes only one of the fields `sasl`, `noAuth`<br>
endpoints[].<br>settings.<br>kafkaTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>topicSettings | **object**<br><p>Target topic settings</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic | **object**<br>Full topic name <br>`endpoints[].settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`<br>
endpoints[].<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic.<br>topicName | **string**<br><p>Topic name</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topic.<br>saveTxOrder | **boolean** (boolean)<br><p>Save transactions order Not to split events queue into separate per-table queues.</p> 
endpoints[].<br>settings.<br>kafkaTarget.<br>topicSettings.<br>topicPrefix | **string** <br>`endpoints[].settings.kafkaTarget.topicSettings` includes only one of the fields `topic`, `topicPrefix`<br><br><p>Topic prefix</p> <p>Analogue of the Debezium setting database.server.name. Messages will be sent to topic with name &lt;topic_prefix&gt;.<schema>.&lt;table_name&gt;.</p> 
endpoints[].<br>settings.<br>mongoTarget | **object** <br>`endpoints[].settings` includes only one of the fields `mysqlSource`, `postgresSource`, `kafkaSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `kafkaTarget`, `mongoTarget`<br>
endpoints[].<br>settings.<br>mongoTarget.<br>connection | **object**
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions | **object**
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>user | **string**<br><p>User name</p> 
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password | **object**<br>Password for user
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Raw secret value</p> 
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>authSource | **string**<br><p>Database name associated with the credentials</p> 
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`endpoints[].settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`endpoints[].settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`endpoints[].settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`endpoints[].settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`endpoints[].settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
endpoints[].<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
endpoints[].<br>settings.<br>mongoTarget.<br>subnetId | **string**
endpoints[].<br>settings.<br>mongoTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
endpoints[].<br>settings.<br>mongoTarget.<br>database | **string**<br><p>Database name</p> 
endpoints[].<br>settings.<br>mongoTarget.<br>cleanupPolicy | **string**<br><ul> <li>DISABLED: Don't cleanup</li> <li>DROP: Drop</li> <li>TRUNCATE: Truncate</li> </ul> 
nextPageToken | **string**<br><p>Opaque value identifying the next endpoints page. This field is empty if there are no more endpoints in the folder. Otherwise, it is non-empty and should be included in the subsequent ``ListEndpointsRequest`` to fetch the next endpoints page.</p> 