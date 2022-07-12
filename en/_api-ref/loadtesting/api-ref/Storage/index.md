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
id | **string**<br>
folderId | **string**<br>
name | **string**<br>
description | **string**<br>
labels | **object**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
objectStorageBucket | **string**<br>
usedSize | **string** (int64)<br>

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a storage for the specified folder.
[delete](delete.md) | Deletes the specified storage
[get](get.md) | Returns the specified storage.
[list](list.md) | Retrieves the list of storages for the specified folder.
[uploadObject](uploadObject.md) | Uploads the object to the specified storage.