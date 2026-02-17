---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization to list applications in.
            The maximum string length in characters is 50.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return.
            Acceptable values are 0 to 1000, inclusive.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for pagination.
            The maximum string length in characters is 2000.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The maximum string length in characters is 1000.
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
---

# SAML Application API, REST: Application.List

Retrieves the list of SAML applications in the specified organization.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications
```

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListApplicationsRequest}

Request to list SAML applications in an organization.

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to list applications in.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token for pagination.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.application.saml.ListApplicationsResponse}

**HTTP Code: 200 - OK**

```json
{
  "applications": [
    {
      "id": "string",
      "organizationId": "string",
      "name": "string",
      "description": "string",
      "status": "string",
      "labels": "object",
      "createdAt": "string",
      "updatedAt": "string",
      "serviceProvider": {
        "entityId": "string",
        "acsUrls": [
          {
            "url": "string",
            "index": "string"
          }
        ],
        "sloUrls": [
          {
            "url": "string",
            "responseUrl": "string",
            "protocolBinding": "string"
          }
        ]
      },
      "securitySettings": {
        "signatureMode": "string",
        "signatureCertificateId": "string"
      },
      "attributeMapping": {
        "nameId": {
          "format": "string",
          "value": "string"
        },
        "attributes": [
          {
            "name": "string",
            "value": "string"
          }
        ]
      },
      "groupClaimsSettings": {
        "groupDistributionType": "string",
        "groupAttributeName": "string"
      },
      "identityProviderMetadata": {
        "issuer": "string",
        "ssoUrl": "string",
        "metadataUrl": "string",
        "sloUrl": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

Response message for [ApplicationService.List](#List).

#|
||Field | Description ||
|| applications[] | **[Application](#yandex.cloud.organizationmanager.v1.idp.application.saml.Application)**

List of SAML applications. ||
|| nextPageToken | **string**

Token for getting the next page of the list. ||
|#

## Application {#yandex.cloud.organizationmanager.v1.idp.application.saml.Application}

A SAML application resource.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the SAML application. ||
|| organizationId | **string**

ID of the organization that the application belongs to. ||
|| name | **string**

Name of the SAML application. ||
|| description | **string**

Description of the SAML application. ||
|| status | **enum** (Status)

Current status of the SAML application.

- `CREATING`: The application is in the process of being created.
- `ACTIVE`: The application is active and can be used for authentication.
- `SUSPENDED`: The application is suspended. I.e. authentication via this application is disabled.
- `DELETING`: The application is in the process of being deleted. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Modification timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| serviceProvider | **[ServiceProvider](#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider)**

Service provider configuration for the SAML application. ||
|| securitySettings | **[SecuritySettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings)**

Security settings for the SAML application. ||
|| attributeMapping | **[AttributeMapping](#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMapping)**

Attribute mapping configuration for the SAML application. ||
|| groupClaimsSettings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings)**

Group claims settings for the SAML application. ||
|| identityProviderMetadata | **[IdentityProviderMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.IdentityProviderMetadata)**

Identity provider metadata for the SAML application. ||
|#

## ServiceProvider {#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider}

Service provider configuration for SAML applications.

#|
||Field | Description ||
|| entityId | **string**

Required field. Service provider entity ID.

The maximum string length in characters is 8000. ||
|| acsUrls[] | **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL)**

Assertion Consumer Service URLs.

The number of elements must be in the range 1-100. ||
|| sloUrls[] | **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL)**

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
|| index | **string** (int64)

Optional index for the assertion consumer service. ||
|#

## SingleLogoutServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL}

Single Logout Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where logout requests are sent.

The maximum string length in characters is 8000. ||
|| responseUrl | **string**

Optional separate URL for logout responses.

The maximum string length in characters is 8000. ||
|| protocolBinding | **enum** (ProtocolBinding)

Required field. Protocol binding supported by the logout endpoint.

- `HTTP_POST`: HTTP POST binding.
- `HTTP_REDIRECT`: HTTP Redirect binding. ||
|#

## SecuritySettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings}

Security settings for SAML applications.

#|
||Field | Description ||
|| signatureMode | **enum** (SignatureMode)

Signature mode for SAML messages.

- `ASSERTIONS`: Sign individual assertions.
- `RESPONSE`: Sign the entire response.
- `RESPONSE_AND_ASSERTIONS`: Sign both the response and individual assertions. ||
|| signatureCertificateId | **string**

ID of the signature certificate to use. ||
|#

## AttributeMapping {#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMapping}

Attribute mapping configuration for SAML applications.

#|
||Field | Description ||
|| nameId | **[NameId](#yandex.cloud.organizationmanager.v1.idp.application.saml.NameId)**

Required field. NameID configuration for the SAML application. ||
|| attributes[] | **[Attribute](#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute)**

List of attribute mappings.

The maximum number of elements is 50. ||
|#

## NameId {#yandex.cloud.organizationmanager.v1.idp.application.saml.NameId}

NameID configuration for SAML applications.

#|
||Field | Description ||
|| format | **enum** (Format)

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
|| groupDistributionType | **enum** (GroupDistributionType)

Distribution type for group claims.

- `NONE`: No groups are provided to the application.
- `ASSIGNED_GROUPS`: Only assigned groups are provided to the application.
- `ALL_GROUPS`: All groups are provided to the application. ||
|| groupAttributeName | **string**

Name of the SAML attribute that contains group information.

The maximum string length in characters is 8000. ||
|#

## IdentityProviderMetadata {#yandex.cloud.organizationmanager.v1.idp.application.saml.IdentityProviderMetadata}

Identity provider metadata for SAML applications.

#|
||Field | Description ||
|| issuer | **string**

Identity provider issuer identifier. ||
|| ssoUrl | **string**

Identity provider Single Sign-On URL. ||
|| metadataUrl | **string**

Identity provider metadata URL. ||
|| sloUrl | **string**

Identity provider Single Logout URL. ||
|#