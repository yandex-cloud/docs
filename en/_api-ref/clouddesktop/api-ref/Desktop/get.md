---
editable: false
---

# Method get
Returns the specified desktop resource.
 
To get the list of available desktops, make a [list](/docs/cloud-desktop/api-ref/Desktop/list) request.
 
## HTTP request {#https-request}
```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktops/{desktopId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
desktopId | <p>Required. ID of the desktop resource to return.</p> <p>To get the desktop ID use a <a href="/docs/cloud-desktop/api-ref/Desktop/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "desktopGroupId": "string",
  "createdAt": "string",
  "status": "string",
  "name": "string",
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "networkInterfaces": [
    {
      "networkId": "string",
      "subnetId": "string"
    }
  ],
  "users": [
    {
      "subjectId": "string"
    }
  ]
}
```
A desktop resource.
 
Field | Description
--- | ---
id | **string**<br><p>Desktop ID.</p> 
folderId | **string**<br><p>ID of the folder that the desktop belongs to.</p> 
desktopGroupId | **string**<br><p>ID of the desktop group that the desktop belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
status | **string**<br><p>Status of the desktop.</p> <ul> <li>CREATING: Desktop is being created.</li> <li>ACTIVE: Desktop is ready to use.</li> <li>DELETING: Desktop is being deleted.</li> </ul> 
name | **string**<br><p>Name of the desktop.</p> 
resources | **object**<br><p>Resources of the desktop.</p> 
resources.<br>memory | **string** (int64)<br><p>The minimum value is 1.</p> 
resources.<br>cores | **string** (int64)<br><p>The minimum value is 1.</p> 
resources.<br>coreFraction | **string** (int64)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
networkInterfaces[] | **object**
networkInterfaces[].<br>networkId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
networkInterfaces[].<br>subnetId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
users[] | **object**
users[].<br>subjectId | **string**<br><p>Required. Identity of the access binding.</p> 