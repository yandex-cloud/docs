---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Address/list.md
---

# Virtual Private Cloud API, REST: Address.list
Retrieves the list of Address resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/addresses
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list addresses in.</p> <p>To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/vpc/api-ref/Address/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/vpc/api-ref/Address/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters Address listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/vpc/api-ref/Address#representation">Address.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-address``.</li> </ol> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "addresses": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
addresses[] | **object**<br><p>List of addresses.</p> 
addresses[].<br>id | **string**<br><p>ID of the address. Generated at creation time.</p> 
addresses[].<br>folderId | **string**<br><p>ID of the folder that the address belongs to.</p> 
addresses[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
addresses[].<br>name | **string**<br><p>Name of the address. The name is unique within the folder.</p> 
addresses[].<br>description | **string**<br><p>Description of the address.</p> 
addresses[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
addresses[].<br>reserved | **boolean** (boolean)<br><p>Specifies if address is reserved or not.</p> 
addresses[].<br>used | **boolean** (boolean)<br><p>Specifies if address is used or not.</p> 
addresses[].<br>type | **string**<br>Type of the IP address.<br><ul> <li>INTERNAL: Internal IP address.</li> <li>EXTERNAL: Public IP address.</li> </ul> 
addresses[].<br>ipVersion | **string**<br>Version of the IP address.<br><ul> <li>IPV4: IPv4 address.</li> <li>IPV6: IPv6 address.</li> </ul> 
addresses[].<br>deletionProtection | **boolean** (boolean)<br><p>Specifies if address protected from deletion.</p> 
addresses[].<br>dnsRecords[] | **object**<br><p>Optional DNS record specifications</p> 
addresses[].<br>dnsRecords[].<br>fqdn | **string**<br><p>DNS record name (absolute or relative to the DNS zone in use).</p> 
addresses[].<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>ID of the public DNS zone.</p> 
addresses[].<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>TTL of record.</p> 
addresses[].<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>If the PTR record is required, this parameter must be set to "true".</p> 
addresses[].<br>externalIpv4Address | **object**
addresses[].<br>externalIpv4Address.<br>address | **string**<br><p>Value of address.</p> 
addresses[].<br>externalIpv4Address.<br>zoneId | **string**<br><p>Availability zone from which the address will be allocated.</p> 
addresses[].<br>externalIpv4Address.<br>requirements | **object**<br><p>Parameters of the allocated address, for example DDoS Protection.</p> 
addresses[].<br>externalIpv4Address.<br>requirements.<br>ddosProtectionProvider | **string**<br><p>DDoS protection provider ID.</p> 
addresses[].<br>externalIpv4Address.<br>requirements.<br>outgoingSmtpCapability | **string**<br><p>Capability to send SMTP traffic.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/vpc/api-ref/Address/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/vpc/api-ref/Address/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 