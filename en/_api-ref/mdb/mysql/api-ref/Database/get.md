---
editable: false
---

# Method get
Retrieves information about the specified database.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster that the database belongs to.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
databaseName | <p>Required. Name of the database to return information about.</p> <p>To get this name, make a <a href="/docs/managed-mysql/api-ref/Database/list">list</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
An object that represents MySQL database.

See [the documentation](/docs/managed-mysql/operations/databases) for details.
 
Field | Description
--- | ---
name | **string**<br><p>Name of the database.</p> 
clusterId | **string**<br><p>ID of the cluster that the database belongs to.</p> 