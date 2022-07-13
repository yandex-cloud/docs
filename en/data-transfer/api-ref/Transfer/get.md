---
editable: false
sourcePath: en/_api-ref/datatransfer/api-ref/Transfer/get.md
---

# Method get

 

 
## HTTP request {#https-request}
```
GET https://datatransfer.{{ api-host }}/v1/transfer/{transferId}
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

      // `source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`
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
          "trigger": "string"
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
          "materializedView": "string"
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

      // `target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`
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
          "trigger": "string"
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
          "materializedView": "string"
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
source.<br>settings.<br>mysqlSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
source.<br>settings.<br>mysqlSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
source.<br>settings.<br>mysqlSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
source.<br>settings.<br>mysqlSource.<br>serviceDatabase | **string**<br><p>Database for service tables</p> <p>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
source.<br>settings.<br>mysqlSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
source.<br>settings.<br>mysqlSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
source.<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Password</p> 
source.<br>settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**
source.<br>settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**
source.<br>settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> 
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
source.<br>settings.<br>postgresSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
source.<br>settings.<br>postgresSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
source.<br>settings.<br>postgresSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
source.<br>settings.<br>postgresSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
source.<br>settings.<br>postgresSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
source.<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Password</p> 
source.<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
source.<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
source.<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum WAL size for the replication slot</p> <p>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default.</p> 
source.<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service tables</p> <p>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder).</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br><p>Sequences</p> <p>CREATE SEQUENCE ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br><p>Owned sequences</p> <p>CREATE SEQUENCE ... OWNED BY ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br><p>Tables</p> <p>CREATE TABLE ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br><p>Primary keys</p> <p>ALTER TABLE ... ADD PRIMARY KEY ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br><p>Foreign keys</p> <p>ALTER TABLE ... ADD FOREIGN KEY ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br><p>Default values</p> <p>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br><p>Constraints</p> <p>ALTER TABLE ... ADD CONSTRAINT ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br><p>Indexes</p> <p>CREATE INDEX ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br><p>Functions</p> <p>CREATE FUNCTION ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br><p>Types</p> <p>CREATE TYPE ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br><p>Rules</p> <p>CREATE RULE ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br><p>Collations</p> <p>CREATE COLLATION ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br><p>Policies</p> <p>CREATE POLICY ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br><p>Casts</p> <p>CREATE CAST ...</p> 
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>materializedView | **string**<br><p>Materialized views</p> <p>CREATE MATERIALIZED VIEW ...</p> 
source.<br>settings.<br>mongoSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
source.<br>settings.<br>mongoSource.<br>connection | **object**
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions | **object**
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>user | **string**
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password | **object**
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>authSource | **string**
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
source.<br>settings.<br>mongoSource.<br>collections[] | **object**
source.<br>settings.<br>mongoSource.<br>collections[].<br>databaseName | **string**
source.<br>settings.<br>mongoSource.<br>collections[].<br>collectionName | **string**
source.<br>settings.<br>mongoSource.<br>excludedCollections[] | **object**
source.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>databaseName | **string**
source.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>collectionName | **string**
source.<br>settings.<br>mongoSource.<br>secondaryPreferredMode | **boolean** (boolean)
source.<br>settings.<br>clickhouseSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
source.<br>settings.<br>clickhouseSource.<br>connection | **object**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions | **object**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>database | **string**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>user | **string**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password | **object**
source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
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
source.<br>settings.<br>clickhouseSource.<br>includeTables[] | **string**
source.<br>settings.<br>clickhouseSource.<br>excludeTables[] | **string**
source.<br>settings.<br>mysqlTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
source.<br>settings.<br>mysqlTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
source.<br>settings.<br>mysqlTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
source.<br>settings.<br>mysqlTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
source.<br>settings.<br>mysqlTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
source.<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
source.<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>sql_mode</p> <p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
source.<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
source.<br>settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
source.<br>settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
source.<br>settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
source.<br>settings.<br>postgresTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
source.<br>settings.<br>postgresTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
source.<br>settings.<br>postgresTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
source.<br>settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
source.<br>settings.<br>postgresTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
source.<br>settings.<br>postgresTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
source.<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
source.<br>settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
source.<br>settings.<br>clickhouseTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
source.<br>settings.<br>clickhouseTarget.<br>connection | **object**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions | **object**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>database | **string**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>user | **string**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password | **object**
source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
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
source.<br>settings.<br>clickhouseTarget.<br>altNames[] | **object**
source.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>fromName | **string**<br><p>From table name</p> 
source.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>toName | **string**<br><p>To table name</p> 
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
source.<br>settings.<br>mongoTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
source.<br>settings.<br>mongoTarget.<br>connection | **object**
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions | **object**
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>user | **string**
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password | **object**
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>authSource | **string**
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
source.<br>settings.<br>mongoTarget.<br>database | **string**
source.<br>settings.<br>mongoTarget.<br>cleanupPolicy | **string**
target | **object**
target.<br>id | **string**
target.<br>folderId | **string**
target.<br>name | **string**
target.<br>description | **string**
target.<br>labels | **object**
target.<br>settings | **object**
target.<br>settings.<br>mysqlSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
target.<br>settings.<br>mysqlSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
target.<br>settings.<br>mysqlSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
target.<br>settings.<br>mysqlSource.<br>serviceDatabase | **string**<br><p>Database for service tables</p> <p>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
target.<br>settings.<br>mysqlSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
target.<br>settings.<br>mysqlSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
target.<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Password</p> 
target.<br>settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**
target.<br>settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**
target.<br>settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> 
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
target.<br>settings.<br>postgresSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
target.<br>settings.<br>postgresSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
target.<br>settings.<br>postgresSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
target.<br>settings.<br>postgresSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
target.<br>settings.<br>postgresSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
target.<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Password</p> 
target.<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
target.<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
target.<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum WAL size for the replication slot</p> <p>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default.</p> 
target.<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service tables</p> <p>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder).</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br><p>Sequences</p> <p>CREATE SEQUENCE ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br><p>Owned sequences</p> <p>CREATE SEQUENCE ... OWNED BY ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br><p>Tables</p> <p>CREATE TABLE ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br><p>Primary keys</p> <p>ALTER TABLE ... ADD PRIMARY KEY ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br><p>Foreign keys</p> <p>ALTER TABLE ... ADD FOREIGN KEY ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br><p>Default values</p> <p>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br><p>Constraints</p> <p>ALTER TABLE ... ADD CONSTRAINT ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br><p>Indexes</p> <p>CREATE INDEX ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br><p>Functions</p> <p>CREATE FUNCTION ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br><p>Types</p> <p>CREATE TYPE ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br><p>Rules</p> <p>CREATE RULE ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br><p>Collations</p> <p>CREATE COLLATION ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br><p>Policies</p> <p>CREATE POLICY ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br><p>Casts</p> <p>CREATE CAST ...</p> 
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>materializedView | **string**<br><p>Materialized views</p> <p>CREATE MATERIALIZED VIEW ...</p> 
target.<br>settings.<br>mongoSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
target.<br>settings.<br>mongoSource.<br>connection | **object**
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions | **object**
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>user | **string**
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password | **object**
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>authSource | **string**
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
target.<br>settings.<br>mongoSource.<br>collections[] | **object**
target.<br>settings.<br>mongoSource.<br>collections[].<br>databaseName | **string**
target.<br>settings.<br>mongoSource.<br>collections[].<br>collectionName | **string**
target.<br>settings.<br>mongoSource.<br>excludedCollections[] | **object**
target.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>databaseName | **string**
target.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>collectionName | **string**
target.<br>settings.<br>mongoSource.<br>secondaryPreferredMode | **boolean** (boolean)
target.<br>settings.<br>clickhouseSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
target.<br>settings.<br>clickhouseSource.<br>connection | **object**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions | **object**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>database | **string**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>user | **string**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password | **object**
target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
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
target.<br>settings.<br>clickhouseSource.<br>includeTables[] | **string**
target.<br>settings.<br>clickhouseSource.<br>excludeTables[] | **string**
target.<br>settings.<br>mysqlTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
target.<br>settings.<br>mysqlTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
target.<br>settings.<br>mysqlTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
target.<br>settings.<br>mysqlTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
target.<br>settings.<br>mysqlTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
target.<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
target.<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>sql_mode</p> <p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
target.<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
target.<br>settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
target.<br>settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
target.<br>settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
target.<br>settings.<br>postgresTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
target.<br>settings.<br>postgresTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
target.<br>settings.<br>postgresTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
target.<br>settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
target.<br>settings.<br>postgresTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
target.<br>settings.<br>postgresTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
target.<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
target.<br>settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
target.<br>settings.<br>clickhouseTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
target.<br>settings.<br>clickhouseTarget.<br>connection | **object**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions | **object**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>database | **string**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>user | **string**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password | **object**
target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
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
target.<br>settings.<br>clickhouseTarget.<br>altNames[] | **object**
target.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>fromName | **string**<br><p>From table name</p> 
target.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>toName | **string**<br><p>To table name</p> 
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
target.<br>settings.<br>mongoTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
target.<br>settings.<br>mongoTarget.<br>connection | **object**
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions | **object**
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>user | **string**
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password | **object**
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>authSource | **string**
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
target.<br>settings.<br>mongoTarget.<br>database | **string**
target.<br>settings.<br>mongoTarget.<br>cleanupPolicy | **string**
status | **string**
type | **string**<br><ul> <li>SNAPSHOT_AND_INCREMENT: Snapshot and increment</li> <li>SNAPSHOT_ONLY: Snapshot</li> <li>INCREMENT_ONLY: Increment</li> </ul> 
warning | **string**