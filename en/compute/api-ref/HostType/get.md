---
editable: false
sourcePath: en/_api-ref/compute/api-ref/HostType/get.md
---

# Method get
Returns information about specified host type.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/hostTypes/{hostTypeId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
hostTypeId | <p>Required. ID of the host type to return.</p> <p>To get a host type ID make a <a href="/docs/compute/api-ref/HostType/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "cores": "string",
  "memory": "string",
  "disks": "string",
  "diskSize": "string"
}
```
Represents host resources.
Note: Platform can use hosts with different number of memory and cores.
TODO: Do we need sockets here?
 
Field | Description
--- | ---
id | **string**<br><p>Unique type identifier.</p> 
cores | **string** (int64)<br><p>Total number of cores available for instances.</p> 
memory | **string** (int64)<br><p>Ammount of memory available for instances.</p> 
disks | **string** (int64)<br><p>Number of local disks available for instances</p> 
diskSize | **string** (int64)<br><p>Size of each local disk</p> 