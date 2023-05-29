---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ApiKey/get.md
---

# Identity and Access Management API, REST: ApiKey.get
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
description | **string**<br><p>Description of the API key. 0-256 characters long.</p> 