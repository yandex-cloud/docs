---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Gateway/list.md
---

# Virtual Private Cloud API, REST: Gateway.list
Retrieves the list of Gateway resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/gateways
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list gateways in.</p> <p>To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/vpc/api-ref/Gateway/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/vpc/api-ref/Gateway/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters Gateway listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/vpc/api-ref/Gateway#representation">Gateway.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-gateway``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
gateways[] | **object**<br><p>List of gateways.</p> 
gateways[].<br>id | **string**<br><p>ID of the gateway. Generated at creation time.</p> 
gateways[].<br>folderId | **string**<br><p>ID of the folder that the gateway belongs to.</p> 
gateways[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
gateways[].<br>name | **string**<br><p>Name of the gateway. The name is unique within the folder. Value must match the regular expression ``\\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
gateways[].<br>description | **string**<br><p>Description of the gateway. 0-256 characters long.</p> 
gateways[].<br>labels | **object**<br><p>Gateway labels as ``key:value`` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\\@0-9a-z]*``. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\\@0-9a-z]*``.</p> 
gateways[].<br>sharedEgressGateway | **object**<br><p>Shared Egress Gateway configuration</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/vpc/api-ref/Gateway/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/vpc/api-ref/Gateway/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 