# Managed Service for OpenSearch API, gRPC: ClusterService.Update

Updates the specified OpenSearch cluster.

## gRPC request

**rpc Update ([UpdateClusterRequest](#yandex.cloud.mdb.opensearch.v1.UpdateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterRequest {#yandex.cloud.mdb.opensearch.v1.UpdateClusterRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "description": "string",
  "labels": "map<string, string>",
  "config_spec": {
    "version": "string",
    "admin_password": "string",
    "opensearch_spec": {
      "plugins": [
        "string"
      ],
      // Includes only one of the fields `opensearch_config_2`
      "opensearch_config_2": {
        "max_clause_count": "google.protobuf.Int64Value",
        "fielddata_cache_size": "string",
        "search_max_buckets": "google.protobuf.Int64Value",
        "reindex_remote_whitelist": "string",
        "http_max_initial_line_length": "google.protobuf.StringValue"
      },
      // end of the list of possible fields
      "set_keystore_settings": [
        {
          "name": "string",
          "value": "string"
        }
      ],
      "remove_keystore_settings": [
        "string"
      ]
    },
    "dashboards_spec": "DashboardsClusterUpdateSpec",
    "access": {
      "data_transfer": "bool",
      "serverless": "bool"
    },
    "snapshot_management": {
      "snapshot_schedule": {
        // Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`
        "hourly_snapshot_schedule": {
          "minute": "int64"
        },
        "daily_snapshot_schedule": {
          "hour": "int64",
          "minute": "int64"
        },
        "weekly_snapshot_schedule": {
          "day": "WeekDay",
          "hour": "int64",
          "minute": "int64"
        }
        // end of the list of possible fields
      },
      "snapshot_max_age_days": "google.protobuf.Int64Value"
    },
    "audit_log": {
      "compliance_enabled": "google.protobuf.BoolValue",
      "log_request_body": "google.protobuf.BoolValue",
      "log_search_queries": "google.protobuf.BoolValue",
      "log_data_modifications": "google.protobuf.BoolValue",
      "log_index_metadata_access": "google.protobuf.BoolValue",
      "log_monitoring_checks": "google.protobuf.BoolValue",
      "log_index_maintenance": "google.protobuf.BoolValue",
      "log_backup_operations": "google.protobuf.BoolValue"
    },
    "cloud_storage": {
      "enabled": "google.protobuf.BoolValue"
    }
  },
  "name": "string",
  "security_group_ids": [
    "string"
  ],
  "service_account_id": "string",
  "deletion_protection": "bool",
  "maintenance_window": {
    // Includes only one of the fields `anytime`, `weekly_maintenance_window`
    "anytime": "AnytimeMaintenanceWindow",
    "weekly_maintenance_window": {
      "day": "WeekDay",
      "hour": "int64"
    }
    // end of the list of possible fields
  },
  "network_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the OpenSearch cluster resource to update.
To get the OpenSearch cluster ID, use a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the OpenSearch cluster resource should be updated. ||
|| description | **string**

New description of the OpenSearch cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels for the OpenSearch cluster as `key:value` pairs.
For example, `"project": "mvp"` or `"source": "dictionary"`.
The new set of labels completely replaces the old one. To add a label, request the current
set with the [ClusterService.Get](get.md#Get) method, then send an [ClusterService.Update](#Update) request with the new label added to the set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| config_spec | **[ConfigUpdateSpec](#yandex.cloud.mdb.opensearch.v1.ConfigUpdateSpec)**

New cluster configuration ||
|| name | **string**

New name for the cluster. The name must be unique within the folder.

The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `. ||
|| security_group_ids[] | **string**

User security groups ||
|| service_account_id | **string**

ID of the service account used to access Object Storage. ||
|| deletion_protection | **bool**

Determines whether the cluster is protected from being deleted. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow)**

Cluster maintenance window. Should be defined by either one of the two options. ||
|| network_id | **string**

ID of the network to move the cluster to.

The maximum string length in characters is 50. ||
|#

## ConfigUpdateSpec {#yandex.cloud.mdb.opensearch.v1.ConfigUpdateSpec}

#|
||Field | Description ||
|| version | **string**

OpenSearch version. ||
|| admin_password | **string**

Required field. OpenSearch admin password.

The string length in characters must be 10-72. ||
|| opensearch_spec | **[OpenSearchClusterUpdateSpec](#yandex.cloud.mdb.opensearch.v1.OpenSearchClusterUpdateSpec)**

OpenSearch configuration. ||
|| dashboards_spec | **[DashboardsClusterUpdateSpec](#yandex.cloud.mdb.opensearch.v1.DashboardsClusterUpdateSpec)**

Dashboards configuration. ||
|| access | **[Access](#yandex.cloud.mdb.opensearch.v1.Access)**

Access policy for external services. ||
|| snapshot_management | **[SnapshotManagement](#yandex.cloud.mdb.opensearch.v1.SnapshotManagement)**

Snapshot management configuration. ||
|| audit_log | **[AuditLog](#yandex.cloud.mdb.opensearch.v1.config.AuditLog)**

Audit log settings. ||
|| cloud_storage | **[CloudStorage](#yandex.cloud.mdb.opensearch.v1.CloudStorage)**

Cloud storage configuration. ||
|#

## OpenSearchClusterUpdateSpec {#yandex.cloud.mdb.opensearch.v1.OpenSearchClusterUpdateSpec}

#|
||Field | Description ||
|| plugins[] | **string**

Names of the cluster plugins. ||
|| opensearch_config_2 | **[OpenSearchConfig2](#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2)**

OpenSearch server configuration settings.

Includes only one of the fields `opensearch_config_2`. ||
|| set_keystore_settings[] | **[KeystoreSetting](#yandex.cloud.mdb.opensearch.v1.KeystoreSetting)**

Keystore settings to add/replace. Old entries not listed here will be left unchanged. ||
|| remove_keystore_settings[] | **string**

Keystore entries names to remove. ||
|#

## OpenSearchConfig2 {#yandex.cloud.mdb.opensearch.v1.config.OpenSearchConfig2}

OpenSearch server configuration settings.

#|
||Field | Description ||
|| max_clause_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Defines the maximum product of fields and terms that are queryable simultaneously.

Default value: **1024**.

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings). ||
|| fielddata_cache_size | **string**

The maximum size of the field data cache.
May be specified as an absolute value (for example, 8GB) or a percentage of the node heap (for example, 50%).
This setting is dynamic. If you don't specify this setting, the maximum size is 35%.
This value should be smaller than the **indices.breaker.fielddata.limit**

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/index-settings/#dynamic-cluster-level-index-settings). ||
|| search_max_buckets | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of aggregation buckets allowed in a single response. Default is 65535

Default value: **65535**.

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/install-and-configure/configuring-opensearch/search-settings). ||
|| reindex_remote_whitelist | **string**

Allowed remote hosts

Change of the setting is applied with restart.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/api-reference/document-apis/reindex/#remote-cluster-allow-list). ||
|| http_max_initial_line_length | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

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

## DashboardsClusterUpdateSpec {#yandex.cloud.mdb.opensearch.v1.DashboardsClusterUpdateSpec}

Dashboards configuration.

#|
||Field | Description ||
|| Empty | > ||
|#

## Access {#yandex.cloud.mdb.opensearch.v1.Access}

Access policy for external services.

#|
||Field | Description ||
|| data_transfer | **bool**

Determines whether the access to Data Transfer is allowed. ||
|| serverless | **bool**

Determines whether the access to Serverless is allowed. ||
|#

## SnapshotManagement {#yandex.cloud.mdb.opensearch.v1.SnapshotManagement}

Snapshot management configuration

#|
||Field | Description ||
|| snapshot_schedule | **[SnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule)**

Snapshot creation schedule ||
|| snapshot_max_age_days | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Snapshot max age in days

The minimum value is 7. ||
|#

## SnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.SnapshotSchedule}

Snapshot creation schedule

#|
||Field | Description ||
|| hourly_snapshot_schedule | **[HourlySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule)**

Hourly based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|| daily_snapshot_schedule | **[DailySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule)**

Daily based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|| weekly_snapshot_schedule | **[WeeklySnapshotSchedule](#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule)**

Weekly based snapshot schedule

Includes only one of the fields `hourly_snapshot_schedule`, `daily_snapshot_schedule`, `weekly_snapshot_schedule`. ||
|#

## HourlySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.HourlySnapshotSchedule}

Hourly based snapshot schedule

#|
||Field | Description ||
|| minute | **int64**

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## DailySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.DailySnapshotSchedule}

Daily based snapshot schedule

#|
||Field | Description ||
|| hour | **int64**

The hour of the day in UTC timezone at which the backup should be created.

Acceptable values are 0 to 23, inclusive. ||
|| minute | **int64**

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## WeeklySnapshotSchedule {#yandex.cloud.mdb.opensearch.v1.WeeklySnapshotSchedule}

Weekly based snapshot schedule

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week

- `MON`
- `TUE`
- `WED`
- `THU`
- `FRI`
- `SAT`
- `SUN` ||
|| hour | **int64**

The hour of the day in UTC timezone at which the backup should be created.

Acceptable values are 0 to 23, inclusive. ||
|| minute | **int64**

The minute of the hour at which the backup should be created.

Acceptable values are 0 to 59, inclusive. ||
|#

## AuditLog {#yandex.cloud.mdb.opensearch.v1.config.AuditLog}

OpenSearch audit logs settings.

#|
||Field | Description ||
|| compliance_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables audit logging on changes to a security index, such as changes to roles mappings and role creation or deletion.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#audit-user-account-manipulation). ||
|| log_request_body | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Includes the body of the request (if available) for both REST and the transport layer.

For details, see [OpenSearch documentation](https://docs.opensearch.org/latest/security/audit-logs/index/#disable-request-body-logging). ||
|| log_search_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables indices data read requests logging. ||
|| log_data_modifications | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables indices data write request logging. ||
|| log_index_metadata_access | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables indices metadata requests logging. ||
|| log_monitoring_checks | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables monitoring data requests logging. ||
|| log_index_maintenance | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables indices maintenance requests logging, such as indices refreshes, flushes and merges. ||
|| log_backup_operations | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Enables snapshots and repositories requests logging. ||
|#

## CloudStorage {#yandex.cloud.mdb.opensearch.v1.CloudStorage}

Cloud storage configuration.

#|
||Field | Description ||
|| enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether to use Object Storage for storing OpenSearch data. ||
|#

## MaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.MaintenanceWindow}

An OpenSearch cluster maintenance window. Should be defined by either one of the two options.

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.AnytimeMaintenanceWindow)**

An any-time maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow)**

A weekly maintenance window.

Includes only one of the fields `anytime`, `weekly_maintenance_window`. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.AnytimeMaintenanceWindow}

An any-time maintenance window.

#|
||Field | Description ||
|| Empty | > ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.mdb.opensearch.v1.WeeklyMaintenanceWindow}

A weekly maintenance window.

#|
||Field | Description ||
|| day | enum **WeekDay**

Day of the week.

- `MON`: Monday
- `TUE`: Tuesday
- `WED`: Wednesday
- `THU`: Thursday
- `FRI`: Friday
- `SAT`: Saturday
- `SUN`: Sunday ||
|| hour | **int64**

Hour of the day in the UTC timezone.

Acceptable values are 1 to 24, inclusive. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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