---
editable: false
---

# Data Transfer API, REST: Transfer.list

 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-data-transfer }}/v1/transfers/list/{folderId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
folderId | <p>Identifier of the folder containing the transfers to be listed.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of transfers to be sent in the response message. If the folder contains more transfers than page_size, next_page_token will be included in the response message. Include it into the subsequent ListTransfersRequest to fetch the next page. Defaults to 100 if not specified. The maximum allowed value for this field is 500.</p> 
pageToken | <p>Opaque value identifying the transfers page to be fetched. Should be empty in the first ListTransfersRequest. Subsequent request should have this field filled with the next_page_token from the previous ListTransfersResponse.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "transfers": [
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

          // `transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`
          "mysqlSource": {
            "connection": {

              // `transfers[].source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `transfers[].source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`transfers[].source.settings.mysqlSource.connection.onPremise.tlsMode`

                },
                "subnetId": "string"
              },
              // end of the list of possible fields`transfers[].source.settings.mysqlSource.connection`

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

              // `transfers[].source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `transfers[].source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`transfers[].source.settings.postgresSource.connection.onPremise.tlsMode`

                },
                "subnetId": "string"
              },
              // end of the list of possible fields`transfers[].source.settings.postgresSource.connection`

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

                // `transfers[].source.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
                "mdbClusterId": "string",
                "onPremise": {
                  "hosts": [
                    "string"
                  ],
                  "port": "string",
                  "tlsMode": {

                    // `transfers[].source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                    "disabled": "object",
                    "enabled": {
                      "caCertificate": "string"
                    },
                    // end of the list of possible fields`transfers[].source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode`

                  },
                  "replicaSet": "string"
                },
                // end of the list of possible fields`transfers[].source.settings.mongoSource.connection.connectionOptions`

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

                // `transfers[].source.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
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

                    // `transfers[].source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                    "disabled": "object",
                    "enabled": {
                      "caCertificate": "string"
                    },
                    // end of the list of possible fields`transfers[].source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode`

                  }
                },
                // end of the list of possible fields`transfers[].source.settings.clickhouseSource.connection.connectionOptions`

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

              // `transfers[].source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `transfers[].source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`transfers[].source.settings.mysqlTarget.connection.onPremise.tlsMode`

                },
                "subnetId": "string"
              },
              // end of the list of possible fields`transfers[].source.settings.mysqlTarget.connection`

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

              // `transfers[].source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `transfers[].source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`transfers[].source.settings.postgresTarget.connection.onPremise.tlsMode`

                },
                "subnetId": "string"
              },
              // end of the list of possible fields`transfers[].source.settings.postgresTarget.connection`

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

                // `transfers[].source.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
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

                    // `transfers[].source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                    "disabled": "object",
                    "enabled": {
                      "caCertificate": "string"
                    },
                    // end of the list of possible fields`transfers[].source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode`

                  }
                },
                // end of the list of possible fields`transfers[].source.settings.clickhouseTarget.connection.connectionOptions`

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

              // `transfers[].source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`
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
              // end of the list of possible fields`transfers[].source.settings.clickhouseTarget.sharding`

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

                // `transfers[].source.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
                "mdbClusterId": "string",
                "onPremise": {
                  "hosts": [
                    "string"
                  ],
                  "port": "string",
                  "tlsMode": {

                    // `transfers[].source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                    "disabled": "object",
                    "enabled": {
                      "caCertificate": "string"
                    },
                    // end of the list of possible fields`transfers[].source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode`

                  },
                  "replicaSet": "string"
                },
                // end of the list of possible fields`transfers[].source.settings.mongoTarget.connection.connectionOptions`

              }
            },
            "subnetId": "string",
            "securityGroups": [
              "string"
            ],
            "database": "string",
            "cleanupPolicy": "string"
          },
          // end of the list of possible fields`transfers[].source.settings`

        }
      },
      "target": {
        "id": "string",
        "folderId": "string",
        "name": "string",
        "description": "string",
        "labels": "object",
        "settings": {

          // `transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`
          "mysqlSource": {
            "connection": {

              // `transfers[].target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `transfers[].target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`transfers[].target.settings.mysqlSource.connection.onPremise.tlsMode`

                },
                "subnetId": "string"
              },
              // end of the list of possible fields`transfers[].target.settings.mysqlSource.connection`

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

              // `transfers[].target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `transfers[].target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`transfers[].target.settings.postgresSource.connection.onPremise.tlsMode`

                },
                "subnetId": "string"
              },
              // end of the list of possible fields`transfers[].target.settings.postgresSource.connection`

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

                // `transfers[].target.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
                "mdbClusterId": "string",
                "onPremise": {
                  "hosts": [
                    "string"
                  ],
                  "port": "string",
                  "tlsMode": {

                    // `transfers[].target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                    "disabled": "object",
                    "enabled": {
                      "caCertificate": "string"
                    },
                    // end of the list of possible fields`transfers[].target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode`

                  },
                  "replicaSet": "string"
                },
                // end of the list of possible fields`transfers[].target.settings.mongoSource.connection.connectionOptions`

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

                // `transfers[].target.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
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

                    // `transfers[].target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                    "disabled": "object",
                    "enabled": {
                      "caCertificate": "string"
                    },
                    // end of the list of possible fields`transfers[].target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode`

                  }
                },
                // end of the list of possible fields`transfers[].target.settings.clickhouseSource.connection.connectionOptions`

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

              // `transfers[].target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `transfers[].target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`transfers[].target.settings.mysqlTarget.connection.onPremise.tlsMode`

                },
                "subnetId": "string"
              },
              // end of the list of possible fields`transfers[].target.settings.mysqlTarget.connection`

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

              // `transfers[].target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
              "mdbClusterId": "string",
              "onPremise": {
                "hosts": [
                  "string"
                ],
                "port": "string",
                "tlsMode": {

                  // `transfers[].target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                  "disabled": "object",
                  "enabled": {
                    "caCertificate": "string"
                  },
                  // end of the list of possible fields`transfers[].target.settings.postgresTarget.connection.onPremise.tlsMode`

                },
                "subnetId": "string"
              },
              // end of the list of possible fields`transfers[].target.settings.postgresTarget.connection`

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

                // `transfers[].target.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
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

                    // `transfers[].target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                    "disabled": "object",
                    "enabled": {
                      "caCertificate": "string"
                    },
                    // end of the list of possible fields`transfers[].target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode`

                  }
                },
                // end of the list of possible fields`transfers[].target.settings.clickhouseTarget.connection.connectionOptions`

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

              // `transfers[].target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`
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
              // end of the list of possible fields`transfers[].target.settings.clickhouseTarget.sharding`

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

                // `transfers[].target.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
                "mdbClusterId": "string",
                "onPremise": {
                  "hosts": [
                    "string"
                  ],
                  "port": "string",
                  "tlsMode": {

                    // `transfers[].target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
                    "disabled": "object",
                    "enabled": {
                      "caCertificate": "string"
                    },
                    // end of the list of possible fields`transfers[].target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode`

                  },
                  "replicaSet": "string"
                },
                // end of the list of possible fields`transfers[].target.settings.mongoTarget.connection.connectionOptions`

              }
            },
            "subnetId": "string",
            "securityGroups": [
              "string"
            ],
            "database": "string",
            "cleanupPolicy": "string"
          },
          // end of the list of possible fields`transfers[].target.settings`

        }
      },
      "status": "string",
      "type": "string",
      "warning": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
