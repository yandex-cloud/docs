---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Address/index.md
---

# Virtual Private Cloud API, REST: Address methods
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
  "type": "string",
  "ipVersion": "string",
  "deletionProtection": true,
  "dnsRecords": [
    {
      "fqdn": "string",
      "dnsZoneId": "string",
      "ttl": "string",
      "ptr": true
    }
  ],
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the address. The name is unique within the folder. Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``.</p> 
description | **string**<br><p>Description of the address. 0-256 characters long.</p> 
labels | **object**<br><p>Address labels as ``key:value`` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``.</p> 
reserved | **boolean** (boolean)<br><p>Specifies if address is reserved or not.</p> 
used | **boolean** (boolean)<br><p>Specifies if address is used or not.</p> 
type | **string**<br>Type of the IP address.<br><ul> <li>INTERNAL: Internal IP address.</li> <li>EXTERNAL: Public IP address.</li> </ul> 
ipVersion | **string**<br>Version of the IP address.<br><ul> <li>IPV4: IPv4 address.</li> <li>IPV6: IPv6 address.</li> </ul> 
deletionProtection | **boolean** (boolean)<br><p>Specifies if address protected from deletion.</p> 
dnsRecords[] | **object**<br><p>Optional DNS record specifications</p> 
dnsRecords[].<br>fqdn | **string**<br><p>DNS record name (absolute or relative to the DNS zone in use).</p> 
dnsRecords[].<br>dnsZoneId | **string**<br><p>ID of the public DNS zone.</p> 
dnsRecords[].<br>ttl | **string** (int64)<br><p>TTL of record.</p> 
dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>If the PTR record is required, this parameter must be set to "true".</p> 
externalIpv4Address | **object**
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
[move](move.md) | Move an address to another folder
[update](update.md) | Updates the specified address.