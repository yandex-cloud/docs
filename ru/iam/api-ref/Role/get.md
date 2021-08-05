---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method get
Returns the specified Role resource.
 
To get the list of available Role resources, make a [list](/docs/iam/api-ref/Role/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/roles/{roleId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
roleId | Required. ID of the Role resource to return. To get the role ID, use a [list](/docs/iam/api-ref/Role/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string"
}
```
A Role resource. For more information, see [Roles](/docs/iam/concepts/access-control/roles).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the role.</p> 
description | **string**<br><p>Description of the role. 0-256 characters long.</p> 