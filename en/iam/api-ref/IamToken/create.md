# Method create
Creates an IAM token for the specified identity.
 

 
## HTTP request {#https-request}
```
POST https://iam.api.cloud.yandex.net/iam/v1/tokens
```
 
## Body parameters {#body_params}
 
```json 
 {

  // includes only one of the fields `yandexPassportOauthToken`
  "yandexPassportOauthToken": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
yandexPassportOauthToken | **string** <br> includes only one of the fields `yandexPassportOauthToken`<br><br><p>OAuth token for a Yandex.Passport account. For more information, see <a href="/docs/iam/concepts/authorization/oauth-token">OAuth token</a>.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**


 
Field | Description
--- | ---
iamToken | **string**<br><p>IAM token for the specified identity.</p> <p>You should pass the token in the <code>Authorization</code> header for any further API requests. For example, <code>Authorization: Bearer [iam_token]</code>.</p> 