---
editable: false
---

# Identity and Access Management API, REST: UserAccount methods
A set of methods for managing user accounts. Currently applicable only for [Yandex accounts](/docs/iam/concepts/#passport).
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the user account.</p> 
yandexPassportUserAccount | **object** <br> includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>A YandexPassportUserAccount resource. For more information, see <a href="/docs/iam/concepts/#passport">Yandex account</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Login of the Yandex user account.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Default email of the Yandex user account.</p> 
samlUserAccount | **object** <br> includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`<br><br><p>A SAML federated user. For more information, see <a href="/docs/iam/concepts/federations">federations</a>.</p> 
samlUserAccount.<br>federationId | **string**<br><p>Required. ID of the federation that the federation belongs to.</p> <p>The maximum string length in characters is 50.</p> 
samlUserAccount.<br>nameId | **string**<br><p>Required. Name Id of the SAML federated user. The name is unique within the federation. 1-256 characters long.</p> <p>The string length in characters must be 1-256.</p> 
samlUserAccount.<br>attributes | **object**<br><p>Additional attributes of the SAML federated user.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified UserAccount resource.