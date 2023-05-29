---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/User/list.md
---

# Managed Service for Apache Kafka® API, REST: User.list
Retrieves the list of Kafka users in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/users
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Apache Kafka® cluster to list Kafka users in.</p> <p>To get the Apache Kafka® cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-kafka/api-ref/User/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageToken</a> to the <a href="/docs/managed-kafka/api-ref/User/list#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
          "role": "string",
          "allowHosts": [
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
users[] | **object**<br><p>List of Kafka users.</p> 
users[].<br>name | **string**<br><p>Name of the Kafka user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the Apache Kafka® cluster the user belongs to.</p> <p>To get the Apache Kafka® cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to this user.</p> 
users[].<br>permissions[].<br>topicName | **string**<br><p>Name or prefix-pattern with wildcard for the topic that the permission grants access to.</p> <p>To get the topic name, make a <a href="/docs/managed-kafka/api-ref/Topic/list">list</a> request.</p> 
users[].<br>permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: consumer role for the user.</li> <li>ACCESS_ROLE_ADMIN: admin role for the user.</li> </ul> 
users[].<br>permissions[].<br>allowHosts[] | **string**<br><p>Lists hosts allowed for this permission. When not defined, access from any host is allowed.</p> <p>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the ``allowHosts`` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageSize</a>, use the <a href="/docs/managed-kafka/api-ref/User/list#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/User/list#responses">nextPageToken</a> to continue paging through the results.</p> 