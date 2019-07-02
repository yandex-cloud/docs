---
editable: false
---

# UserAccount
A set of methods for managing user accounts. Currently applicable only for [Yandex.Passport accounts](/docs/iam/concepts/#passport).
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "yandexPassportUserAccount": {
    "login": "string",
    "defaultEmail": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the user account.</p> 
yandexPassportUserAccount | **object**<br><p>A YandexPassportUserAccount resource. For more information, see <a href="/docs/iam/concepts/#passport">Yandex.Passport account</a>.</p> 
yandexPassportUserAccount.<br>login | **string**<br><p>Login of the Yandex.Passport user account.</p> 
yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Default email of the Yandex.Passport user account.</p> 

## Methods {#methods}
Method | Description
--- | ---
[get](get.md) | Returns the specified UserAccount resource.