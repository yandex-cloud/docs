---
editable: false
sourcePath: en/_api-ref/iam/api-ref/IamToken/create.md
---

# Method create
Creates an IAM token for the specified identity.
 

 
## HTTP request {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/v1/tokens
```
 
## Body parameters {#body_params}
 
```json 
{

  //  includes only one of the fields `yandexPassportOauthToken`, `jwt`
  "yandexPassportOauthToken": "string",
  "jwt": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
yandexPassportOauthToken | **string** <br> includes only one of the fields `yandexPassportOauthToken`, `jwt`<br><br><p>OAuth token for a Yandex account. For more information, see <a href="/docs/iam/concepts/authorization/oauth-token">OAuth token</a>.</p> 
jwt | **string** <br> includes only one of the fields `yandexPassportOauthToken`, `jwt`<br><br><p>JSON Web Token (JWT) for a service account. For more information, see <a href="/docs/iam/operations/iam-token/create-for-sa">Get IAM token for a service account</a>.</p> 
 
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