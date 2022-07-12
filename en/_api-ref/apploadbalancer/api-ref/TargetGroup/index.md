---
editable: false
---

# TargetGroup
A set of methods for managing target groups.
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
      "privateIpv4Address": true,
      "ipAddress": "string"
    }
  ],
  "createdAt": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the target group. Generated at creation time.</p> 
name | **string**<br><p>Name of the target group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the target group.</p> 
folderId | **string**<br><p>ID of the folder that the target group belongs to.</p> 
labels | **object**<br><p>Target group labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
targets[] | **object**<br><p>List of targets in the target group.</p> 
targets[].<br>subnetId | **string**<br><p>ID of the subnet that the target is connected to.</p> 
targets[].<br>privateIpv4Address | **boolean** (boolean)<br><p>If set, will not require ``subnet_id`` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of ``subnet_id`` or ``private_ipv4_address`` should be set.</p> 
targets[].<br>ipAddress | **string**<br><p>IP address of the target.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addTargets](addTargets.md) | Adds targets to the specified target group.
[create](create.md) | Creates a target group in the specified folder.
[delete](delete.md) | Deletes the specified target group.
[get](get.md) | Returns the specified target group.
[list](list.md) | Lists target groups in the specified folder.
[listOperations](listOperations.md) | Lists operations for the specified target group.
[removeTargets](removeTargets.md) | Removes targets from the specified target group.
[update](update.md) | Updates the specified target group.