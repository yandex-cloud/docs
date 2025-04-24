---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Federation/listUserAccounts.md
---

# SAML Federation API, REST: Federation.ListUserAccounts

Lists users for the specified federation.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}:listUserAccounts
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to list user accounts for. ||
|#

## Query parameters {#yandex.cloud.organizationmanager.v1.saml.ListFederatedUserAccountsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListFederatedUserAccountsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.saml.ListFederatedUserAccountsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListFederatedUserAccountsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.saml.ListFederatedUserAccountsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [nameId](#yandex.cloud.organizationmanager.v1.SamlUserAccount) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 1-1000 characters long and match the regular expression
`[a-z0-9A-Z/@_.\-=+*\\]+`. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.saml.ListFederatedUserAccountsResponse}

**HTTP Code: 200 - OK**

```json
{
  "userAccounts": [
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
        "attributes": "object"
      }
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| userAccounts[] | **[UserAccount](#yandex.cloud.organizationmanager.v1.UserAccount)**

List of user accounts for the specified federation. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederatedUserAccountsRequest.pageSize](#yandex.cloud.organizationmanager.v1.saml.ListFederatedUserAccountsRequest), use the `nextPageToken` as the value
for the [ListFederatedUserAccountsRequest.pageToken](#yandex.cloud.organizationmanager.v1.saml.ListFederatedUserAccountsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## UserAccount {#yandex.cloud.organizationmanager.v1.UserAccount}

Currently represents only [Yandex account](/docs/iam/concepts/users/accounts#passport).

#|
||Field | Description ||
|| id | **string**

ID of the user account. ||
|| yandexPassportUserAccount | **[YandexPassportUserAccount](#yandex.cloud.organizationmanager.v1.YandexPassportUserAccount)**

A YandexPassportUserAccount resource.

Includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`. ||
|| samlUserAccount | **[SamlUserAccount](#yandex.cloud.organizationmanager.v1.SamlUserAccount)**

A SAML federated user.

Includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`. ||
|#

## YandexPassportUserAccount {#yandex.cloud.organizationmanager.v1.YandexPassportUserAccount}

A YandexPassportUserAccount resource.
For more information, see [Yandex account](/docs/iam/concepts/users/accounts#passport).

#|
||Field | Description ||
|| login | **string**

Login of the Yandex user account. ||
|| defaultEmail | **string**

Default email of the Yandex user account. ||
|#

## SamlUserAccount {#yandex.cloud.organizationmanager.v1.SamlUserAccount}

A SAML federated user.
For more information, see [federations](/docs/iam/concepts/users/accounts#saml-federation).

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation that the federation belongs to. ||
|| nameId | **string**

Required field. Name Id of the SAML federated user.
The name is unique within the federation. 1-256 characters long. ||
|| attributes | **object** (map<**string**, **[Attribute](#yandex.cloud.organizationmanager.v1.SamlUserAccount.Attribute)**>)

Additional attributes of the SAML federated user. ||
|#

## Attribute {#yandex.cloud.organizationmanager.v1.SamlUserAccount.Attribute}

#|
||Field | Description ||
|| value[] | **string** ||
|#