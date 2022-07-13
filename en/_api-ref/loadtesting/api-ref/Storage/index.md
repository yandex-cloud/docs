---
editable: false
---

# Storage

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "createdAt": "string",
  "objectStorageBucket": "string",
  "usedSize": "string"
}
```
 
Field | Description
--- | ---
id | **string**
folderId | **string**
name | **string**
description | **string**
labels | **object**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
objectStorageBucket | **string**
usedSize | **string** (int64)

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a storage for the specified folder.
[delete](delete.md) | Deletes the specified storage
[get](get.md) | Returns the specified storage.
[list](list.md) | Retrieves the list of storages for the specified folder.
[uploadObject](uploadObject.md) | Uploads the object to the specified storage.