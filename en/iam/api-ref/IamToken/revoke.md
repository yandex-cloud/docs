---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/IamToken/revoke.md
---

# Identity and Access Management API, REST: IamToken.revoke
Revoke the IAM token.
 

 
## HTTP request {#https-request}
```
POST https://iam.{{ api-host }}/iam/v1/tokens:revoke
```
 
## Body parameters {#body_params}
 
```json 
{
  "iamToken": "string"
}
```

 
Field | Description
--- | ---
iamToken | **string**<br><p>Required.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "subjectId": "string"
}
```

 
Field | Description
--- | ---
subjectId | **string**