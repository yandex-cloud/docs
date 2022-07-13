---
editable: false
---

# Device
A set of methods for managing devices.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "registryId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "topicAliases": "object",
  "status": "string",
  "monitoringData": {
    "lastAuthIp": "string",
    "lastAuthTime": "string",
    "lastPubActivityTime": "string",
    "lastSubActivityTime": "string",
    "lastOnlineTime": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the device.</p> 
registryId | **string**<br><p>ID of the registry that the device belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the device. The name is unique within the registry.</p> 
description | **string**<br><p>Description of the device. 0-256 characters long.</p> 
topicAliases | **object**<br><p>Alias of a device topic.</p> <p>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. ``my/custom/alias`` match to ``$device/abcdef/events``.</p> 
status | **string**<br><p>Status of the device.</p> <ul> <li>CREATING: Device is being created.</li> <li>ACTIVE: Device is ready to use.</li> <li>DELETING: Device is being deleted.</li> </ul> 
monitoringData | **object**<br><p>Device monitoring data, returns if FULL view specified.</p> 
monitoringData.<br>lastAuthIp | **string**
monitoringData.<br>lastAuthTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
monitoringData.<br>lastPubActivityTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
monitoringData.<br>lastSubActivityTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
monitoringData.<br>lastOnlineTime | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 

## Methods {#methods}
Method | Description
--- | ---
[addCertificate](addCertificate.md) | Adds a certificate.
[addPassword](addPassword.md) | Adds password for the specified device.
[create](create.md) | Creates a device in the specified registry.
[delete](delete.md) | Deletes the specified device.
[deleteCertificate](deleteCertificate.md) | Deletes the specified device certificate.
[deletePassword](deletePassword.md) | Deletes the specified password.
[get](get.md) | Returns the specified device.
[getByName](getByName.md) | 
[list](list.md) | Retrieves the list of devices in the specified registry.
[listCertificates](listCertificates.md) | Retrieves the list of device certificates for the specified device.
[listOperations](listOperations.md) | Lists operations for the specified device.
[listPasswords](listPasswords.md) | Retrieves the list of passwords for the specified device.
[update](update.md) | Updates the specified device.