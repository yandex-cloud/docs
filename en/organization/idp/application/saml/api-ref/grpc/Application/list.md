---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/application/saml/api-ref/grpc/Application/list.md
---

# SAML Application API, gRPC: ApplicationService.List

Retrieves the list of SAML applications in the specified organization.

## gRPC request

**rpc List ([ListApplicationsRequest](#yandex.cloud.organizationmanager.v1.idp.application.saml.ListApplicationsRequest)) returns ([ListApplicationsResponse](#yandex.cloud.organizationmanager.v1.idp.application.saml.ListApplicationsResponse))**

## ListApplicationsRequest {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListApplicationsRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

Request to list SAML applications in an organization.

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization to list applications in. ||
|| page_size | **int64**

The maximum number of results per page to return. ||
|| page_token | **string**

Page token for pagination. ||
|| filter | **string**

A filter expression that filters resources listed in the response. ||
|#

## ListApplicationsResponse {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListApplicationsResponse}

```json
{
  "applications": [
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
  ],
  "next_page_token": "string"
}
```

Response message for [ApplicationService.List](#List).

#|
||Field | Description ||
|| applications[] | **[Application](#yandex.cloud.organizationmanager.v1.idp.application.saml.Application)**

List of SAML applications. ||
|| next_page_token | **string**

Token for getting the next page of the list. ||
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