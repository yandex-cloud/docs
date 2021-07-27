---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Method list
Retrieves the list of Kafka users in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Apache Kafka® cluster to list Kafka users in.  To get the Apache Kafka® cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return.  If the number of available results is larger than [pageSize](/docs/managed-kafka/api-ref/User/list#query_params), the service returns a [nextPageToken](/docs/managed-kafka/api-ref/User/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token.  To get the next page of results, set [pageToken](/docs/managed-kafka/api-ref/User/list#query_params) to the [nextPageToken](/docs/managed-kafka/api-ref/User/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
          "topicName": "string",
          "role": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
users[] | **object**<br><p>A Kafka user. For more information, see the <a href="/docs/managed-kafka/operations/cluster-accounts">Operations -&gt; Accounts</a> section of the documentation.</p> 
users[].<br>name | **string**<br><p>Name of the Kafka user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the Apache Kafka® cluster the user belongs to.</p> <p>To get the Apache Kafka® cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to this user.</p> 
users[].<br>permissions[].<br>topicName | **string**<br><p>Name or prefix-pattern with wildcard for the topic that the permission grants access to.</p> <p>To get the topic name, make a <a href="/docs/managed-kafka/api-ref/Topic/list">list</a> request.</p> 
users[].<br>permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: consumer role for the user.</li> <li>ACCESS_ROLE_ADMIN: admin role for the user.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-kafka/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 