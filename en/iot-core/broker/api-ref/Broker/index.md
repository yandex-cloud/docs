---
editable: false
sourcePath: en/_api-ref/iot/broker/v1/broker/api-ref/Broker/index.md
---

# IoT Core Broker Service, REST: Broker methods
A set of methods for managing broker.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the broker.</p> 
folderId | **string**<br><p>ID of the folder that the broker belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the broker. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the broker. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
status | **string**<br><p>Status of the broker.</p> <ul> <li>CREATING: Broker is being created.</li> <li>ACTIVE: Broker is ready to use.</li> <li>DELETING: Broker is being deleted.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[addCertificate](addCertificate.md) | Adds a certificate.
[addPassword](addPassword.md) | Adds password for the specified broker.
[create](create.md) | Creates a broker in the specified folder.
[delete](delete.md) | Deletes the specified broker.
[deleteCertificate](deleteCertificate.md) | Deletes the specified broker certificate.
[deletePassword](deletePassword.md) | Deletes the specified password.
[get](get.md) | Returns the specified broker.
[list](list.md) | Retrieves the list of brokers in the specified folder.
[listCertificates](listCertificates.md) | Retrieves the list of broker certificates for the specified broker.
[listOperations](listOperations.md) | Lists operations for the specified broker.
[listPasswords](listPasswords.md) | Retrieves the list of passwords for the specified broker.
[update](update.md) | Updates the specified broker.