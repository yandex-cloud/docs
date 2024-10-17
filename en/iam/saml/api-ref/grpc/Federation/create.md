---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/saml/api-ref/grpc/Federation/create.md
---

# Identity and Access Management SAML API, gRPC: FederationService.Create {#Create}

Creates a federation in the specified folder.

## gRPC request

**rpc Create ([CreateFederationRequest](#yandex.cloud.iam.v1.saml.CreateFederationRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateFederationRequest {#yandex.cloud.iam.v1.saml.CreateFederationRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
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

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create a federation in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the federation.
The name must be unique within the cloud. ||
|| description | **string**

Description of the federation. ||
|| cookieMaxAge | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Browser cookie lifetime in seconds.
If the cookie is still valid, the management console
authenticates the user immediately and redirects them to the home page.
The default value is `8h`. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "federationId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateFederationMetadata](#yandex.cloud.iam.v1.saml.CreateFederationMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Federation](#yandex.cloud.iam.v1.saml.Federation)**

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

## CreateFederationMetadata {#yandex.cloud.iam.v1.saml.CreateFederationMetadata}

#|
||Field | Description ||
|| federationId | **string**

ID of the federation that is being created. ||
|#

## Federation {#yandex.cloud.iam.v1.saml.Federation}

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
|| securitySettings | **[FederationSecuritySettings](#yandex.cloud.iam.v1.saml.FederationSecuritySettings2)**

Federation security settings. ||
|| caseInsensitiveNameIds | **bool**

Use case insensitive Name IDs. ||
|#

## FederationSecuritySettings {#yandex.cloud.iam.v1.saml.FederationSecuritySettings2}

Federation security settings.

#|
||Field | Description ||
|| encryptedAssertions | **bool**

Enable encrypted assertions. ||
|#