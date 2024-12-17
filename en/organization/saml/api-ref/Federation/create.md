---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Federation/create.md
---

# SAML Federation API, REST: Federation.Create

Creates a federation in the specified organization.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations
```

## Body parameters {#yandex.cloud.organizationmanager.v1.saml.CreateFederationRequest}

```json
{
  "organizationId": "string",
  "name": "string",
  "description": "string",
  "cookieMaxAge": "string",
  "autoCreateAccountOnLogin": "boolean",
  "issuer": "string",
  "ssoBinding": "string",
  "ssoUrl": "string",
  "securitySettings": {
    "encryptedAssertions": "boolean",
    "forceAuthn": "boolean"
  },
  "caseInsensitiveNameIds": "boolean",
  "labels": "object"
}
```

#|
||Field | Description ||
|| organizationId | **string**

ID of the organization to create a federation in.
To get the organization ID, make a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/Organization/list#List) request. ||
|| name | **string**

Name of the federation.
The name must be unique within the organization. ||
|| description | **string**

Description of the federation. ||
|| cookieMaxAge | **string** (duration)

Browser cookie lifetime in seconds.
If the cookie is still valid, the management console
authenticates the user immediately and redirects them to the home page.
The default value is `8h`. ||
|| autoCreateAccountOnLogin | **boolean**

Add new users automatically on successful authentication.
The user becomes member of the organization automatically,
but you need to grant other roles to them.

If the value is `false`, users who aren't added to the organization
can't log in, even if they have authenticated on your server. ||
|| issuer | **string**

Required field. ID of the IdP server to be used for authentication.
The IdP server also responds to IAM with this ID after the user authenticates. ||
|| ssoBinding | **enum** (BindingType)

Single sign-on endpoint binding type. Most Identity Providers support the `POST` binding type.

SAML Binding is a mapping of a SAML protocol message onto standard messaging
formats and/or communications protocols.

- `BINDING_TYPE_UNSPECIFIED`
- `POST`: HTTP POST binding.
- `REDIRECT`: HTTP redirect binding.
- `ARTIFACT`: HTTP artifact binding. ||
|| ssoUrl | **string**

Required field. Single sign-on endpoint URL.
Specify the link to the IdP login page here. ||
|| securitySettings | **[FederationSecuritySettings](#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings)**

Federation security settings. ||
|| caseInsensitiveNameIds | **boolean**

Use case insensitive Name IDs. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. ||
|#

## FederationSecuritySettings {#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings}

Federation security settings.

#|
||Field | Description ||
|| encryptedAssertions | **boolean**

Enable encrypted assertions. ||
|| forceAuthn | **boolean**

Value parameter ForceAuthn in SAMLRequest. ||
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
    "id": "string",
    "organizationId": "string",
    "name": "string",
    "description": "string",
    "createdAt": "string",
    "cookieMaxAge": "string",
    "autoCreateAccountOnLogin": "boolean",
    "issuer": "string",
    "ssoBinding": "string",
    "ssoUrl": "string",
    "securitySettings": {
      "encryptedAssertions": "boolean",
      "forceAuthn": "boolean"
    },
    "caseInsensitiveNameIds": "boolean",
    "labels": "object"
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
|| metadata | **[CreateFederationMetadata](#yandex.cloud.organizationmanager.v1.saml.CreateFederationMetadata)**

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
|| response | **[Federation](#yandex.cloud.organizationmanager.v1.saml.Federation)**

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

## CreateFederationMetadata {#yandex.cloud.organizationmanager.v1.saml.CreateFederationMetadata}

#|
||Field | Description ||
|| federationId | **string**

ID of the federation that is being created. ||
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

## Federation {#yandex.cloud.organizationmanager.v1.saml.Federation}

A federation.
For more information, see [SAML-compatible identity federations](/docs/iam/concepts/federations).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the federation. ||
|| organizationId | **string**

ID of the organization that the federation belongs to. ||
|| name | **string**

Required field. Name of the federation. ||
|| description | **string**

Description of the federation. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cookieMaxAge | **string** (duration)

Browser cookie lifetime in seconds.
If the cookie is still valid, the management console
authenticates the user immediately and redirects them to the home page. ||
|| autoCreateAccountOnLogin | **boolean**

Add new users automatically on successful authentication.
The user becomes member of the organization automatically,
but you need to grant other roles to them.

If the value is `false`, users who aren't added to the organization
can't log in, even if they have authenticated on your server. ||
|| issuer | **string**

Required field. ID of the IdP server to be used for authentication.
The IdP server also responds to IAM with this ID after the user authenticates. ||
|| ssoBinding | **enum** (BindingType)

Single sign-on endpoint binding type. Most Identity Providers support the `POST` binding type.

SAML Binding is a mapping of a SAML protocol message onto standard messaging
formats and/or communications protocols.

- `BINDING_TYPE_UNSPECIFIED`
- `POST`: HTTP POST binding.
- `REDIRECT`: HTTP redirect binding.
- `ARTIFACT`: HTTP artifact binding. ||
|| ssoUrl | **string**

Required field. Single sign-on endpoint URL.
Specify the link to the IdP login page here. ||
|| securitySettings | **[FederationSecuritySettings](#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings2)**

Federation security settings. ||
|| caseInsensitiveNameIds | **boolean**

Use case insensitive Name IDs. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#

## FederationSecuritySettings {#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings2}

Federation security settings.

#|
||Field | Description ||
|| encryptedAssertions | **boolean**

Enable encrypted assertions. ||
|| forceAuthn | **boolean**

Value parameter ForceAuthn in SAMLRequest. ||
|#