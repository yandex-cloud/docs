---
editable: false
---

# Managed Service for Greenplum® Audit Trails Events: DeleteCluster

## Event JSON schema {#yandex.cloud.audit.mdb.greenplum.DeleteCluster2-schema}

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
      "config": {
        "version": "string",
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
          "yandexQuery": "boolean"
        },
        "zoneId": "string",
        "subnetId": "string",
        "assignPublicIp": "boolean",
        "fullVersion": "string"
      },
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
      "masterConfig": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "segmentConfig": {
        "resources": {
          "resourcePresetId": "string",
          "diskSize": "string",
          "diskTypeId": "string"
        }
      },
      "masterHostCount": "string",
      "segmentHostCount": "string",
      "segmentInHost": "string",
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
        "delayedUntil": "string"
      },
      "securityGroupIds": [
        "string"
      ],
      "userName": "string",
      "deletionProtection": "boolean",
      "hostGroupIds": [
        "string"
      ],
      "clusterConfig": {
        // Includes only one of the fields `greenplumConfigSet_6`
        "greenplumConfigSet_6": {
          "effectiveConfig": {
            "maxConnections": "string",
            "maxSlotWalKeepSize": "string",
            "gpWorkfileLimitPerSegment": "string",
            "gpWorkfileLimitPerQuery": "string",
            "gpWorkfileLimitFilesPerQuery": "string",
            "maxPreparedTransactions": "string",
            "gpWorkfileCompression": "boolean",
            "maxStatementMem": "string",
            "logStatement": "string",
            "gpAddColumnInheritsTableSetting": "boolean",
            "gpEnableGlobalDeadlockDetector": "boolean",
            "gpGlobalDeadlockDetectorPeriod": "string",
            "gpMaxSlices": "string",
            "gpCachedSegworkersThreshold": "string",
            "lockTimeout": "string",
            "idleInTransactionSessionTimeout": "string",
            "runawayDetectorActivationPercent": "string",
            "gpVmemProtectSegworkerCacheLimit": "string",
            "gpEnableZstdMemoryAccounting": "boolean",
            "gpMaxPlanSize": "string",
            "gpAutostatsMode": "string",
            "gpAutostatsOnChangeThreshold": "string",
            "gpResourceGroupMemoryLimit": "number",
            "logConnections": "boolean",
            "logDisconnections": "boolean",
            "logHostname": "boolean",
            "logStatementStats": "boolean",
            "logMinDurationStatement": "string",
            "masterSharedBuffers": "string",
            "maxLocksPerTransaction": "string",
            "segmentSharedBuffers": "string",
            "logErrorVerbosity": "string",
            "logMinMessages": "string"
          },
          "userConfig": {
            "maxConnections": "string",
            "maxSlotWalKeepSize": "string",
            "gpWorkfileLimitPerSegment": "string",
            "gpWorkfileLimitPerQuery": "string",
            "gpWorkfileLimitFilesPerQuery": "string",
            "maxPreparedTransactions": "string",
            "gpWorkfileCompression": "boolean",
            "maxStatementMem": "string",
            "logStatement": "string",
            "gpAddColumnInheritsTableSetting": "boolean",
            "gpEnableGlobalDeadlockDetector": "boolean",
            "gpGlobalDeadlockDetectorPeriod": "string",
            "gpMaxSlices": "string",
            "gpCachedSegworkersThreshold": "string",
            "lockTimeout": "string",
            "idleInTransactionSessionTimeout": "string",
            "runawayDetectorActivationPercent": "string",
            "gpVmemProtectSegworkerCacheLimit": "string",
            "gpEnableZstdMemoryAccounting": "boolean",
            "gpMaxPlanSize": "string",
            "gpAutostatsMode": "string",
            "gpAutostatsOnChangeThreshold": "string",
            "gpResourceGroupMemoryLimit": "number",
            "logConnections": "boolean",
            "logDisconnections": "boolean",
            "logHostname": "boolean",
            "logStatementStats": "boolean",
            "logMinDurationStatement": "string",
            "masterSharedBuffers": "string",
            "maxLocksPerTransaction": "string",
            "segmentSharedBuffers": "string",
            "logErrorVerbosity": "string",
            "logMinMessages": "string"
          },
          "defaultConfig": {
            "maxConnections": "string",
            "maxSlotWalKeepSize": "string",
            "gpWorkfileLimitPerSegment": "string",
            "gpWorkfileLimitPerQuery": "string",
            "gpWorkfileLimitFilesPerQuery": "string",
            "maxPreparedTransactions": "string",
            "gpWorkfileCompression": "boolean",
            "maxStatementMem": "string",
            "logStatement": "string",
            "gpAddColumnInheritsTableSetting": "boolean",
            "gpEnableGlobalDeadlockDetector": "boolean",
            "gpGlobalDeadlockDetectorPeriod": "string",
            "gpMaxSlices": "string",
            "gpCachedSegworkersThreshold": "string",
            "lockTimeout": "string",
            "idleInTransactionSessionTimeout": "string",
            "runawayDetectorActivationPercent": "string",
            "gpVmemProtectSegworkerCacheLimit": "string",
            "gpEnableZstdMemoryAccounting": "boolean",
            "gpMaxPlanSize": "string",
            "gpAutostatsMode": "string",
            "gpAutostatsOnChangeThreshold": "string",
            "gpResourceGroupMemoryLimit": "number",
            "logConnections": "boolean",
            "logDisconnections": "boolean",
            "logHostname": "boolean",
            "logStatementStats": "boolean",
            "logMinDurationStatement": "string",
            "masterSharedBuffers": "string",
            "maxLocksPerTransaction": "string",
            "segmentSharedBuffers": "string",
            "logErrorVerbosity": "string",
            "logMinMessages": "string"
          }
        },
        // end of the list of possible fields
        "pool": {
          "effectiveConfig": {
            "mode": "string",
            "size": "string",
            "clientIdleTimeout": "string",
            "idleInTransactionTimeout": "string"
          },
          "userConfig": {
            "mode": "string",
            "size": "string",
            "clientIdleTimeout": "string",
            "idleInTransactionTimeout": "string"
          },
          "defaultConfig": {
            "mode": "string",
            "size": "string",
            "clientIdleTimeout": "string",
            "idleInTransactionTimeout": "string"
          }
        },
        "backgroundActivities": {
          "tableSizes": {
            "starts": [
              {
                "hours": "string",
                "minutes": "string"
              }
            ]
          },
          "analyzeAndVacuum": {
            "start": {
              "hours": "string",
              "minutes": "string"
            },
            "analyzeTimeout": "string",
            "vacuumTimeout": "string"
          },
          "queryKillerScripts": {
            "idle": {
              "enable": "boolean",
              "maxAge": "string",
              "ignoreUsers": [
                "string"
              ]
            },
            "idleInTransaction": {
              "enable": "boolean",
              "maxAge": "string",
              "ignoreUsers": [
                "string"
              ]
            },
            "longRunning": {
              "enable": "boolean",
              "maxAge": "string",
              "ignoreUsers": [
                "string"
              ]
            }
          }
        },
        "pxfConfig": {
          "effectiveConfig": {
            "connectionTimeout": "string",
            "uploadTimeout": "string",
            "maxThreads": "string",
            "poolAllowCoreThreadTimeout": "boolean",
            "poolCoreSize": "string",
            "poolQueueCapacity": "string",
            "poolMaxSize": "string",
            "xmx": "string",
            "xms": "string"
          },
          "userConfig": {
            "connectionTimeout": "string",
            "uploadTimeout": "string",
            "maxThreads": "string",
            "poolAllowCoreThreadTimeout": "boolean",
            "poolCoreSize": "string",
            "poolQueueCapacity": "string",
            "poolMaxSize": "string",
            "xmx": "string",
            "xms": "string"
          },
          "defaultConfig": {
            "connectionTimeout": "string",
            "uploadTimeout": "string",
            "maxThreads": "string",
            "poolAllowCoreThreadTimeout": "boolean",
            "poolCoreSize": "string",
            "poolQueueCapacity": "string",
            "poolMaxSize": "string",
            "xmx": "string",
            "xms": "string"
          }
        }
      },
      "cloudStorage": {
        "enable": "boolean"
      },
      "masterHostGroupIds": [
        "string"
      ],
      "segmentHostGroupIds": [
        "string"
      ],
      "serviceAccountId": "string",
      "logging": {
        "enabled": "boolean",
        // Includes only one of the fields `folderId`, `logGroupId`
        "folderId": "string",
        "logGroupId": "string",
        // end of the list of possible fields
        "commandCenterEnabled": "boolean",
        "greenplumEnabled": "boolean",
        "poolerEnabled": "boolean"
      }
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.greenplum.DeleteCluster2}

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
|| details | **[ClusterEventDetails](#yandex.cloud.audit.mdb.greenplum.ClusterEventDetails)** ||
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

## ClusterEventDetails {#yandex.cloud.audit.mdb.greenplum.ClusterEventDetails}

#|
||Field | Description ||
|| clusterId | **string**

The maximum string length in characters is 50. ||
|| clusterName | **string** ||
|| cluster | **[Cluster](#yandex.cloud.mdb.greenplum.v1.Cluster)** ||
|#

## Cluster {#yandex.cloud.mdb.greenplum.v1.Cluster}

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
|| name | **string**

The maximum string length in characters is 63. ||
|| config | **[GreenplumConfig](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig)** ||
|| description | **string**

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>) ||
|| environment | **enum** (Environment)

- `PRODUCTION`
- `PRESTABLE` ||
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.greenplum.v1.Monitoring)** ||
|| masterConfig | **[MasterSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig)** ||
|| segmentConfig | **[SegmentSubclusterConfig](#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig)** ||
|| masterHostCount | **string** (int64) ||
|| segmentHostCount | **string** (int64) ||
|| segmentInHost | **string** (int64) ||
|| networkId | **string** ||
|| health | **enum** (Health)

- `HEALTH_UNKNOWN`
- `ALIVE`
- `DEAD`
- `DEGRADED`
- `UNBALANCED` ||
|| status | **enum** (Status)

- `STATUS_UNKNOWN`
- `CREATING`
- `RUNNING`
- `ERROR`
- `UPDATING`
- `STOPPING`
- `STOPPED`
- `STARTING` ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation)** ||
|| securityGroupIds[] | **string** ||
|| userName | **string** ||
|| deletionProtection | **boolean** ||
|| hostGroupIds[] | **string** ||
|| clusterConfig | **[ClusterConfigSet](#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet)** ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.greenplum.v1.CloudStorage)** ||
|| masterHostGroupIds[] | **string** ||
|| segmentHostGroupIds[] | **string** ||
|| serviceAccountId | **string** ||
|| logging | **[LoggingConfig](#yandex.cloud.mdb.greenplum.v1.LoggingConfig)** ||
|#

## GreenplumConfig {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig}

#|
||Field | Description ||
|| version | **string** ||
|| backupWindowStart | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| backupRetainPeriodDays | **string** (int64)

Acceptable values are 1 to 60, inclusive. ||
|| access | **[Access](#yandex.cloud.mdb.greenplum.v1.Access)** ||
|| zoneId | **string**

The maximum string length in characters is 50. ||
|| subnetId | **string**

The maximum string length in characters is 50. ||
|| assignPublicIp | **boolean** ||
|| fullVersion | **string** ||
|#

## TimeOfDay {#google.type.TimeOfDay}

#|
||Field | Description ||
|| hours | **integer** (int32) ||
|| minutes | **integer** (int32) ||
|| seconds | **integer** (int32) ||
|| nanos | **integer** (int32) ||
|#

## Access {#yandex.cloud.mdb.greenplum.v1.Access}

#|
||Field | Description ||
|| dataLens | **boolean** ||
|| webSql | **boolean** ||
|| dataTransfer | **boolean** ||
|| yandexQuery | **boolean** ||
|#

## Monitoring {#yandex.cloud.mdb.greenplum.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## MasterSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.MasterSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)** ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## SegmentSubclusterConfig {#yandex.cloud.mdb.greenplum.v1.SegmentSubclusterConfig}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)** ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.greenplum.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.mdb.greenplum.v1.MaintenanceOperation}

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
|#

## ClusterConfigSet {#yandex.cloud.mdb.greenplum.v1.ClusterConfigSet}

#|
||Field | Description ||
|| greenplumConfigSet_6 | **[GreenplumConfigSet6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6)**

Includes only one of the fields `greenplumConfigSet_6`. ||
|| pool | **[ConnectionPoolerConfigSet](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet)** ||
|| backgroundActivities | **[BackgroundActivitiesConfig](#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig)** ||
|| pxfConfig | **[PXFConfigSet](#yandex.cloud.mdb.greenplum.v1.PXFConfigSet)** ||
|#

## GreenplumConfigSet6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfigSet6}

#|
||Field | Description ||
|| effectiveConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)** ||
|| userConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)** ||
|| defaultConfig | **[GreenplumConfig6](#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6)** ||
|#

## GreenplumConfig6 {#yandex.cloud.mdb.greenplum.v1.GreenplumConfig6}

#|
||Field | Description ||
|| maxConnections | **string** (int64)

Acceptable values are 50 to 1000, inclusive. ||
|| maxSlotWalKeepSize | **string** (int64)

Acceptable values are 0 to 214748364800, inclusive. ||
|| gpWorkfileLimitPerSegment | **string** (int64)

The minimum value is 0. ||
|| gpWorkfileLimitPerQuery | **string** (int64)

Acceptable values are 0 to 1099511627776, inclusive. ||
|| gpWorkfileLimitFilesPerQuery | **string** (int64)

Acceptable values are 0 to 100000, inclusive. ||
|| maxPreparedTransactions | **string** (int64)

Acceptable values are 50 to 10000, inclusive. ||
|| gpWorkfileCompression | **boolean** ||
|| maxStatementMem | **string** (int64)

Acceptable values are 134217728 to 1099511627776, inclusive. ||
|| logStatement | **enum** (LogStatement)

- `NONE`
- `DDL`
- `MOD`
- `ALL` ||
|| gpAddColumnInheritsTableSetting | **boolean** ||
|| gpEnableGlobalDeadlockDetector | **boolean** ||
|| gpGlobalDeadlockDetectorPeriod | **string** (int64) ||
|| gpMaxSlices | **string** (int64)

Acceptable values are 10 to 100, inclusive. ||
|| gpCachedSegworkersThreshold | **string** (int64)

Acceptable values are 0 to 10, inclusive. ||
|| lockTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| idleInTransactionSessionTimeout | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| runawayDetectorActivationPercent | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| gpVmemProtectSegworkerCacheLimit | **string** (int64)

Acceptable values are 0 to 4096, inclusive. ||
|| gpEnableZstdMemoryAccounting | **boolean** ||
|| gpMaxPlanSize | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| gpAutostatsMode | **enum** (GPAutostatsMode)

- `GP_AUTOSTATS_MODE_NONE`
- `GP_AUTOSTATS_MODE_ON_CHANGE`
- `GP_AUTOSTATS_MODE_ON_NO_STATS` ||
|| gpAutostatsOnChangeThreshold | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| gpResourceGroupMemoryLimit | **number** (double) ||
|| logConnections | **boolean** ||
|| logDisconnections | **boolean** ||
|| logHostname | **boolean** ||
|| logStatementStats | **boolean** ||
|| logMinDurationStatement | **string** (int64) ||
|| masterSharedBuffers | **string** (int64)

Acceptable values are 1048576 to 2147483647, inclusive. ||
|| maxLocksPerTransaction | **string** (int64)

Acceptable values are 128 to 2048, inclusive. ||
|| segmentSharedBuffers | **string** (int64)

Acceptable values are 1048576 to 2147483647, inclusive. ||
|| logErrorVerbosity | **enum** (LogErrorVerbosity)

- `TERSE`
- `DEFAULT`
- `VERBOSE` ||
|| logMinMessages | **enum** (LogLevelMessage)

- `DEBUG5`
- `DEBUG4`
- `DEBUG3`
- `DEBUG2`
- `DEBUG1`
- `INFO`
- `NOTICE`
- `WARNING`
- `ERROR`
- `FATAL`
- `PANIC` ||
|#

## ConnectionPoolerConfigSet {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)** ||
|| userConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)** ||
|| defaultConfig | **[ConnectionPoolerConfig](#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig)** ||
|#

## ConnectionPoolerConfig {#yandex.cloud.mdb.greenplum.v1.ConnectionPoolerConfig}

#|
||Field | Description ||
|| mode | **enum** (PoolMode)

- `SESSION`
- `TRANSACTION` ||
|| size | **string** (int64) ||
|| clientIdleTimeout | **string** (int64) ||
|| idleInTransactionTimeout | **string** (int64) ||
|#

## BackgroundActivitiesConfig {#yandex.cloud.mdb.greenplum.v1.BackgroundActivitiesConfig}

#|
||Field | Description ||
|| tableSizes | **[TableSizes](#yandex.cloud.mdb.greenplum.v1.TableSizes)** ||
|| analyzeAndVacuum | **[AnalyzeAndVacuum](#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum)** ||
|| queryKillerScripts | **[QueryKillerScripts](#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts)** ||
|#

## TableSizes {#yandex.cloud.mdb.greenplum.v1.TableSizes}

#|
||Field | Description ||
|| starts[] | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)**

The maximum number of elements is 4. ||
|#

## BackgroundActivityStartAt {#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt}

#|
||Field | Description ||
|| hours | **string** (int64)

Acceptable values are 0 to 23, inclusive. ||
|| minutes | **string** (int64)

Acceptable values are 0 to 59, inclusive. ||
|#

## AnalyzeAndVacuum {#yandex.cloud.mdb.greenplum.v1.AnalyzeAndVacuum}

#|
||Field | Description ||
|| start | **[BackgroundActivityStartAt](#yandex.cloud.mdb.greenplum.v1.BackgroundActivityStartAt)** ||
|| analyzeTimeout | **string** (int64)

Acceptable values are 7200 to 86399, inclusive. ||
|| vacuumTimeout | **string** (int64)

Acceptable values are 7200 to 86399, inclusive. ||
|#

## QueryKillerScripts {#yandex.cloud.mdb.greenplum.v1.QueryKillerScripts}

#|
||Field | Description ||
|| idle | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)** ||
|| idleInTransaction | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)** ||
|| longRunning | **[QueryKiller](#yandex.cloud.mdb.greenplum.v1.QueryKiller)** ||
|#

## QueryKiller {#yandex.cloud.mdb.greenplum.v1.QueryKiller}

#|
||Field | Description ||
|| enable | **boolean** ||
|| maxAge | **string** (int64)

Acceptable values are 1 to 86400, inclusive. ||
|| ignoreUsers[] | **string** ||
|#

## PXFConfigSet {#yandex.cloud.mdb.greenplum.v1.PXFConfigSet}

#|
||Field | Description ||
|| effectiveConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)** ||
|| userConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)** ||
|| defaultConfig | **[PXFConfig](#yandex.cloud.mdb.greenplum.v1.PXFConfig)** ||
|#

## PXFConfig {#yandex.cloud.mdb.greenplum.v1.PXFConfig}

#|
||Field | Description ||
|| connectionTimeout | **string** (int64)

Acceptable values are 5 to 600, inclusive. ||
|| uploadTimeout | **string** (int64)

Acceptable values are 5 to 600, inclusive. ||
|| maxThreads | **string** (int64)

Acceptable values are 1 to 1024, inclusive. ||
|| poolAllowCoreThreadTimeout | **boolean** ||
|| poolCoreSize | **string** (int64)

Acceptable values are 1 to 1024, inclusive. ||
|| poolQueueCapacity | **string** (int64)

The minimum value is 0. ||
|| poolMaxSize | **string** (int64)

Acceptable values are 1 to 1024, inclusive. ||
|| xmx | **string** (int64)

The minimum value is 64. ||
|| xms | **string** (int64)

The minimum value is 64. ||
|#

## CloudStorage {#yandex.cloud.mdb.greenplum.v1.CloudStorage}

#|
||Field | Description ||
|| enable | **boolean** ||
|#

## LoggingConfig {#yandex.cloud.mdb.greenplum.v1.LoggingConfig}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| folderId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`. ||
|| logGroupId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `folderId`, `logGroupId`. ||
|| commandCenterEnabled | **boolean** ||
|| greenplumEnabled | **boolean** ||
|| poolerEnabled | **boolean** ||
|#