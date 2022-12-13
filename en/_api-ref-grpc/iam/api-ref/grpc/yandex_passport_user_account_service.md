---
editable: false
---

# Identity and Access Management API, gRPC: YandexPassportUserAccountService

A set of methods for managing YandexPassportUserAccount resources.

| Call | Description |
| --- | --- |
| [GetByLogin](#GetByLogin) | Returns the specified YandexPassportUserAccount resource. |

## Calls YandexPassportUserAccountService {#calls}

## GetByLogin {#GetByLogin}

Returns the specified YandexPassportUserAccount resource.

**rpc GetByLogin ([GetUserAccountByLoginRequest](#GetUserAccountByLoginRequest)) returns ([UserAccount](#UserAccount))**

### GetUserAccountByLoginRequest {#GetUserAccountByLoginRequest}

Field | Description
--- | ---
login | **string**<br>Required. Login of the YandexPassportUserAccount resource to return. 


### UserAccount {#UserAccount}

Field | Description
--- | ---
id | **string**<br>ID of the user account. 
user_account | **oneof:** `yandex_passport_user_account` or `saml_user_account`<br>
&nbsp;&nbsp;yandex_passport_user_account | **[YandexPassportUserAccount](#YandexPassportUserAccount)**<br>A YandexPassportUserAccount resource. 
&nbsp;&nbsp;saml_user_account | **[SamlUserAccount](#SamlUserAccount)**<br>A SAML federated user. 


### YandexPassportUserAccount {#YandexPassportUserAccount}

Field | Description
--- | ---
login | **string**<br>Login of the Yandex user account. 
default_email | **string**<br>Default email of the Yandex user account. 


### SamlUserAccount {#SamlUserAccount}

Field | Description
--- | ---
federation_id | **string**<br>Required. ID of the federation that the federation belongs to. The maximum string length in characters is 50.
name_id | **string**<br>Required. Name Id of the SAML federated user. The name is unique within the federation. 1-256 characters long. The string length in characters must be 1-256.
attributes | **map<string,Attribute>**<br>Additional attributes of the SAML federated user. 


### Attribute {#Attribute}

Field | Description
--- | ---
value[] | **string**<br> 


