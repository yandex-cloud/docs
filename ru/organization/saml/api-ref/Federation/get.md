---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/saml/api-ref/Federation/get.md
---

# SAML Federation API, REST: Federation.Get

Returns the specified federation.

To get the list of available federations, make a [List](/docs/organization/saml/api-ref/Federation/list#List) request.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/{federationId}
```

## Path parameters

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the federation to return.
To get the federation ID, make a [FederationService.List](/docs/organization/saml/api-ref/Federation/list#List) request. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.saml.Federation}

**HTTP Code: 200 - OK**

```json
{
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
```

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
|| securitySettings | **[FederationSecuritySettings](#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings)**

Federation security settings. ||
|| caseInsensitiveNameIds | **boolean**

Use case insensitive Name IDs. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
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