---
editable: false
---

# User
A set of methods for managing Apache Kafka users.
## JSON-представление {#representation}
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
 
Поле | Описание
--- | ---
name | **string**<br><p>Name of the Apache Kafka user.</p> 
clusterId | **string**<br><p>ID of the Apache Kafka cluster the user belongs to.</p> <p>To get the Apache Kafka cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
permissions[] | **object**<br><p>Set of permissions granted to this user.</p> 
permissions[].<br>topicName | **string**<br><p>Name of the topic that the permission grants access to.</p> <p>To get the topic name, make a [Topic.List] request.</p> 
permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: Producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: Consumer role for the user.</li> </ul> 

## Методы {#methods}
Метод | Описание
--- | ---
[create](create.md) | Creates a Apache Kafka user in the specified cluster.
[delete](delete.md) | Deletes the specified Apache Kafka user.
[get](get.md) | Returns the specified Apache Kafka user.
[grantPermission](grantPermission.md) | Grants permission to the specified Apache Kafka user.
[list](list.md) | Retrieves the list of Apache Kafka users in the specified cluster.
[revokePermission](revokePermission.md) | Revokes permission from the specified Apache Kafka user.
[update](update.md) | Updates the specified Apache Kafka user.