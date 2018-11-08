# Method get
Returns the specified UserAccount resource.
 

 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/userAccounts/{userAccountId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
userAccountId | Required. ID of the UserAccount resource to return.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

A UserAccount resource. For more information, see [Users](/docs/iam/concepts/users/users).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the user account.</p> 
yandexPassportUserAccount | **object** <br> includes only one of the fields `yandexPassportUserAccount`<br><br><p>A YandexPassportUserAccount resource. For more information, see <a href="/docs/iam/concepts/users/users#passport">Passport users</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Login of the Yandex.Passport user account.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Default email of the Yandex.Passport user account.</p> 