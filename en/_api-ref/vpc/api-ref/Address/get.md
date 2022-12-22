---
editable: false
---

# Virtual Private Cloud API, REST: Address.get
Returns the specified Address resource.
 
To get the list of all available Address resources, make a [list](/docs/vpc/api-ref/Address/list) request.
 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/addresses/{addressId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
addressId | <p>Required. ID of the Address resource to return.</p> <p>To get Address resource ID make a <a href="/docs/vpc/api-ref/Address/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
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
  "reserved": true,
  "used": true,
  "type": "string",
  "ipVersion": "string",
  "deletionProtection": true,
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
An Address resource. For more information, see [Address](/docs/vpc/concepts/address).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the address. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the address belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the address. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the address.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
reserved | **boolean** (boolean)<br><p>Specifies if address is reserved or not.</p> 
used | **boolean** (boolean)<br><p>Specifies if address is used or not.</p> 
type | **string**<br>Type of the IP address.<br><ul> <li>INTERNAL: Internal IP address.</li> <li>EXTERNAL: Public IP address.</li> </ul> 
ipVersion | **string**<br>Vervion of the IP address.<br><ul> <li>IPV4: IPv4 address.</li> <li>IPV6: IPv6 address.</li> </ul> 
deletionProtection | **boolean** (boolean)<br><p>Specifies if address protected from deletion.</p> 
externalIpv4Address | **object**
externalIpv4Address.<br>address | **string**<br><p>Value of address.</p> 
externalIpv4Address.<br>zoneId | **string**<br><p>Availability zone from which the address will be allocated.</p> 
externalIpv4Address.<br>requirements | **object**<br><p>Parameters of the allocated address, for example DDoS Protection.</p> 
externalIpv4Address.<br>requirements.<br>ddosProtectionProvider | **string**<br><p>DDoS protection provider ID.</p> 
externalIpv4Address.<br>requirements.<br>outgoingSmtpCapability | **string**<br><p>Capability to send SMTP traffic.</p> 