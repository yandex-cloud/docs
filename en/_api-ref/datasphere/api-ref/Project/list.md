---
editable: false
---

# Method list
Lists projects for the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.{{ api-host }}/datasphere/v1/projects
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list projects in. To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/datasphere/api-ref/Project/list#query_params">pageSize</a>, the service returns a <a href="/docs/datasphere/api-ref/Project/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/datasphere/api-ref/Project/list#query_params">pageToken</a> to the <a href="/docs/datasphere/api-ref/Project/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "projects": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
projects[] | **object**<br><p>List of Project resources.</p> 
projects[].<br>id | **string**<br><p>ID of the project.</p> 
projects[].<br>folderId | **string**<br><p>ID of the folder that the project belongs to.</p> 
projects[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
projects[].<br>name | **string**<br><p>Name of the project. 1-63 characters long.</p> 
projects[].<br>description | **string**<br><p>Description of the project. 0-256 characters long.</p> 
projects[].<br>settings | **object**<br><p>Settings of the project.</p> 
projects[].<br>settings.<br>serviceAccountId | **string**<br><p>ID of the service account, on whose behalf all operations with clusters will be performed.</p> 
projects[].<br>settings.<br>subnetId | **string**<br><p>ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported.</p> 
projects[].<br>settings.<br>dataProcClusterId | **string**<br><p>ID of the DataProc cluster.</p> 
projects[].<br>settings.<br>commitMode | **string**<br><p>Commit mode that is assigned to the project.</p> <ul> <li>STANDARD: Commit happens after the execution of a cell or group of cells or after completion with an error.</li> <li>AUTO: Commit happens periodically. Also, automatic saving of state occurs when switching to another type of computing resource.</li> </ul> 
projects[].<br>settings.<br>securityGroupIds[] | **string**<br><p>Network interfaces security groups.</p> 
projects[].<br>limits | **object**<br><p>Limits of the project.</p> 
projects[].<br>limits.<br>maxUnitsPerHour | **integer** (int64)<br><p>The number of units that can be spent per hour.</p> 
projects[].<br>limits.<br>maxUnitsPerExecution | **integer** (int64)<br><p>The number of units that can be spent on the one execution.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/datasphere/api-ref/Project/list#query_params">pageSize</a>, use the <a href="/docs/datasphere/api-ref/Project/list#responses">nextPageToken</a> as the value for the <a href="/docs/datasphere/api-ref/Project/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/datasphere/api-ref/Project/list#responses">nextPageToken</a> to continue paging through the results.</p> 