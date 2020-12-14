---
editable: false
---

# Address
A set of methods for managing Address resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "reserved": true,
  "used": true,
  "externalIpv4Address": {
    "address": "string",
    "zoneId": "string",
    "requirements": {
      "ddosProtectionProvider": "string",
      "outgoingSmtpCapability": "string"
    }
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the address. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the address belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the address. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the address.</p> 
labels | **object**<br><p>Resource labels as `key:value` pairs.</p> 
reserved | **boolean** (boolean)<br><p>Specifies if address is reserved or not.</p> 
used | **boolean** (boolean)<br><p>Specifies if address is used or not.</p> 
externalIpv4Address | **object**<br>
externalIpv4Address.<br>address | **string**<br><p>Value of address.</p> 
externalIpv4Address.<br>zoneId | **string**<br><p>Availability zone from which the address will be allocated.</p> 
externalIpv4Address.<br>requirements | **object**<br><p>Parameters of the allocated address, for example DDoS Protection.</p> 
externalIpv4Address.<br>requirements.<br>ddosProtectionProvider | **string**<br><p>DDoS protection provider ID.</p> 
externalIpv4Address.<br>requirements.<br>outgoingSmtpCapability | **string**<br><p>Capability to send SMTP traffic.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates an address in the specified folder and network.
[delete](delete.md) | Deletes the specified address.
[get](get.md) | Returns the specified Address resource.
[getByValue](getByValue.md) | Returns the specified Address resource by a given value.
[list](list.md) | Retrieves the list of Address resources in the specified folder.
[listOperations](listOperations.md) | List operations for the specified address.
[update](update.md) | Updates the specified address.