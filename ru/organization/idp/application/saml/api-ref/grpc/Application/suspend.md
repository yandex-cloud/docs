---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/application/saml/api-ref/grpc/Application/suspend.md
---

# SAML Application API, gRPC: ApplicationService.Suspend

Suspends the specified SAML application.

## gRPC request

**rpc Suspend ([SuspendApplicationRequest](#yandex.cloud.organizationmanager.v1.idp.application.saml.SuspendApplicationRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## SuspendApplicationRequest {#yandex.cloud.organizationmanager.v1.idp.application.saml.SuspendApplicationRequest}

```json
{
  "application_id": "string"
}
```

Request to suspend a SAML application.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the SAML application to suspend. ||
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
    "application_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "organization_id": "string",
    "name": "string",
    "description": "string",
    "status": "Status",
    "labels": "map<string, string>",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "service_provider": {
      "entity_id": "string",
      "acs_urls": [
        {
          "url": "string",
          "index": "google.protobuf.Int64Value"
        }
      ],
      "slo_urls": [
        {
          "url": "string",
          "response_url": "string",
          "protocol_binding": "ProtocolBinding"
        }
      ]
    },
    "security_settings": {
      "signature_mode": "SignatureMode",
      "signature_certificate_id": "string"
    },
    "attribute_mapping": {
      "name_id": {
        "format": "Format",
        "value": "string"
      },
      "attributes": [
        {
          "name": "string",
          "value": "string"
        }
      ]
    },
    "group_claims_settings": {
      "group_distribution_type": "GroupDistributionType",
      "group_attribute_name": "string"
    },
    "identity_provider_metadata": {
      "issuer": "string",
      "sso_url": "string",
      "metadata_url": "string",
      "slo_url": "string"
    }
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
|| metadata | **[SuspendApplicationMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.SuspendApplicationMetadata)**

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
|| response | **[Application](#yandex.cloud.organizationmanager.v1.idp.application.saml.Application)**

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

## SuspendApplicationMetadata {#yandex.cloud.organizationmanager.v1.idp.application.saml.SuspendApplicationMetadata}

Metadata for the [ApplicationService.Suspend](#Suspend) operation.

#|
||Field | Description ||
|| application_id | **string**

ID of the SAML application that is being suspended. ||
|#

## Application {#yandex.cloud.organizationmanager.v1.idp.application.saml.Application}

A SAML application resource.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the SAML application. ||
|| organization_id | **string**

ID of the organization that the application belongs to. ||
|| name | **string**

Name of the SAML application. ||
|| description | **string**

Description of the SAML application. ||
|| status | enum **Status**

Current status of the SAML application.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `CREATING`: The application is in the process of being created.
- `ACTIVE`: The application is active and can be used for authentication.
- `SUSPENDED`: The application is suspended. I.e. authentication via this application is disabled.
- `DELETING`: The application is in the process of being deleted. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Modification timestamp. ||
|| service_provider | **[ServiceProvider](#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider)**

Service provider configuration for the SAML application. ||
|| security_settings | **[SecuritySettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings)**

Security settings for the SAML application. ||
|| attribute_mapping | **[AttributeMapping](#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMapping)**

Attribute mapping configuration for the SAML application. ||
|| group_claims_settings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings)**

Group claims settings for the SAML application. ||
|| identity_provider_metadata | **[IdentityProviderMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.IdentityProviderMetadata)**

Identity provider metadata for the SAML application. ||
|#

## ServiceProvider {#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider}

Service provider configuration for SAML applications.

#|
||Field | Description ||
|| entity_id | **string**

Required field. Service provider entity ID. ||
|| acs_urls[] | **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL)**

Assertion Consumer Service URLs. ||
|| slo_urls[] | **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL)**

Single Logout Service URLs. ||
|#

## AssertionConsumerServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL}

Assertion Consumer Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where SAML responses are sent. ||
|| index | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Optional index for the assertion consumer service. ||
|#

## SingleLogoutServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL}

Single Logout Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where logout requests are sent. ||
|| response_url | **string**

Optional separate URL for logout responses. ||
|| protocol_binding | enum **ProtocolBinding**

Required field. Protocol binding supported by the logout endpoint.

- `PROTOCOL_BINDING_UNSPECIFIED`: The protocol binding is not specified.
- `HTTP_POST`: HTTP POST binding.
- `HTTP_REDIRECT`: HTTP Redirect binding. ||
|#

## SecuritySettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings}

Security settings for SAML applications.

#|
||Field | Description ||
|| signature_mode | enum **SignatureMode**

Signature mode for SAML messages.

- `SIGNATURE_MODE_UNSPECIFIED`: The signature mode is not specified.
- `ASSERTIONS`: Sign individual assertions.
- `RESPONSE`: Sign the entire response.
- `RESPONSE_AND_ASSERTIONS`: Sign both the response and individual assertions. ||
|| signature_certificate_id | **string**

ID of the signature certificate to use. ||
|#

## AttributeMapping {#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMapping}

Attribute mapping configuration for SAML applications.

#|
||Field | Description ||
|| name_id | **[NameId](#yandex.cloud.organizationmanager.v1.idp.application.saml.NameId)**

Required field. NameID configuration for the SAML application. ||
|| attributes[] | **[Attribute](#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute)**

List of attribute mappings. ||
|#

## NameId {#yandex.cloud.organizationmanager.v1.idp.application.saml.NameId}

NameID configuration for SAML applications.

#|
||Field | Description ||
|| format | enum **Format**

Required field. Format of the NameID.

- `FORMAT_UNSPECIFIED`: The NameID format is not specified.
- `PERSISTENT`: Persistent NameID format.
This provides a stable, opaque identifier for the user.
- `EMAIL`: Email NameID format.
This uses the user's email address as the identifier. ||
|| value | **string**

Required field. Value of the NameID. ||
|#

## Attribute {#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute}

Attribute mapping for SAML applications.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SAML attribute. ||
|| value | **string**

Required field. Value of the SAML attribute. ||
|#

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings}

Group claims settings for SAML applications.

#|
||Field | Description ||
|| group_distribution_type | enum **GroupDistributionType**

Distribution type for group claims.

- `GROUP_DISTRIBUTION_TYPE_UNSPECIFIED`: The group distribution type is not specified.
- `NONE`: No groups are provided to the application.
- `ASSIGNED_GROUPS`: Only assigned groups are provided to the application.
- `ALL_GROUPS`: All groups are provided to the application. ||
|| group_attribute_name | **string**

Name of the SAML attribute that contains group information. ||
|#

## IdentityProviderMetadata {#yandex.cloud.organizationmanager.v1.idp.application.saml.IdentityProviderMetadata}

Identity provider metadata for SAML applications.

#|
||Field | Description ||
|| issuer | **string**

Identity provider issuer identifier. ||
|| sso_url | **string**

Identity provider Single Sign-On URL. ||
|| metadata_url | **string**

Identity provider metadata URL. ||
|| slo_url | **string**

Identity provider Single Logout URL. ||
|#