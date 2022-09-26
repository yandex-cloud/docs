---
editable: false
sourcePath: en/_api-ref/dns/api-ref/DnsZone/list.md
---

# Method list
Retrieves the list of DNS zones in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://dns.{{ api-host }}/dns/v1/zones
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list DNS zones in.</p> <p>To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/dns/api-ref/DnsZone/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/dns/api-ref/DnsZone/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 1000.</p> 
filter | <p>A filter expression that filters DNS zones listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on the <a href="/docs/dns/api-ref/DnsZone#representation">DnsZone.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-dns-zone``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "dnsZones": [
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
      "publicVisibility": {}
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
dnsZones[] | **object**<br><p>List of DNS zones in the specified folder.</p> 
dnsZones[].<br>id | **string**<br><p>ID of the DNS zone. Generated at creation time.</p> 
dnsZones[].<br>folderId | **string**<br><p>ID of the folder that the DNS zone belongs to.</p> 
dnsZones[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
dnsZones[].<br>name | **string**<br><p>Name of the DNS zone. The name is unique within the folder.</p> 
dnsZones[].<br>description | **string**<br><p>Description of the DNS zone.</p> 
dnsZones[].<br>labels | **object**<br><p>DNS zone labels as ``key:value`` pairs.</p> 
dnsZones[].<br>zone | **string**<br><p>DNS zone suffix.</p> 
dnsZones[].<br>privateVisibility | **object**<br><p>Privately visible zone settings. Specifies whether records within the zone are visible from a VPC networks only.</p> <p>Configuration for privately visible zones.</p> 
dnsZones[].<br>privateVisibility.<br>networkIds[] | **string**<br><p>Network IDs.</p> <p>The number of elements must be in the range 0-100. The string length in characters for each value must be equal to 20.</p> 
dnsZones[].<br>publicVisibility | **object**<br><p>Publicly visible zone settings. Indicates whether records within the zone are publicly visible.</p> <p>Configuration for publicly visible zones.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/dns/api-ref/DnsZone/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/dns/api-ref/DnsZone/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 