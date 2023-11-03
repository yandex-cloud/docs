---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/HostGroup/index.md
---

# Compute Cloud API, REST: HostGroup methods
A set of methods for managing groups of dedicated hosts.
## JSON Representation {#representation}
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

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a host group in the specified folder.
[delete](delete.md) | Deletes the specified host group.
[get](get.md) | Returns the specified host group.
[list](list.md) | Retrieves the list of host groups in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists access bindings for the host group.
[listHosts](listHosts.md) | Lists hosts that belongs to the specified host group.
[listInstances](listInstances.md) | Lists instances that belongs to the specified host group.
[listOperations](listOperations.md) | Lists operations for the specified host group.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the host group.
[update](update.md) | Updates the specified host group.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the host group.
[updateHost](updateHost.md) | Update host