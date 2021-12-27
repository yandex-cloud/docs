---
editable: false
sourcePath: en/_api-ref/apploadbalancer/api-ref/TargetGroup/get.md
---


# Method get
Returns the specified target group.
 
To get the list of all available target groups, make a [list](/docs/application-load-balancer/api-ref/TargetGroup/list) request.
 
## HTTP request {#https-request}
```
GET https://alb.api.cloud.yandex.net/apploadbalancer/v1/targetGroups/{targetGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
targetGroupId | Required. ID of the target group to return.  To get the target group ID, make a [list](/docs/application-load-balancer/api-ref/TargetGroup/list) request.
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
A target group resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the target group. Generated at creation time.</p> 
name | **string**<br><p>Name of the target group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the target group.</p> 
folderId | **string**<br><p>ID of the folder that the target group belongs to.</p> 
labels | **object**<br><p>Target group labels as ``key:value`` pairs. For details about the concept, see <a href="/docs/overview/concepts/services#labels">documentation</a>.</p> 
targets[] | **object**<br><p>A target resource. For details about the concept, see <a href="/docs/application-load-balancer/concepts/target-group">documentation</a>.</p> 
targets[].<br>subnetId | **string**<br><p>ID of the subnet that the target is connected to.</p> 
targets[].<br>privateIpv4Address | **boolean** (boolean)<br><p>If set, will not require ``subnet_id`` to validate the target. Instead, the address should belong to one of the following ranges: 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 Only one of ``subnet_id`` or ``private_ipv4_address`` should be set.</p> 
targets[].<br>ipAddress | **string**<br><p>IP address of the target.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 