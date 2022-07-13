---
editable: false
sourcePath: en/_api-ref/iam/api-ref/ApiKey/get.md
---

# Method get
Returns the specified API key.
 
To get the list of available API keys, make a [list](/docs/iam/api-ref/ApiKey/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/apiKeys/{apiKeyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
apiKeyId | <p>Required. ID of the API key to return. To get the API key ID, use a <a href="/docs/iam/api-ref/ApiKey/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "serviceAccountId": "string",
  "createdAt": "string",
  "description": "string"
}
```
An ApiKey resource. For more information, see [Api-Key](/docs/iam/concepts/authorization/api-key).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the API Key.</p> 
serviceAccountId | **string**<br><p>ID of the service account that the API key belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
description | **string**<br><p>Description of the API key. 0-256 characters long.</p> 