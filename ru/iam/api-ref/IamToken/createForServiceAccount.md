---
editable: false
sourcePath: en/_api-ref/iam/api-ref/IamToken/createForServiceAccount.md
---

# Method createForServiceAccount
Create iam token for service account.
 

 
## HTTP request {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/v1/tokens:createForServiceAccount
```
 
## Body parameters {#body_params}
 
```json 
{
  "serviceAccountId": "string"
}
```

 
Field | Description
--- | ---
serviceAccountId | **string**<br><p>Required. The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "iamToken": "string",
  "expiresAt": "string"
}
```

 
Field | Description
--- | ---
iamToken | **string**<br><p>IAM token for the specified identity.</p> <p>You should pass the token in the ``Authorization`` header for any further API requests. For example, ``Authorization: Bearer [iam_token]``.</p> 
expiresAt | **string** (date-time)<br><p>IAM token expiration time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 