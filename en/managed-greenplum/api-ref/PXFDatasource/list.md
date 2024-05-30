---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/PXFDatasource/list.md
---

# Managed Service for Greenplum® API, REST: PXFDatasource.list
List all PXF datasources
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/pxf_datasources
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "datasources": [
    {
      "name": "string",

      // `datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`
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
          "namenodes": "object",
          "nameservices": "string"
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
      // end of the list of possible fields`datasources[]`

    }
  ]
}
```

 
Field | Description
--- | ---
datasources[] | **object**
datasources[].<br>name | **string**<br><p>Required. The string length in characters must be 3-200. Value must match the regular expression ``^[^\\|/*?.,;"'<>]+$``.</p> 
datasources[].<br>s3 | **object** <br>`datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasources[].<br>s3.<br>accessKey | **string**<br><p>The maximum string length in characters is 200.</p> 
datasources[].<br>s3.<br>secretKey | **string**<br><p>The maximum string length in characters is 200.</p> 
datasources[].<br>s3.<br>fastUpload | **boolean** (boolean)
datasources[].<br>s3.<br>endpoint | **string**<br><p>The maximum string length in characters is 200. Value must match the regular expression ``(((s3\|https?)://)?([a-z0-9]([a-z0-9-]*[a-z0-9])?[.])+[a-z]{2,})?``.</p> 
datasources[].<br>jdbc | **object** <br>`datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasources[].<br>jdbc.<br>driver | **string**<br><p>Matches jdbc.driver</p> <p>The maximum string length in characters is 50.</p> 
datasources[].<br>jdbc.<br>url | **string**<br><p>Matches jdbc.url</p> <p>The maximum string length in characters is 1000.</p> 
datasources[].<br>jdbc.<br>user | **string**<br><p>Matches jdbc.user</p> <p>The maximum string length in characters is 200.</p> 
datasources[].<br>jdbc.<br>password | **string**<br><p>Matches jdbc.password</p> <p>The maximum string length in characters is 200.</p> 
datasources[].<br>jdbc.<br>statementBatchSize | **integer** (int64)<br><p>Matches jdbc.statement.batchsize</p> <p>Acceptable values are 50 to 1000, inclusive.</p> 
datasources[].<br>jdbc.<br>statementFetchSize | **integer** (int64)<br><p>Matches jdbc.statement.fetchsize</p> <p>Acceptable values are 50 to 10000, inclusive.</p> 
datasources[].<br>jdbc.<br>statementQueryTimeout | **integer** (int64)<br><p>Matches jdbc.statement.querytimeout</p> <p>Acceptable values are 5 to 43200, inclusive.</p> 
datasources[].<br>jdbc.<br>poolEnabled | **boolean** (boolean)<br><p>Matches jdbc.pool.enabled</p> 
datasources[].<br>jdbc.<br>poolMaximumSize | **integer** (int64)<br><p>Matches jdbc.pool.property.maximumpoolsize</p> <p>Acceptable values are 1 to 200, inclusive.</p> 
datasources[].<br>jdbc.<br>poolConnectionTimeout | **integer** (int64)<br><p>Matches jdbc.pool.property.connectiontimeout</p> <p>Acceptable values are 5000 to 600000, inclusive.</p> 
datasources[].<br>jdbc.<br>poolIdleTimeout | **integer** (int64)<br><p>Matches jdbc.pool.property.idletimeout</p> <p>Acceptable values are 5000 to 600000, inclusive.</p> 
datasources[].<br>jdbc.<br>poolMinimumIdle | **integer** (int64)<br><p>Matches jdbc.pool.property.minimumidle</p> <p>Acceptable values are 0 to 200, inclusive.</p> 
datasources[].<br>hdfs | **object** <br>`datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasources[].<br>hdfs.<br>core | **object**
datasources[].<br>hdfs.<br>core.<br>defaultFs | **string**<br><p>The maximum string length in characters is 200.</p> 
datasources[].<br>hdfs.<br>core.<br>securityAuthToLocal | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hdfs.<br>kerberos | **object**
datasources[].<br>hdfs.<br>kerberos.<br>enable | **boolean** (boolean)
datasources[].<br>hdfs.<br>kerberos.<br>primary | **string**<br><p>The maximum string length in characters is 128.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>realm | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>kdcServers[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>adminServer | **string**<br><p>The maximum string length in characters is 128.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>defaultDomain | **string**<br><p>The maximum string length in characters is 128.</p> 
datasources[].<br>hdfs.<br>kerberos.<br>keytabBase64 | **string**<br><p>The maximum string length in characters is 65536. Value must match the regular expression ``^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$``.</p> 
datasources[].<br>hdfs.<br>userImpersonation | **boolean** (boolean)
datasources[].<br>hdfs.<br>username | **string**<br><p>The maximum string length in characters is 128.</p> 
datasources[].<br>hdfs.<br>saslConnectionRetries | **integer** (int64)<br><p>Acceptable values are 1 to 50, inclusive.</p> 
datasources[].<br>hdfs.<br>zkHosts[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hdfs.<br>dfs | **object**
datasources[].<br>hdfs.<br>dfs.<br>haAutomaticFailoverEnabled | **boolean** (boolean)
datasources[].<br>hdfs.<br>dfs.<br>blockAccessTokenEnabled | **boolean** (boolean)
datasources[].<br>hdfs.<br>dfs.<br>useDatanodeHostname | **boolean** (boolean)
datasources[].<br>hdfs.<br>dfs.<br>namenodes | **object**<br><p>No more than 10000 per resource.</p> 
datasources[].<br>hdfs.<br>dfs.<br>nameservices | **string**<br><p>Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource</p> 
datasources[].<br>hdfs.<br>yarn | **object**
datasources[].<br>hdfs.<br>yarn.<br>resourcemanagerHaEnabled | **boolean** (boolean)
datasources[].<br>hdfs.<br>yarn.<br>resourcemanagerHaAutoFailoverEnabled | **boolean** (boolean)
datasources[].<br>hdfs.<br>yarn.<br>resourcemanagerHaAutoFailoverEmbedded | **boolean** (boolean)
datasources[].<br>hdfs.<br>yarn.<br>resourcemanagerClusterId | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hdfs.<br>yarn.<br>haRm | **object**<br><p>No more than 10000 per resource.</p> 
datasources[].<br>hive | **object** <br>`datasources[]` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasources[].<br>hive.<br>core | **object**
datasources[].<br>hive.<br>core.<br>defaultFs | **string**<br><p>The maximum string length in characters is 200.</p> 
datasources[].<br>hive.<br>core.<br>securityAuthToLocal | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hive.<br>kerberos | **object**
datasources[].<br>hive.<br>kerberos.<br>enable | **boolean** (boolean)
datasources[].<br>hive.<br>kerberos.<br>primary | **string**<br><p>The maximum string length in characters is 128.</p> 
datasources[].<br>hive.<br>kerberos.<br>realm | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hive.<br>kerberos.<br>kdcServers[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hive.<br>kerberos.<br>adminServer | **string**<br><p>The maximum string length in characters is 128.</p> 
datasources[].<br>hive.<br>kerberos.<br>defaultDomain | **string**<br><p>The maximum string length in characters is 128.</p> 
datasources[].<br>hive.<br>kerberos.<br>keytabBase64 | **string**<br><p>The maximum string length in characters is 65536. Value must match the regular expression ``^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$``.</p> 
datasources[].<br>hive.<br>userImpersonation | **boolean** (boolean)
datasources[].<br>hive.<br>username | **string**<br><p>The maximum string length in characters is 128.</p> 
datasources[].<br>hive.<br>saslConnectionRetries | **integer** (int64)<br><p>Acceptable values are 1 to 50, inclusive.</p> 
datasources[].<br>hive.<br>zkHosts[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hive.<br>ppd | **boolean** (boolean)
datasources[].<br>hive.<br>metastoreUris[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasources[].<br>hive.<br>metastoreKerberosPrincipal | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasources[].<br>hive.<br>authKerberosPrincipal | **string**<br><p>The maximum string length in characters is 1000.</p> 