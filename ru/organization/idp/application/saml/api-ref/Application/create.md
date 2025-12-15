---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization to create the application in.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Required field. Name of the SAML application.
            Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
          pattern: '[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the SAML application.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `` key:value `` pairs.
            No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        serviceProvider:
          description: |-
            **[ServiceProvider](#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider)**
            Service provider configuration for the SAML application.
          $ref: '#/definitions/ServiceProvider'
        securitySettings:
          description: |-
            **[SecuritySettingsSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettingsSpec)**
            Security settings for the SAML application.
          $ref: '#/definitions/SecuritySettingsSpec'
        attributeMapping:
          description: |-
            **[AttributeMappingSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMappingSpec)**
            Attribute mapping configuration for the SAML application.
          $ref: '#/definitions/AttributeMappingSpec'
        groupClaimsSettings:
          description: |-
            **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings)**
            Group claims settings for the SAML application.
          $ref: '#/definitions/GroupClaimsSettings'
      required:
        - organizationId
        - name
      additionalProperties: false
    definitions:
      AssertionConsumerServiceURL:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. The URL where SAML responses are sent.
              The maximum string length in characters is 8000.
            type: string
          index:
            description: |-
              **string** (int64)
              Optional index for the assertion consumer service.
            type: string
            format: int64
        required:
          - url
      SingleLogoutServiceURL:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. The URL where logout requests are sent.
              The maximum string length in characters is 8000.
            type: string
          responseUrl:
            description: |-
              **string**
              Optional separate URL for logout responses.
              The maximum string length in characters is 8000.
            type: string
          protocolBinding:
            description: |-
              **enum** (ProtocolBinding)
              Required field. Protocol binding supported by the logout endpoint.
              - `HTTP_POST`: HTTP POST binding.
              - `HTTP_REDIRECT`: HTTP Redirect binding.
            type: string
            enum:
              - PROTOCOL_BINDING_UNSPECIFIED
              - HTTP_POST
              - HTTP_REDIRECT
        required:
          - url
          - protocolBinding
      ServiceProvider:
        type: object
        properties:
          entityId:
            description: |-
              **string**
              Required field. Service provider entity ID.
              The maximum string length in characters is 8000.
            type: string
          acsUrls:
            description: |-
              **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL)**
              Assertion Consumer Service URLs.
              The number of elements must be in the range 1-100.
            type: array
            items:
              $ref: '#/definitions/AssertionConsumerServiceURL'
          sloUrls:
            description: |-
              **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL)**
              Single Logout Service URLs.
              The number of elements must be in the range 0-100.
            type: array
            items:
              $ref: '#/definitions/SingleLogoutServiceURL'
        required:
          - entityId
      SecuritySettingsSpec:
        type: object
        properties:
          signatureMode:
            description: |-
              **enum** (SignatureMode)
              Signature mode for SAML assertions and responses.
              - `ASSERTIONS`: Sign individual assertions.
              - `RESPONSE`: Sign the entire response.
              - `RESPONSE_AND_ASSERTIONS`: Sign both the response and individual assertions.
            type: string
            enum:
              - SIGNATURE_MODE_UNSPECIFIED
              - ASSERTIONS
              - RESPONSE
              - RESPONSE_AND_ASSERTIONS
      NameIdSpec:
        type: object
        properties:
          format:
            description: |-
              **enum** (Format)
              Required field. Format of the NameID.
              - `PERSISTENT`: Persistent NameID format.
              This provides a stable, opaque identifier for the user.
              - `EMAIL`: Email NameID format.
              This uses the user's email address as the identifier.
            type: string
            enum:
              - FORMAT_UNSPECIFIED
              - PERSISTENT
              - EMAIL
        required:
          - format
      Attribute:
        type: object
        properties:
          name:
            description: |-
              **string**
              Required field. Name of the SAML attribute.
              The maximum string length in characters is 8000.
            type: string
          value:
            description: |-
              **string**
              Required field. Value of the SAML attribute.
              The maximum string length in characters is 50.
            type: string
        required:
          - name
          - value
      AttributeMappingSpec:
        type: object
        properties:
          nameId:
            description: |-
              **[NameIdSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.NameIdSpec)**
              Required field. NameID configuration.
            $ref: '#/definitions/NameIdSpec'
          attributes:
            description: |-
              **[Attribute](#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute)**
              List of attribute mappings.
              The maximum number of elements is 50.
            type: array
            items:
              $ref: '#/definitions/Attribute'
        required:
          - nameId
      GroupClaimsSettings:
        type: object
        properties:
          groupDistributionType:
            description: |-
              **enum** (GroupDistributionType)
              Distribution type for group claims.
              - `NONE`: No groups are provided to the application.
              - `ASSIGNED_GROUPS`: Only assigned groups are provided to the application.
              - `ALL_GROUPS`: All groups are provided to the application.
            type: string
            enum:
              - GROUP_DISTRIBUTION_TYPE_UNSPECIFIED
              - NONE
              - ASSIGNED_GROUPS
              - ALL_GROUPS
          groupAttributeName:
            description: |-
              **string**
              Name of the SAML attribute that contains group information.
              The maximum string length in characters is 8000.
            type: string
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/saml/api-ref/Application/create.md
---

# SAML Application API, REST: Application.Create

Creates a SAML application in the specified organization.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications
```

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateApplicationRequest}

```json
{
  "organizationId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
    "signatureMode": "string"
  },
  "attributeMapping": {
    "nameId": {
      "format": "string"
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
  }
}
```

Request to create a new SAML application.

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to create the application in.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Name of the SAML application.

Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `. ||
|| description | **string**

Description of the SAML application.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs.

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|| serviceProvider | **[ServiceProvider](#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider)**

Service provider configuration for the SAML application. ||
|| securitySettings | **[SecuritySettingsSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettingsSpec)**

Security settings for the SAML application. ||
|| attributeMapping | **[AttributeMappingSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMappingSpec)**

Attribute mapping configuration for the SAML application. ||
|| groupClaimsSettings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings)**

Group claims settings for the SAML application. ||
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

## SecuritySettingsSpec {#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettingsSpec}

Security settings specification for SAML application creation.

#|
||Field | Description ||
|| signatureMode | **enum** (SignatureMode)

Signature mode for SAML assertions and responses.

- `ASSERTIONS`: Sign individual assertions.
- `RESPONSE`: Sign the entire response.
- `RESPONSE_AND_ASSERTIONS`: Sign both the response and individual assertions. ||
|#

## AttributeMappingSpec {#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMappingSpec}

Attribute mapping specification for SAML application.

#|
||Field | Description ||
|| nameId | **[NameIdSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.NameIdSpec)**

Required field. NameID configuration. ||
|| attributes[] | **[Attribute](#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute)**

List of attribute mappings.

The maximum number of elements is 50. ||
|#

## NameIdSpec {#yandex.cloud.organizationmanager.v1.idp.application.saml.NameIdSpec}

NameID specification for SAML application.

#|
||Field | Description ||
|| format | **enum** (Format)

Required field. Format of the NameID.

- `PERSISTENT`: Persistent NameID format.
This provides a stable, opaque identifier for the user.
- `EMAIL`: Email NameID format.
This uses the user's email address as the identifier. ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "applicationId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateApplicationMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateApplicationMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## CreateApplicationMetadata {#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateApplicationMetadata}

Metadata for the [ApplicationService.Create](#Create) operation.

#|
||Field | Description ||
|| applicationId | **string**

ID of the SAML application that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
|| serviceProvider | **[ServiceProvider](#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider2)**

Service provider configuration for the SAML application. ||
|| securitySettings | **[SecuritySettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings)**

Security settings for the SAML application. ||
|| attributeMapping | **[AttributeMapping](#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMapping)**

Attribute mapping configuration for the SAML application. ||
|| groupClaimsSettings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings2)**

Group claims settings for the SAML application. ||
|| identityProviderMetadata | **[IdentityProviderMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.IdentityProviderMetadata)**

Identity provider metadata for the SAML application. ||
|#

## ServiceProvider {#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider2}

Service provider configuration for SAML applications.

#|
||Field | Description ||
|| entityId | **string**

Required field. Service provider entity ID.

The maximum string length in characters is 8000. ||
|| acsUrls[] | **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL2)**

Assertion Consumer Service URLs.

The number of elements must be in the range 1-100. ||
|| sloUrls[] | **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL2)**

Single Logout Service URLs.

The number of elements must be in the range 0-100. ||
|#

## AssertionConsumerServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL2}

Assertion Consumer Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where SAML responses are sent.

The maximum string length in characters is 8000. ||
|| index | **string** (int64)

Optional index for the assertion consumer service. ||
|#

## SingleLogoutServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL2}

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
|| attributes[] | **[Attribute](#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute2)**

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

## Attribute {#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute2}

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

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings2}

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