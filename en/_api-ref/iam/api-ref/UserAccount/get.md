---
editable: false
---

# Method get
Returns the specified UserAccount resource.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/userAccounts/{userAccountId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
userAccountId | <p>Required. ID of the UserAccount resource to return.</p> <p>The maximum string length in characters is 50.</p> 
 
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
Currently represents only [Yandex account](/docs/iam/concepts/#passport).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the user account.</p> 
yandexPassportUserAccount | **object**<br>A YandexPassportUserAccount resource. <br> includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`<br>
yandexPassportUserAccount.<br>login | **string**<br><p>Login of the Yandex user account.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Default email of the Yandex user account.</p> 
samlUserAccount | **object**<br>A SAML federated user. <br> includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`<br>
samlUserAccount.<br>federationId | **string**<br><p>Required. ID of the federation that the federation belongs to.</p> <p>The maximum string length in characters is 50.</p> 
samlUserAccount.<br>nameId | **string**<br><p>Required. Name Id of the SAML federated user. The name is unique within the federation. 1-256 characters long.</p> <p>The string length in characters must be 1-256.</p> 
samlUserAccount.<br>attributes | **object**<br><p>Additional attributes of the SAML federated user.</p> 