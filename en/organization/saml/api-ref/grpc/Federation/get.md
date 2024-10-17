---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Federation/get.md
---

# Cloud Organization SAML API, gRPC: FederationService.Get {#Get}

Returns the specified federation.

To get the list of available federations, make a [List](/docs/organization/api-ref/grpc/Federation/list#List) request.

## gRPC request

**rpc Get ([GetFederationRequest](#yandex.cloud.organizationmanager.v1.saml.GetFederationRequest)) returns ([Federation](#yandex.cloud.organizationmanager.v1.saml.Federation))**

## GetFederationRequest {#yandex.cloud.organizationmanager.v1.saml.GetFederationRequest}

```json
{
  "federationId": "string"
}
```

#|
||Field | Description ||
|| federationId | **string**

ID of the federation to return.
To get the federation ID, make a [FederationService.List](/docs/organization/api-ref/grpc/Federation/list#List) request. ||
|#

## Federation {#yandex.cloud.organizationmanager.v1.saml.Federation}

```json
{
  "id": "string",
  "organizationId": "string",
  "name": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "cookieMaxAge": "google.protobuf.Duration",
  "autoCreateAccountOnLogin": "bool",
  "issuer": "string",
  "ssoBinding": "BindingType",
  "ssoUrl": "string",
  "securitySettings": {
    "encryptedAssertions": "bool",
    "forceAuthn": "bool"
  },
  "caseInsensitiveNameIds": "bool",
  "labels": "string"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| cookieMaxAge | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Browser cookie lifetime in seconds.
If the cookie is still valid, the management console
authenticates the user immediately and redirects them to the home page. ||
|| autoCreateAccountOnLogin | **bool**

Add new users automatically on successful authentication.
The user becomes member of the organization automatically,
but you need to grant other roles to them.

If the value is `false`, users who aren't added to the organization
can't log in, even if they have authenticated on your server. ||
|| issuer | **string**

Required field. ID of the IdP server to be used for authentication.
The IdP server also responds to IAM with this ID after the user authenticates. ||
|| ssoBinding | enum **BindingType**

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
|| caseInsensitiveNameIds | **bool**

Use case insensitive Name IDs. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#

## FederationSecuritySettings {#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings}

Federation security settings.

#|
||Field | Description ||
|| encryptedAssertions | **bool**

Enable encrypted assertions. ||
|| forceAuthn | **bool**

Value parameter ForceAuthn in SAMLRequest. ||
|#