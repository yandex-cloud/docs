---
editable: false
---

# Cloud Desktop API, REST: DesktopGroup methods
A set of methods for managing desktop group resources.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>Desktop group ID.</p> 
folderId | **string**<br><p>ID of the folder that the desktop group belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
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

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates desktop group in the specified folder.
[delete](delete.md) | Deletes the specified desktop group.
[get](get.md) | Returns the specified desktop group resource.
[list](list.md) | Retrieves the list of desktop group resources.
[listAccessBindings](listAccessBindings.md) | Returns a list of the access bindings for the specified desktop group.
[listDesktops](listDesktops.md) | Retrieves the list of desktops resources.
[listOperations](listOperations.md) | Returns list of the operations for the specified desktop group.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified desktop group.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings of the specified desktop group.