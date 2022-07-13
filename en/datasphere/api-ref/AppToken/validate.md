---
editable: false
sourcePath: en/_api-ref/datasphere/api-ref/AppToken/validate.md
---

# Method validate
Validates app token.
 

 
## HTTP request {#https-request}
```
POST https://datasphere.{{ api-host }}/datasphere/v1/appTokens/{token}:validate
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
token | <p>App token to validate.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object ``{}``.</p> 