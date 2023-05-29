---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/User/list.md
---

# Managed Service for MongoDB API, REST: User.list
Retrieves the list of MongoDB User resources in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list MongoDB users in. To get the cluster ID, use a <a href="/docs/managed-mongodb/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-mongodb/api-ref/User/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-mongodb/api-ref/User/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-mongodb/api-ref/User/list#query_params">pageToken</a> to the <a href="/docs/managed-mongodb/api-ref/User/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "users": [
    {
      "name": "string",
      "clusterId": "string",
      "permissions": [
        {
          "databaseName": "string",
          "roles": [
            "string"
          ]
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>List of MongoDB User resources.</p> 
users[].<br>name | **string**<br><p>Name of the MongoDB user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the MongoDB cluster the user belongs to.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
users[].<br>permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
users[].<br>permissions[].<br>roles[] | **string**<br><p>MongoDB roles for the ``databaseName`` database that the permission grants.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-mongodb/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-mongodb/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mongodb/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-mongodb/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 