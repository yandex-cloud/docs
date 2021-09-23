---
editable: false
---

# Method create

 

 
## HTTP request {#https-request}
```
POST https://datatransfer.api.cloud.yandex.net/v1/endpoint
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
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
      "serviceSchema": "string"
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
      }
    },
    // end of the list of possible fields`settings`

  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br>
name | **string**<br>
description | **string**<br>
settings | **object**<br>
settings.<br>mysqlSource | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
settings.<br>mysqlSource.<br>connection | **object**<br>
settings.<br>mysqlSource.<br>connection.<br>mdbClusterId | **string** <br>`settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>mysqlSource.<br>connection.<br>onPremise | **object** <br>`settings.mysqlSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.mysqlSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
settings.<br>mysqlSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
settings.<br>mysqlSource.<br>database | **string**<br>
settings.<br>mysqlSource.<br>user | **string**<br>
settings.<br>mysqlSource.<br>password | **object**<br>
settings.<br>mysqlSource.<br>password.<br>raw | **string**<br>
settings.<br>mysqlSource.<br>includeTables[] | **string**<br>
settings.<br>mysqlSource.<br>excludeTables[] | **string**<br>
settings.<br>mysqlSource.<br>timezone | **string**<br>
settings.<br>mysqlSource.<br>objectTransferSettings | **object**<br>
settings.<br>mysqlSource.<br>objectTransferSettings.<br>view | **string**<br>
settings.<br>mysqlSource.<br>objectTransferSettings.<br>routine | **string**<br>
settings.<br>mysqlSource.<br>objectTransferSettings.<br>trigger | **string**<br>
settings.<br>postgresSource | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
settings.<br>postgresSource.<br>connection | **object**<br>
settings.<br>postgresSource.<br>connection.<br>mdbClusterId | **string** <br>`settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>postgresSource.<br>connection.<br>onPremise | **object** <br>`settings.postgresSource.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.postgresSource.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
settings.<br>postgresSource.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
settings.<br>postgresSource.<br>database | **string**<br>
settings.<br>postgresSource.<br>user | **string**<br>
settings.<br>postgresSource.<br>password | **object**<br>
settings.<br>postgresSource.<br>password.<br>raw | **string**<br>
settings.<br>postgresSource.<br>includeTables[] | **string**<br>
settings.<br>postgresSource.<br>excludeTables[] | **string**<br>
settings.<br>postgresSource.<br>slotByteLagLimit | **string** (int64)<br>
settings.<br>postgresSource.<br>serviceSchema | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings | **object**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>sequence | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>sequenceOwnedBy | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>table | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>primaryKey | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>fkConstraint | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>defaultValues | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>constraint | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>index | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>view | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>function | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>trigger | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>type | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>rule | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>collation | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>policy | **string**<br>
settings.<br>postgresSource.<br>objectTransferSettings.<br>cast | **string**<br>
settings.<br>mysqlTarget | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
settings.<br>mysqlTarget.<br>connection | **object**<br>
settings.<br>mysqlTarget.<br>connection.<br>mdbClusterId | **string** <br>`settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise | **object** <br>`settings.mysqlTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.mysqlTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
settings.<br>mysqlTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
settings.<br>mysqlTarget.<br>database | **string**<br>
settings.<br>mysqlTarget.<br>user | **string**<br>
settings.<br>mysqlTarget.<br>password | **object**<br>
settings.<br>mysqlTarget.<br>password.<br>raw | **string**<br>
settings.<br>mysqlTarget.<br>sqlMode | **string**<br>
settings.<br>mysqlTarget.<br>skipConstraintChecks | **boolean** (boolean)<br>
settings.<br>mysqlTarget.<br>timezone | **string**<br>
settings.<br>mysqlTarget.<br>serviceSchema | **string**<br>
settings.<br>postgresTarget | **object** <br>`settings` includes only one of the fields `mysqlSource`, `postgresSource`, `mysqlTarget`, `postgresTarget`<br><br>
settings.<br>postgresTarget.<br>connection | **object**<br>
settings.<br>postgresTarget.<br>connection.<br>mdbClusterId | **string** <br>`settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>postgresTarget.<br>connection.<br>onPremise | **object** <br>`settings.postgresTarget.connection` includes only one of the fields `mdbClusterId`, `onPremise`<br><br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>hosts[] | **string**<br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>port | **string** (int64)<br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode | **object**<br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>disabled.<br>disabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br><p>Empty JSON object ``{}``.</p> 
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled | **object** <br>`settings.postgresTarget.connection.onPremise.tlsMode` includes only one of the fields `disabled`, `enabled`<br><br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>tlsMode.<br>enabled.<br>caCertificate | **string**<br>
settings.<br>postgresTarget.<br>connection.<br>onPremise.<br>subnetId | **string**<br>
settings.<br>postgresTarget.<br>database | **string**<br>
settings.<br>postgresTarget.<br>user | **string**<br>
settings.<br>postgresTarget.<br>password | **object**<br>
settings.<br>postgresTarget.<br>password.<br>raw | **string**<br>
 
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
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 