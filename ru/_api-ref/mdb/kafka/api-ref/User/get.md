---
editable: false
---

# Метод get
Returns the specified Apache Kafka user.
 
To get the list of available Apache Kafka users, make a [list](/docs/managed-kafka/api-ref/User/list) request.
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/users/{userName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. ID of the Apache Kafka cluster the user belongs to.  To get the cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  Максимальная длина строки в символах — 50.
userName | Обязательное поле. Name of the Apache Kafka User resource to return.  To get the name of the user, make a [list](/docs/managed-kafka/api-ref/User/list) request.  Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
An Apache Kafka user.
For more information, see the [Concepts → Accounts](/docs/managed-kafka/concepts/users) section of the documentation.
 
Поле | Описание
--- | ---
name | **string**<br><p>Name of the Apache Kafka user.</p> 
clusterId | **string**<br><p>ID of the Apache Kafka cluster the user belongs to.</p> <p>To get the Apache Kafka cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
permissions[] | **object**<br><p>Set of permissions granted to this user.</p> 
permissions[].<br>topicName | **string**<br><p>Name of the topic that the permission grants access to.</p> <p>To get the topic name, make a [Topic.List] request.</p> 
permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: Producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: Consumer role for the user.</li> </ul> 