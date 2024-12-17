---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Federation/create.md
---

# SAML Federation API, gRPC: FederationService.Create

Creates a federation in the specified organization.

## gRPC request

**rpc Create ([CreateFederationRequest](#yandex.cloud.organizationmanager.v1.saml.CreateFederationRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateFederationRequest {#yandex.cloud.organizationmanager.v1.saml.CreateFederationRequest}

```json
{
  "organization_id": "string",
  "name": "string",
  "description": "string",
  "cookie_max_age": "google.protobuf.Duration",
  "auto_create_account_on_login": "bool",
  "issuer": "string",
  "sso_binding": "BindingType",
  "sso_url": "string",
  "security_settings": {
    "encrypted_assertions": "bool",
    "force_authn": "bool"
  },
  "case_insensitive_name_ids": "bool",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| organization_id | **string**

ID of the organization to create a federation in.
To get the organization ID, make a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|| name | **string**

Name of the federation.
The name must be unique within the organization. ||
|| description | **string**

Description of the federation. ||
|| cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Browser cookie lifetime in seconds.
If the cookie is still valid, the management console
authenticates the user immediately and redirects them to the home page.
The default value is `8h`. ||
|| auto_create_account_on_login | **bool**

Add new users automatically on successful authentication.
The user becomes member of the organization automatically,
but you need to grant other roles to them.

If the value is `false`, users who aren't added to the organization
can't log in, even if they have authenticated on your server. ||
|| issuer | **string**

Required field. ID of the IdP server to be used for authentication.
The IdP server also responds to IAM with this ID after the user authenticates. ||
|| sso_binding | enum **BindingType**

Single sign-on endpoint binding type. Most Identity Providers support the `POST` binding type.

SAML Binding is a mapping of a SAML protocol message onto standard messaging
formats and/or communications protocols.

- `BINDING_TYPE_UNSPECIFIED`
- `POST`: HTTP POST binding.
- `REDIRECT`: HTTP redirect binding.
- `ARTIFACT`: HTTP artifact binding. ||
|| sso_url | **string**

Required field. Single sign-on endpoint URL.
Specify the link to the IdP login page here. ||
|| security_settings | **[FederationSecuritySettings](#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings)**

Federation security settings. ||
|| case_insensitive_name_ids | **bool**

Use case insensitive Name IDs. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. ||
|#

## FederationSecuritySettings {#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings}

Federation security settings.

#|
||Field | Description ||
|| encrypted_assertions | **bool**

Enable encrypted assertions. ||
|| force_authn | **bool**

Value parameter ForceAuthn in SAMLRequest. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "federation_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "organization_id": "string",
    "name": "string",
    "description": "string",
    "created_at": "google.protobuf.Timestamp",
    "cookie_max_age": "google.protobuf.Duration",
    "auto_create_account_on_login": "bool",
    "issuer": "string",
    "sso_binding": "BindingType",
    "sso_url": "string",
    "security_settings": {
      "encrypted_assertions": "bool",
      "force_authn": "bool"
    },
    "case_insensitive_name_ids": "bool",
    "labels": "map<string, string>"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateFederationMetadata](#yandex.cloud.organizationmanager.v1.saml.CreateFederationMetadata)**

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
|| federation_id | **string**

ID of the federation that is being created. ||
|#

## Federation {#yandex.cloud.organizationmanager.v1.saml.Federation}

A federation.
For more information, see [SAML-compatible identity federations](/docs/iam/concepts/federations).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the federation. ||
|| organization_id | **string**

ID of the organization that the federation belongs to. ||
|| name | **string**

Required field. Name of the federation. ||
|| description | **string**

Description of the federation. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| cookie_max_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Browser cookie lifetime in seconds.
If the cookie is still valid, the management console
authenticates the user immediately and redirects them to the home page. ||
|| auto_create_account_on_login | **bool**

Add new users automatically on successful authentication.
The user becomes member of the organization automatically,
but you need to grant other roles to them.

If the value is `false`, users who aren't added to the organization
can't log in, even if they have authenticated on your server. ||
|| issuer | **string**

Required field. ID of the IdP server to be used for authentication.
The IdP server also responds to IAM with this ID after the user authenticates. ||
|| sso_binding | enum **BindingType**

Single sign-on endpoint binding type. Most Identity Providers support the `POST` binding type.

SAML Binding is a mapping of a SAML protocol message onto standard messaging
formats and/or communications protocols.

- `BINDING_TYPE_UNSPECIFIED`
- `POST`: HTTP POST binding.
- `REDIRECT`: HTTP redirect binding.
- `ARTIFACT`: HTTP artifact binding. ||
|| sso_url | **string**

Required field. Single sign-on endpoint URL.
Specify the link to the IdP login page here. ||
|| security_settings | **[FederationSecuritySettings](#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings2)**

Federation security settings. ||
|| case_insensitive_name_ids | **bool**

Use case insensitive Name IDs. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#

## FederationSecuritySettings {#yandex.cloud.organizationmanager.v1.saml.FederationSecuritySettings2}

Federation security settings.

#|
||Field | Description ||
|| encrypted_assertions | **bool**

Enable encrypted assertions. ||
|| force_authn | **bool**

Value parameter ForceAuthn in SAMLRequest. ||
|#