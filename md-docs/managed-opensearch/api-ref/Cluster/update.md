# Managed Service for OpenSearch API, REST: Cluster.Update

Updates the specified OpenSearch cluster.

## HTTP request

```
PATCH https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the OpenSearch cluster resource to update.
To get the OpenSearch cluster ID, use a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.opensearch.v1.UpdateClusterRequest}

```json
{
  "updateMask": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "version": "string",
    "adminPassword": "string",
    "opensearchSpec": {
      "plugins": [
        "string"
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
      "setKeystoreSettings": [
        {
          "name": "string",
          "value": "string"
        }
      ],
      "removeKeystoreSettings": [
        "string"
      ]
    },
    "dashboardsSpec": "object",
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
    }
  },
  "name": "string",
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
  "networkId": "string"
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| description | **string**

New description of the OpenSearch cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the OpenSearch cluster as `key:value` pairs.
For example, `"project": "mvp"` or `"source": "dictionary"`.
The new set of labels completely replaces the old one. To add a label, request the current
set with the [ClusterService.Get](get.md#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| configSpec | **[ConfigUpdateSpec](#yandex.cloud.mdb.opensearch.v1.ConfigUpdateSpec)**

New cluster configuration ||
|| name | **string**

New name for the cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| securityGroupIds[] | **string**

User security groups ||
|| serviceAccountId | **string**

ID of the service account used to access Object Storage. ||
|| deletionProtection | **boolean**

Determines whether the cluster is protected from being deleted. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| networkId | **string**

ID of the network to move the cluster to.

The maximum string length in characters is 50. ||
|#

## ConfigUpdateSpec {#yandex.cloud.mdb.opensearch.v1.ConfigUpdateSpec}

#|
||Field | Description ||
|| version | **string**

OpenSearch version. ||
|| adminPassword | **string**

Required field. OpenSearch admin password.

The string length in characters must be 10-72. ||
|| opensearchSpec | **[OpenSearchClusterUpdateSpec](#yandex.cloud.mdb.opensearch.v1.OpenSearchClusterUpdateSpec)**

OpenSearch configuration. ||
|| dashboardsSpec | **object**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**

Access policy for external services. ||
|| snapshotManagement | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**

Snapshot management configuration ||
|| auditLog | **[AuditLog](#yandex.cloud.mdb.opensearch.v1.AuditLog)**

Audit log settings ||
|#

## OpenSearchClusterUpdateSpec {#yandex.cloud.mdb.opensearch.v1.OpenSearchClusterUpdateSpec}

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| opensearchConfig_2 | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**

Includes only one of the fields `opensearchConfig_2`. ||
|| setKeystoreSettings[] | **[KeystoreSetting](#yandex.cloud.mdb.opensearch.v1.KeystoreSetting)**

Keystore settings to add/replace. Old entries not listed here will be left unchanged. ||
|| removeKeystoreSettings[] | **string**

Keystore entries names to remove. ||
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

## AuditLog {#yandex.cloud.mdb.opensearch.v1.AuditLog}

Audit log settings.

#|
||Field | Description ||
|| complianceEnabled | **boolean**

Enable compliance audit logging. ||
|| logRequestBody | **boolean**

Log request body in audit logs. ||
|| logSearchQueries | **boolean**

Log search queries in audit logs. ||
|| logDataModifications | **boolean**

Log data modifications in audit logs. ||
|| logIndexMetadataAccess | **boolean**

Log index metadata access in audit logs. ||
|| logMonitoringChecks | **boolean**

Log monitoring checks in audit logs. ||
|| logIndexMaintenance | **boolean**

Log index maintenance operations in audit logs. ||
|| logBackupOperations | **boolean**

Log backup operations in audit logs. ||
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