transfers[] | **object**<br><p>The list of transfers. If there are more transfers in the folder, then next_page_token is a non-empty string to be included into the subsequent ListTransfersRequest to fetch the next transfers page.</p> 
transfers[].<br>id | **string**
transfers[].<br>folderId | **string**
transfers[].<br>name | **string**
transfers[].<br>description | **string**
transfers[].<br>labels | **object**
transfers[].<br>source | **object**
transfers[].<br>source.<br>id | **string**
transfers[].<br>source.<br>folderId | **string**
transfers[].<br>source.<br>name | **string**
transfers[].<br>source.<br>description | **string**
transfers[].<br>source.<br>labels | **object**
transfers[].<br>source.<br>settings | **object**
transfers[].<br>source.<br>settings.<br>mysqlSource | **object** <br>`transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`transfers[].source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`transfers[].source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>serviceDatabase | **string**<br><p>Database for service tables</p> <p>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> 
transfers[].<br>source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource | **object** <br>`transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`transfers[].source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`transfers[].source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum WAL size for the replication slot</p> <p>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service tables</p> <p>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder).</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br><p>Sequences</p> <p>CREATE SEQUENCE ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br><p>Owned sequences</p> <p>CREATE SEQUENCE ... OWNED BY ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br><p>Tables</p> <p>CREATE TABLE ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br><p>Primary keys</p> <p>ALTER TABLE ... ADD PRIMARY KEY ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br><p>Foreign keys</p> <p>ALTER TABLE ... ADD FOREIGN KEY ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br><p>Default values</p> <p>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br><p>Constraints</p> <p>ALTER TABLE ... ADD CONSTRAINT ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br><p>Indexes</p> <p>CREATE INDEX ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br><p>Functions</p> <p>CREATE FUNCTION ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br><p>Types</p> <p>CREATE TYPE ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br><p>Rules</p> <p>CREATE RULE ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br><p>Collations</p> <p>CREATE COLLATION ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br><p>Policies</p> <p>CREATE POLICY ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br><p>Casts</p> <p>CREATE CAST ...</p> 
transfers[].<br>source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>materializedView | **string**<br><p>Materialized views</p> <p>CREATE MATERIALIZED VIEW ...</p> 
transfers[].<br>source.<br>settings.<br>mongoSource | **object** <br>`transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection | **object**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions | **object**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>user | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password | **object**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>authSource | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`transfers[].source.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`transfers[].source.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].source.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>source.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>subnetId | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>source.<br>settings.<br>mongoSource.<br>collections[] | **object**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>collections[].<br>databaseName | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>collections[].<br>collectionName | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>excludedCollections[] | **object**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>databaseName | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>collectionName | **string**
transfers[].<br>source.<br>settings.<br>mongoSource.<br>secondaryPreferredMode | **boolean** (boolean)
transfers[].<br>source.<br>settings.<br>clickhouseSource | **object** <br>`transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection | **object**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions | **object**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>database | **string**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>user | **string**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password | **object**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`transfers[].source.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`transfers[].source.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].source.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>subnetId | **string**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>securityGroups[] | **string**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>includeTables[] | **string**
transfers[].<br>source.<br>settings.<br>clickhouseSource.<br>excludeTables[] | **string**
transfers[].<br>source.<br>settings.<br>mysqlTarget | **object** <br>`transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`transfers[].source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`transfers[].source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>sql_mode</p> <p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
transfers[].<br>source.<br>settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget | **object** <br>`transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`transfers[].source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`transfers[].source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>source.<br>settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget | **object** <br>`transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>database | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>user | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`transfers[].source.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`transfers[].source.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].source.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>subnetId | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>securityGroups[] | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>clickhouseClusterName | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>altNames[] | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>fromName | **string**<br><p>From table name</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>toName | **string**<br><p>To table name</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash | **object** <br>`transfers[].source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash.<br>columnName | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping | **object** <br>`transfers[].source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>columnName | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[] | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue | **object**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue.<br>stringValue | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>shardName | **string**
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId | **object** <br>`transfers[].source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId.<br>transferId | **object** <br>`transfers[].source.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>clickhouseTarget.<br>cleanupPolicy | **string**
transfers[].<br>source.<br>settings.<br>mongoTarget | **object** <br>`transfers[].source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection | **object**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions | **object**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>user | **string**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password | **object**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>authSource | **string**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`transfers[].source.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`transfers[].source.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].source.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>subnetId | **string**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>database | **string**
transfers[].<br>source.<br>settings.<br>mongoTarget.<br>cleanupPolicy | **string**
transfers[].<br>target | **object**
transfers[].<br>target.<br>id | **string**
transfers[].<br>target.<br>folderId | **string**
transfers[].<br>target.<br>name | **string**
transfers[].<br>target.<br>description | **string**
transfers[].<br>target.<br>labels | **object**
transfers[].<br>target.<br>settings | **object**
transfers[].<br>target.<br>settings.<br>mysqlSource | **object** <br>`transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`transfers[].target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`transfers[].target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>serviceDatabase | **string**<br><p>Database for service tables</p> <p>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> 
transfers[].<br>target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource | **object** <br>`transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`transfers[].target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`transfers[].target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum WAL size for the replication slot</p> <p>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service tables</p> <p>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder).</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br><p>Sequences</p> <p>CREATE SEQUENCE ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br><p>Owned sequences</p> <p>CREATE SEQUENCE ... OWNED BY ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br><p>Tables</p> <p>CREATE TABLE ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br><p>Primary keys</p> <p>ALTER TABLE ... ADD PRIMARY KEY ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br><p>Foreign keys</p> <p>ALTER TABLE ... ADD FOREIGN KEY ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br><p>Default values</p> <p>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br><p>Constraints</p> <p>ALTER TABLE ... ADD CONSTRAINT ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br><p>Indexes</p> <p>CREATE INDEX ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br><p>Functions</p> <p>CREATE FUNCTION ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br><p>Types</p> <p>CREATE TYPE ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br><p>Rules</p> <p>CREATE RULE ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br><p>Collations</p> <p>CREATE COLLATION ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br><p>Policies</p> <p>CREATE POLICY ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br><p>Casts</p> <p>CREATE CAST ...</p> 
transfers[].<br>target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>materializedView | **string**<br><p>Materialized views</p> <p>CREATE MATERIALIZED VIEW ...</p> 
transfers[].<br>target.<br>settings.<br>mongoSource | **object** <br>`transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection | **object**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions | **object**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>user | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password | **object**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>authSource | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`transfers[].target.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`transfers[].target.settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].target.settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>target.<br>settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>subnetId | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>target.<br>settings.<br>mongoSource.<br>collections[] | **object**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>collections[].<br>databaseName | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>collections[].<br>collectionName | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>excludedCollections[] | **object**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>databaseName | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>excludedCollections[].<br>collectionName | **string**
transfers[].<br>target.<br>settings.<br>mongoSource.<br>secondaryPreferredMode | **boolean** (boolean)
transfers[].<br>target.<br>settings.<br>clickhouseSource | **object** <br>`transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection | **object**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions | **object**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>database | **string**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>user | **string**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password | **object**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`transfers[].target.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`transfers[].target.settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].target.settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>subnetId | **string**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>securityGroups[] | **string**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>includeTables[] | **string**
transfers[].<br>target.<br>settings.<br>clickhouseSource.<br>excludeTables[] | **string**
transfers[].<br>target.<br>settings.<br>mysqlTarget | **object** <br>`transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`transfers[].target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`transfers[].target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>sql_mode</p> <p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
transfers[].<br>target.<br>settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget | **object** <br>`transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`transfers[].target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`transfers[].target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>target.<br>settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget | **object** <br>`transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>database | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>user | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`transfers[].target.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`transfers[].target.settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].target.settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>subnetId | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>securityGroups[] | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>clickhouseClusterName | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>altNames[] | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>fromName | **string**<br><p>From table name</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>altNames[].<br>toName | **string**<br><p>To table name</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash | **object** <br>`transfers[].target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash.<br>columnName | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping | **object** <br>`transfers[].target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>columnName | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[] | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue | **object**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue.<br>stringValue | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>shardName | **string**
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId | **object** <br>`transfers[].target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>sharding.<br>transferId.<br>transferId | **object** <br>`transfers[].target.settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>clickhouseTarget.<br>cleanupPolicy | **string**
transfers[].<br>target.<br>settings.<br>mongoTarget | **object** <br>`transfers[].target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection | **object**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions | **object**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>user | **string**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password | **object**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>authSource | **string**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`transfers[].target.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`transfers[].target.settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`transfers[].target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`transfers[].target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`transfers[].target.settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>subnetId | **string**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>database | **string**
transfers[].<br>target.<br>settings.<br>mongoTarget.<br>cleanupPolicy | **string**
transfers[].<br>status | **string**
transfers[].<br>type | **string**<br><ul> <li>SNAPSHOT_AND_INCREMENT: Snapshot and increment</li> <li>SNAPSHOT_ONLY: Snapshot</li> <li>INCREMENT_ONLY: Increment</li> </ul> 
transfers[].<br>warning | **string**
nextPageToken | **string**<br><p>Opaque value identifying the next transfers page. This field is empty if there are no more transfers in the folder. Otherwise it is non-empty and should be included in the subsequent ListTransfersRequest to fetch the next transfers page.</p> 