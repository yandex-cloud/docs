---
editable: false
---

# Method get
Returns the specified TargetGroup resource.
 

 
## HTTP request {#https-request}
```
GET https://load-balancer.{{ api-host }}/load-balancer/v1/targetGroups/{targetGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
targetGroupId | <p>Required. ID of the TargetGroup resource to return. To get the target group ID, use a <a href="/docs/network-load-balancer/api-ref/TargetGroup/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
A TargetGroup resource. For more information, see [Target groups and resources](/docs/network-load-balancer/target-resources).
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the target group.</p> 
folderId | **string**<br><p>ID of the folder that the target group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Output only. Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the target group. The name is unique within the folder. 3-63 characters long.</p> 
description | **string**<br><p>Description of the target group. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
regionId | **string**<br><p>ID of the region where the target group resides.</p> 
targets[] | **object**<br><p>A list of targets in the target group.</p> 
targets[].<br>subnetId | **string**<br><p>ID of the subnet that targets are connected to. All targets in the target group must be connected to the same subnet within a single availability zone.</p> <p>The maximum string length in characters is 50.</p> 
targets[].<br>address | **string**<br><p>IP address of the target.</p> 