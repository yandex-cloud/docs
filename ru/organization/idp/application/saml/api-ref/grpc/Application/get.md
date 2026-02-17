---
editable: false
---

# SAML Application API, gRPC: ApplicationService.Get

Returns the specified SAML application.

To get the list of available applications, make a [List](/docs/organization/idp/application/saml/mapi-ref/grpc/Application/list#List) request.

## gRPC request

**rpc Get ([GetApplicationRequest](#yandex.cloud.organizationmanager.v1.idp.application.saml.GetApplicationRequest)) returns ([Application](#yandex.cloud.organizationmanager.v1.idp.application.saml.Application))**

## GetApplicationRequest {#yandex.cloud.organizationmanager.v1.idp.application.saml.GetApplicationRequest}

```json
{
  "application_id": "string"
}
```

Request to get a SAML application by ID.

#|
||Field | Description ||
|| application_id | **string**

Required field. ID of the SAML application to return.

The maximum string length in characters is 50. ||
|#

## Application {#yandex.cloud.organizationmanager.v1.idp.application.saml.Application}

```json
{
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
```

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

Required field. Service provider entity ID.

The maximum string length in characters is 8000. ||
|| acs_urls[] | **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL)**

Assertion Consumer Service URLs.

The number of elements must be in the range 1-100. ||
|| slo_urls[] | **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL)**

Single Logout Service URLs.

The number of elements must be in the range 0-100. ||
|#

## AssertionConsumerServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL}

Assertion Consumer Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where SAML responses are sent.

The maximum string length in characters is 8000. ||
|| index | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Optional index for the assertion consumer service. ||
|#

## SingleLogoutServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL}

Single Logout Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where logout requests are sent.

The maximum string length in characters is 8000. ||
|| response_url | **string**

Optional separate URL for logout responses.

The maximum string length in characters is 8000. ||
|| protocol_binding | enum **ProtocolBinding**

Required field. Protocol binding supported by the logout endpoint.

- `HTTP_POST`: HTTP POST binding.
- `HTTP_REDIRECT`: HTTP Redirect binding. ||
|#

## SecuritySettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings}

Security settings for SAML applications.

#|
||Field | Description ||
|| signature_mode | enum **SignatureMode**

Signature mode for SAML messages.

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

List of attribute mappings.

The maximum number of elements is 50. ||
|#

## NameId {#yandex.cloud.organizationmanager.v1.idp.application.saml.NameId}

NameID configuration for SAML applications.

#|
||Field | Description ||
|| format | enum **Format**

Required field. Format of the NameID.

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

Required field. Name of the SAML attribute.

The maximum string length in characters is 8000. ||
|| value | **string**

Required field. Value of the SAML attribute.

The maximum string length in characters is 50. ||
|#

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings}

Group claims settings for SAML applications.

#|
||Field | Description ||
|| group_distribution_type | enum **GroupDistributionType**

Distribution type for group claims.

- `NONE`: No groups are provided to the application.
- `ASSIGNED_GROUPS`: Only assigned groups are provided to the application.
- `ALL_GROUPS`: All groups are provided to the application. ||
|| group_attribute_name | **string**

Name of the SAML attribute that contains group information.

The maximum string length in characters is 8000. ||
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