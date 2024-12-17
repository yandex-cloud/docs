---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/saml/api-ref/grpc/Federation/listUserAccounts.md
---

# Identity and Access Management SAML API, gRPC: FederationService.ListUserAccounts

Lists users for the specified federation.

## gRPC request

**rpc ListUserAccounts ([ListFederatedUserAccountsRequest](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsRequest)) returns ([ListFederatedUserAccountsResponse](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsResponse))**

## ListFederatedUserAccountsRequest {#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsRequest}

```json
{
  "federation_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field. ID of the federation to list user accounts for. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListFederatedUserAccountsResponse.next_page_token](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListFederatedUserAccountsResponse.next_page_token](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsResponse)
returned by a previous list request. ||
|#

## ListFederatedUserAccountsResponse {#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsResponse}

```json
{
  "user_accounts": [
    {
      "id": "string",
      // Includes only one of the fields `yandex_passport_user_account`, `saml_user_account`
      "yandex_passport_user_account": {
        "login": "string",
        "default_email": "string"
      },
      "saml_user_account": {
        "federation_id": "string",
        "name_id": "string",
        "attributes": "map<string, Attribute>"
      },
      // end of the list of possible fields
      "last_authenticated_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| user_accounts[] | **[UserAccount](#yandex.cloud.iam.v1.UserAccount)**

List of user accounts for the specified federation. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederatedUserAccountsRequest.page_size](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsRequest), use the `next_page_token` as the value
for the [ListFederatedUserAccountsRequest.page_token](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## UserAccount {#yandex.cloud.iam.v1.UserAccount}

Currently represents only [Yandex account](/docs/iam/concepts/users/accounts#passport).

#|
||Field | Description ||
|| id | **string**

ID of the user account. ||
|| yandex_passport_user_account | **[YandexPassportUserAccount](#yandex.cloud.iam.v1.YandexPassportUserAccount)**

A YandexPassportUserAccount resource.

Includes only one of the fields `yandex_passport_user_account`, `saml_user_account`. ||
|| saml_user_account | **[SamlUserAccount](#yandex.cloud.iam.v1.SamlUserAccount)**

A SAML federated user.

Includes only one of the fields `yandex_passport_user_account`, `saml_user_account`. ||
|| last_authenticated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|#

## YandexPassportUserAccount {#yandex.cloud.iam.v1.YandexPassportUserAccount}

A YandexPassportUserAccount resource.
For more information, see [Yandex account](/docs/iam/concepts/users/accounts#passport).

#|
||Field | Description ||
|| login | **string**

Login of the Yandex user account. ||
|| default_email | **string**

Default email of the Yandex user account. ||
|#

## SamlUserAccount {#yandex.cloud.iam.v1.SamlUserAccount}

A SAML federated user.
For more information, see [federations](/docs/iam/concepts/federations).

#|
||Field | Description ||
|| federation_id | **string**

Required field. ID of the federation that the federation belongs to. ||
|| name_id | **string**

Required field. Name Id of the SAML federated user.
The name is unique within the federation. 1-256 characters long. ||
|| attributes | **object** (map<**string**, **[Attribute](#yandex.cloud.iam.v1.SamlUserAccount.Attribute)**>)

Additional attributes of the SAML federated user. ||
|#

## Attribute {#yandex.cloud.iam.v1.SamlUserAccount.Attribute}

#|
||Field | Description ||
|| value[] | **string** ||
|#