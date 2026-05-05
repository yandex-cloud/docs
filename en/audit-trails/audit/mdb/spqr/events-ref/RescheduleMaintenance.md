---
editable: false
---

# Managed Service for SPQR Audit Trails Events: RescheduleMaintenance

## Event JSON schema {#yandex.cloud.audit.mdb.spqr.RescheduleMaintenance2-schema}

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
    "clusterId": "string",
    "clusterName": "string",
    "cluster": {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "environment": "string",
      "monitoring": [
        {
          "name": "string",
          "description": "string",
          "link": "string"
        }
      ],
      "config": {
        "spqrConfig": {
          "router": {
            "config": {
              "showNoticeMessages": "boolean",
              "timeQuantiles": [
                "string"
              ],
              "defaultRouteBehavior": "string",
              "preferSameAvailabilityZone": "boolean",
              "enhancedMultishardProcessing": "boolean",
              "defaultTargetSessionAttrs": "string",
              "defaultCommitStrategy": "string"
            },
            "resources": {
              "resourcePresetId": "string",
              "diskSize": "string",
              "diskTypeId": "string"
            }
          },
          "coordinator": {
            "config": "object",
            "resources": {
              "resourcePresetId": "string",
              "diskSize": "string",
              "diskTypeId": "string"
            }
          },
          "postgresql": {
            "config": "object",
            "resources": {
              "resourcePresetId": "string",
              "diskSize": "string",
              "diskTypeId": "string"
            }
          },
          "infra": {
            "resources": {
              "resourcePresetId": "string",
              "diskSize": "string",
              "diskTypeId": "string"
            },
            "router": {
              "showNoticeMessages": "boolean",
              "timeQuantiles": [
                "string"
              ],
              "defaultRouteBehavior": "string",
              "preferSameAvailabilityZone": "boolean",
              "enhancedMultishardProcessing": "boolean",
              "defaultTargetSessionAttrs": "string",
              "defaultCommitStrategy": "string"
            },
            "coordinator": "object"
          },
          "logLevel": "string",
          "balancer": {
            "cpuThreshold": "number",
            "spaceThreshold": "number",
            "statIntervalSec": "string",
            "maxMoveCount": "string",
            "keysPerMove": "string",
            "timeout": "string"
          }
        },
        "backupWindowStart": {
          "hours": "integer",
          "minutes": "integer",
          "seconds": "integer",
          "nanos": "integer"
        },
        "backupRetainPeriodDays": "string",
        "access": {
          "dataLens": "boolean",
          "webSql": "boolean",
          "dataTransfer": "boolean",
          "serverless": "boolean"
        },
        "soxAudit": "boolean"
      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "maintenanceWindow": {
        // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
        "anytime": "object",
        "weeklyMaintenanceWindow": {
          "day": "string",
          "hour": "string"
        }
        // end of the list of possible fields
      },
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string",
        "latestMaintenanceTime": "string",
        "nextMaintenanceWindowTime": "string"
      },
      "securityGroupIds": [
        "string"
      ],
      "deletionProtection": "boolean"
    },
    "description": "string",
    "labels": "object"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.spqr.RescheduleMaintenance2}

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
|| details | **[ClusterEventDetails](#yandex.cloud.audit.mdb.spqr.ClusterEventDetails)** ||
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

## ClusterEventDetails {#yandex.cloud.audit.mdb.spqr.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| clusterName | **string** ||
|| cluster | **[Cluster](#yandex.cloud.mdb.spqr.v1.Cluster)** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|#

## Cluster {#yandex.cloud.mdb.spqr.v1.Cluster}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| environment | **enum** (Environment)

- `PRODUCTION`
- `PRESTABLE` ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.spqr.v1.Monitoring)** ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.spqr.v1.ClusterConfig)** ||
|| networkId | **string** ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED` ||
|| status | **enum** (Status)

- `STATUS_UNKNOWN`
- `CREATING`
- `RUNNING`
- `ERROR`
- `UPDATING`
- `STOPPING`
- `STOPPED`
- `STARTING` ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.spqr.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.spqr.v1.MaintenanceOperation)** ||
|| securityGroupIds[] | **string** ||
|| deletionProtection | **boolean** ||
|#

## Monitoring {#yandex.cloud.mdb.spqr.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## ClusterConfig {#yandex.cloud.mdb.spqr.v1.ClusterConfig}

#|
||Field | Description ||
|| spqrConfig | **[SPQRConfig](#yandex.cloud.mdb.spqr.v1.SPQRConfig)** ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| backupRetainPeriodDays | **string** (int64) ||
|| access | **[Access](#yandex.cloud.mdb.spqr.v1.Access)** ||
|| soxAudit | **boolean** ||
|#

## SPQRConfig {#yandex.cloud.mdb.spqr.v1.SPQRConfig}

#|
||Field | Description ||
|| router | **[RouterConfig](#yandex.cloud.mdb.spqr.v1.RouterConfig)** ||
|| coordinator | **[CoordinatorConfig](#yandex.cloud.mdb.spqr.v1.CoordinatorConfig)** ||
|| postgresql | **[PostgreSQLConfig](#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig)** ||
|| infra | **[InfraConfig](#yandex.cloud.mdb.spqr.v1.InfraConfig)** ||
|| logLevel | **enum** (LogLevel)

- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `FATAL` ||
|| balancer | **[BalancerSettings](#yandex.cloud.mdb.spqr.v1.BalancerSettings)** ||
|#

## RouterConfig {#yandex.cloud.mdb.spqr.v1.RouterConfig}

#|
||Field | Description ||
|| config | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## RouterSettings {#yandex.cloud.mdb.spqr.v1.RouterSettings}

#|
||Field | Description ||
|| showNoticeMessages | **boolean** ||
|| timeQuantiles[] | **string** ||
|| defaultRouteBehavior | **enum** (DefaultRouteBehavior)

- `BLOCK`
- `ALLOW` ||
|| preferSameAvailabilityZone | **boolean** ||
|| enhancedMultishardProcessing | **boolean** ||
|| defaultTargetSessionAttrs | **enum** (TargetSessionAttrs)

- `READ_WRITE`
- `SMART_READ_WRITE`
- `READ_ONLY`
- `PREFER_STANDBY`
- `ANY` ||
|| defaultCommitStrategy | **enum** (CommitStrategy)

- `BEST_EFFORT`
- `ONE_PC`
- `TWO_PC` ||
|#

## Resources {#yandex.cloud.mdb.spqr.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## CoordinatorConfig {#yandex.cloud.mdb.spqr.v1.CoordinatorConfig}

#|
||Field | Description ||
|| config | **object** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## PostgreSQLConfig {#yandex.cloud.mdb.spqr.v1.PostgreSQLConfig}

#|
||Field | Description ||
|| config | **object** ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|#

## InfraConfig {#yandex.cloud.mdb.spqr.v1.InfraConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)** ||
|| router | **[RouterSettings](#yandex.cloud.mdb.spqr.v1.RouterSettings)** ||
|| coordinator | **object** ||
|#

## BalancerSettings {#yandex.cloud.mdb.spqr.v1.BalancerSettings}

#|
||Field | Description ||
|| cpuThreshold | **number** (double) ||
|| spaceThreshold | **number** (double) ||
|| statIntervalSec | **string** (int64) ||
|| maxMoveCount | **string** (int64) ||
|| keysPerMove | **string** (int64) ||
|| timeout | **string** (int64) ||
|#

## TimeOfDay {#google.type.TimeOfDay}

#|
||Field | Description ||
|| hours | **integer** (int32) ||
|| minutes | **integer** (int32) ||
|| seconds | **integer** (int32) ||
|| nanos | **integer** (int32) ||
|#

## Access {#yandex.cloud.mdb.spqr.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean** ||
|| webSql | **boolean** ||
|| dataTransfer | **boolean** ||
|| serverless | **boolean** ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.spqr.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.spqr.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| day | **enum** (WeekDay)

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

Acceptable values are 1 to 24, inclusive. ||
|#

## MaintenanceOperation {#yandex.cloud.mdb.spqr.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The maximum string length in characters is 256. ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| latestMaintenanceTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextMaintenanceWindowTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#