---
editable: false
---

# Cloud Backup API, REST: Provider.listActivated
List activated providers for specified client.
 

 
## HTTP request {#https-request}
```
GET https://backup.{{ api-host }}/backup/v1/providers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "folderId": "string",
  "names": [
    "string"
  ]
}
```

 
Field | Description
--- | ---
folderId | **string**
names[] | **string**