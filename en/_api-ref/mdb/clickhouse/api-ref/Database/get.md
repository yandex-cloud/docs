---
editable: false
---

# Managed Service for ClickHouse API, REST: Database.get
Returns the specified ClickHouse Database resource.
 
To get the list of available ClickHouse Database resources, make a [list](/docs/managed-clickhouse/api-ref/Database/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the ClickHouse cluster that the database belongs to. To get the cluster ID, use a <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
databaseName | <p>Required. Name of the ClickHouse Database resource to return. To get the name of the database, use a <a href="/docs/managed-clickhouse/api-ref/Database/list">list</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
A ClickHouse Database resource. For more information, see the 
[Developer's Guide](/docs/managed-clickhouse/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the database.</p> 
clusterId | **string**<br><p>ID of the ClickHouse cluster that the database belongs to.</p> 