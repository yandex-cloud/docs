---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications/{applicationId}
    method: patch
    path:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the SAML application to update.
          type: string
      required:
        - applicationId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            New name for the SAML application.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            New description for the SAML application.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            New resource labels as `` key:value `` pairs.
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
            New service provider configuration for the SAML application.
          $ref: '#/definitions/ServiceProvider'
        securitySettings:
          description: |-
            **[SecuritySettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings)**
            New security settings for the SAML application.
          $ref: '#/definitions/SecuritySettings'
        attributeMapping:
          description: |-
            **[AttributeMappingSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMappingSpec)**
            New attribute mapping configuration for the SAML application.
          $ref: '#/definitions/AttributeMappingSpec'
        groupClaimsSettings:
          description: |-
            **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings)**
            New group claims settings for the SAML application.
          $ref: '#/definitions/GroupClaimsSettings'
      additionalProperties: false
    definitions:
      AssertionConsumerServiceURL:
        type: object
        properties:
          url:
            description: |-
              **string**
              Required field. The URL where SAML responses are sent.
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
            type: string
          responseUrl:
            description: |-
              **string**
              Optional separate URL for logout responses.
            type: string
          protocolBinding:
            description: |-
              **enum** (ProtocolBinding)
              Required field. Protocol binding supported by the logout endpoint.
              - `PROTOCOL_BINDING_UNSPECIFIED`: The protocol binding is not specified.
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
            type: string
          acsUrls:
            description: |-
              **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL)**
              Assertion Consumer Service URLs.
            type: array
            items:
              $ref: '#/definitions/AssertionConsumerServiceURL'
          sloUrls:
            description: |-
              **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL)**
              Single Logout Service URLs.
            type: array
            items:
              $ref: '#/definitions/SingleLogoutServiceURL'
        required:
          - entityId
      SecuritySettings:
        type: object
        properties:
          signatureMode:
            description: |-
              **enum** (SignatureMode)
              Signature mode for SAML messages.
              - `SIGNATURE_MODE_UNSPECIFIED`: The signature mode is not specified.
              - `ASSERTIONS`: Sign individual assertions.
              - `RESPONSE`: Sign the entire response.
              - `RESPONSE_AND_ASSERTIONS`: Sign both the response and individual assertions.
            type: string
            enum:
              - SIGNATURE_MODE_UNSPECIFIED
              - ASSERTIONS
              - RESPONSE
              - RESPONSE_AND_ASSERTIONS
          signatureCertificateId:
            description: |-
              **string**
              ID of the signature certificate to use.
            type: string
      NameIdSpec:
        type: object
        properties:
          format:
            description: |-
              **enum** (Format)
              Required field. Format of the NameID.
              - `FORMAT_UNSPECIFIED`: The NameID format is not specified.
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
            type: string
          value:
            description: |-
              **string**
              Required field. Value of the SAML attribute.
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
              - `GROUP_DISTRIBUTION_TYPE_UNSPECIFIED`: The group distribution type is not specified.
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
            type: string
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/saml/api-ref/Application/update.md
---

# SAML Application API, REST: Application.Update

Updates the specified SAML application.

## HTTP request

```
PATCH https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/applications/{applicationId}
```

## Path parameters

Request to update an existing SAML application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the SAML application to update. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateApplicationRequest}

```json
{
  "updateMask": "string",
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
    "signatureMode": "string",
    "signatureCertificateId": "string"
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

Request to update an existing SAML application.

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name for the SAML application. ||
|| description | **string**

New description for the SAML application. ||
|| labels | **object** (map<**string**, **string**>)

New resource labels as `` key:value `` pairs. ||
|| serviceProvider | **[ServiceProvider](#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider)**

New service provider configuration for the SAML application. ||
|| securitySettings | **[SecuritySettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings)**

New security settings for the SAML application. ||
|| attributeMapping | **[AttributeMappingSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMappingSpec)**

New attribute mapping configuration for the SAML application. ||
|| groupClaimsSettings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings)**

New group claims settings for the SAML application. ||
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

## AttributeMappingSpec {#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMappingSpec}

Attribute mapping specification for SAML application.

#|
||Field | Description ||
|| nameId | **[NameIdSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.NameIdSpec)**

Required field. NameID configuration. ||
|| attributes[] | **[Attribute](#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute)**

List of attribute mappings. ||
|#

## NameIdSpec {#yandex.cloud.organizationmanager.v1.idp.application.saml.NameIdSpec}

NameID specification for SAML application.

#|
||Field | Description ||
|| format | **enum** (Format)

Required field. Format of the NameID.

- `FORMAT_UNSPECIFIED`: The NameID format is not specified.
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
|| metadata | **[UpdateApplicationMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateApplicationMetadata)**

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

## UpdateApplicationMetadata {#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateApplicationMetadata}

Metadata for the [ApplicationService.Update](#Update) operation.

#|
||Field | Description ||
|| applicationId | **string**

ID of the SAML application that is being updated. ||
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
|| serviceProvider | **[ServiceProvider](#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider2)**

Service provider configuration for the SAML application. ||
|| securitySettings | **[SecuritySettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings2)**

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

Required field. Service provider entity ID. ||
|| acsUrls[] | **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL2)**

Assertion Consumer Service URLs. ||
|| sloUrls[] | **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL2)**

Single Logout Service URLs. ||
|#

## AssertionConsumerServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL2}

Assertion Consumer Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where SAML responses are sent. ||
|| index | **string** (int64)

Optional index for the assertion consumer service. ||
|#

## SingleLogoutServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL2}

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

## SecuritySettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings2}

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
|| attributes[] | **[Attribute](#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute2)**

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

## Attribute {#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute2}

Attribute mapping for SAML applications.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SAML attribute. ||
|| value | **string**

Required field. Value of the SAML attribute. ||
|#

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings2}

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