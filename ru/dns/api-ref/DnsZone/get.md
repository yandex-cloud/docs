---
editable: false
sourcePath: en/_api-ref/dns/v1/api-ref/DnsZone/get.md
---

# Cloud DNS API, REST: DnsZone.get
Returns the specified DNS zone.
 
To get the list of all available DNS zones, make a [list](/docs/dns/api-ref/DnsZone/list) request.
 
## HTTP request {#https-request}
```
GET https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dnsZoneId | <p>Required. ID of the DNS zone to return.</p> <p>To get a DNS zone ID, make a <a href="/docs/dns/api-ref/DnsZone/list">list</a> request.</p> 
 
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
  "zone": "string",
  "privateVisibility": {
    "networkIds": [
      "string"
    ]
  },
  "publicVisibility": {},
  "deletionProtection": true
}
```
A DNS zone. For details about the concept, see [DNS zones](/docs/dns/concepts/dns-zone).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the DNS zone. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the DNS zone belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the DNS zone. The name is unique within the folder.</p> 
description | **string**<br><p>Description of the DNS zone.</p> 
labels | **object**<br><p>DNS zone labels as ``key:value`` pairs.</p> 
zone | **string**<br><p>DNS zone suffix.</p> 
privateVisibility | **object**<br><p>Privately visible zone settings. Specifies whether records within the zone are visible from a VPC networks only.</p> <p>Configuration for privately visible zones.</p> 
privateVisibility.<br>networkIds[] | **string**<br><p>Network IDs.</p> <p>The number of elements must be in the range 0-100. The string length in characters for each value must be equal to 20.</p> 
publicVisibility | **object**<br><p>Publicly visible zone settings. Indicates whether records within the zone are publicly visible.</p> <p>Configuration for publicly visible zones.</p> 
deletionProtection | **boolean** (boolean)<br><p>Prevents accidental zone removal.</p> 