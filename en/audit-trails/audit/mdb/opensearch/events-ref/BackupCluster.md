---
editable: false
---

# Managed Service for OpenSearch Audit Trails Events: BackupCluster

## Event JSON schema {#yandex.cloud.audit.mdb.opensearch.BackupCluster2-schema}

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
    "backupId": "string",
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
        "version": "string",
        "opensearch": {
          "plugins": [
            "string"
          ],
          "nodeGroups": [
            {
              "name": "string",
              "resources": {
                "resourcePresetId": "string",
                "diskSize": "string",
                "diskTypeId": "string"
              },
              "hostsCount": "string",
              "zoneIds": [
                "string"
              ],
              "subnetIds": [
                "string"
              ],
              "assignPublicIp": "boolean",
              "roles": [
                "string"
              ],
              "diskSizeAutoscaling": {
                "plannedUsageThreshold": "string",
                "emergencyUsageThreshold": "string",
                "diskSizeLimit": "string"
              }
            }
          ],
          // Includes only one of the fields `opensearchConfigSet_2`
          "opensearchConfigSet_2": {
            "effectiveConfig": {
              "maxClauseCount": "string",
              "fielddataCacheSize": "string",
              "searchMaxBuckets": "string",
              "reindexRemoteWhitelist": "string",
              "httpMaxInitialLineLength": "string"
            },
            "userConfig": {
              "maxClauseCount": "string",
              "fielddataCacheSize": "string",
              "searchMaxBuckets": "string",
              "reindexRemoteWhitelist": "string",
              "httpMaxInitialLineLength": "string"
            },
            "defaultConfig": {
              "maxClauseCount": "string",
              "fielddataCacheSize": "string",
              "searchMaxBuckets": "string",
              "reindexRemoteWhitelist": "string",
              "httpMaxInitialLineLength": "string"
            }
          },
          // end of the list of possible fields
          "keystoreSettings": [
            "string"
          ]
        },
        "dashboards": {
          "nodeGroups": [
            {
              "name": "string",
              "resources": {
                "resourcePresetId": "string",
                "diskSize": "string",
                "diskTypeId": "string"
              },
              "hostsCount": "string",
              "zoneIds": [
                "string"
              ],
              "subnetIds": [
                "string"
              ],
              "assignPublicIp": "boolean",
              "diskSizeAutoscaling": {
                "plannedUsageThreshold": "string",
                "emergencyUsageThreshold": "string",
                "diskSizeLimit": "string"
              }
            }
          ]
        },
        "access": {
          "dataTransfer": "boolean",
          "serverless": "boolean"
        },
        "snapshotManagement": {
          "snapshotSchedule": {
            // Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`
            "hourlySnapshotSchedule": {
              "minute": "string"
            },
            "dailySnapshotSchedule": {
              "hour": "string",
              "minute": "string"
            },
            "weeklySnapshotSchedule": {
              "day": "string",
              "hour": "string",
              "minute": "string"
            }
            // end of the list of possible fields
          },
          "snapshotMaxAgeDays": "string"
        },
        "fullVersion": "string"
      },
      "networkId": "string",
      "health": "string",
      "status": "string",
      "securityGroupIds": [
        "string"
      ],
      "serviceAccountId": "string",
      "deletionProtection": "boolean",
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
      "diskEncryptionKeyId": "string"
    },
    "backup": {
      "id": "string",
      "folderId": "string",
      "sourceClusterId": "string",
      "startedAt": "string",
      "createdAt": "string",
      "indices": [
        "string"
      ],
      "opensearchVersion": "string",
      "sizeBytes": "string",
      "indicesTotal": "string",
      "incrementalSizeBytes": "string",
      "totalSizeBytes": "string",
      "freeSpaceRequiredBytes": "string"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.mdb.opensearch.BackupCluster2}

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
|| details | **[ClusterBackupEventDetails](#yandex.cloud.audit.mdb.opensearch.ClusterBackupEventDetails)** ||
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

## ClusterBackupEventDetails {#yandex.cloud.audit.mdb.opensearch.ClusterBackupEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| backupId | **string** ||
|| clusterName | **string** ||
|| cluster | **[Cluster](#yandex.cloud.mdb.opensearch.v1.Cluster)** ||
|| backup | **[Backup](#yandex.cloud.mdb.opensearch.v1.Backup)** ||
|#

## Cluster {#yandex.cloud.mdb.opensearch.v1.Cluster}

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
|| monitoring[] | **[Monitoring](#yandex.cloud.mdb.opensearch.v1.Monitoring)** ||
|| config | **[ClusterConfig](#yandex.cloud.mdb.opensearch.v1.ClusterConfig)** ||
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
|| securityGroupIds[] | **string** ||
|| serviceAccountId | **string** ||
|| deletionProtection | **boolean** ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)** ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation)** ||
|| diskEncryptionKeyId | **string** ||
|#

## Monitoring {#yandex.cloud.mdb.opensearch.v1.Monitoring}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| link | **string** ||
|#

## ClusterConfig {#yandex.cloud.mdb.opensearch.v1.ClusterConfig}

#|
||Field | Description ||
|| version | **string** ||
|| opensearch | **[OpenSearch](#yandex.cloud.mdb.opensearch.v1.OpenSearch)** ||
|| dashboards | **[Dashboards](#yandex.cloud.mdb.opensearch.v1.Dashboards)** ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)** ||
|| snapshotManagement | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)** ||
|| fullVersion | **string** ||
|#

## OpenSearch {#yandex.cloud.mdb.opensearch.v1.OpenSearch}

#|
||Field | Description ||
|| plugins[] | **string** ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearch.NodeGroup)** ||
|| opensearchConfigSet_2 | **[OpenSearchConfigSet2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfigSet2)**

Includes only one of the fields `opensearchConfigSet_2`. ||
|| keystoreSettings[] | **string** ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.OpenSearch.NodeGroup}

#|
||Field | Description ||
|| name | **string** ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)** ||
|| hostsCount | **string** (int64) ||
|| zoneIds[] | **string** ||
|| subnetIds[] | **string** ||
|| assignPublicIp | **boolean** ||
|| roles[] | **enum** (GroupRole)

- `DATA`
- `MANAGER` ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)** ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|| diskSize | **string** (int64) ||
|| diskTypeId | **string** ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling}

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64) ||
|#

