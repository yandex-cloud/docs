---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications/{applicationId}
    method: get
    path:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the SAML application to return.
          type: string
      required:
        - applicationId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/saml/api-ref/Application/get.md
---

# SAML Application API, REST: Application.Get

Returns the specified SAML application.

To get the list of available applications, make a [List](/docs/organization/idp/application/saml/mapi-ref/Application/list#List) request.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications/{applicationId}
```

## Path parameters

Request to get a SAML application by ID.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the SAML application to return. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.application.saml.Application}

**HTTP Code: 200 - OK**

```json
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
```

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

- `STATUS_UNSPECIFIED`: The status is not specified.
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

Required field. Service provider entity ID. ||
|| acsUrls[] | **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL)**

Assertion Consumer Service URLs. ||
|| sloUrls[] | **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL)**

Single Logout Service URLs. ||
|#

## AssertionConsumerServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL}

Assertion Consumer Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where SAML responses are sent. ||
|| index | **string** (int64)

Optional index for the assertion consumer service. ||
|#

## SingleLogoutServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL}

Single Logout Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where logout requests are sent. ||
|| responseUrl | **string**

Optional separate URL for logout responses. ||
|| protocolBinding | **enum** (ProtocolBinding)

Required field. Protocol binding supported by the logout endpoint.

- `PROTOCOL_BINDING_UNSPECIFIED`: The protocol binding is not specified.
- `HTTP_POST`: HTTP POST binding.
- `HTTP_REDIRECT`: HTTP Redirect binding. ||
|#

## SecuritySettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings}

Security settings for SAML applications.

#|
||Field | Description ||
|| signatureMode | **enum** (SignatureMode)

Signature mode for SAML messages.

- `SIGNATURE_MODE_UNSPECIFIED`: The signature mode is not specified.
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

List of attribute mappings. ||
|#

## NameId {#yandex.cloud.organizationmanager.v1.idp.application.saml.NameId}

NameID configuration for SAML applications.

#|
||Field | Description ||
|| format | **enum** (Format)

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
|| groupDistributionType | **enum** (GroupDistributionType)

Distribution type for group claims.

- `GROUP_DISTRIBUTION_TYPE_UNSPECIFIED`: The group distribution type is not specified.
- `NONE`: No groups are provided to the application.
- `ASSIGNED_GROUPS`: Only assigned groups are provided to the application.
- `ALL_GROUPS`: All groups are provided to the application. ||
|| groupAttributeName | **string**

Name of the SAML attribute that contains group information. ||
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