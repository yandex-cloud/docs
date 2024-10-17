---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/saml/api-ref/grpc/Federation/get.md
---

# Identity and Access Management SAML API, gRPC: FederationService.Get {#Get}

Returns the specified federation.

To get the list of available federations, make a [List](/docs/iam/api-ref/grpc/Federation/list#List) request.

## gRPC request

**rpc Get ([GetFederationRequest](#yandex.cloud.iam.v1.saml.GetFederationRequest)) returns ([Federation](#yandex.cloud.iam.v1.saml.Federation))**

## GetFederationRequest {#yandex.cloud.iam.v1.saml.GetFederationRequest}

```json
{
  "federationId": "string"
}
```

#|
||Field | Description ||
|| federationId | **string**

ID of the federation to return.
To get the federation ID, make a [FederationService.List](/docs/iam/api-ref/grpc/Federation/list#List) request. ||
|#

## Federation {#yandex.cloud.iam.v1.saml.Federation}

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "cookieMaxAge": "google.protobuf.Duration",
  "autoCreateAccountOnLogin": "bool",
  "issuer": "string",
  "ssoBinding": "BindingType",
  "ssoUrl": "string",
  "securitySettings": {
    "encryptedAssertions": "bool"
  },
  "caseInsensitiveNameIds": "bool"
}
```

A federation.
For more information, see [SAML-compatible identity federations](/docs/iam/concepts/federations).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the federation. ||
|| folderId | **string**

Required field. ID of the folder that the federation belongs to. ||
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
The user will get the `resource-manager.clouds.member` role automatically,
but you need to grant other roles to them.

If the value is `false`, users who aren't added to the cloud
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
|| securitySettings | **[FederationSecuritySettings](#yandex.cloud.iam.v1.saml.FederationSecuritySettings)**

Federation security settings. ||
|| caseInsensitiveNameIds | **bool**

Use case insensitive Name IDs. ||
|#

## FederationSecuritySettings {#yandex.cloud.iam.v1.saml.FederationSecuritySettings}

Federation security settings.

#|
||Field | Description ||
|| encryptedAssertions | **bool**

Enable encrypted assertions. ||
|#