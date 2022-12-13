---
editable: false
---

# Compute Cloud API, REST: Zone methods
A set of methods to retrieve information about availability zones.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "regionId": "string",
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the zone.</p> 
regionId | **string**<br><p>ID of the region.</p> 
status | **string**<br><p>Status of the zone.</p> <ul> <li>UP: Zone is available. You can access the resources allocated in this zone.</li> <li>DOWN: Zone is not available.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the information about the specified availability zone.
[list](list.md) | Retrieves the list of availability zones.