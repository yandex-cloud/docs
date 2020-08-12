---
editable: false
---

# User
A set of methods for managing Kafka users.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
name | **string**<br><p>Name of the Kafka user.</p> 
clusterId | **string**<br><p>ID of the Apache Kafka® cluster the user belongs to.</p> <p>To get the Apache Kafka® cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
permissions[] | **object**<br><p>Set of permissions granted to this user.</p> 
permissions[].<br>topicName | **string**<br><p>Name of the topic that the permission grants access to.</p> <p>To get the topic name, make a <a href="/docs/managed-kafka/api-ref/Topic/list">list</a> request.</p> 
permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: consumer role for the user.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a Kafka user in the specified cluster.
[delete](delete.md) | Deletes the specified Kafka user.
[get](get.md) | Returns the specified Kafka user.
[grantPermission](grantPermission.md) | Grants permission to the specified Kafka user.
[list](list.md) | Retrieves the list of Kafka users in the specified cluster.
[revokePermission](revokePermission.md) | Revokes permission from the specified Kafka user.
[update](update.md) | Updates the specified Kafka user.