---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/YandexPassportUserAccount/getByLogin.md
---

# Identity and Access Management API, gRPC: YandexPassportUserAccountService.GetByLogin {#GetByLogin}

Returns the specified YandexPassportUserAccount resource.

## gRPC request

**rpc GetByLogin ([GetUserAccountByLoginRequest](#yandex.cloud.iam.v1.GetUserAccountByLoginRequest)) returns ([UserAccount](#yandex.cloud.iam.v1.UserAccount))**

## GetUserAccountByLoginRequest {#yandex.cloud.iam.v1.GetUserAccountByLoginRequest}

```json
{
  "login": "string"
}
```

#|
||Field | Description ||
|| login | **string**

Required field. Login of the YandexPassportUserAccount resource to return. ||
|#

## UserAccount {#yandex.cloud.iam.v1.UserAccount}

```json
{
  "id": "string",
  // Includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`
  "yandexPassportUserAccount": {
    "login": "string",
    "defaultEmail": "string"
  },
  "samlUserAccount": {
    "federationId": "string",
    "nameId": "string",
    "attributes": {
      "value": [
        "string"
      ]
    }
  },
  // end of the list of possible fields
  "lastAuthenticatedAt": "google.protobuf.Timestamp"
}
```

Currently represents only [Yandex account](/docs/iam/concepts/users/accounts#passport).

#|
||Field | Description ||
|| id | **string**

ID of the user account. ||
|| yandexPassportUserAccount | **[YandexPassportUserAccount](#yandex.cloud.iam.v1.YandexPassportUserAccount)**

A YandexPassportUserAccount resource.

Includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`. ||
|| samlUserAccount | **[SamlUserAccount](#yandex.cloud.iam.v1.SamlUserAccount)**

A SAML federated user.

Includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`. ||
|| lastAuthenticatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#

## YandexPassportUserAccount {#yandex.cloud.iam.v1.YandexPassportUserAccount}

A YandexPassportUserAccount resource.
For more information, see [Yandex account](/docs/iam/concepts/users/accounts#passport).

#|
||Field | Description ||
|| login | **string**

Login of the Yandex user account. ||
|| defaultEmail | **string**

Default email of the Yandex user account. ||
|#

## SamlUserAccount {#yandex.cloud.iam.v1.SamlUserAccount}

A SAML federated user.
For more information, see [federations](/docs/iam/concepts/federations).

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation that the federation belongs to. ||
|| nameId | **string**

Required field. Name Id of the SAML federated user.
The name is unique within the federation. 1-256 characters long. ||
|| attributes | **[Attribute](#yandex.cloud.iam.v1.SamlUserAccount.Attribute)**

Additional attributes of the SAML federated user. ||
|#

## Attribute {#yandex.cloud.iam.v1.SamlUserAccount.Attribute}

#|
||Field | Description ||
|| value[] | **string** ||
|#