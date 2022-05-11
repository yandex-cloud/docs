---
editable: false
---

# Method list
Retrieves the list of Gateway resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/gateways
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list gateways in.  To get the folder ID use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/vpc/api-ref/Gateway/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/vpc/api-ref/Gateway/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters Gateway listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on [Gateway.name](/docs/vpc/api-ref/Gateway#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. Example of a filter: `name=my-gateway`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "gateways": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "sharedEgressGateway": {}
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
gateways[] | **object**<br><p>A Gateway resource. For more information, see <a href="/docs/vpc/concepts/gateway">Gateway</a>.</p> 
gateways[].<br>id | **string**<br><p>ID of the gateway. Generated at creation time.</p> 
gateways[].<br>folderId | **string**<br><p>ID of the folder that the gateway belongs to.</p> 
gateways[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
gateways[].<br>name | **string**<br><p>Name of the gateway. The name is unique within the folder.</p> 
gateways[].<br>description | **string**<br><p>Description of the gateway.</p> 
gateways[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
gateways[].<br>sharedEgressGateway | **object**<br><p>Shared Egress Gateway configuration</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/vpc/api-ref/Gateway/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/vpc/api-ref/Gateway/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 