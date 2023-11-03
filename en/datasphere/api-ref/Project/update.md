---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Project/update.md
---

# DataSphere API v2, REST: Project.update
Updates the specified project.
 

 
## HTTP request {#https-request}
```
PATCH https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | <p>Required. ID of the Project resource to update. To get the project ID use a <a href="/docs/datasphere/api-ref/v2/Project/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "settings": {
    "serviceAccountId": "string",
    "subnetId": "string",
    "dataProcClusterId": "string",
    "commitMode": "string",
    "securityGroupIds": [
      "string"
    ],
    "earlyAccess": true,
    "ide": "string",
    "defaultFolderId": "string",
    "staleExecTimeoutMode": "string",
    "ideExecutionMode": "string",
    "vmInactivityTimeout": "string",
    "defaultDedicatedSpec": "string"
  },
  "limits": {
    "maxUnitsPerHour": "integer",
    "maxUnitsPerExecution": "integer"
  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the Project resource are going to be updated.</p> <p>A comma-separated names off ALL fields to be updated. Only the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>Name of the project. 0-63 characters long.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the project. 0-256 characters long.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Labels of the project.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
settings | **object**<br><p>Settings of the project.</p> 
settings.<br>serviceAccountId | **string**<br><p>ID of the service account, on whose behalf all operations with clusters will be performed.</p> 
settings.<br>subnetId | **string**<br><p>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported.</p> 
settings.<br>dataProcClusterId | **string**<br><p>ID of the DataProc cluster.</p> 
settings.<br>commitMode | **string**<br><p>Commit mode that is assigned to the project.</p> <ul> <li>STANDARD: Commit happens after the execution of a cell or group of cells or after completion with an error.</li> <li>AUTO: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li> </ul> 
settings.<br>securityGroupIds[] | **string**<br><p>Network interfaces security groups.</p> 
settings.<br>earlyAccess | **boolean** (boolean)<br><p>Is early access preview enabled for the project.</p> 
settings.<br>ide | **string**<br><p>Project IDE.</p> <ul> <li>JUPYTER_LAB: Project running on JupyterLab IDE.</li> </ul> 
settings.<br>defaultFolderId | **string**<br><p>Default project folder ID.</p> 
settings.<br>staleExecTimeoutMode | **string**<br><p>Timeout to automatically stop stale executions.</p> <ul> <li>ONE_HOUR: Setting to automatically stop stale execution after one hour with low consumption.</li> <li>THREE_HOURS: Setting to automatically stop stale execution after three hours with low consumption.</li> <li>NO_TIMEOUT: Setting to never automatically stop stale executions.</li> </ul> 
settings.<br>ideExecutionMode | **string**<br><p>VM allocation mode.</p> <ul> <li>SERVERLESS: VM is allocated for specific execution and deallocated after the execution ends.</li> <li>DEDICATED: VM is allocated at the first execution and stays allocated until manually deallocated. Or until timeout exceeded.</li> </ul> 
settings.<br>vmInactivityTimeout | **string**<br><p>Timeout for VM deallocation.</p> 
settings.<br>defaultDedicatedSpec | **string**<br><p>Default VM configuration for DEDICATED mode.</p> 
limits | **object**<br><p>Limits of the project.</p> 
limits.<br>maxUnitsPerHour | **integer** (int64)<br><p>The number of units that can be spent per hour.</p> 
limits.<br>maxUnitsPerExecution | **integer** (int64)<br><p>The number of units that can be spent on the one execution.</p> 
 
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