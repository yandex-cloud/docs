# Managed Service for OpenSearch API, REST: Cluster.Restore

Creates a new OpenSearch cluster using the specified backup.

## HTTP request

```
POST https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters:restore
```

## Body parameters {#yandex.cloud.mdb.opensearch.v1.RestoreClusterRequest}

```json
{
  "backupId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "adminPassword": "string",
    "opensearchSpec": {
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
      // Includes only one of the fields `opensearchConfig_2`
      "opensearchConfig_2": {
        "maxClauseCount": "string",
        "fielddataCacheSize": "string",
        "searchMaxBuckets": "string",
        "reindexRemoteWhitelist": "string",
        "httpMaxInitialLineLength": "string"
      },
      // end of the list of possible fields
      "keystoreSettings": [
        {
          "name": "string",
          "value": "string"
        }
      ]
    },
    "dashboardsSpec": {
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
    "auditLog": {
      "complianceEnabled": "boolean",
      "logRequestBody": "boolean",
      "logSearchQueries": "boolean",
      "logDataModifications": "boolean",
      "logIndexMetadataAccess": "boolean",
      "logMonitoringChecks": "boolean",
      "logIndexMaintenance": "boolean",
      "logBackupOperations": "boolean"
    },
    "cloudStorage": {
      "enabled": "boolean"
    }
  },
  "networkId": "string",
  "securityGroupIds": [
    "string"
  ],
  "serviceAccountId": "string",
  "deletionProtection": "boolean",
  "folderId": "string",
  "maintenanceWindow": {
    // Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": "object",
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    }
    // end of the list of possible fields
  },
  "diskEncryptionKeyId": "string"
}
```

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to create a new cluster from.
To get the backup ID, use a [ClusterService.ListBackups](listBackups.md#ListBackups) request. ||
|| name | **string**

Required field. Name of the new OpenSearch cluster to be created from the backup. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| description | **string**

Description of the new OpenSearch cluster to be created from the backup.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the new OpenSearch cluster to be created from the backup as `key:value` pairs. Maximum 64 per resource.
For example, "project": "mvp" or "source": "dictionary".

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| environment | **enum** (Environment)

Deployment environment of the new OpenSearch cluster to be created from the backup.

- `PRODUCTION`: Stable environment with a conservative update policy:
only hotfixes are applied during regular maintenance.
- `PRESTABLE`: Environment with more aggressive update policy: new versions
are rolled out irrespective of backward compatibility. ||
|| configSpec | **[ConfigCreateSpec](#yandex.cloud.mdb.opensearch.v1.ConfigCreateSpec)**

Required field. Configuration for the new OpenSearch cluster to be created from the backup. ||
|| networkId | **string**

Required field. ID of the network to create the cluster in.

The maximum string length in characters is 50. ||
|| securityGroupIds[] | **string**

User security groups. ||
|| serviceAccountId | **string**

ID of the service account used to access Object Storage. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| folderId | **string**

Required field. ID of the folder to create the OpenSearch cluster in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.

The maximum string length in characters is 50. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| diskEncryptionKeyId | **string**

ID of the key to encrypt cluster disks. ||
|#

## ConfigCreateSpec {#yandex.cloud.mdb.opensearch.v1.ConfigCreateSpec}

#|
||Field | Description ||
|| version | **string**

OpenSearch version. ||
|| adminPassword | **string**

Required field. OpenSearch admin password.

The string length in characters must be 10-72. ||
|| opensearchSpec | **[OpenSearchCreateSpec](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec)**

OpenSearch configuration. ||
|| dashboardsSpec | **[DashboardsCreateSpec](#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec)**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**

Access policy for external services. ||
|| snapshotManagement | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**

Snapshot management configuration. ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.opensearch.v1.config.AuditLog)**

Audit log settings. ||
|| cloudStorage | **[CloudStorage](#yandex.cloud.mdb.opensearch.v1.CloudStorage)**

Cloud storage configuration. ||
|#

## OpenSearchCreateSpec {#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec}

OpenSearch create-time configuration.

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec.NodeGroup)**

OpenSearch type host groups of the cluster. ||
|| opensearchConfig_2 | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**

OpenSearch server configuration settings.

Includes only one of the fields `opensearchConfig_2`. ||
|| keystoreSettings[] | **[KeystoreSetting](#yandex.cloud.mdb.opensearch.v1.KeystoreSetting)**

Initial cluster keystore settings. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.OpenSearchCreateSpec.NodeGroup}

Configuration of the host group.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the group.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hostsCount | **string** (int64)

Number of hosts in the group.

The minimum value is 1. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to.

The maximum string length in characters for each value is 50. The maximum number of elements is 10. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to.

The maximum string length in characters for each value is 50. The maximum number of elements is 10. ||
|| assignPublicIp | **boolean**

Determines whether a public IP is assigned to the hosts in the group. ||
|| roles[] | **enum** (GroupRole)

Roles of the hosts in the group.

- `DATA`: Data nodes store indices data.
- `MANAGER`: Manager nodes perform cluster coordination.
- `WARM`: Warm nodes provide access to searchable snapshots and manage search cache for these snapshots.
- `INGEST`: Ingest nodes provides indexed data processing.
If no node groups have INGEST role explicitly set, then all DATA nodes will implicitly have INGEST role. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources}

A list of computational resources allocated to a host.

#|
||Field | Description ||
|| resourcePresetId | **string**

Required field. ID of the preset for computational resources allocated to a host. ||
|| diskSize | **string** (int64)

Volume of the storage used by the host, in bytes.

Value must be greater than 0. ||
|| diskTypeId | **string**

Required field. Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## DiskSizeAutoscaling {#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling}

Disk size autoscaling settings.

#|
||Field | Description ||
|| plannedUsageThreshold | **string** (int64)

Amount of used storage for automatic disk scaling in the maintenance window, 0 means disabled, in percent.

Acceptable values are 0 to 100, inclusive. ||
|| emergencyUsageThreshold | **string** (int64)

Amount of used storage for immediately  automatic disk scaling, 0 means disabled, in percent.

Acceptable values are 0 to 100, inclusive. ||
|| diskSizeLimit | **string** (int64)

Limit on how large the storage for database instances can automatically grow, in bytes. ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2}

