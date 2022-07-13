---
editable: false
sourcePath: en/_api-ref/dns/api-ref/DnsZone/getRecordSet.md
---

# Method getRecordSet
Returns the specified record set.
 

 
## HTTP request {#https-request}
```
GET https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:getRecordSet
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dnsZoneId | <p>ID of the DNS zone to get record set from.</p> <p>To get a DNS zone ID, make a <a href="/docs/dns/api-ref/DnsZone/list">list</a> request.</p> <p>The string length in characters must be equal to 20.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
name | <p>Required. Name of the record set.</p> <p>The maximum string length in characters is 255.</p> 
type | <p>Required. Type of the record set.</p> <p>The maximum string length in characters is 10.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "type": "string",
  "ttl": "string",
  "data": [
    "string"
  ]
}
```
A record set. For details about the concept, see [Resource record](/docs/dns/concepts/resource-record).
 
Field | Description
--- | ---
name | **string**<br><p>Domain name.</p> <p>The string length in characters must be 1-254.</p> 
type | **string**<br><p>Record type.</p> <p>The string length in characters must be 1-20.</p> 
ttl | **string** (int64)<br><p>Time to live in seconds.</p> <p>Acceptable values are 0 to 2147483647, inclusive.</p> 
data[] | **string**<br><p>Required. Data of the record set.</p> <p>The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.</p> 