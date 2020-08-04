---
editable: false
---

# User
A set of methods for managing Apache Kafka User resources.
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
name | **string**<br><p>Name of the Apache Kafka user.</p> 
clusterId | **string**<br><p>ID of the Apache Kafka cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>topicName | **string**<br><p>Name of the topic that the permission grants access to.</p> 
permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a Apache Kafka user in the specified cluster.
[delete](delete.md) | Deletes the specified Apache Kafka user.
[get](get.md) | Returns the specified Apache Kafka User resource.
[grantPermission](grantPermission.md) | Grants permission to the specified Apache Kafka user.
[list](list.md) | Retrieves the list of Apache Kafka User resources in the specified cluster.
[revokePermission](revokePermission.md) | Revokes permission from the specified Apache Kafka user.
[update](update.md) | Updates the specified Apache Kafka user.