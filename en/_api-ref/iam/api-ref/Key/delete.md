---
editable: false
---

# Method delete
Deletes the specified key pair.
 

 
## HTTP request {#https-request}
```
DELETE https://iam.api.cloud.yandex.net/iam/v1/keys/{keyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. ID of the key to delete. To get key ID use a [list](/docs/iam/api-ref/Key/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object <code>{}</code>.</p> 