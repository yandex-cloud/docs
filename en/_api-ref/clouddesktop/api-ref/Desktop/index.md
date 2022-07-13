---
editable: false
---

# Desktop
A set of methods for managing desktop resources.
## JSON Representation {#representation}
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

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates desktop in the specified folder.
[delete](delete.md) | Deletes the specified desktop.
[get](get.md) | Returns the specified desktop resource.
[getRdpFile](getRdpFile.md) | Returns a RDP file for the specified desktop.
[list](list.md) | Retrieves the list of desktop resources.
[listOperations](listOperations.md) | Returns list of the operations for the specified desktop.
[resetPassword](resetPassword.md) | Reset password