## OpenSearchConfigSet2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfigSet2}

#|
||Field | Description ||
|| effectiveConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)** ||
|| userConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)** ||
|| defaultConfig | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)** ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2}

#|
||Field | Description ||
|| maxClauseCount | **string** (int64)

Acceptable values are 1 to 2147483647, inclusive. ||
|| fielddataCacheSize | **string** ||
|| searchMaxBuckets | **string** (int64)

Acceptable values are 0 to 2147483647, inclusive. ||
|| reindexRemoteWhitelist | **string** ||
|| httpMaxInitialLineLength | **string** ||
|#

## Dashboards {#yandex.cloud.mdb.opensearch.v1.Dashboards}

#|
||Field | Description ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.Dashboards.NodeGroup)** ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.Dashboards.NodeGroup}

#|
||Field | Description ||
|| name | **string** ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)** ||
|| hostsCount | **string** (int64) ||
|| zoneIds[] | **string** ||
|| subnetIds[] | **string** ||
|| assignPublicIp | **boolean** ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)** ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access}

#|
||Field | Description ||
|| dataTransfer | **boolean** ||
|| serverless | **boolean** ||
|#

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement}

#|
||Field | Description ||
|| snapshotSchedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)** ||
|| snapshotMaxAgeDays | **string** (int64)

The minimum value is 7. ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule}

#|
||Field | Description ||
|| hourlySnapshotSchedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| dailySnapshotSchedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| weeklySnapshotSchedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule}

#|
||Field | Description ||
|| minute | **string** (int64)

Acceptable values are 0 to 59, inclusive. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule}

#|
||Field | Description ||
|| hour | **string** (int64)

Acceptable values are 0 to 23, inclusive. ||
|| minute | **string** (int64)

Acceptable values are 0 to 59, inclusive. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule}

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

Acceptable values are 0 to 23, inclusive. ||
|| minute | **string** (int64)

Acceptable values are 0 to 59, inclusive. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow}

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

## MaintenanceOperation {#yandex.cloud.mdb.opensearch.v1.MaintenanceOperation}

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

## Backup {#yandex.cloud.mdb.opensearch.v1.Backup}

#|
||Field | Description ||
|| id | **string** ||
|| folderId | **string** ||
|| sourceClusterId | **string** ||
|| startedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| indices[] | **string**

The maximum number of elements is 100. ||
|| opensearchVersion | **string** ||
|| sizeBytes | **string** (int64) ||
|| indicesTotal | **string** (int64) ||
|| incrementalSizeBytes | **string** (int64) ||
|| totalSizeBytes | **string** (int64) ||
|| freeSpaceRequiredBytes | **string** (int64) ||
|#