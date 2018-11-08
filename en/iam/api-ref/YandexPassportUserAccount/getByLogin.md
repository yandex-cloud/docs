# Method getByLogin
Returns the specified YandexPassportUserAccount resource.
 

 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
login | Required. Login of the YandexPassportUserAccount resource to return.
 
## Response {#responses}
**HTTP Code: 200 - OK**

A UserAccount resource. For more information, see [Users](/docs/iam/concepts/users/users).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the user account.</p> 
yandexPassportUserAccount | **object** <br> includes only one of the fields `yandexPassportUserAccount`<br><br><p>A YandexPassportUserAccount resource. For more information, see <a href="/docs/iam/concepts/users/users#passport">Passport users</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Login of the Yandex.Passport user account.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Default email of the Yandex.Passport user account.</p> 