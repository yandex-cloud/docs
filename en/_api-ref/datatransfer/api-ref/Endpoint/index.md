---
editable: false
---

# Endpoint

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "settings": {

    // `settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`
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
      "database": "string",
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
        "cast": "string"
      }
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
      "database": "string",
      "user": "string",
      "password": {
        "raw": "string"
      },
      "cleanupPolicy": "string"
    },
    // end of the list of possible fields`settings`

  }
}
```
 
Field | Description
--- | ---
id | **string**<br>
folderId | **string**<br>
name | **string**<br>
description | **string**<br>
labels | **object**<br>
settings | **object**<br>
settings.<br>mysqlSource | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
settings.<br>mysqlSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Yandex.Cloud Managed MySQL cluster ID</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise | **object** <br>`settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
settings.<br>mysqlSource.<br>database | **string**<br><p>Database name</p> <p>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source.</p> 
settings.<br>mysqlSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
settings.<br>mysqlSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
settings.<br>mysqlSource.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>mysqlSource.<br>includeTablesRegex[] | **string**<br>
settings.<br>mysqlSource.<br>excludeTablesRegex[] | **string**<br>
settings.<br>mysqlSource.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br><p>Schema migration</p> <p>Select database objects to be transferred during activation or deactivation.</p> 
settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br><p>Views</p> <p>CREATE VIEW ...</p> 
settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br><p>Routines</p> <p>CREATE PROCEDURE ... ; CREATE FUNCTION ... ;</p> 
settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br><p>Triggers</p> <p>CREATE TRIGGER ...</p> 
settings.<br>postgresSource | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
settings.<br>postgresSource.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Yandex.Cloud Managed PostgreSQL cluster ID</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise | **object** <br>`settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
settings.<br>postgresSource.<br>database | **string**<br><p>Database name</p> 
settings.<br>postgresSource.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
settings.<br>postgresSource.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
settings.<br>postgresSource.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>postgresSource.<br>includeTables[] | **string**<br><p>Included tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
settings.<br>postgresSource.<br>excludeTables[] | **string**<br><p>Excluded tables</p> <p>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns.</p> 
settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br><p>Maximum WAL size for the replication slot</p> <p>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default.</p> 
settings.<br>postgresSource.<br>serviceSchema | **string**<br><p>Database schema for service table</p> <p>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder).</p> 
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
settings.<br>mysqlTarget | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
settings.<br>mysqlTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Yandex.Cloud Managed MySQL cluster ID</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise MySQL <br>`settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Default: 3306.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
settings.<br>mysqlTarget.<br>database | **string**<br><p>Database name</p> <p>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table.</p> 
settings.<br>mysqlTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
settings.<br>mysqlTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>mysqlTarget.<br>sqlMode | **string**<br><p>sql_mode</p> <p>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION.</p> 
settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br><p>Disable constraints checks</p> <p>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0.</p> 
settings.<br>mysqlTarget.<br>timezone | **string**<br><p>Database timezone</p> <p>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone.</p> 
settings.<br>mysqlTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 
settings.<br>mysqlTarget.<br>serviceDatabase | **string**<br><p>Database schema for service table</p> <p>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper).</p> 
settings.<br>postgresTarget | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
settings.<br>postgresTarget.<br>connection | **object**<br><p>Connection settings</p> <p>Database connection settings</p> 
settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br><p>Managed cluster</p> <p>Yandex.Cloud Managed PostgreSQL cluster ID</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise | **object**<br>On-premise  Connection options for on-premise PostgreSQL <br>`settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br><p>Database port</p> <p>Will be used if the cluster ID is not specified. Default: 6432.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br><p>TLS mode</p> <p>TLS settings for server connection. Disabled by default.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br><p>CA certificate</p> <p>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br><p>Network interface for endpoint</p> <p>Default: public IPv4.</p> 
settings.<br>postgresTarget.<br>database | **string**<br><p>Database name</p> 
settings.<br>postgresTarget.<br>user | **string**<br><p>Username</p> <p>User for database access.</p> 
settings.<br>postgresTarget.<br>password | **object**<br><p>Password</p> <p>Password for database access.</p> 
settings.<br>postgresTarget.<br>password.<br>raw | **string**<br><p>Password</p> 
settings.<br>postgresTarget.<br>cleanupPolicy | **string**<br><p>Cleanup policy</p> <p>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | 
[delete](delete.md) | 
[get](get.md) | 
[list](list.md) | 
[update](update.md) | 