---
editable: false
---

# Compute Cloud API, REST: Zone.get
Returns the information about the specified availability zone.
 
To get the list of availability zones, make a [list](/docs/compute/api-ref/Zone/list) request.
 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/zones/{zoneId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
zoneId | <p>Required. ID of the availability zone to return information about.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "regionId": "string",
  "status": "string"
}
```
Availability zone. For more information, see [Availability zones](/docs/overview/concepts/geo-scope).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the zone.</p> 
regionId | **string**<br><p>ID of the region.</p> 
status | **string**<br><p>Status of the zone.</p> <ul> <li>UP: Zone is available. You can access the resources allocated in this zone.</li> <li>DOWN: Zone is not available.</li> </ul> 