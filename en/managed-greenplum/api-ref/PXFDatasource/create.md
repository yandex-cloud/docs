---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/PXFDatasource/create.md
---

# Managed Service for Greenplum® API, REST: PXFDatasource.create
Creates PXF datasource
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/pxf_datasources
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "datasource": {
    "name": "string",

    // `datasource` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`
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
    // end of the list of possible fields`datasource`

  }
}
```

 
Field | Description
--- | ---
datasource | **object**
datasource.<br>name | **string**<br><p>Required. The string length in characters must be 3-200. Value must match the regular expression ``^[^\\|/*?.,;"'<>]+$``.</p> 
datasource.<br>s3 | **object** <br>`datasource` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasource.<br>s3.<br>accessKey | **string**<br><p>The maximum string length in characters is 200.</p> 
datasource.<br>s3.<br>secretKey | **string**<br><p>The maximum string length in characters is 200.</p> 
datasource.<br>s3.<br>fastUpload | **boolean** (boolean)
datasource.<br>s3.<br>endpoint | **string**<br><p>The maximum string length in characters is 200. Value must match the regular expression ``(((s3\|https?)://)?([a-z0-9]([a-z0-9-]*[a-z0-9])?[.])+[a-z]{2,})?``.</p> 
datasource.<br>jdbc | **object** <br>`datasource` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasource.<br>jdbc.<br>driver | **string**<br><p>Matches jdbc.driver</p> <p>The maximum string length in characters is 50.</p> 
datasource.<br>jdbc.<br>url | **string**<br><p>Matches jdbc.url</p> <p>The maximum string length in characters is 1000.</p> 
datasource.<br>jdbc.<br>user | **string**<br><p>Matches jdbc.user</p> <p>The maximum string length in characters is 200.</p> 
datasource.<br>jdbc.<br>password | **string**<br><p>Matches jdbc.password</p> <p>The maximum string length in characters is 200.</p> 
datasource.<br>jdbc.<br>statementBatchSize | **integer** (int64)<br><p>Matches jdbc.statement.batchsize</p> <p>Acceptable values are 50 to 1000, inclusive.</p> 
datasource.<br>jdbc.<br>statementFetchSize | **integer** (int64)<br><p>Matches jdbc.statement.fetchsize</p> <p>Acceptable values are 50 to 10000, inclusive.</p> 
datasource.<br>jdbc.<br>statementQueryTimeout | **integer** (int64)<br><p>Matches jdbc.statement.querytimeout</p> <p>Acceptable values are 5 to 43200, inclusive.</p> 
datasource.<br>jdbc.<br>poolEnabled | **boolean** (boolean)<br><p>Matches jdbc.pool.enabled</p> 
datasource.<br>jdbc.<br>poolMaximumSize | **integer** (int64)<br><p>Matches jdbc.pool.property.maximumpoolsize</p> <p>Acceptable values are 1 to 200, inclusive.</p> 
datasource.<br>jdbc.<br>poolConnectionTimeout | **integer** (int64)<br><p>Matches jdbc.pool.property.connectiontimeout</p> <p>Acceptable values are 5000 to 600000, inclusive.</p> 
datasource.<br>jdbc.<br>poolIdleTimeout | **integer** (int64)<br><p>Matches jdbc.pool.property.idletimeout</p> <p>Acceptable values are 5000 to 600000, inclusive.</p> 
datasource.<br>jdbc.<br>poolMinimumIdle | **integer** (int64)<br><p>Matches jdbc.pool.property.minimumidle</p> <p>Acceptable values are 0 to 200, inclusive.</p> 
datasource.<br>hdfs | **object** <br>`datasource` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasource.<br>hdfs.<br>core | **object**
datasource.<br>hdfs.<br>core.<br>defaultFs | **string**<br><p>The maximum string length in characters is 200.</p> 
datasource.<br>hdfs.<br>core.<br>securityAuthToLocal | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasource.<br>hdfs.<br>kerberos | **object**
datasource.<br>hdfs.<br>kerberos.<br>enable | **boolean** (boolean)
datasource.<br>hdfs.<br>kerberos.<br>primary | **string**<br><p>The maximum string length in characters is 128.</p> 
datasource.<br>hdfs.<br>kerberos.<br>realm | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasource.<br>hdfs.<br>kerberos.<br>kdcServers[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasource.<br>hdfs.<br>kerberos.<br>adminServer | **string**<br><p>The maximum string length in characters is 128.</p> 
datasource.<br>hdfs.<br>kerberos.<br>defaultDomain | **string**<br><p>The maximum string length in characters is 128.</p> 
datasource.<br>hdfs.<br>kerberos.<br>keytabBase64 | **string**<br><p>The maximum string length in characters is 65536. Value must match the regular expression ``^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$``.</p> 
datasource.<br>hdfs.<br>userImpersonation | **boolean** (boolean)
datasource.<br>hdfs.<br>username | **string**<br><p>The maximum string length in characters is 128.</p> 
datasource.<br>hdfs.<br>saslConnectionRetries | **integer** (int64)<br><p>Acceptable values are 1 to 50, inclusive.</p> 
datasource.<br>hdfs.<br>zkHosts[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasource.<br>hdfs.<br>dfs | **object**
datasource.<br>hdfs.<br>dfs.<br>haAutomaticFailoverEnabled | **boolean** (boolean)
datasource.<br>hdfs.<br>dfs.<br>blockAccessTokenEnabled | **boolean** (boolean)
datasource.<br>hdfs.<br>dfs.<br>useDatanodeHostname | **boolean** (boolean)
datasource.<br>hdfs.<br>dfs.<br>namenodes | **object**<br><p>No more than 10000 per resource.</p> 
datasource.<br>hdfs.<br>dfs.<br>nameservices | **string**<br><p>Corresponds well-known HDFS client setting "dfs.nameservices" for this datasource</p> 
datasource.<br>hdfs.<br>yarn | **object**
datasource.<br>hdfs.<br>yarn.<br>resourcemanagerHaEnabled | **boolean** (boolean)
datasource.<br>hdfs.<br>yarn.<br>resourcemanagerHaAutoFailoverEnabled | **boolean** (boolean)
datasource.<br>hdfs.<br>yarn.<br>resourcemanagerHaAutoFailoverEmbedded | **boolean** (boolean)
datasource.<br>hdfs.<br>yarn.<br>resourcemanagerClusterId | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasource.<br>hdfs.<br>yarn.<br>haRm | **object**<br><p>No more than 10000 per resource.</p> 
datasource.<br>hive | **object** <br>`datasource` includes only one of the fields `s3`, `jdbc`, `hdfs`, `hive`<br>
datasource.<br>hive.<br>core | **object**
datasource.<br>hive.<br>core.<br>defaultFs | **string**<br><p>The maximum string length in characters is 200.</p> 
datasource.<br>hive.<br>core.<br>securityAuthToLocal | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasource.<br>hive.<br>kerberos | **object**
datasource.<br>hive.<br>kerberos.<br>enable | **boolean** (boolean)
datasource.<br>hive.<br>kerberos.<br>primary | **string**<br><p>The maximum string length in characters is 128.</p> 
datasource.<br>hive.<br>kerberos.<br>realm | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasource.<br>hive.<br>kerberos.<br>kdcServers[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasource.<br>hive.<br>kerberos.<br>adminServer | **string**<br><p>The maximum string length in characters is 128.</p> 
datasource.<br>hive.<br>kerberos.<br>defaultDomain | **string**<br><p>The maximum string length in characters is 128.</p> 
datasource.<br>hive.<br>kerberos.<br>keytabBase64 | **string**<br><p>The maximum string length in characters is 65536. Value must match the regular expression ``^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$``.</p> 
datasource.<br>hive.<br>userImpersonation | **boolean** (boolean)
datasource.<br>hive.<br>username | **string**<br><p>The maximum string length in characters is 128.</p> 
datasource.<br>hive.<br>saslConnectionRetries | **integer** (int64)<br><p>Acceptable values are 1 to 50, inclusive.</p> 
datasource.<br>hive.<br>zkHosts[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasource.<br>hive.<br>ppd | **boolean** (boolean)
datasource.<br>hive.<br>metastoreUris[] | **string**<br><p>The maximum number of elements is 200. The string length in characters for each value must be 1-200.</p> 
datasource.<br>hive.<br>metastoreKerberosPrincipal | **string**<br><p>The maximum string length in characters is 1000.</p> 
datasource.<br>hive.<br>authKerberosPrincipal | **string**<br><p>The maximum string length in characters is 1000.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 