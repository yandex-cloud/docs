---
editable: false
---

# Transfer

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "source": {
    "id": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "settings": {

      // `source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`
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
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
        },
        "sqlMode": "string",
        "skipConstraintChecks": true,
        "timezone": "string",
        "serviceSchema": "string"
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
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
        }
      },
      // end of the list of possible fields`source.settings`

    }
  },
  "target": {
    "id": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "settings": {

      // `target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`
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
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
        },
        "sqlMode": "string",
        "skipConstraintChecks": true,
        "timezone": "string",
        "serviceSchema": "string"
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
        "database": "string",
        "user": "string",
        "password": {
          "raw": "string"
        }
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
id | **string**<br>
folderId | **string**<br>
name | **string**<br>
description | **string**<br>
source | **object**<br>
source.<br>id | **string**<br>
source.<br>folderId | **string**<br>
source.<br>name | **string**<br>
source.<br>description | **string**<br>
source.<br>settings | **object**<br>
source.<br>settings.<br>mysqlSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
source.<br>settings.<br>mysqlSource.<br>connection | **object**<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object** <br>`source.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
source.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
source.<br>settings.<br>mysqlSource.<br>database | **string**<br>
source.<br>settings.<br>mysqlSource.<br>user | **string**<br>
source.<br>settings.<br>mysqlSource.<br>password | **object**<br>
source.<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br>
source.<br>settings.<br>mysqlSource.<br>includeTables[] | **string**<br>
source.<br>settings.<br>mysqlSource.<br>excludeTables[] | **string**<br>
source.<br>settings.<br>mysqlSource.<br>timezone | **string**<br>
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br>
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br>
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br>
source.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br>
source.<br>settings.<br>postgresSource | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
source.<br>settings.<br>postgresSource.<br>connection | **object**<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object** <br>`source.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
source.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
source.<br>settings.<br>postgresSource.<br>database | **string**<br>
source.<br>settings.<br>postgresSource.<br>user | **string**<br>
source.<br>settings.<br>postgresSource.<br>password | **object**<br>
source.<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br>
source.<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br>
source.<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br>
source.<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br>
source.<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br>
source.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br>
source.<br>settings.<br>mysqlTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
source.<br>settings.<br>mysqlTarget.<br>connection | **object**<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object** <br>`source.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
source.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
source.<br>settings.<br>mysqlTarget.<br>database | **string**<br>
source.<br>settings.<br>mysqlTarget.<br>user | **string**<br>
source.<br>settings.<br>mysqlTarget.<br>password | **object**<br>
source.<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br>
source.<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br>
source.<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br>
source.<br>settings.<br>mysqlTarget.<br>timezone | **string**<br>
source.<br>settings.<br>mysqlTarget.<br>serviceSchema | **string**<br>
source.<br>settings.<br>postgresTarget | **object** <br>`source.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
source.<br>settings.<br>postgresTarget.<br>connection | **object**<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object** <br>`source.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`source.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
source.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
source.<br>settings.<br>postgresTarget.<br>database | **string**<br>
source.<br>settings.<br>postgresTarget.<br>user | **string**<br>
source.<br>settings.<br>postgresTarget.<br>password | **object**<br>
source.<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br>
target | **object**<br>
target.<br>id | **string**<br>
target.<br>folderId | **string**<br>
target.<br>name | **string**<br>
target.<br>description | **string**<br>
target.<br>settings | **object**<br>
target.<br>settings.<br>mysqlSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
target.<br>settings.<br>mysqlSource.<br>connection | **object**<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise | **object** <br>`target.settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
target.<br>settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
target.<br>settings.<br>mysqlSource.<br>database | **string**<br>
target.<br>settings.<br>mysqlSource.<br>user | **string**<br>
target.<br>settings.<br>mysqlSource.<br>password | **object**<br>
target.<br>settings.<br>mysqlSource.<br>password.<br>raw | **string**<br>
target.<br>settings.<br>mysqlSource.<br>includeTables[] | **string**<br>
target.<br>settings.<br>mysqlSource.<br>excludeTables[] | **string**<br>
target.<br>settings.<br>mysqlSource.<br>timezone | **string**<br>
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br>
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br>
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br>
target.<br>settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br>
target.<br>settings.<br>postgresSource | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
target.<br>settings.<br>postgresSource.<br>connection | **object**<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise | **object** <br>`target.settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
target.<br>settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
target.<br>settings.<br>postgresSource.<br>database | **string**<br>
target.<br>settings.<br>postgresSource.<br>user | **string**<br>
target.<br>settings.<br>postgresSource.<br>password | **object**<br>
target.<br>settings.<br>postgresSource.<br>password.<br>raw | **string**<br>
target.<br>settings.<br>postgresSource.<br>includeTables[] | **string**<br>
target.<br>settings.<br>postgresSource.<br>excludeTables[] | **string**<br>
target.<br>settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br>
target.<br>settings.<br>postgresSource.<br>serviceSchema | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings | **object**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br>
target.<br>settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br>
target.<br>settings.<br>mysqlTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
target.<br>settings.<br>mysqlTarget.<br>connection | **object**<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object** <br>`target.settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
target.<br>settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
target.<br>settings.<br>mysqlTarget.<br>database | **string**<br>
target.<br>settings.<br>mysqlTarget.<br>user | **string**<br>
target.<br>settings.<br>mysqlTarget.<br>password | **object**<br>
target.<br>settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br>
target.<br>settings.<br>mysqlTarget.<br>sqlMode | **string**<br>
target.<br>settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br>
target.<br>settings.<br>mysqlTarget.<br>timezone | **string**<br>
target.<br>settings.<br>mysqlTarget.<br>serviceSchema | **string**<br>
target.<br>settings.<br>postgresTarget | **object** <br>`target.settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
target.<br>settings.<br>postgresTarget.<br>connection | **object**<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise | **object** <br>`target.settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`target.settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
target.<br>settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
target.<br>settings.<br>postgresTarget.<br>database | **string**<br>
target.<br>settings.<br>postgresTarget.<br>user | **string**<br>
target.<br>settings.<br>postgresTarget.<br>password | **object**<br>
target.<br>settings.<br>postgresTarget.<br>password.<br>raw | **string**<br>
status | **string**<br>
type | **string**<br>
warning | **string**<br>

## Methods {#methods}
Method | Description
--- | ---
[activate](activate.md) | 
[create](create.md) | 
[deactivate](deactivate.md) | 
[delete](delete.md) | 
[get](get.md) | 
[update](update.md) | 