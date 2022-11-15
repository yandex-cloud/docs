---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/api-ref/Cluster/update.md
---

# Method update
Updates the specified OpenSearch cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the OpenSearch cluster resource to update. To get the OpenSearch cluster ID, use a <a href="/docs/managed-opensearch/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "adminPassword": "string",
    "opensearchSpec": {
      "plugins": [
        "string"
      ]
    },
    "dashboardsSpec": {},
    "access": {
      "dataTransfer": true,
      "serverless": true
    }
  },
  "name": "string",
  "securityGroupIds": [
    "string"
  ],
  "serviceAccountId": "string",
  "deletionProtection": true,
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the OpenSearch cluster resource should be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
description | **string**<br><p>New description of the OpenSearch cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the OpenSearch cluster as ``key:value`` pairs. For example, ``"project": "mvp"`` or ``"source": "dictionary"``.</p> <p>The new set of labels completely replaces the old one. To add a label, request the current set with the <a href="/docs/managed-opensearch/api-ref/Cluster/get">get</a> method, then send an <a href="/docs/managed-opensearch/api-ref/Cluster/update">update</a> request with the new label added to the set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
configSpec | **object**<br><p>New cluster configuration</p> 
configSpec.<br>version | **string**<br><p>OpenSearch version.</p> 
configSpec.<br>adminPassword | **string**<br><p>Required. OpenSearch admin password.</p> 
configSpec.<br>opensearchSpec | **object**<br><p>OpenSearch configuration.</p> 
configSpec.<br>opensearchSpec.<br>plugins[] | **string**<br><p>Names of the cluster plugins.</p> 
configSpec.<br>dashboardsSpec | **object**<br><p>Dashboards configuration.</p> <p>Dashboards configuration.</p> 
configSpec.<br>access | **object**<br><p>Access policy for external services.</p> <p>Access policy for external services.</p> 
configSpec.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Determines whether the access to Data Transfer is allowed.</p> 
configSpec.<br>access.<br>serverless | **boolean** (boolean)<br><p>Determines whether the access to Serverless is allowed.</p> 
name | **string**<br><p>New name for the cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
serviceAccountId | **string**<br><p>ID of the service account used to access Object Storage.</p> 
deletionProtection | **boolean** (boolean)<br><p>Determines whether the cluster is protected from being deleted.</p> 
maintenanceWindow | **object**<br><p>Cluster maintenance window. Should be defined by either one of the two options.</p> <p>An OpenSearch cluster maintenance window. Should be defined by either one of the two options.</p> 
maintenanceWindow.<br>anytime | **object**<br>An any-time maintenance window. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>A weekly maintenance window. <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**<br><p>Day of the week.</p> <ul> <li>MON: Monday</li> <li>TUE: Tuesday</li> <li>WED: Wednesday</li> <li>THU: Thursday</li> <li>FRI: Friday</li> <li>SAT: Saturday</li> <li>SUN: Sunday</li> </ul> 
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in the UTC timezone.</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
 
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