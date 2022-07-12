---
editable: false
---

# Method get
Returns the specified desktop group resource.
 
To get the list of available desktop groups, make a [list](/docs/cloud-desktop/api-ref/DesktopGroup/list) request.
 
## HTTP request {#https-request}
```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups/{desktopGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
desktopGroupId | <p>Required. ID of the desktop group resource to return.</p> <p>To get the desktop group ID use a <a href="/docs/cloud-desktop/api-ref/DesktopGroup/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "status": "string",
  "name": "string",
  "description": "string",
  "resourcesSpec": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "networkInterfaceSpec": {
    "networkId": "string",
    "subnetIds": [
      "string"
    ]
  }
}
```
A desktop group resource.
 
Field | Description
--- | ---
id | **string**<br><p>Desktop group ID.</p> 
folderId | **string**<br><p>ID of the folder that the desktop group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
status | **string**<br><p>Status of the desktop group.</p> <ul> <li>CREATING: Desktop group is being created.</li> <li>ACTIVE: Desktop group is ready to use.</li> <li>DELETING: Desktop group is being deleted.</li> </ul> 
name | **string**<br><p>Name of the desktop group.</p> 
description | **string**<br><p>Description of the desktop group.</p> 
resourcesSpec | **object**<br><p>Resource specification of the desktop group.</p> 
resourcesSpec.<br>memory | **string** (int64)<br><p>RAM volume, in bytes.</p> <p>The minimum value is 1.</p> 
resourcesSpec.<br>cores | **string** (int64)<br><p>Number of CPU cores.</p> <p>The minimum value is 1.</p> 
resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
networkInterfaceSpec | **object**<br><p>Network interface specification of the desktop group.</p> 
networkInterfaceSpec.<br>networkId | **string**<br><p>Required. ID of the network interface specification.</p> <p>The maximum string length in characters is 50.</p> 
networkInterfaceSpec.<br>subnetIds[] | **string**<br><p>Required. List of subnet IDs.</p> <p>Must contain at least one element. The maximum string length in characters for each value is 50.</p> 