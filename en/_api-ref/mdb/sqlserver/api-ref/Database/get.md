---
editable: false
---

# Managed Service for SQL Server API, REST: Database.get
Returns the specified SQL Server database.
 
To get the list of available SQL Server databases, make a [list](/docs/managed-sqlserver/api-ref/Database/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/mdb/sqlserver/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the SQL Server cluster the database belongs to.</p> <p>To get the cluster ID, use a <a href="/docs/managed-sqlserver/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
databaseName | <p>Required. Name of the SQL Server database to return.</p> <p>To get the name of the database use a <a href="/docs/managed-sqlserver/api-ref/Database/list">list</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
An SQL Server database.

For more information, see the [Concepts](/docs/managed-sqlserver/concepts) section of the documentation.
 
Field | Description
--- | ---
name | **string**<br><p>Name of the database.</p> 
clusterId | **string**<br><p>ID of the SQL Server cluster that the database belongs to.</p> 