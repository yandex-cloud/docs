---
editable: false
---

# Compute Audit Trails Events: DeleteSnapshotSchedule

## Event JSON schema {#yandex.cloud.audit.compute.DeleteSnapshotSchedule2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    "subjectType": "string",
    "subjectId": "string",
    "subjectName": "string",
    "federationId": "string",
    "federationName": "string",
    "federationType": "string",
    "tokenInfo": {
      "maskedIamToken": "string",
      "iamTokenId": "string",
      "impersonatorId": "string",
      "impersonatorType": "string",
      "impersonatorName": "string",
      "impersonatorFederationId": "string",
      "impersonatorFederationName": "string",
      "impersonatorFederationType": "string"
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
        "resourceName": "string"
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    "remotePort": "string"
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
    "snapshotScheduleId": "string",
    "snapshotScheduleName": "string",
    "status": "string",
    "schedulePolicy": {
      "startAt": "string",
      "expression": "string"
    },
    // Includes only one of the fields `retentionPeriod`, `snapshotCount`
    "retentionPeriod": "string",
    "snapshotCount": "string"
    // end of the list of possible fields
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.compute.DeleteSnapshotSchedule2}

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
|| authentication | **[Authentication](#yandex.cloud.audit.Authentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `EVENT_STATUS_UNSPECIFIED`
- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[SnapshotScheduleEventDetails](#yandex.cloud.audit.compute.SnapshotScheduleEventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## Authentication {#yandex.cloud.audit.Authentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (SubjectType)

- `SUBJECT_TYPE_UNSPECIFIED`
- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| subjectId | **string** ||
|| subjectName | **string** ||
|| federationId | **string**

Federation block will be filled only when subject_type = FEDERATED_USER_ACCOUNT ||
|| federationName | **string** ||
|| federationType | **enum** (FederationType)

- `FEDERATION_TYPE_UNSPECIFIED`
- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.Authentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.Authentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string** ||
|| impersonatorId | **string** ||
|| impersonatorType | **enum** (SubjectType)

- `SUBJECT_TYPE_UNSPECIFIED`
- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| impersonatorName | **string** ||
|| impersonatorFederationId | **string** ||
|| impersonatorFederationName | **string** ||
|| impersonatorFederationType | **enum** (FederationType)

- `FEDERATION_TYPE_UNSPECIFIED`
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
|| resourceName | **string** ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64) ||
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

## SnapshotScheduleEventDetails {#yandex.cloud.audit.compute.SnapshotScheduleEventDetails}

#|
||Field | Description ||
|| snapshotScheduleId | **string** ||
|| snapshotScheduleName | **string** ||
|| status | **enum** (Status)

- `STATUS_UNSPECIFIED`
- `CREATING`
- `ACTIVE`
- `INACTIVE`
- `DELETING`
- `UPDATING` ||
|| schedulePolicy | **[SchedulePolicy](#yandex.cloud.compute.v1.SchedulePolicy)** ||
|| retentionPeriod | **string** (duration)

Includes only one of the fields `retentionPeriod`, `snapshotCount`. ||
|| snapshotCount | **string** (int64)

Includes only one of the fields `retentionPeriod`, `snapshotCount`. ||
|#

## SchedulePolicy {#yandex.cloud.compute.v1.SchedulePolicy}

A resource for frequency settings of a snapshot schedule.

#|
||Field | Description ||
|| startAt | **string** (date-time)

Timestamp for creating the first snapshot.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expression | **string**

Cron expression for the snapshot schedule (UTC+0).

The expression must consist of five fields (`Minutes Hours Day-of-month Month Day-of-week`) or be one of
nonstandard predefined expressions (e.g. `@hourly`). For details about the format,
see [documentation](/docs/compute/concepts/snapshot-schedule#cron) ||
|#