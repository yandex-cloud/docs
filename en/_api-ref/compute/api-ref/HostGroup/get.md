---
editable: false
---

# Compute Cloud API, REST: HostGroup.get
Returns the specified host group.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/hostGroups/{hostGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
hostGroupId | <p>Required. ID of the host group to return. To get the host group ID, use <a href="/docs/compute/api-ref/HostGroup/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
  "zoneId": "string",
  "status": "string",
  "typeId": "string",
  "maintenancePolicy": "string",
  "scalePolicy": {
    "fixedScale": {
      "size": "string"
    }
  }
}
```
Represents group of dedicated hosts
 
Field | Description
--- | ---
id | **string**<br><p>ID of the group.</p> 
folderId | **string**<br><p>ID of the folder that the group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the group. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the group.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
zoneId | **string**<br><p>Availability zone where all dedicated hosts are allocated.</p> 
status | **string**<br><p>Status of the group.</p> 
typeId | **string**<br><p>ID of host type. Resources provided by each host of the group.</p> 
maintenancePolicy | **string**<br><p>Behaviour on maintenance events.</p> <ul> <li>RESTART: Restart instances on the same host after maintenance event.</li> <li>MIGRATE: Migrate instances to another host before maintenance event.</li> </ul> 
scalePolicy | **object**<br><p>Scale policy. Only fixed number of hosts are supported at this moment.</p> 
scalePolicy.<br>fixedScale | **object**
scalePolicy.<br>fixedScale.<br>size | **string** (int64)