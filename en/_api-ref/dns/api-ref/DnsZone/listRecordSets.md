---
editable: false
---

# Method listRecordSets
Retrieves the list of record sets in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://dns.api.cloud.yandex.net/dns/v1/zones/{dnsZoneId}:listRecordSets
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dnsZoneId | ID of the DNS zone to list record sets in.   To get a DNS zone ID, make a [list](/docs/dns/api-ref/DnsZone/list) request.  The string length in characters must be equal to 20.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/dns/api-ref/DnsZone/listRecordSets#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set `page_token` to the  [nextPageToken](/docs/dns/api-ref/DnsZone/listRecordSets#responses) returned by a previous list request.  The maximum string length in characters is 1000.
filter | A filter expression that filters record sets listed in the response.  The expression must specify:  1. The field name. Currently you can use filtering only on the `name` and `type` fields.  2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. Example of a filter: `name=my-record-set`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "recordSets": [
    {
      "name": "string",
      "type": "string",
      "ttl": "string",
      "data": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
recordSets[] | **object**<br><p>A record set. For details about the concept, see <a href="/docs/dns/concepts/resource-record">Resource record</a>.</p> 
recordSets[].<br>name | **string**<br><p>Domain name.</p> <p>The string length in characters must be 1-254.</p> 
recordSets[].<br>type | **string**<br><p>Record type.</p> <p>The string length in characters must be 1-20.</p> 
recordSets[].<br>ttl | **string** (int64)<br><p>Time to live in seconds.</p> <p>Acceptable values are 0 to 2147483647, inclusive.</p> 
recordSets[].<br>data[] | **string**<br><p>Required. Data of the record set.</p> <p>The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/dns/api-ref/DnsZone/listRecordSets#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/dns/api-ref/DnsZone/listRecordSets#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 