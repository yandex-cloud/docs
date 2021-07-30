---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method validate
Validates app token.
 

 
## HTTP request {#https-request}
```
POST https://datasphere.api.cloud.yandex.net/datasphere/v1/appTokens/{token}:validate
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
token | App token to validate.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object ``{}``.</p> 