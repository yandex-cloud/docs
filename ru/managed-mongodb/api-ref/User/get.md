---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method get
Returns the specified MongoDB User resource.
 
To get the list of available MongoDB User resources, make a [list](/docs/managed-mongodb/api-ref/User/list) request.
 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/users/{userName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the MongoDB cluster the user belongs to. To get the cluster ID, use a [list](/docs/managed-mongodb/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
userName | Required. Name of the MongoDB User resource to return. To get the name of the user, use a [list](/docs/managed-mongodb/api-ref/User/list) request.  The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "permissions": [
    {
      "databaseName": "string",
      "roles": [
        "string"
      ]
    }
  ]
}
```
A MongoDB User resource. For more information, see the 
[Developer's Guide](/docs/managed-mongodb/concepts).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the MongoDB user.</p> 
clusterId | **string**<br><p>ID of the MongoDB cluster the user belongs to.</p> 
permissions[] | **object**<br><p>Set of permissions granted to the user.</p> 
permissions[].<br>databaseName | **string**<br><p>Name of the database that the permission grants access to.</p> 
permissions[].<br>roles[] | **string**<br><p>MongoDB roles for the ``databaseName`` database that the permission grants.</p> 