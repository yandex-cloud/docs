---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
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