OpenSearch server configuration settings.

#|
||Field | Description ||
|| maxClauseCount | **string** (int64)

Defines the maximum product of fields and terms that are queryable simultaneously.

Default value: **1024**.

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings). ||
|| fielddataCacheSize | **string**

The maximum size of the field data cache.
May be specified as an absolute value (for example, 8GB) or a percentage of the node heap (for example, 50%).
This setting is dynamic. If you don't specify this setting, the maximum size is 35%.
This value should be smaller than the **indices.breaker.fielddata.limit**

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings). ||
|| searchMaxBuckets | **string** (int64)

The maximum number of aggregation buckets allowed in a single response. Default is 65535

Default value: **65535**.

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/search-settings). ||
|| reindexRemoteWhitelist | **string**

Allowed remote hosts

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/api-reference/document-apis/reindex/#remote-cluster-allow-list). ||
|| httpMaxInitialLineLength | **string**

Sets the maximum length allowed for HTTP URLs in the initial request line. URLs exceeding this limit will be rejected. Default is **4kb**.

Default value: **4kb**.

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/network-settings/#advanced-http-settings). ||
|#

## KeystoreSetting {#yandex.cloud.mdb.opensearch.v1.KeystoreSetting}

Single keystore entry.

#|
||Field | Description ||
|| name | **string**

Required field. Keystore entry name. ||
|| value | **string**

Required field. Keystore entry value. ||
|#

## DashboardsCreateSpec {#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec}

Dashboards create-time configuration.

#|
||Field | Description ||
|| nodeGroups[] | **[NodeGroup](#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec.NodeGroup)**

Dashboards type host groups of the cluster. ||
|#

## NodeGroup {#yandex.cloud.mdb.opensearch.v1.DashboardsCreateSpec.NodeGroup}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the group.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the hosts. ||
|| hostsCount | **string** (int64)

Number of hosts in the group.

The minimum value is 1. ||
|| zoneIds[] | **string**

IDs of the availability zones the hosts belong to. ||
|| subnetIds[] | **string**

IDs of the subnets that the hosts belong to.

The maximum string length in characters for each value is 50. The maximum number of elements is 10. ||
|| assignPublicIp | **boolean**

Determines whether a public IP is assigned to the hosts in the group. ||
|| diskSizeAutoscaling | **[DiskSizeAutoscaling](#yandex.cloud.mdb.opensearch.v1.DiskSizeAutoscaling)**

Disk size autoscaling settings ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access}

Access policy for external services.

#|
||Field | Description ||
|| dataTransfer | **boolean**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **boolean**

Determines whether the access to Serverless is allowed. ||
|#

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement}

Snapshot management configuration

#|
||Field | Description ||
|| snapshotSchedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)**

Snapshot creation schedule ||
|| snapshotMaxAgeDays | **string** (int64)

Snapshot max age in days

The minimum value is 7. ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule}

Snapshot creation schedule

#|
||Field | Description ||
|| hourlySnapshotSchedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**

Hourly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| dailySnapshotSchedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**

Daily based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|| weeklySnapshotSchedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**

Weekly based snapshot schedule

Includes only one of the fields `hourlySnapshotSchedule`, `dailySnapshotSchedule`, `weeklySnapshotSchedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule}

Hourly based snapshot schedule

#|
||Field | Description ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule}

Daily based snapshot schedule

#|
||Field | Description ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created.

Acceptable values are 0 to 23, inclusive. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule}

Weekly based snapshot schedule

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **string** (int64)

The hour of the day in UTC timezone at which the backup should be created.

Acceptable values are 0 to 23, inclusive. ||
|| minute | **string** (int64)

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## AuditLog {#yandex.cloud.mdb.opensearch.v1.config.AuditLog}

OpenSearch audit logs settings.

#|
||Field | Description ||
|| complianceEnabled | **boolean**

Enables audit logging on changes to a security index, such as changes to roles mappings and role creation or deletion.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#audit-user-account-manipulation). ||
|| logRequestBody | **boolean**

Includes the body of the request (if available) for both REST and the transport layer.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#disable-request-body-logging). ||
|| logSearchQueries | **boolean**

Enables indices data read requests logging. ||
|| logDataModifications | **boolean**

Enables indices data write request logging. ||
|| logIndexMetadataAccess | **boolean**

Enables indices metadata requests logging. ||
|| logMonitoringChecks | **boolean**

Enables monitoring data requests logging. ||
|| logIndexMaintenance | **boolean**

Enables indices maintenance requests logging, such as indices refreshes, flushes and merges. ||
|| logBackupOperations | **boolean**

Enables snapshots and repositories requests logging. ||
|#

## CloudStorage {#yandex.cloud.mdb.opensearch.v1.CloudStorage}

Cloud storage configuration.

#|
||Field | Description ||
|| enabled | **boolean**

Whether to use Object Storage for storing OpenSearch data. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **object**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weeklyMaintenanceWindow`. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | **enum** (WeekDay)

Day of the week.

- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **string** (int64)

Hour of the day in the UTC timezone.

Acceptable values are 1 to 24, inclusive. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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
|| metadata | **object**

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
|| response | **object**

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