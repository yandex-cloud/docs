---
editable: false
sourcePath: en/_api-ref/iam/v1/saml/api-ref/Federation/listUserAccounts.md
---

# Identity and Access Management SAML API, REST: Federation.ListUserAccounts

Lists users for the specified federation.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/saml/federations/{federationId}:listUserAccounts
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to list user accounts for. ||
|#

## Query parameters {#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListFederatedUserAccountsResponse.nextPageToken](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListFederatedUserAccountsResponse.nextPageToken](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsResponse}

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
      },
      // end of the list of possible fields
      "lastAuthenticatedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| userAccounts[] | **[UserAccount](#yandex.cloud.iam.v1.UserAccount)**

List of user accounts for the specified federation. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederatedUserAccountsRequest.pageSize](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsRequest), use the `nextPageToken` as the value
for the [ListFederatedUserAccountsRequest.pageToken](#yandex.cloud.iam.v1.saml.ListFederatedUserAccountsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## UserAccount {#yandex.cloud.iam.v1.UserAccount}

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
|| lastAuthenticatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| attributes | **object** (map<**string**, **[Attribute](#yandex.cloud.iam.v1.SamlUserAccount.Attribute)**>)

Additional attributes of the SAML federated user. ||
|#

## Attribute {#yandex.cloud.iam.v1.SamlUserAccount.Attribute}

#|
||Field | Description ||
|| value[] | **string** ||
|#