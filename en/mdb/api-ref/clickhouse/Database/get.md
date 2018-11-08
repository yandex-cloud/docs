# Method get
Returns the specified ClickHouse Database resource.
 
To get the list of available ClickHouse Database resources, make a [list](/docs/mdb/api-ref/clickhouse/Database/list) request.
 
## HTTP request {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/databases/{databaseName}`
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the ClickHouse cluster that the database belongs to. To get the cluster ID, use a [list](/docs/mdb/api-ref/clickhouse/Cluster/list) request.  The maximum string length in characters is 50.
databaseName | Required. Name of the ClickHouse Database resource to return. To get the name of the database, use a [list](/docs/mdb/api-ref/clickhouse/Database/list) request.  The string length in characters must be 1-63. Value must match the regular expression `` [a-zA-Z0-9_]+ ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

A ClickHouse Database resource. For more information, see the 
[Developer's Guide](/docs/mdb/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the database.</p> 
clusterId | **string**<br><p>ID of the ClickHouse cluster that the database belongs to.</p> 