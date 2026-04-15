---
editable: false
---

# Security Deck Audit Trails Events: DeleteScanJob

## Event JSON schema {#yandex.cloud.audit.securitydeck.cspm.DeleteScanJob2-schema}

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
    "id": "string",
    "securityDeckScopeId": "string",
    "securityDeckWorkspaceId": "string",
    "createdAt": "string",
    "modifiedAt": "string",
    "lastRunAt": "string",
    "status": "string",
    "scope": {
      // Includes only one of the fields `yandexCloudOptions`
      "yandexCloudOptions": {
        "serviceAccountId": "string",
        "organizationId": "string",
        "includeResources": [
          {
            // Includes only one of the fields `cloud`, `folder`
            "cloud": {
              "cloudId": "string"
            },
            "folder": {
              "folderId": "string"
            }
            // end of the list of possible fields
          }
        ],
        "excludeResources": [
          {
            // Includes only one of the fields `cloud`, `folder`
            "cloud": {
              "cloudId": "string"
            },
            "folder": {
              "folderId": "string"
            }
            // end of the list of possible fields
          }
        ]
      }
      // end of the list of possible fields
    },
    "ruleIds": [
      "string"
    ],
    "trigger": {
      // Includes only one of the fields `schedule`
      "schedule": {
        // Includes only one of the fields `hours`
        "hours": "string"
        // end of the list of possible fields
      }
      // end of the list of possible fields
    },
    "alertSinkId": "string",
    "name": "string",
    "description": "string"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.securitydeck.cspm.DeleteScanJob2}

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
|| eventStatus | **enum** (SynchronousEventStatus)

- `ERROR`
- `DONE` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[ScanJobEventDetails](#yandex.cloud.audit.securitydeck.cspm.ScanJobEventDetails)** ||
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

## ScanJobEventDetails {#yandex.cloud.audit.securitydeck.cspm.ScanJobEventDetails}

#|
||Field | Description ||
|| id | **string** ||
|| securityDeckScopeId | **string** ||
|| securityDeckWorkspaceId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastRunAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

- `CREATING`
- `ACTIVE`
- `PAUSED`
- `UPDATING`
- `DELETING` ||
|| scope | **[ScopeDefinition](#yandex.cloud.audit.securitydeck.cspm.ScopeDefinition)** ||
|| ruleIds[] | **string** ||
|| trigger | **[Trigger](#yandex.cloud.audit.securitydeck.cspm.Trigger)** ||
|| alertSinkId | **string** ||
|| name | **string** ||
|| description | **string** ||
|#

## ScopeDefinition {#yandex.cloud.audit.securitydeck.cspm.ScopeDefinition}

#|
||Field | Description ||
|| yandexCloudOptions | **[YandexCloudScopeOptions](#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions)**

Includes only one of the fields `yandexCloudOptions`. ||
|#

## YandexCloudScopeOptions {#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions}

#|
||Field | Description ||
|| serviceAccountId | **string**

The maximum string length in characters is 50. ||
|| organizationId | **string** ||
|| includeResources[] | **[Resource](#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions.Resource)**

The number of elements must be in the range 0-255. ||
|| excludeResources[] | **[Resource](#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions.Resource)**

The number of elements must be in the range 0-255. ||
|#

## Resource {#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions.Resource}

#|
||Field | Description ||
|| cloud | **[Cloud](#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions.Resource.Cloud)**

Includes only one of the fields `cloud`, `folder`. ||
|| folder | **[Folder](#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions.Resource.Folder)**

Includes only one of the fields `cloud`, `folder`. ||
|#

## Cloud {#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions.Resource.Cloud}

#|
||Field | Description ||
|| cloudId | **string**

The maximum string length in characters is 50. ||
|#

## Folder {#yandex.cloud.audit.securitydeck.cspm.YandexCloudScopeOptions.Resource.Folder}

#|
||Field | Description ||
|| folderId | **string**

The maximum string length in characters is 50. ||
|#

## Trigger {#yandex.cloud.audit.securitydeck.cspm.Trigger}

#|
||Field | Description ||
|| schedule | **[Schedule](#yandex.cloud.audit.securitydeck.cspm.Schedule)**

Includes only one of the fields `schedule`. ||
|#

## Schedule {#yandex.cloud.audit.securitydeck.cspm.Schedule}

#|
||Field | Description ||
|| hours | **string** (int64)

The minimum value is 4.

Includes only one of the fields `hours`. ||
|#