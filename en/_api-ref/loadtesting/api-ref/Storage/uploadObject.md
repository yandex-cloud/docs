---
editable: false
---

# Method uploadObject
Uploads the object to the specified storage.
 

 
## HTTP request {#https-request}
```
POST https://loadtesting.{{ api-host }}/loadtesting/v1/storages/{storageId}/uploadObject
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
storageId | <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "filename": "string",
  "testData": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
filename | **string**<br><p>The maximum string length in characters is 50.</p> 
testData | **string** (byte)<br><p>Required.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "objectStorageBucket": "string",
  "objectStorageFilename": "string"
}
```

 
Field | Description
--- | ---
objectStorageBucket | **string**
objectStorageFilename | **string**