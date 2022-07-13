---
editable: false
sourcePath: en/_api-ref/serverless/functions/functions/api-ref/Function/get.md
---

# Method get
Returns the specified function.
 
To get the list of all available functions, make a [list](/docs/functions/functions/api-ref/Function/list) request.
 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/functions/{functionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionId | <p>Required. ID of the function to return.</p> <p>To get a function ID make a <a href="/docs/functions/functions/api-ref/Function/list">list</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
A serverless function. For details about the concept, see [Functions](/docs/functions/concepts/function).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the function. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the function belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the function.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the function. The name is unique within the folder.</p> <p>The string length in characters must be 3-63.</p> 
description | **string**<br><p>Description of the function.</p> <p>The string length in characters must be 0-256.</p> 
labels | **object**<br><p>Function labels as ``key:value`` pairs.</p> <p>No more than 64 per resource.</p> 
logGroupId | **string**<br><p>ID of the log group for the function.</p> 
httpInvokeUrl | **string**<br><p>URL that needs to be requested to invoke the function.</p> 
status | **string**<br><p>Status of the function.</p> <ul> <li>CREATING: Function is being created.</li> <li>ACTIVE: Function is ready to be invoked.</li> <li>DELETING: Function is being deleted.</li> <li>ERROR: Function failed.</li> </ul> 