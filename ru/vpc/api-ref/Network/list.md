---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Network/list.md
---

# Virtual Private Cloud API, REST: Network.list
Retrieves the list of Network resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://vpc.{{ api-host }}/vpc/v1/networks
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list networks in. To get the folder ID, use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/vpc/api-ref/Network/list#query_params">pageSize</a>, the service returns a <a href="/docs/vpc/api-ref/Network/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/vpc/api-ref/Network/list#query_params">pageToken</a> to the <a href="/docs/vpc/api-ref/Network/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on the <a href="/docs/vpc/api-ref/Network#representation">Network.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "networks": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "defaultSecurityGroupId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
networks[] | **object**<br><p>List of Network resources.</p> 
networks[].<br>id | **string**<br><p>ID of the network.</p> 
networks[].<br>folderId | **string**<br><p>ID of the folder that the network belongs to.</p> 
networks[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
networks[].<br>name | **string**<br><p>Name of the network. The name is unique within the folder. Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``.</p> 
networks[].<br>description | **string**<br><p>Optional description of the network. 0-256 characters long.</p> 
networks[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``.</p> 
networks[].<br>defaultSecurityGroupId | **string**<br><p>ID of default security group for network.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/vpc/api-ref/Network/list#query_params">pageSize</a>, use the <a href="/docs/vpc/api-ref/Network/list#responses">nextPageToken</a> as the value for the <a href="/docs/vpc/api-ref/Network/list#query_params">pageToken</a> query parameter in the next list request. Subsequent list requests will have their own <a href="/docs/vpc/api-ref/Network/list#responses">nextPageToken</a> to continue paging through the results.</p> 