---
editable: false
---

# Load Testing API, REST: Storage methods

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
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
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