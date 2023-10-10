---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/PXFDatasource/index.md
---

# Managed Service for Greenplum® API, REST: PXFDatasource methods

## JSON Representation {#representation}
```json 
{
  "name": "string",

  //  includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`
  "s3": {
    "accessKey": "string",
    "secretKey": "string",
    "fastUpload": true,
    "endpoint": "string"
  },
  "jdbc": {
    "driver": "string",
    "url": "string",
    "user": "string",
    "password": "string",
    "statementBatchSize": "integer",
    "statementFetchSize": "integer",
    "statementQueryTimeout": "integer",
    "poolEnabled": true,
    "poolMaximumSize": "integer",
    "poolConnectionTimeout": "integer",
    "poolIdleTimeout": "integer",
    "poolMinimumIdle": "integer"
  },
  "hdfs": {
    "core": {
      "defaultFs": "string",
      "securityAuthToLocal": "string"
    },
    "kerberos": {
      "enable": true,
      "primary": "string",
      "realm": "string",
      "kdcServers": [
        "string"
      ],
      "adminServer": "string",
      "defaultDomain": "string",
      "keytabBase64": "string"
    },
    "userImpersonation": true,
    "username": "string",
    "saslConnectionRetries": "integer",
    "zkHosts": [
      "string"
    ],
    "dfs": {
      "haAutomaticFailoverEnabled": true,
      "blockAccessTokenEnabled": true,
      "useDatanodeHostname": true,
      "namenodes": "object"
    },
    "yarn": {
      "resourcemanagerHaEnabled": true,
      "resourcemanagerHaAutoFailoverEnabled": true,
      "resourcemanagerHaAutoFailoverEmbedded": true,
      "resourcemanagerClusterId": "string",
      "haRm": "object"
    }
  },
  "hive": {
    "core": {
      "defaultFs": "string",
      "securityAuthToLocal": "string"
    },
    "kerberos": {
      "enable": true,
      "primary": "string",
      "realm": "string",
      "kdcServers": [
        "string"
      ],
      "adminServer": "string",
      "defaultDomain": "string",
      "keytabBase64": "string"
    },
    "userImpersonation": true,
    "username": "string",
    "saslConnectionRetries": "integer",
    "zkHosts": [
      "string"
    ],
    "ppd": true,
    "metastoreUris": [
      "string"
    ],
    "metastoreKerberosPrincipal": "string",
    "authKerberosPrincipal": "string"
  },
  // end of the list of possible fields

}
```
 
Field | Description
--- | ---
name | **string**<br><p>Required. The string length in characters must be 3-200.</p> 
s3 | **object** <br> includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
s3.<br>accessKey | **string**<br><p>The maximum string length in characters is 200.</p> 
s3.<br>secretKey | **string**<br><p>The maximum string length in characters is 200.</p> 
s3.<br>fastUpload | **boolean** (boolean)
s3.<br>endpoint | **string**<br><p>The maximum string length in characters is 200.</p> 
jdbc | **object** <br> includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
jdbc.<br>driver | **string**<br><p>Matches jdbc.driver</p> <p>The maximum string length in characters is 50.</p> 
jdbc.<br>url | **string**<br><p>Matches jdbc.url</p> <p>The maximum string length in characters is 200.</p> 
jdbc.<br>user | **string**<br><p>Matches jdbc.user</p> <p>The maximum string length in characters is 200.</p> 
jdbc.<br>password | **string**<br><p>Matches jdbc.password</p> <p>The maximum string length in characters is 200.</p> 
jdbc.<br>statementBatchSize | **integer** (int64)<br><p>Matches jdbc.statement.batchsize</p> <p>Acceptable values are 50 to 1000, inclusive.</p> 
jdbc.<br>statementFetchSize | **integer** (int64)<br><p>Matches jdbc.statement.fetchsize</p> <p>Acceptable values are 50 to 10000, inclusive.</p> 
jdbc.<br>statementQueryTimeout | **integer** (int64)<br><p>Matches jdbc.statement.querytimeout</p> <p>Acceptable values are 5 to 600, inclusive.</p> 
jdbc.<br>poolEnabled | **boolean** (boolean)<br><p>Matches jdbc.pool.enabled</p> 
jdbc.<br>poolMaximumSize | **integer** (int64)<br><p>Matches jdbc.pool.property.maximumpoolsize</p> <p>Acceptable values are 10 to 200, inclusive.</p> 
jdbc.<br>poolConnectionTimeout | **integer** (int64)<br><p>Matches jdbc.pool.property.connectiontimeout</p> <p>Acceptable values are 5000 to 600000, inclusive.</p> 
jdbc.<br>poolIdleTimeout | **integer** (int64)<br><p>Matches jdbc.pool.property.idletimeout</p> <p>Acceptable values are 5000 to 600000, inclusive.</p> 
jdbc.<br>poolMinimumIdle | **integer** (int64)<br><p>Matches jdbc.pool.property.minimumidle</p> <p>Acceptable values are 0 to 200, inclusive.</p> 
hdfs | **object** <br> includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
hdfs.<br>core | **object**
hdfs.<br>core.<br>defaultFs | **string**<br><p>The maximum string length in characters is 200.</p> 
hdfs.<br>core.<br>securityAuthToLocal | **string**<br><p>The maximum string length in characters is 1000.</p> 
hdfs.<br>kerberos | **object**
hdfs.<br>kerberos.<br>enable | **boolean** (boolean)
hdfs.<br>kerberos.<br>primary | **string**<br><p>The maximum string length in characters is 128.</p> 
hdfs.<br>kerberos.<br>realm | **string**<br><p>The maximum string length in characters is 1000.</p> 
hdfs.<br>kerberos.<br>kdcServers[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
hdfs.<br>kerberos.<br>adminServer | **string**<br><p>The maximum string length in characters is 128.</p> 
hdfs.<br>kerberos.<br>defaultDomain | **string**<br><p>The maximum string length in characters is 128.</p> 
hdfs.<br>kerberos.<br>keytabBase64 | **string**<br><p>The maximum string length in characters is 65536. Value must match the regular expression ``^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$``.</p> 
hdfs.<br>userImpersonation | **boolean** (boolean)
hdfs.<br>username | **string**<br><p>The maximum string length in characters is 128.</p> 
hdfs.<br>saslConnectionRetries | **integer** (int64)<br><p>Acceptable values are 1 to 50, inclusive.</p> 
hdfs.<br>zkHosts[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
hdfs.<br>dfs | **object**
hdfs.<br>dfs.<br>haAutomaticFailoverEnabled | **boolean** (boolean)
hdfs.<br>dfs.<br>blockAccessTokenEnabled | **boolean** (boolean)
hdfs.<br>dfs.<br>useDatanodeHostname | **boolean** (boolean)
hdfs.<br>dfs.<br>namenodes | **object**<br><p>No more than 10000 per resource.</p> 
hdfs.<br>yarn | **object**
hdfs.<br>yarn.<br>resourcemanagerHaEnabled | **boolean** (boolean)
hdfs.<br>yarn.<br>resourcemanagerHaAutoFailoverEnabled | **boolean** (boolean)
hdfs.<br>yarn.<br>resourcemanagerHaAutoFailoverEmbedded | **boolean** (boolean)
hdfs.<br>yarn.<br>resourcemanagerClusterId | **string**<br><p>The maximum string length in characters is 1000.</p> 
hdfs.<br>yarn.<br>haRm | **object**<br><p>No more than 10000 per resource.</p> 
hive | **object** <br> includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
hive.<br>core | **object**
hive.<br>core.<br>defaultFs | **string**<br><p>The maximum string length in characters is 200.</p> 
hive.<br>core.<br>securityAuthToLocal | **string**<br><p>The maximum string length in characters is 1000.</p> 
hive.<br>kerberos | **object**
hive.<br>kerberos.<br>enable | **boolean** (boolean)
hive.<br>kerberos.<br>primary | **string**<br><p>The maximum string length in characters is 128.</p> 
hive.<br>kerberos.<br>realm | **string**<br><p>The maximum string length in characters is 1000.</p> 
hive.<br>kerberos.<br>kdcServers[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
hive.<br>kerberos.<br>adminServer | **string**<br><p>The maximum string length in characters is 128.</p> 
hive.<br>kerberos.<br>defaultDomain | **string**<br><p>The maximum string length in characters is 128.</p> 
hive.<br>kerberos.<br>keytabBase64 | **string**<br><p>The maximum string length in characters is 65536. Value must match the regular expression ``^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$``.</p> 
hive.<br>userImpersonation | **boolean** (boolean)
hive.<br>username | **string**<br><p>The maximum string length in characters is 128.</p> 
hive.<br>saslConnectionRetries | **integer** (int64)<br><p>Acceptable values are 1 to 50, inclusive.</p> 
hive.<br>zkHosts[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
hive.<br>ppd | **boolean** (boolean)
hive.<br>metastoreUris[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
hive.<br>metastoreKerberosPrincipal | **string**<br><p>The maximum string length in characters is 1000.</p> 
hive.<br>authKerberosPrincipal | **string**<br><p>The maximum string length in characters is 1000.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates PXF datasource
[delete](delete.md) | Delete PXF datasource
[list](list.md) | List all PXF datasources
[update](update.md) | Update PXF datasource