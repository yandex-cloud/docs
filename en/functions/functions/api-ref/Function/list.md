---
editable: false
---

# Method list
Retrieves the list of functions in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.api.cloud.yandex.net/functions/v1/functions
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list functions in.  To get a folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [nextPageToken](/docs/functions/functions/api-ref/Function/list#responses) that can be used to get the next page of results in subsequent list requests.  Default value: 100.
pageToken | Page token. To get the next page of results, set `pageToken` to the [nextPageToken](/docs/functions/functions/api-ref/Function/list#responses) returned by a previous list request.
filter | A filter expression that filters functions listed in the response.  The expression must specify: 1. The field name. Currently filtering can only be applied to the [Function.name](/docs/functions/functions/api-ref/Function#representation) field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Example of a filter: `name=my-function`.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "functions": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "logGroupId": "string",
      "httpInvokeUrl": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
functions[] | **object**<br><p>A serverless function. For details about the concept, see <a href="/docs/functions/concepts/function">Functions</a>.</p> 
functions[].<br>id | **string**<br><p>ID of the function. Generated at creation time.</p> 
functions[].<br>folderId | **string**<br><p>ID of the folder that the function belongs to.</p> 
functions[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the function.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
functions[].<br>name | **string**<br><p>Name of the function. The name is unique within the folder.</p> <p>The string length in characters must be 3-63.</p> 
functions[].<br>description | **string**<br><p>Description of the function.</p> <p>The string length in characters must be 0-256.</p> 
functions[].<br>labels | **object**<br><p>Function labels as `key:value` pairs.</p> <p>No more than 64 per resource.</p> 
functions[].<br>logGroupId | **string**<br><p>ID of the log group for the function.</p> 
functions[].<br>httpInvokeUrl | **string**<br><p>URL that needs to be requested to invoke the function.</p> 
functions[].<br>status | **string**<br><p>Status of the function.</p> <ul> <li>CREATING: Function is being created.</li> <li>ACTIVE: Function is ready to be invoked.</li> <li>DELETING: Function is being deleted.</li> <li>ERROR: Function failed.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/functions/api-ref/Function/list#query_params">pageSize</a>, use `nextPageToken` as the value for the <a href="/docs/functions/functions/api-ref/Function/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own `nextPageToken` to continue paging through the results.</p> 