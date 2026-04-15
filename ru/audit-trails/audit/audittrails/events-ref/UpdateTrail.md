---
editable: false
---

# Audit Trails Events: UpdateTrail

## Event JSON schema {#yandex.cloud.audit.audittrails.UpdateTrail2-schema}

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
    "trailId": "string",
    "trailName": "string",
    "destination": {
      // Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`
      "objectStorage": {
        "bucketId": "string",
        // Includes only one of the fields `objectPrefix`
        "objectPrefix": "string"
        // end of the list of possible fields
      },
      "cloudLogging": {
        // Includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string"
        // end of the list of possible fields
      },
      "dataStream": {
        "databaseId": "string",
        "streamName": "string",
        // Includes only one of the fields `codec`
        "codec": "string"
        // end of the list of possible fields
      },
      "eventrouter": {
        "eventrouterConnectorId": "string"
      }
      // end of the list of possible fields
    },
    // Includes only one of the fields `serviceAccountId`
    "serviceAccountId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `status`
    "status": "string",
    // end of the list of possible fields
    "pathFilter": {
      "root": {
        // Includes only one of the fields `anyFilter`, `someFilter`
        "anyFilter": {
          "resource": {
            "id": "string",
            "type": "string"
          }
        },
        "someFilter": {
          "resource": {
            "id": "string",
            "type": "string"
          },
          "filters": [
            "object"
          ]
        }
        // end of the list of possible fields
      }
    },
    "eventFilter": {
      "dataplaneFilters": [
        {
          "service": "string"
        }
      ]
    },
    "filteringPolicy": {
      "managementEventsFilter": {
        "resourceScopes": [
          {
            "id": "string",
            "type": "string"
          }
        ]
      },
      "dataEventsFilters": [
        {
          "service": "string",
          // Includes only one of the fields `includedEvents`, `excludedEvents`
          "includedEvents": {
            "eventTypes": [
              "string"
            ]
          },
          "excludedEvents": {
            "eventTypes": [
              "string"
            ]
          },
          // end of the list of possible fields
          "resourceScopes": [
            {
              "id": "string",
              "type": "string"
            }
          ]
        }
      ]
    },
    // Includes only one of the fields `description`
    "description": "string",
    // end of the list of possible fields
    "labels": "object"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.audittrails.UpdateTrail2}

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
|| details | **[EventDetails](#yandex.cloud.audit.audittrails.UpdateTrail.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.audittrails.UpdateTrail.EventDetails}

#|
||Field | Description ||
|| trailId | **string** ||
|| trailName | **string** ||
|| destination | **[Destination](#yandex.cloud.audit.audittrails.Destination)** ||
|| serviceAccountId | **string**

Includes only one of the fields `serviceAccountId`. ||
|| status | **enum** (TrailStatus)

Includes only one of the fields `status`.

- `ACTIVE`
- `ERROR`
- `DELETED` ||
|| pathFilter | **[PathFilter](#yandex.cloud.audit.audittrails.PathFilter)** ||
|| eventFilter | **[EventFilter](#yandex.cloud.audit.audittrails.EventFilter)** ||
|| filteringPolicy | **[FilteringPolicy](#yandex.cloud.audit.audittrails.FilteringPolicy)** ||
|| description | **string**

The maximum string length in characters is 1024.

Includes only one of the fields `description`. ||
|| labels | **object** (map<**string**, **string**>)

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|#

## Destination {#yandex.cloud.audit.audittrails.Destination}

#|
||Field | Description ||
|| objectStorage | **[ObjectStorage](#yandex.cloud.audit.audittrails.ObjectStorage)**

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| cloudLogging | **[CloudLogging](#yandex.cloud.audit.audittrails.CloudLogging)**

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| dataStream | **[DataStream](#yandex.cloud.audit.audittrails.DataStream)**

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|| eventrouter | **[EventRouter](#yandex.cloud.audit.audittrails.EventRouter)**

Includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`, `eventrouter`. ||
|#

## ObjectStorage {#yandex.cloud.audit.audittrails.ObjectStorage}

#|
||Field | Description ||
|| bucketId | **string** ||
|| objectPrefix | **string**

Includes only one of the fields `objectPrefix`. ||
|#

## CloudLogging {#yandex.cloud.audit.audittrails.CloudLogging}

#|
||Field | Description ||
|| logGroupId | **string**

Includes only one of the fields `logGroupId`, `folderId`. ||
|| folderId | **string**

Includes only one of the fields `logGroupId`, `folderId`. ||
|#

## DataStream {#yandex.cloud.audit.audittrails.DataStream}

#|
||Field | Description ||
|| databaseId | **string** ||
|| streamName | **string** ||
|| codec | **enum** (Codec)

Includes only one of the fields `codec`.

- `RAW`
- `GZIP`
- `ZSTD` ||
|#

## EventRouter {#yandex.cloud.audit.audittrails.EventRouter}

#|
||Field | Description ||
|| eventrouterConnectorId | **string** ||
|#

## PathFilter {#yandex.cloud.audit.audittrails.PathFilter}

#|
||Field | Description ||
|| root | **[PathFilterElement](#yandex.cloud.audit.audittrails.PathFilterElement)** ||
|#

## PathFilterElement {#yandex.cloud.audit.audittrails.PathFilterElement}

#|
||Field | Description ||
|| anyFilter | **[PathFilterElementAny](#yandex.cloud.audit.audittrails.PathFilterElementAny)**

Includes only one of the fields `anyFilter`, `someFilter`. ||
|| someFilter | **[PathFilterElementSome](#yandex.cloud.audit.audittrails.PathFilterElementSome)**

Includes only one of the fields `anyFilter`, `someFilter`. ||
|#

## PathFilterElementAny {#yandex.cloud.audit.audittrails.PathFilterElementAny}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.audit.audittrails.Resource)** ||
|#

## Resource {#yandex.cloud.audit.audittrails.Resource}

#|
||Field | Description ||
|| id | **string**

The maximum string length in characters is 64. ||
|| type | **string**

The maximum string length in characters is 50. ||
|#

## PathFilterElementSome {#yandex.cloud.audit.audittrails.PathFilterElementSome}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.audit.audittrails.Resource)** ||
|| filters[] | **[PathFilterElement](#yandex.cloud.audit.audittrails.PathFilterElement)**

The number of elements must be greater than 0. ||
|#

## EventFilter {#yandex.cloud.audit.audittrails.EventFilter}

#|
||Field | Description ||
|| dataplaneFilters[] | **[EventFilterElement](#yandex.cloud.audit.audittrails.EventFilterElement)**

The minimum number of elements is 0. ||
|#

## EventFilterElement {#yandex.cloud.audit.audittrails.EventFilterElement}

#|
||Field | Description ||
|| service | **string** ||
|#

## FilteringPolicy {#yandex.cloud.audit.audittrails.FilteringPolicy}

#|
||Field | Description ||
|| managementEventsFilter | **[ManagementEventsFiltering](#yandex.cloud.audit.audittrails.ManagementEventsFiltering)** ||
|| dataEventsFilters[] | **[DataEventsFiltering](#yandex.cloud.audit.audittrails.DataEventsFiltering)**

The number of elements must be less than 128. ||
|#

## ManagementEventsFiltering {#yandex.cloud.audit.audittrails.ManagementEventsFiltering}

#|
||Field | Description ||
|| resourceScopes[] | **[Resource](#yandex.cloud.audit.audittrails.Resource)**

The number of elements must be in the range 1-1024. ||
|#

## DataEventsFiltering {#yandex.cloud.audit.audittrails.DataEventsFiltering}

#|
||Field | Description ||
|| service | **string** ||
|| includedEvents | **[EventTypes](#yandex.cloud.audit.audittrails.EventTypes)**

Includes only one of the fields `includedEvents`, `excludedEvents`. ||
|| excludedEvents | **[EventTypes](#yandex.cloud.audit.audittrails.EventTypes)**

Includes only one of the fields `includedEvents`, `excludedEvents`. ||
|| resourceScopes[] | **[Resource](#yandex.cloud.audit.audittrails.Resource)**

The number of elements must be in the range 1-1024. ||
|#

## EventTypes {#yandex.cloud.audit.audittrails.EventTypes}

#|
||Field | Description ||
|| eventTypes[] | **string**

The number of elements must be in the range 1-1024. ||
|#