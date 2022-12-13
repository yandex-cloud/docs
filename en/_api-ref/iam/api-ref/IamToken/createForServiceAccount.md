---
editable: false
---

# Identity and Access Management API, REST: IamToken.createForServiceAccount
Create iam token for service account.
 

 
## HTTP request {#https-request}
```
POST https://iam.{{ api-host }}/iam/v1/tokens:createForServiceAccount
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
expiresAt | **string** (date-time)<br><p>IAM token expiration time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 