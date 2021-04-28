---
editable: false
---

# TargetGroup

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folderId": "string",
  "labels": "object",
  "targets": [
    {
      "subnetId": "string",
      "ipAddress": "string"
    }
  ],
  "createdAt": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the target group.</p> 
name | **string**<br><p>The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the target group. 0-256 characters long.</p> 
folderId | **string**<br><p>ID of the folder that the target group belongs to.</p> 
labels | **object**<br><p>Resource labels as `key:value` pairs. Maximum of 64 per resource.</p> 
targets[] | **object**<br><p>NOTE: all endpoints must use the same address_type - either ip or hostname.</p> 
targets[].<br>subnetId | **string**<br><p>ID of the subnet that target connected to.</p> 
targets[].<br>ipAddress | **string**<br>
createdAt | **string** (date-time)<br><p>Creation timestamp for the target group.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addTargets](addTargets.md) | 
[create](create.md) | 
[delete](delete.md) | 
[get](get.md) | 
[list](list.md) | 
[listOperations](listOperations.md) | Lists operations for the specified target group.
[removeTargets](removeTargets.md) | 
[update](update.md) | 