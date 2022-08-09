---
editable: false
---

# Method update

 

 
## HTTP request {#https-request}
```
PATCH https://datatransfer.{{ api-host }}/v1/endpoint/{endpointId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
endpointId | <p>Identifier of the endpoint to be updated.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "name": "string",
  "description": "string",
  "labels": "object",
  "settings": {

    // `settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`
    "mysqlSource": {
      "connection": {

        // `settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
        "mdbClusterId": "string",
        "onPremise": {
          "hosts": [
            "string"
          ],
          "port": "string",
          "tlsMode": {

            // `settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
            "disabled": "object",
            "enabled": {
              "caCertificate": "string"
            },
            // end of the list of possible fields`settings.mysqlSource.connection.onPremise.tlsMode`

          },
          "subnetId": "string"
        },
        // end of the list of possible fields`settings.mysqlSource.connection`

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

        // `settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`
        "mdbClusterId": "string",
        "onPremise": {
          "hosts": [
            "string"
          ],
          "port": "string",
          "tlsMode": {

            // `settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
            "disabled": "object",
            "enabled": {
              "caCertificate": "string"
            },
            // end of the list of possible fields`settings.postgresSource.connection.onPremise.tlsMode`

          },
          "subnetId": "string"
        },
        // end of the list of possible fields`settings.postgresSource.connection`

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

          // `settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`settings.mongoSource.connection.connectionOptions.onPremise.tlsMode`

            },
            "replicaSet": "string"
          },
          // end of the list of possible fields`settings.mongoSource.connection.connectionOptions`

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

          // `settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
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

              // `settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode`

            }
          },
          // end of the list of possible fields`settings.clickhouseSource.connection.connectionOptions`

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

        // `settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
        "mdbClusterId": "string",
        "onPremise": {
          "hosts": [
            "string"
          ],
          "port": "string",
          "tlsMode": {

            // `settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
            "disabled": "object",
            "enabled": {
              "caCertificate": "string"
            },
            // end of the list of possible fields`settings.mysqlTarget.connection.onPremise.tlsMode`

          },
          "subnetId": "string"
        },
        // end of the list of possible fields`settings.mysqlTarget.connection`

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

        // `settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`
        "mdbClusterId": "string",
        "onPremise": {
          "hosts": [
            "string"
          ],
          "port": "string",
          "tlsMode": {

            // `settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
            "disabled": "object",
            "enabled": {
              "caCertificate": "string"
            },
            // end of the list of possible fields`settings.postgresTarget.connection.onPremise.tlsMode`

          },
          "subnetId": "string"
        },
        // end of the list of possible fields`settings.postgresTarget.connection`

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

          // `settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
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

              // `settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode`

            }
          },
          // end of the list of possible fields`settings.clickhouseTarget.connection.connectionOptions`

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

        // `settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`
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
        // end of the list of possible fields`settings.clickhouseTarget.sharding`

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

          // `settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`
          "mdbClusterId": "string",
          "onPremise": {
            "hosts": [
              "string"
            ],
            "port": "string",
            "tlsMode": {

              // `settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`
              "disabled": "object",
              "enabled": {
                "caCertificate": "string"
              },
              // end of the list of possible fields`settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode`

            },
            "replicaSet": "string"
          },
          // end of the list of possible fields`settings.mongoTarget.connection.connectionOptions`

        }
      },
      "subnetId": "string",
      "securityGroups": [
        "string"
      ],
      "database": "string",
      "cleanupPolicy": "string"
    },
    // end of the list of possible fields`settings`

  },
  "updateMask": "string"
}
```

 
Field | Description
--- | ---
name | **string**<br><p>The new endpoint name. Must be unique within the folder.</p> 
description | **string**<br><p>The new description for the endpoint.</p> 
labels | **object**
settings | **object**<br><p>The new endpoint name. Must be unique within the folder.</p> 
settings.<br>mysqlSource | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
settings.<br>mysqlSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
settings.<br>mysqlSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
settings.<br>mysqlSource.<br>serviceDatabase | **string**<br><p>Database for service tables</p> <p>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
settings.<br>mysqlSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
settings.<br>mysqlSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**
settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**
settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> 
settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
settings.<br>postgresSource | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
settings.<br>postgresSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
settings.<br>postgresSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
settings.<br>postgresSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
settings.<br>postgresSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum WAL size for the replication slot</p> <p>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default.</p> 
settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service tables</p> <p>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder).</p> 
settings.<br>postgresSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br><p>Sequences</p> <p>CREATE SEQUENCE ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br><p>Owned sequences</p> <p>CREATE SEQUENCE ... OWNED BY ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br><p>Tables</p> <p>CREATE TABLE ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br><p>Primary keys</p> <p>ALTER TABLE ... ADD PRIMARY KEY ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br><p>Foreign keys</p> <p>ALTER TABLE ... ADD FOREIGN KEY ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br><p>Default values</p> <p>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br><p>Constraints</p> <p>ALTER TABLE ... ADD CONSTRAINT ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br><p>Indexes</p> <p>CREATE INDEX ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br><p>Functions</p> <p>CREATE FUNCTION ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br><p>Types</p> <p>CREATE TYPE ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br><p>Rules</p> <p>CREATE RULE ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br><p>Collations</p> <p>CREATE COLLATION ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br><p>Policies</p> <p>CREATE POLICY ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br><p>Casts</p> <p>CREATE CAST ...</p> 
settings.<br>postgresSource.<br>objectTransferSettings.<br>materializedView | **string**<br><p>Materialized views</p> <p>CREATE MATERIALIZED VIEW ...</p> 
settings.<br>mongoSource | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
settings.<br>mongoSource.<br>connection | **object**
settings.<br>mongoSource.<br>connection.<br>connectionOptions | **object**
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>user | **string**
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password | **object**
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>authSource | **string**
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`settings.mongoSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.mongoSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>mongoSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
settings.<br>mongoSource.<br>subnetId | **string**
settings.<br>mongoSource.<br>securityGroups[] | **string**<br><p>Security groups</p> 
settings.<br>mongoSource.<br>collections[] | **object**
settings.<br>mongoSource.<br>collections[].<br>databaseName | **string**
settings.<br>mongoSource.<br>collections[].<br>collectionName | **string**
settings.<br>mongoSource.<br>excludedCollections[] | **object**
settings.<br>mongoSource.<br>excludedCollections[].<br>databaseName | **string**
settings.<br>mongoSource.<br>excludedCollections[].<br>collectionName | **string**
settings.<br>mongoSource.<br>secondaryPreferredMode | **boolean** (boolean)
settings.<br>clickhouseSource | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
settings.<br>clickhouseSource.<br>connection | **object**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions | **object**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>database | **string**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>user | **string**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password | **object**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`settings.clickhouseSource.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.clickhouseSource.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
settings.<br>clickhouseSource.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>clickhouseSource.<br>subnetId | **string**
settings.<br>clickhouseSource.<br>securityGroups[] | **string**
settings.<br>clickhouseSource.<br>includeTables[] | **string**
settings.<br>clickhouseSource.<br>excludeTables[] | **string**
settings.<br>mysqlTarget | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
settings.<br>mysqlTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for MySQL cluster ID</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
settings.<br>mysqlTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
settings.<br>mysqlTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
settings.<br>mysqlTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>sql_mode</p> <p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
settings.<br>postgresTarget | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
settings.<br>postgresTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Managed Service for PostgreSQL cluster ID</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
settings.<br>postgresTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
settings.<br>postgresTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
settings.<br>postgresTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
settings.<br>clickhouseTarget | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
settings.<br>clickhouseTarget.<br>connection | **object**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions | **object**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>database | **string**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>user | **string**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password | **object**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`settings.clickhouseTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[] | **object**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>name | **string**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>shards[].<br>hosts[] | **string**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>httpPort | **string** (int64)
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>nativePort | **string** (int64)
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.clickhouseTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
settings.<br>clickhouseTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>clickhouseTarget.<br>subnetId | **string**
settings.<br>clickhouseTarget.<br>securityGroups[] | **string**
settings.<br>clickhouseTarget.<br>clickhouseClusterName | **string**
settings.<br>clickhouseTarget.<br>altNames[] | **object**
settings.<br>clickhouseTarget.<br>altNames[].<br>fromName | **string**<br><p>From table name</p> 
settings.<br>clickhouseTarget.<br>altNames[].<br>toName | **string**<br><p>To table name</p> 
settings.<br>clickhouseTarget.<br>sharding | **object**
settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash | **object** <br>`settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
settings.<br>clickhouseTarget.<br>sharding.<br>columnValueHash.<br>columnName | **string**
settings.<br>clickhouseTarget.<br>sharding.<br>customMapping | **object** <br>`settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br>
settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>columnName | **string**
settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[] | **object**
settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue | **object**
settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>columnValue.<br>stringValue | **string**
settings.<br>clickhouseTarget.<br>sharding.<br>customMapping.<br>mapping[].<br>shardName | **string**
settings.<br>clickhouseTarget.<br>sharding.<br>transferId | **object** <br>`settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>clickhouseTarget.<br>sharding.<br>transferId.<br>transferId | **object** <br>`settings.clickhouseTarget.sharding` includes only one of the fields `columnValueHash`, `customMapping`, `transferId`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>clickhouseTarget.<br>cleanupPolicy | **string**
settings.<br>mongoTarget | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mongoSource`, `clickhouseSource`, `mysqlTarget`, `postgresTarget`, `clickhouseTarget`, `mongoTarget`<br>
settings.<br>mongoTarget.<br>connection | **object**
settings.<br>mongoTarget.<br>connection.<br>connectionOptions | **object**
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>user | **string**
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password | **object**
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>authSource | **string**
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>mdbClusterId | **string** <br>`settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise | **object** <br>`settings.mongoTarget.connection.connectionOptions` includes only one of the fields `mdbClusterId`, `onPremise`<br>
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>hosts[] | **string**
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>port | **string** (int64)
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode | **object**
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.mongoTarget.connection.connectionOptions.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br>
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>mongoTarget.<br>connection.<br>connectionOptions.<br>onPremise.<br>replicaSet | **string**
settings.<br>mongoTarget.<br>subnetId | **string**
settings.<br>mongoTarget.<br>securityGroups[] | **string**<br><p>Security groups</p> 
settings.<br>mongoTarget.<br>database | **string**
settings.<br>mongoTarget.<br>cleanupPolicy | **string**
updateMask | **string**<br><p>Field mask specifying endpoint fields to be updated. Semantics for this field is described here: https://pkg.go.dev/google.golang.org/protobuf/types/known/fieldmaskpb#FieldMask The only exception is that if the repeated field is specified in the mask, then the new value replaces the old one instead of being appended to the old one.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 