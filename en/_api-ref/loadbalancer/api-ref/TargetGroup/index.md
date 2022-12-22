---
editable: false
---

# Network Load Balancer API, REST: TargetGroup methods
A set of methods for managing TargetGroup resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "regionId": "string",
  "targets": [
    {
      "subnetId": "string",
      "address": "string"
    }
  ]
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the target group.</p> 
folderId | **string**<br><p>ID of the folder that the target group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the target group. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the target group. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
regionId | **string**<br><p>ID of the region where the target group resides.</p> 
targets[] | **object**<br><p>A list of targets in the target group.</p> 
targets[].<br>subnetId | **string**<br><p>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>address | **string**<br><p>IP address of the target.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addTargets](addTargets.md) | Adds targets to the target group.
[create](create.md) | Creates a target group in the specified folder and adds the specified targets to it.
[delete](delete.md) | Deletes the specified target group.
[get](get.md) | Returns the specified TargetGroup resource.
[list](list.md) | Retrieves the list of TargetGroup resources in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified target group.
[removeTargets](removeTargets.md) | Removes targets from the target group.
[update](update.md) | Updates the specified target group.