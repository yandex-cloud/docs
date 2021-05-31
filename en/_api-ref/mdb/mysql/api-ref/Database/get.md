---
editable: false
---

# Method get
Returns the specified MySQL database.
 
To get the list of available MySQL databases, make a [list](/docs/managed-mysql/api-ref/Database/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MySQL cluster that the database belongs to. To get the cluster ID use a [list](/docs/managed-mysql/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
databaseName | Required. Name of the MySQL database to return. To get the name of the database use a [list](/docs/managed-mysql/api-ref/Database/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
A MySQL database. For more information, see
the [documentation](/docs/managed-mysql/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the database.</p> 
clusterId | **string**<br><p>ID of the MySQL cluster that the database belongs to.</p> 