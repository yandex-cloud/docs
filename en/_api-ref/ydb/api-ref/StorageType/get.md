---
editable: false
---

# Managed Service for YDB API, REST: StorageType.get
Returns the specified storage types.
 

 
## HTTP request {#https-request}
```
GET https://ydb.{{ api-host }}/ydb/v1/storageTypes/{storageTypeId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
storageTypeId | <p>Required. Required. ID of the storage type to return.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "deviceType": "string",
  "redundancyType": "string"
}
```

 
Field | Description
--- | ---
id | **string**
deviceType | **string**
redundancyType | **string**