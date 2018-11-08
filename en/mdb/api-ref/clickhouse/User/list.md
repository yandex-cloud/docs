# Method list
Retrieves the list of ClickHouse User resources in the specified cluster.
 

 
## HTTP request {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/users`
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to list ClickHouse users in. To get the cluster ID, use a [list](/docs/mdb/api-ref/clickhouse/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/mdb/api-ref/clickhouse/User/list#query_params), the service returns a [nextPageToken](/docs/mdb/api-ref/clickhouse/User/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token.  To get the next page of results, set [pageToken](/docs/mdb/api-ref/clickhouse/User/list#query_params) to the [nextPageToken](/docs/mdb/api-ref/clickhouse/User/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**


 
Field | Description
--- | ---
users | **object**<br><p>A ClickHouse User resource. For more information, see the <a href="/docs/mdb/concepts">Developer's guide</a>.</p> 
users.<br>name | **string**<br><p>Name of the ClickHouse user.</p> 
users.<br>clusterId | **string**<br><p>ID of the ClickHouse cluster the user belongs to.</p> 
users.<br>permissions | **object**<br><p>Set of permissions granted to the user.</p> 
users.<br>permissions.<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/mdb/api-ref/clickhouse/User/list#query_params">pageSize</a>, use the <a href="/docs/mdb/api-ref/clickhouse/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/mdb/api-ref/clickhouse/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/mdb/api-ref/clickhouse/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 