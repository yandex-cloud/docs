---
editable: false
---

# Метод list
Retrieves the list of Apache Kafka users in the specified cluster.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/users
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. ID of the cluster to list Apache Kafka users in.  To get the cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | The maximum number of results per page to return.  If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-kafka/api-ref/User/list#responses) that can be used to get the next page of results in subsequent list requests.  Максимальное значение — 1000.
pageToken | Page token.  To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-kafka/api-ref/User/list#responses) returned by a previous list request.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
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

 
Поле | Описание
--- | ---
users[] | **object**<br><p>An Apache Kafka user. For more information, see the <a href="/docs/managed-kafka/concepts/users">Concepts → Accounts</a> section of the documentation.</p> 
users[].<br>name | **string**<br><p>Name of the Apache Kafka user.</p> 
users[].<br>clusterId | **string**<br><p>ID of the Apache Kafka cluster the user belongs to.</p> <p>To get the Apache Kafka cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
users[].<br>permissions[] | **object**<br><p>Set of permissions granted to this user.</p> 
users[].<br>permissions[].<br>topicName | **string**<br><p>Name of the topic that the permission grants access to.</p> <p>To get the topic name, make a [Topic.List] request.</p> 
users[].<br>permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: Producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: Consumer role for the user.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageSize</a>, use the <code>next_page_token</code> as the value for the <a href="/docs/managed-kafka/api-ref/User/list#query_params">pageToken</a> parameter in the next list request. Each subsequent list request will have its own <code>next_page_token</code> to continue paging through the results.</p> 