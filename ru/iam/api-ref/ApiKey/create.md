---
editable: false
sourcePath: en/_api-ref/iam/api-ref/ApiKey/create.md
---

# Method create
Creates an API key for the specified service account.
 

 
## HTTP request {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/v1/apiKeys
```
 
## Body parameters {#body_params}
 
```json 
{
  "serviceAccountId": "string",
  "description": "string"
}
```

 
Field | Description
--- | ---
serviceAccountId | **string**<br><p>ID of the service account to create an API key for. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request. If not specified, it defaults to the subject that made the request.</p> <p>The maximum string length in characters is 50.</p> 
description | **string**<br><p>Description of the API key.</p> <p>The maximum string length in characters is 256.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "apiKey": {
    "id": "string",
    "serviceAccountId": "string",
    "createdAt": "string",
    "description": "string"
  },
  "secret": "string"
}
```

 
Field | Description
--- | ---
apiKey | **object**<br><p>ApiKey resource.</p> <p>An ApiKey resource. For more information, see <a href="/docs/iam/concepts/authorization/api-key">Api-Key</a>.</p> 
apiKey.<br>id | **string**<br><p>ID of the API Key.</p> 
apiKey.<br>serviceAccountId | **string**<br><p>ID of the service account that the API key belongs to.</p> 
apiKey.<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
apiKey.<br>description | **string**<br><p>Description of the API key. 0-256 characters long.</p> 
secret | **string**<br><p>Secret part of the API key. This secret key you may use in the requests for authentication.</p> 