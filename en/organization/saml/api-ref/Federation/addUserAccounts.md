---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}:addUserAccounts
    method: post
    path:
      type: object
      properties:
        federationId:
          description: |-
            **string**
            ID of the federation to add users.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        nameIds:
          description: |-
            **string**
            Name IDs returned by the Identity Provider (IdP) on successful authentication.
            These may be UPNs or user email addresses.
          type: array
          items:
            type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Federation/addUserAccounts.md
---

# SAML Federation API, REST: Federation.AddUserAccounts

Adds users to the specified federation.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}:addUserAccounts
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to add users. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.saml.AddFederatedUserAccountsRequest}

```json
{
  "nameIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| nameIds[] | **string**

Name IDs returned by the Identity Provider (IdP) on successful authentication.
These may be UPNs or user email addresses. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "federationId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddFederatedUserAccountsMetadata](#yandex.cloud.organizationmanager.v1.saml.AddFederatedUserAccountsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[AddFederatedUserAccountsResponse](#yandex.cloud.organizationmanager.v1.saml.AddFederatedUserAccountsResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## AddFederatedUserAccountsMetadata {#yandex.cloud.organizationmanager.v1.saml.AddFederatedUserAccountsMetadata}

#|
||Field | Description ||
|| federationId | **string**

ID of the federation that is being altered. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## AddFederatedUserAccountsResponse {#yandex.cloud.organizationmanager.v1.saml.AddFederatedUserAccountsResponse}

#|
||Field | Description ||
|| userAccounts[] | **[UserAccount](#yandex.cloud.organizationmanager.v1.UserAccount)**

List of users created by [FederationService.AddUserAccounts](#AddUserAccounts) request. ||
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