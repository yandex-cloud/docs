---
editable: false
---

# Method listActivated
List activated providers for specified client.
 

 
## HTTP request {#https-request}
```
GET https://cdn.api.cloud.yandex.net/cdn/v1/providers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "providers": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
providers[] | **string**<br>