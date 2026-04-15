---
editable: false
---

# Identity Hub Audit Trails Events: ReactivateApplication

## Event JSON schema {#yandex.cloud.audit.organizationmanager.application.saml.ReactivateApplication2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "applicationId": "string",
    "applicationName": "string",
    "status": "string",
    "serviceProvider": {
      "entityId": "string",
      "acsUrls": [
        {
          "url": "string",
          "index": "string"
        }
      ]
    },
    "securitySettings": {
      "signatureMode": "string",
      "signatureCertificateId": "string",
      "requestSigning": {
        "requireRequestSigning": "boolean"
      },
      "responseEncryption": {
        "requireResponseEncryption": "boolean",
        "encryptionCertificateId": "string",
        "dataEncryptionAlgorithm": "string",
        "keyEncryptionAlgorithm": "string"
      }
    },
    "groupClaimsSettings": {
      "groupDistributionType": "string",
      "groupAttributeName": "string"
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
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.organizationmanager.application.saml.ReactivateApplication2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ApplicationDetails](#yandex.cloud.audit.organizationmanager.application.saml.ApplicationDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## ApplicationDetails {#yandex.cloud.audit.organizationmanager.application.saml.ApplicationDetails}

#|
||Field | Description ||
|| applicationId | **string** ||
|| applicationName | **string** ||
|| status | **enum** (Status)

- `CREATING`
- `ACTIVE`
- `SUSPENDED`
- `DELETING` ||
|| serviceProvider | **[ServiceProviderDetails](#yandex.cloud.audit.organizationmanager.application.saml.ServiceProviderDetails)** ||
|| securitySettings | **[SecuritySettingsDetails](#yandex.cloud.audit.organizationmanager.application.saml.SecuritySettingsDetails)** ||
|| groupClaimsSettings | **[GroupClaimsSettingsDetails](#yandex.cloud.audit.organizationmanager.application.saml.GroupClaimsSettingsDetails)** ||
|| attributeMapping | **[AttributeMappingDetails](#yandex.cloud.audit.organizationmanager.application.saml.AttributeMappingDetails)** ||
|#

## ServiceProviderDetails {#yandex.cloud.audit.organizationmanager.application.saml.ServiceProviderDetails}

#|
||Field | Description ||
|| entityId | **string** ||
|| acsUrls[] | **[AssertionConsumerServiceURLDetails](#yandex.cloud.audit.organizationmanager.application.saml.AssertionConsumerServiceURLDetails)** ||
|#

## AssertionConsumerServiceURLDetails {#yandex.cloud.audit.organizationmanager.application.saml.AssertionConsumerServiceURLDetails}

#|
||Field | Description ||
|| url | **string** ||
|| index | **string** (int64) ||
|#

## SecuritySettingsDetails {#yandex.cloud.audit.organizationmanager.application.saml.SecuritySettingsDetails}

#|
||Field | Description ||
|| signatureMode | **enum** (SignatureMode)

- `ASSERTIONS`
- `RESPONSE`
- `RESPONSE_AND_ASSERTIONS` ||
|| signatureCertificateId | **string** ||
|| requestSigning | **[RequestSigning](#yandex.cloud.audit.organizationmanager.application.saml.RequestSigning)** ||
|| responseEncryption | **[ResponseEncryption](#yandex.cloud.audit.organizationmanager.application.saml.ResponseEncryption)** ||
|#

## RequestSigning {#yandex.cloud.audit.organizationmanager.application.saml.RequestSigning}

#|
||Field | Description ||
|| requireRequestSigning | **boolean** ||
|#

## ResponseEncryption {#yandex.cloud.audit.organizationmanager.application.saml.ResponseEncryption}

#|
||Field | Description ||
|| requireResponseEncryption | **boolean** ||
|| encryptionCertificateId | **string** ||
|| dataEncryptionAlgorithm | **enum** (DataEncryptionAlgorithm)

- `AES_128_CBC`
- `AES_256_CBC` ||
|| keyEncryptionAlgorithm | **enum** (KeyEncryptionAlgorithm)

- `RSA_OAEP_SHA1`
- `RSA_OAEP_SHA256` ||
|#

## GroupClaimsSettingsDetails {#yandex.cloud.audit.organizationmanager.application.saml.GroupClaimsSettingsDetails}

#|
||Field | Description ||
|| groupDistributionType | **enum** (GroupDistributionType)

- `NONE`
- `ASSIGNED_GROUPS`
- `ALL_GROUPS` ||
|| groupAttributeName | **string** ||
|#

## AttributeMappingDetails {#yandex.cloud.audit.organizationmanager.application.saml.AttributeMappingDetails}

#|
||Field | Description ||
|| nameId | **[NameId](#yandex.cloud.audit.organizationmanager.application.saml.AttributeMappingDetails.NameId)** ||
|| attributes[] | **[Attribute](#yandex.cloud.audit.organizationmanager.application.saml.AttributeMappingDetails.Attribute)** ||
|#

## NameId {#yandex.cloud.audit.organizationmanager.application.saml.AttributeMappingDetails.NameId}

#|
||Field | Description ||
|| format | **enum** (Format)

- `PERSISTENT`
- `EMAIL` ||
|| value | **string** ||
|#

## Attribute {#yandex.cloud.audit.organizationmanager.application.saml.AttributeMappingDetails.Attribute}

#|
||Field | Description ||
|| name | **string** ||
|| value | **string** ||
|#