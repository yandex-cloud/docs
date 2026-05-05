---
editable: false
---

# Identity Hub Audit Trails Events: ValidateUserpoolDomain

## Event JSON schema {#yandex.cloud.audit.organizationmanager.idp.ValidateUserpoolDomain2-schema}

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
    "userpoolId": "string",
    "userpoolName": "string",
    "status": "string",
    "domains": [
      "string"
    ],
    "userSettings": {
      "allowEditSelfPassword": "boolean",
      "allowEditSelfInfo": "boolean",
      "allowEditSelfContacts": "boolean",
      "allowEditSelfLogin": "boolean",
      "allowEditSelfJobInfo": "boolean"
    },
    "passwordQualityPolicy": {
      "allowSimilar": "boolean",
      "maxLength": "string",
      "matchLength": "string",
      // Includes only one of the fields `fixed`, `smart`
      "fixed": {
        "lowersRequired": "boolean",
        "uppersRequired": "boolean",
        "digitsRequired": "boolean",
        "specialsRequired": "boolean",
        "minLength": "string"
      },
      "smart": {
        "oneClass": "string",
        "twoClasses": "string",
        "threeClasses": "string",
        "fourClasses": "string"
      }
      // end of the list of possible fields
    },
    "passwordLifetimePolicy": {
      "minDaysCount": "string",
      "maxDaysCount": "string"
    },
    "bruteforceProtectionPolicy": {
      "window": "string",
      "block": "string",
      "attempts": "string"
    },
    "cookieMaxAge": "string",
    "passwordBlacklistPolicy": {
      "checkCommon": "boolean"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.organizationmanager.idp.ValidateUserpoolDomain2}

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
|| details | **[UserpoolEventDetails](#yandex.cloud.audit.organizationmanager.idp.UserpoolEventDetails)** ||
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

## UserpoolEventDetails {#yandex.cloud.audit.organizationmanager.idp.UserpoolEventDetails}

#|
||Field | Description ||
|| userpoolId | **string** ||
|| userpoolName | **string** ||
|| status | **enum** (Status)

- `CREATING`
- `ACTIVE`
- `DELETING` ||
|| domains[] | **string** ||
|| userSettings | **[UserSettings](#yandex.cloud.audit.organizationmanager.idp.UserSettings)** ||
|| passwordQualityPolicy | **[PasswordQualityPolicy](#yandex.cloud.audit.organizationmanager.idp.PasswordQualityPolicy)** ||
|| passwordLifetimePolicy | **[PasswordLifetimePolicy](#yandex.cloud.audit.organizationmanager.idp.PasswordLifetimePolicy)** ||
|| bruteforceProtectionPolicy | **[BruteforceProtectionPolicy](#yandex.cloud.audit.organizationmanager.idp.BruteforceProtectionPolicy)** ||
|| cookieMaxAge | **string** (duration) ||
|| passwordBlacklistPolicy | **[PasswordBlacklistPolicy](#yandex.cloud.audit.organizationmanager.idp.PasswordBlacklistPolicy)** ||
|#

## UserSettings {#yandex.cloud.audit.organizationmanager.idp.UserSettings}

#|
||Field | Description ||
|| allowEditSelfPassword | **boolean** ||
|| allowEditSelfInfo | **boolean** ||
|| allowEditSelfContacts | **boolean** ||
|| allowEditSelfLogin | **boolean** ||
|| allowEditSelfJobInfo | **boolean** ||
|#

## PasswordQualityPolicy {#yandex.cloud.audit.organizationmanager.idp.PasswordQualityPolicy}

#|
||Field | Description ||
|| allowSimilar | **boolean** ||
|| maxLength | **string** (int64) ||
|| matchLength | **string** (int64) ||
|| fixed | **[Fixed](#yandex.cloud.audit.organizationmanager.idp.PasswordQualityPolicy.Fixed)**

Includes only one of the fields `fixed`, `smart`. ||
|| smart | **[Smart](#yandex.cloud.audit.organizationmanager.idp.PasswordQualityPolicy.Smart)**

Includes only one of the fields `fixed`, `smart`. ||
|#

## Fixed {#yandex.cloud.audit.organizationmanager.idp.PasswordQualityPolicy.Fixed}

#|
||Field | Description ||
|| lowersRequired | **boolean** ||
|| uppersRequired | **boolean** ||
|| digitsRequired | **boolean** ||
|| specialsRequired | **boolean** ||
|| minLength | **string** (int64) ||
|#

## Smart {#yandex.cloud.audit.organizationmanager.idp.PasswordQualityPolicy.Smart}

#|
||Field | Description ||
|| oneClass | **string** (int64) ||
|| twoClasses | **string** (int64) ||
|| threeClasses | **string** (int64) ||
|| fourClasses | **string** (int64) ||
|#

## PasswordLifetimePolicy {#yandex.cloud.audit.organizationmanager.idp.PasswordLifetimePolicy}

#|
||Field | Description ||
|| minDaysCount | **string** (int64) ||
|| maxDaysCount | **string** (int64) ||
|#

## BruteforceProtectionPolicy {#yandex.cloud.audit.organizationmanager.idp.BruteforceProtectionPolicy}

#|
||Field | Description ||
|| window | **string** (duration) ||
|| block | **string** (duration) ||
|| attempts | **string** (int64) ||
|#

## PasswordBlacklistPolicy {#yandex.cloud.audit.organizationmanager.idp.PasswordBlacklistPolicy}

#|
||Field | Description ||
|| checkCommon | **boolean** ||
|#