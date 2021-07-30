---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method getUnitBalance
Returns the unit balance of the specified project.
 

 
## HTTP request {#https-request}
```
GET https://datasphere.api.cloud.yandex.net/datasphere/v1/projects/{projectId}:unitBalance
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
projectId | Required. ID of the project to return the unit balance for.  The maximum string length in characters is 200.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "unitBalance": "integer"
}
```

 
Field | Description
--- | ---
unitBalance | **integer** (int64)<br><p>The number of units available to the project.</p> 