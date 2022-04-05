---
editable: false
sourcePath: en/_api-ref/vpc/api-ref/Network/list.md
---

# Method list
Retrieves the list of Network resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://vpc.api.cloud.yandex.net/vpc/v1/networks
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list networks in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/vpc/api-ref/Network/list#query_params), the service returns a [nextPageToken](/docs/vpc/api-ref/Network/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/vpc/api-ref/Network/list#query_params) to the [nextPageToken](/docs/vpc/api-ref/Network/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on the [Network.name](/docs/vpc/api-ref/Network#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
 
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
networks[] | **object**<br><p>A Network resource. For more information, see <a href="/docs/vpc/concepts/network">Networks</a>.</p> 
networks[].<br>id | **string**<br><p>ID of the network.</p> 
networks[].<br>folderId | **string**<br><p>ID of the folder that the network belongs to.</p> 
networks[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
networks[].<br>name | **string**<br><p>Name of the network. The name is unique within the folder. 3-63 characters long.</p> 
networks[].<br>description | **string**<br><p>Optional description of the network. 0-256 characters long.</p> 
networks[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
networks[].<br>defaultSecurityGroupId | **string**<br><p>ID of default security group for network.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/vpc/api-ref/Network/list#query_params">pageSize</a>, use the <a href="/docs/vpc/api-ref/Network/list#responses">nextPageToken</a> as the value for the <a href="/docs/vpc/api-ref/Network/list#query_params">pageToken</a> query parameter in the next list request. Subsequent list requests will have their own <a href="/docs/vpc/api-ref/Network/list#responses">nextPageToken</a> to continue paging through the results.</p> 