---
editable: false
---

# Method get
Returns the specified resource name.
 
To get the list of all available resource names, make a [list](/docs/service-name/api-ref/ResourceName/list) request.
 
## HTTP request {#https-request}
```
GET https://servicename.{{ api-host }}/servicename/v1/resourceNames/{resourceNameId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourceNameId | <p>Required. ID of the resource name to return.</p> <p>To get a resource name ID make a <a href="/docs/service-name/api-ref/ResourceName/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
  "status": "string"
}
```
A resource name. For details about the concept, see [documentation](/docs/service-name/concepts/resource-name).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the resource name. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the resource name belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the resource name. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the resource name.</p> 
labels | **object**<br><p>Resource name labels as ``key:value`` pairs.</p> 
zoneId | **string**<br><p>ID of the availability zone where the resource name resides.</p> 
status | **string**<br><p>Status of the resource name.</p> <ul> <li>CREATING: Resource name is being created.</li> <li>READY: Resource name is ready to use.</li> <li>ERROR: Resource name encountered a problem and cannot operate.</li> <li>DELETING: Resource name is being deleted.</li> </ul> 