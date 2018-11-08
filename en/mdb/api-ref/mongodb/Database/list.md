# Method list
Retrieves the list of MongoDB Database resources in the specified cluster.
 

 
## HTTP request {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/databases`
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MongoDB cluster to list databases in. To get the cluster ID, use a [list](/docs/mdb/api-ref/mongodb/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/mdb/api-ref/mongodb/Database/list#query_params) to the  [nextPageToken](/docs/mdb/api-ref/mongodb/Database/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**


 
Field | Description
--- | ---
databases | **object**<br><p>A MongoDB Database resource. For more information, see the <a href="/docs/mdb/concepts">Developer's Guide</a>.</p> 
databases.<br>name | **string**<br><p>Name of the database.</p> 
databases.<br>clusterId | **string**<br><p>ID of the MongoDB cluster that the database belongs to.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/mdb/api-ref/mongodb/Database/list#query_params">pageSize</a>, use the <a href="/docs/mdb/api-ref/mongodb/Database/list#responses">nextPageToken</a> as the value for the <a href="/docs/mdb/api-ref/mongodb/Database/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/mdb/api-ref/mongodb/Database/list#responses">nextPageToken</a> to continue paging through the results.</p> 