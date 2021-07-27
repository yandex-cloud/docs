---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# DiskType
A set of methods to retrieve information about disk types.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "description": "string",
  "zoneIds": [
    "string"
  ]
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the disk type.</p> 
description | **string**<br><p>Description of the disk type. 0-256 characters long.</p> 
zoneIds[] | **string**<br><p>Array of availability zones where the disk type is available.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the information about specified disk type.
[list](list.md) | Retrieves the list of disk types for the specified folder.