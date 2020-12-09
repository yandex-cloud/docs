---
editable: false
---

# Method list
Retrieves the list of Address resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/addresses
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list addresses in.  To get the folder ID use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/vpc/api-ref/Address/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set `page_token` to the  [nextPageToken](/docs/vpc/api-ref/Address/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters Address listed in the response.  The expression must specify:  1. The field name. Currently you can use filtering only on [Address.name](/docs/vpc/api-ref/Address#representation) field.  2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Example of a filter: `name=my-address`.
 
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
addresses[] | **object**<br><p>An Address resource. For more information, see <a href="/docs/vpc/concepts/address">Address</a>.</p> 
addresses[].<br>id | **string**<br><p>ID of the address. Generated at creation time.</p> 
addresses[].<br>folderId | **string**<br><p>ID of the folder that the address belongs to.</p> 
addresses[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
addresses[].<br>name | **string**<br><p>Name of the address. The name is unique within the folder.</p> 
addresses[].<br>description | **string**<br><p>Description of the address.</p> 
addresses[].<br>labels | **object**<br><p>Resource labels as `key:value` pairs.</p> 
addresses[].<br>reserved | **boolean** (boolean)<br><p>Specifies if address is reserved or not.</p> 
addresses[].<br>used | **boolean** (boolean)<br><p>Specifies if address is used or not.</p> 
addresses[].<br>externalIpv4Address | **object**<br>
addresses[].<br>externalIpv4Address.<br>address | **string**<br><p>Value of address.</p> 
addresses[].<br>externalIpv4Address.<br>zoneId | **string**<br><p>Availability zone from which the address will be allocated.</p> 
addresses[].<br>externalIpv4Address.<br>requirements | **object**<br><p>Parameters of the allocated address, for example DDoS Protection.</p> 
addresses[].<br>externalIpv4Address.<br>requirements.<br>ddosProtectionProvider | **string**<br><p>DDoS protection provider ID.</p> 
addresses[].<br>externalIpv4Address.<br>requirements.<br>outgoingSmtpCapability | **string**<br><p>Capability to send SMTP traffic.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/vpc/api-ref/Address/list#query_params">pageSize</a>, use `next_page_token` as the value for the <a href="/docs/vpc/api-ref/Address/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own `next_page_token` to continue paging through the results.</p> 