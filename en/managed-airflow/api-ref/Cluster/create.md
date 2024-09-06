---
editable: false
sourcePath: en/_api-ref/airflow/v1/api-ref/Cluster/create.md
---

# Managed Service for Apache Airflow™ API, REST: Cluster.create
Creates an Apache Airflow cluster.
 

 
## HTTP request {#https-request}
```
POST https://airflow.{{ api-host }}/managed-airflow/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "config": {
    "versionId": "string",
    "airflow": {
      "config": "object"
    },
    "webserver": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "scheduler": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "triggerer": {
      "count": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "worker": {
      "minCount": "string",
      "maxCount": "string",
      "resources": {
        "resourcePresetId": "string"
      }
    },
    "dependencies": {
      "pipPackages": [
        "string"
      ],
      "debPackages": [
        "string"
      ]
    },
    "lockbox": {
      "enabled": true
    }
  },
  "network": {
    "subnetIds": [
      "string"
    ],
    "securityGroupIds": [
      "string"
    ]
  },
  "codeSync": {
    "s3": {
      "bucket": "string"
    }
  },
  "deletionProtection": true,
  "serviceAccountId": "string",
  "logging": {
    "enabled": true,
    "minLevel": "string",

    // `logging` includes only one of the fields `folderId`, `logGroupId`
    "folderId": "string",
    "logGroupId": "string",
    // end of the list of possible fields`logging`

  },
  "adminPassword": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create Apache Airflow cluster in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the Apache Airflow cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Description of the Apache Airflow cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Apache Airflow cluster as ``key:value`` pairs. For example, "env": "prod".</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
config | **object**<br><p>Required. Configuration of Apache Airflow components.</p> 
config.<br>versionId | **string**<br><p>Version of Apache that runs on the cluster.</p> 
config.<br>airflow | **object**<br><p>Configuration of the Apache Airflow application itself.</p> 
config.<br>airflow.<br>config | **object**<br><p>Properties to be passed to Apache Airflow configuration file.</p> 
config.<br>webserver | **object**<br><p>Required. Configuration of webserver instances.</p> 
config.<br>webserver.<br>count | **string** (int64)<br><p>The number of webserver instances in the cluster.</p> <p>Acceptable values are 1 to 512, inclusive.</p> 
config.<br>webserver.<br>resources | **object**<br><p>Resources allocated to webserver instances.</p> 
config.<br>webserver.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to an instance (CPU, memory etc.).</p> 
config.<br>scheduler | **object**<br><p>Required. Configuration of scheduler instances.</p> 
config.<br>scheduler.<br>count | **string** (int64)<br><p>The number of scheduler instances in the cluster.</p> <p>Acceptable values are 1 to 512, inclusive.</p> 
config.<br>scheduler.<br>resources | **object**<br><p>Resources allocated to scheduler instances.</p> 
config.<br>scheduler.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to an instance (CPU, memory etc.).</p> 
config.<br>triggerer | **object**<br><p>Configuration of triggerer instances.</p> 
config.<br>triggerer.<br>count | **string** (int64)<br><p>The number of triggerer instances in the cluster.</p> <p>Acceptable values are 0 to 512, inclusive.</p> 
config.<br>triggerer.<br>resources | **object**<br><p>Resources allocated to triggerer instances.</p> 
config.<br>triggerer.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to an instance (CPU, memory etc.).</p> 
config.<br>worker | **object**<br><p>Required. Configuration of worker instances.</p> 
config.<br>worker.<br>minCount | **string** (int64)<br><p>The minimum number of worker instances in the cluster.</p> <p>Acceptable values are 0 to 512, inclusive.</p> 
config.<br>worker.<br>maxCount | **string** (int64)<br><p>The maximum number of worker instances in the cluster.</p> <p>Acceptable values are 1 to 512, inclusive.</p> 
config.<br>worker.<br>resources | **object**<br><p>Resources allocated to worker instances.</p> 
config.<br>worker.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to an instance (CPU, memory etc.).</p> 
config.<br>dependencies | **object**<br><p>The list of additional packages installed in the cluster.</p> 
config.<br>dependencies.<br>pipPackages[] | **string**<br><p>Python packages that are installed in the cluster.</p> 
config.<br>dependencies.<br>debPackages[] | **string**<br><p>System packages that are installed in the cluster.</p> 
config.<br>lockbox | **object**<br><p>Configuration of Lockbox Secret Backend.</p> 
config.<br>lockbox.<br>enabled | **boolean** (boolean)<br><p>The setting allows to enable Lockbox Secret Backend.</p> 
network | **object**<br><p>Network related configuration options.</p> 
network.<br>subnetIds[] | **string**<br><p>IDs of VPC network subnets where instances of the cluster are attached.</p> 
network.<br>securityGroupIds[] | **string**<br><p>User security groups.</p> 
codeSync | **object**<br><p>Parameters of the location and access to the code that will be executed in the cluster.</p> 
codeSync.<br>s3 | **object**
codeSync.<br>s3.<br>bucket | **string**<br><p>The name of the Object Storage bucket that stores DAG files used in the cluster.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster.</p> 
serviceAccountId | **string**<br><p>Service account used to access Cloud resources. For more information, see <a href="/docs/managed-airflow/concepts/impersonation">documentation</a>.</p> <p>The maximum string length in characters is 50.</p> 
logging | **object**<br><p>Cloud Logging configuration.</p> 
logging.<br>enabled | **boolean** (boolean)<br><p>Logs generated by the Airflow components are delivered to Cloud Logging.</p> 
logging.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
logging.<br>folderId | **string** <br>`logging` includes only one of the fields `folderId`, `logGroupId`<br><br><p>Logs should be written to default log group for specified folder.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
logging.<br>logGroupId | **string** <br>`logging` includes only one of the fields `folderId`, `logGroupId`<br><br><p>Logs should be written to log group resolved by ID.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
adminPassword | **string**<br><p>Required. Password of user ``admin``.</p> <p>The string length in characters must be 8-128.</p> 
 
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