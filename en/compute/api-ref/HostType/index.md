---
editable: false
sourcePath: en/_api-ref/compute/api-ref/HostType/index.md
---


# HostType
Set of methods to view possible host configurations.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "cores": "string",
  "memory": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Unique type identifier.</p> 
cores | **string** (int64)<br><p>Total number of cores available for instances.</p> 
memory | **string** (int64)<br><p>Ammount of memory available for instances.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns information about specified host type.
[list](list.md) | List avaliable host types.