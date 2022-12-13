---
editable: false
sourcePath: en/_api-ref/compute/api-ref/HostType/index.md
---

# Compute Cloud API, REST: HostType methods
Set of methods to view possible host configurations.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "cores": "string",
  "memory": "string",
  "disks": "string",
  "diskSize": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Unique type identifier.</p> 
cores | **string** (int64)<br><p>Total number of cores available for instances.</p> 
memory | **string** (int64)<br><p>Ammount of memory available for instances.</p> 
disks | **string** (int64)<br><p>Number of local disks available for instances</p> 
diskSize | **string** (int64)<br><p>Size of each local disk</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns information about specified host type.
[list](list.md) | List avaliable host types.