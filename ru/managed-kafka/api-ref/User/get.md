---
editable: false
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/User/get.md
---

# Managed Service for Apache Kafka® API, REST: User.get
Returns the specified Kafka user.
 
To get the list of available Kafka users, make a [list](/docs/managed-kafka/api-ref/User/list) request.
 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Apache Kafka® cluster the user belongs to.</p> <p>To get the cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
userName | <p>Required. Name of the Kafka user to return.</p> <p>To get the name of the user, make a <a href="/docs/managed-kafka/api-ref/User/list">list</a> request.</p> <p>The string length in characters must be 1-63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
A Kafka user.
For more information, see the [Operations -> Accounts](/docs/managed-kafka/operations/cluster-accounts) section of the documentation.
 
Field | Description
--- | ---
name | **string**<br><p>Name of the Kafka user.</p> 
clusterId | **string**<br><p>ID of the Apache Kafka® cluster the user belongs to.</p> <p>To get the Apache Kafka® cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> 
permissions[] | **object**<br><p>Set of permissions granted to this user.</p> 
permissions[].<br>topicName | **string**<br><p>Name or prefix-pattern with wildcard for the topic that the permission grants access to.</p> <p>To get the topic name, make a <a href="/docs/managed-kafka/api-ref/Topic/list">list</a> request.</p> 
permissions[].<br>role | **string**<br><p>Access role type to grant to the user.</p> <ul> <li>ACCESS_ROLE_PRODUCER: producer role for the user.</li> <li>ACCESS_ROLE_CONSUMER: consumer role for the user.</li> <li>ACCESS_ROLE_ADMIN: admin role for the user.</li> </ul> 
permissions[].<br>allowHosts[] | **string**<br><p>Lists hosts allowed for this permission. When not defined, access from any host is allowed.</p> <p>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the ``allowHosts`` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed.</p> 