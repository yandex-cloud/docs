---
editable: false
sourcePath: en/_api-ref/datasphere/api-ref/Project/get.md
---

# Method get
Returns the specified project.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v1/projects/{projectId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | <p>Required. ID of the Project resource to return. To get the project ID use a <a href="/docs/datasphere/api-ref/Project/list">list</a> request.</p> <p>The maximum string length in characters is 200.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "settings": {
    "serviceAccountId": "string",
    "subnetId": "string",
    "dataProcClusterId": "string",
    "commitMode": "string",
    "securityGroupIds": [
      "string"
    ]
  },
  "limits": {
    "maxUnitsPerHour": "integer",
    "maxUnitsPerExecution": "integer"
  }
}
```
A Project resource.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the project.</p> 
folderId | **string**<br><p>ID of the folder that the project belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the project. 1-63 characters long.</p> 
description | **string**<br><p>Description of the project. 0-256 characters long.</p> 
settings | **object**<br><p>Settings of the project.</p> 
settings.<br>serviceAccountId | **string**<br><p>ID of the service account, on whose behalf all operations with clusters will be performed.</p> 
settings.<br>subnetId | **string**<br><p>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported.</p> 
settings.<br>dataProcClusterId | **string**<br><p>ID of the DataProc cluster.</p> 
settings.<br>commitMode | **string**<br><p>Commit mode that is assigned to the project.</p> <ul> <li>STANDARD: Commit happens after the execution of a cell or group of cells or after completion with an error.</li> <li>AUTO: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li> </ul> 
settings.<br>securityGroupIds[] | **string**<br><p>Network interfaces security groups.</p> 
limits | **object**<br><p>Limits of the project.</p> 
limits.<br>maxUnitsPerHour | **integer** (int64)<br><p>The number of units that can be spent per hour.</p> 
limits.<br>maxUnitsPerExecution | **integer** (int64)<br><p>The number of units that can be spent on the one execution.</p> 