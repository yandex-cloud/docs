---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Database/get.md
---

# Method get
Retrieves information about the specified database.
 

 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-mysql/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster that the database belongs to.  To get this ID, make a [list](/docs/managed-mysql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
databaseName | Required. Name of the database to return information about.  To get this name, make a [list](/docs/managed-mysql/api-ref/Database/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
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