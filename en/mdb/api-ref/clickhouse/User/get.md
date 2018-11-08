# Method get
Returns the specified ClickHouse User resource.
 
To get the list of available ClickHouse User resources, make a [list](/docs/mdb/api-ref/clickhouse/User/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the ClickHouse cluster the user belongs to. To get the cluster ID, use a [list](/docs/mdb/api-ref/clickhouse/Cluster/list) request.  The maximum string length in characters is 50.
userName | Required. Name of the ClickHouse User resource to return. To get the name of the user, use a [list](/docs/mdb/api-ref/clickhouse/User/list) request.  The string length in characters must be 1-63. Value must match the regular expression `` [a-zA-Z0-9_]+ ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

A ClickHouse User resource. For more information, see 
the [Developer's guide](/docs/mdb/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the ClickHouse user.</p> 
clusterId | **string**<br><p>ID of the ClickHouse cluster the user belongs to.</p> 
permissions | **object**<br><p>Set of permissions granted to the user.</p> 
permissions.<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 