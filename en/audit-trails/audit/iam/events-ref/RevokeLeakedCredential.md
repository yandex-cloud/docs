---
editable: false
---

# Identity and Access Management Audit Trails Events: RevokeLeakedCredential

## Event JSON schema {#yandex.cloud.audit.iam.RevokeLeakedCredential2-schema}

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
    "url": "string",
    // Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`
    "yandexCloudIamToken": {
      "iamTokenPart": "string",
      "iamTokenHash": "string",
      "expired": "boolean",
      // Includes only one of the fields `userAccount`, `serviceAccount`
      "userAccount": {
        "userAccountId": "string",
        "federationId": "string"
      },
      "serviceAccount": {
        "serviceAccountId": "string"
      }
      // end of the list of possible fields
    },
    "yandexCloudIamCookie": {
      "iamCookiePart": "string",
      "iamCookieHash": "string",
      "expired": "boolean",
      // Includes only one of the fields `userAccount`
      "userAccount": {
        "userAccountId": "string",
        "federationId": "string"
      }
      // end of the list of possible fields
    },
    "yandexCloudIamApiKey": {
      "iamApiKeyPart": "string",
      "keyId": "string",
      // Includes only one of the fields `serviceAccount`
      "serviceAccount": {
        "serviceAccountId": "string"
      }
      // end of the list of possible fields
    },
    "yandexCloudPassportOauthToken": {
      "passportOauthTokenPart": "string",
      // Includes only one of the fields `userAccount`
      "userAccount": {
        "userAccountId": "string",
        "federationId": "string"
      }
      // end of the list of possible fields
    },
    "yandexCloudIamAccessKey": {
      "keyId": "string",
      // Includes only one of the fields `serviceAccount`
      "serviceAccount": {
        "serviceAccountId": "string"
      }
      // end of the list of possible fields
    },
    "yandexCloudIamKey": {
      "keyId": "string",
      // Includes only one of the fields `serviceAccount`, `userAccount`
      "serviceAccount": {
        "serviceAccountId": "string"
      },
      "userAccount": {
        "userAccountId": "string",
        "federationId": "string"
      }
      // end of the list of possible fields
    },
    "yandexCloudSmartcaptchaServerKey": {
      "folderId": "string",
      "captchaId": "string",
      "clientKey": "string",
      "serverKeyPart": "string"
    },
    "yandexCloudLockboxSecret": {
      "secretId": "string",
      "versionId": "string",
      "keyId": "string"
    },
    "yandexCloudIamRefreshToken": {
      "iamRefreshTokenPart": "string",
      "iamRefreshTokenHash": "string",
      "keyId": "string",
      // Includes only one of the fields `userAccount`
      "userAccount": {
        "userAccountId": "string",
        "federationId": "string"
      }
      // end of the list of possible fields
    },
    "yandexCloudIamOauthClientSecret": {
      "folderId": "string",
      "secretId": "string",
      "clientId": "string"
    },
    // end of the list of possible fields
    "subject": {
      "subjectType": "string",
      "subjectId": "string",
      "subjectName": "string"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.iam.RevokeLeakedCredential2}

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
|| details | **[EventDetails](#yandex.cloud.audit.iam.DetectLeakedCredential.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.iam.DetectLeakedCredential.EventDetails}

#|
||Field | Description ||
|| url | **string** ||
|| yandexCloudIamToken | **[IamToken](#yandex.cloud.audit.iam.DetectLeakedCredential.IamToken)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudIamCookie | **[IamCookie](#yandex.cloud.audit.iam.DetectLeakedCredential.IamCookie)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudIamApiKey | **[IamApiKey](#yandex.cloud.audit.iam.DetectLeakedCredential.IamApiKey)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudPassportOauthToken | **[PassportOauthToken](#yandex.cloud.audit.iam.DetectLeakedCredential.PassportOauthToken)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudIamAccessKey | **[IamAccessKey](#yandex.cloud.audit.iam.DetectLeakedCredential.IamAccessKey)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudIamKey | **[IamKey](#yandex.cloud.audit.iam.DetectLeakedCredential.IamKey)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudSmartcaptchaServerKey | **[SmartCaptchaServerKey](#yandex.cloud.audit.iam.DetectLeakedCredential.SmartCaptchaServerKey)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudLockboxSecret | **[LockboxSecret](#yandex.cloud.audit.iam.DetectLeakedCredential.LockboxSecret)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudIamRefreshToken | **[IamRefreshToken](#yandex.cloud.audit.iam.DetectLeakedCredential.IamRefreshToken)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| yandexCloudIamOauthClientSecret | **[IamOAuthClientSecret](#yandex.cloud.audit.iam.DetectLeakedCredential.IamOAuthClientSecret)**

Includes only one of the fields `yandexCloudIamToken`, `yandexCloudIamCookie`, `yandexCloudIamApiKey`, `yandexCloudPassportOauthToken`, `yandexCloudIamAccessKey`, `yandexCloudIamKey`, `yandexCloudSmartcaptchaServerKey`, `yandexCloudLockboxSecret`, `yandexCloudIamRefreshToken`, `yandexCloudIamOauthClientSecret`. ||
|| subject | **[Subject](#yandex.cloud.audit.Subject)** ||
|#

## IamToken {#yandex.cloud.audit.iam.DetectLeakedCredential.IamToken}

#|
||Field | Description ||
|| iamTokenPart | **string** ||
|| iamTokenHash | **string** ||
|| expired | **boolean** ||
|| userAccount | **[UserAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.UserAccount)**

Includes only one of the fields `userAccount`, `serviceAccount`. ||
|| serviceAccount | **[ServiceAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.ServiceAccount)**

Includes only one of the fields `userAccount`, `serviceAccount`. ||
|#

## UserAccount {#yandex.cloud.audit.iam.DetectLeakedCredential.UserAccount}

#|
||Field | Description ||
|| userAccountId | **string** ||
|| federationId | **string** ||
|#

## ServiceAccount {#yandex.cloud.audit.iam.DetectLeakedCredential.ServiceAccount}

#|
||Field | Description ||
|| serviceAccountId | **string** ||
|#

## IamCookie {#yandex.cloud.audit.iam.DetectLeakedCredential.IamCookie}

#|
||Field | Description ||
|| iamCookiePart | **string** ||
|| iamCookieHash | **string** ||
|| expired | **boolean** ||
|| userAccount | **[UserAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.UserAccount)**

Includes only one of the fields `userAccount`. ||
|#

## IamApiKey {#yandex.cloud.audit.iam.DetectLeakedCredential.IamApiKey}

#|
||Field | Description ||
|| iamApiKeyPart | **string** ||
|| keyId | **string** ||
|| serviceAccount | **[ServiceAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.ServiceAccount)**

Includes only one of the fields `serviceAccount`. ||
|#

## PassportOauthToken {#yandex.cloud.audit.iam.DetectLeakedCredential.PassportOauthToken}

#|
||Field | Description ||
|| passportOauthTokenPart | **string** ||
|| userAccount | **[UserAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.UserAccount)**

Includes only one of the fields `userAccount`. ||
|#

## IamAccessKey {#yandex.cloud.audit.iam.DetectLeakedCredential.IamAccessKey}

#|
||Field | Description ||
|| keyId | **string** ||
|| serviceAccount | **[ServiceAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.ServiceAccount)**

Includes only one of the fields `serviceAccount`. ||
|#

## IamKey {#yandex.cloud.audit.iam.DetectLeakedCredential.IamKey}

#|
||Field | Description ||
|| keyId | **string** ||
|| serviceAccount | **[ServiceAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.ServiceAccount)**

Includes only one of the fields `serviceAccount`, `userAccount`. ||
|| userAccount | **[UserAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.UserAccount)**

Includes only one of the fields `serviceAccount`, `userAccount`. ||
|#

## SmartCaptchaServerKey {#yandex.cloud.audit.iam.DetectLeakedCredential.SmartCaptchaServerKey}

#|
||Field | Description ||
|| folderId | **string** ||
|| captchaId | **string** ||
|| clientKey | **string** ||
|| serverKeyPart | **string** ||
|#

## LockboxSecret {#yandex.cloud.audit.iam.DetectLeakedCredential.LockboxSecret}

#|
||Field | Description ||
|| secretId | **string** ||
|| versionId | **string** ||
|| keyId | **string** ||
|#

## IamRefreshToken {#yandex.cloud.audit.iam.DetectLeakedCredential.IamRefreshToken}

#|
||Field | Description ||
|| iamRefreshTokenPart | **string** ||
|| iamRefreshTokenHash | **string** ||
|| keyId | **string** ||
|| userAccount | **[UserAccount](#yandex.cloud.audit.iam.DetectLeakedCredential.UserAccount)**

Includes only one of the fields `userAccount`. ||
|#

## IamOAuthClientSecret {#yandex.cloud.audit.iam.DetectLeakedCredential.IamOAuthClientSecret}

#|
||Field | Description ||
|| folderId | **string** ||
|| secretId | **string** ||
|| clientId | **string** ||
|#

## Subject {#yandex.cloud.audit.Subject}

#|
||Field | Description ||
|| subjectType | **enum** (SubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT` ||
|| subjectId | **string**

The maximum string length in characters is 50. ||
|| subjectName | **string** ||
|#