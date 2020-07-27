---
editable: false
---

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

```json 
{
  "id": "string",

  //  includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`
  "yandexPassportUserAccount": {
    "login": "string",
    "defaultEmail": "string"
  },
  "samlUserAccount": {
    "federationId": "string",
    "nameId": "string",
    "attributes": "object"
  },
  // end of the list of possible fields

}
```
Currently represents only [Yandex.Passport account](/docs/iam/concepts/#passport).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the user account.</p> 
yandexPassportUserAccount | **object**<br>A YandexPassportUserAccount resource. <br> includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>A YandexPassportUserAccount resource. For more information, see <a href="/docs/iam/concepts/#passport">Yandex.Passport account</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Login of the Yandex.Passport user account.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Default email of the Yandex.Passport user account.</p> 
samlUserAccount | **object**<br>A SAML federated user. <br> includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>A SAML federated user. For more information, see <a href="/docs/iam/concepts/users/saml-federations">federations</a>.</p> 
samlUserAccount.<br>federationId | **string**<br><p>Required. ID of the federation that the federation belongs to.</p> <p>The maximum string length in characters is 50.</p> 
samlUserAccount.<br>nameId | **string**<br><p>Required. Name Id of the SAML federated user. The name is unique within the federation. 1-256 characters long.</p> <p>The string length in characters must be 1-256.</p> 
samlUserAccount.<br>attributes | **object**<br><p>Additional attributes of the SAML federated user.</p> 