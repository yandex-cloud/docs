---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method getByName
Returns the specified Repository resource.
 
To get the list of available Repository resources, make a [list](/docs/container-registry/api-ref/Repository/list) request.
 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/repositories/{repositoryName}:byName
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
repositoryName | Required. Name of the Repository resource to return.  To get the repository name use a [list](/docs/container-registry/api-ref/Repository/list) request.  Value must match the regular expression `` [a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "id": "string"
}
```
A Repository resource. For more information, see [Repository](/docs/cloud/container-registry/repository).
 
Field | Description
--- | ---
name | **string**<br><p>Name of the repository. The name is unique within the registry.</p> 
id | **string**<br><p>Output only. ID of the repository.</p> 