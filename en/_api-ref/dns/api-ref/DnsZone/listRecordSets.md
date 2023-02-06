---
editable: false
---

# Cloud DNS API, REST: DnsZone.listRecordSets
Retrieves the list of record sets in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://dns.{{ api-host }}/dns/v1/zones/{dnsZoneId}:listRecordSets
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dnsZoneId | <p>ID of the DNS zone to list record sets in.</p> <p>To get a DNS zone ID, make a <a href="/docs/dns/api-ref/DnsZone/list">list</a> request.</p> <p>The string length in characters must be equal to 20.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/dns/api-ref/DnsZone/listRecordSets#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/dns/api-ref/DnsZone/listRecordSets#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 1000.</p> 
filter | <p>A filter expression that filters record sets listed in the response. The expression consists of one or more conditions united by ``AND`` operator: ``<condition1> [AND <condition2> [<...> AND <conditionN>]]``.</p> <p>Each condition has the form ``<field> <operator> <value>``, where:</p> <ol> <li>``<field>`` is the field name. Currently you can use filtering only on the ``name`` and ``type`` fields.</li> <li>``<operator>`` is a logical operator, one of ``=``, ``!=``, ``IN``, ``NOT IN``.</li> <li>``<value>`` represents a value. 3.1. In case of single value condition (``=`` or ``!=``), the value is a string in double (``"``) or single (``'``) quotes. C-style escape sequences are supported (``\"`` turns to ``"``, ``\'`` to ``'``, ``\\`` to backslash). 3.2. In case of a list of values condition (``IN`` or ``NOT IN``), the value is ``(<string1>, <string2>, .., <stringN>)``, where ``<string>`` is a string in double (``"``) or single (``'``) quotes.</li> </ol> <p>Examples of a filter: ``name="my-record-set"``, ``type IN ("MX","A") AND name="works.on.my.machine."``.</p> <p>The maximum string length in characters is 1000.</p> 
 
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
recordSets[] | **object**<br><p>List of record sets in the specified DNS zone.</p> 
recordSets[].<br>name | **string**<br><p>Domain name.</p> <p>The string length in characters must be 1-254.</p> 
recordSets[].<br>type | **string**<br><p>Record type.</p> <p>The string length in characters must be 1-20.</p> 
recordSets[].<br>ttl | **string** (int64)<br><p>Time to live in seconds.</p> <p>Acceptable values are 0 to 2147483647, inclusive.</p> 
recordSets[].<br>data[] | **string**<br><p>Required. Data of the record set.</p> <p>The number of elements must be in the range 1-100. The string length in characters for each value must be 1-255.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/dns/api-ref/DnsZone/listRecordSets#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/dns/api-ref/DnsZone/listRecordSets#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 