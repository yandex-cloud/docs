---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/api-ref/User/get.md
---

# Method get
Returns the specified Elasticsearch user.
 
To get the list of available Elasticsearch users, make a [list](/docs/managed-elasticsearch/api-ref/User/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.{{ api-host }}/managed-elasticsearch/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Elasticsearch cluster the user belongs to.</p> <p>To get the cluster ID, make a <a href="/docs/managed-elasticsearch/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
userName | <p>Required. Name of the Elasticsearch user to return.</p> <p>To get the name of the user, make a <a href="/docs/managed-elasticsearch/api-ref/User/list">list</a> request.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
An Elasticsearch user.
 
Field | Description
--- | ---
name | **string**<br><p>Name of the Elasticsearch user.</p> 
clusterId | **string**<br><p>ID of the Elasticsearch cluster the user belongs to.</p> 