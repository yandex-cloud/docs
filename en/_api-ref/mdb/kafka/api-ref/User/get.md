---
editable: false
---

# Method get
Returns the specified Apache Kafka User resource.
 
To get the list of available Apache Kafka User resources, make a [list](/docs/managed-kafka/api-ref/User/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. Required. ID of the Apache Kafka cluster the user belongs to. To get the cluster ID, use a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
userName | Required. Required. Name of the Apache Kafka User resource to return. To get the name of the user, use a [list](/docs/managed-kafka/api-ref/User/list) request.  The string length in characters must be 1-63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.
 
## Response {#responses}
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
A Apache Kafka User resource. For more information, see
the [Developer's Guide](/docs/mdb/kafka/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the Apache Kafka user.</p> 
clusterId | **string**<br><p>ID of the Apache Kafka cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>topicName | **string**<br><p>Name of the topic that the permission grants access to.</p> 
permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> 