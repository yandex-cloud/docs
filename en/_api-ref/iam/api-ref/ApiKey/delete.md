---
editable: false
---

# Method delete
Deletes the specified API key.
 

 
## HTTP request {#https-request}
```
DELETE https://iam.api.cloud.yandex.net/iam/v1/apiKeys/{apiKeyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
apiKeyId | Required. ID of the API key to delete. To get the API key ID, use a [list](/docs/iam/api-ref/ApiKey/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
"object"
```
Empty JSON object `` {} ``.
 
Field | Description
--- | ---
 | **object**<br><p>Empty JSON object <code>{}</code>.</p> 