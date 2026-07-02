[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for MySQL®](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [BackupRetentionPolicy](index.md) > Get

# Managed Service for MySQL API, gRPC: BackupRetentionPolicyService.Get

Get a retention policy by ID.

## gRPC request

**rpc Get ([GetBackupRetentionPolicyRequest](#yandex.cloud.mdb.mysql.v1.GetBackupRetentionPolicyRequest)) returns ([yandex.cloud.mdb.v1.BackupRetentionPolicy](#yandex.cloud.mdb.v1.BackupRetentionPolicy))**

## GetBackupRetentionPolicyRequest {#yandex.cloud.mdb.mysql.v1.GetBackupRetentionPolicyRequest}

```json
{
  "cluster_id": "string",
  "policy_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the MySQL cluster.
To get the MySQL cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|| policy_id | **string**

Required field. Unique identifier for the [BackupRetentionPolicy](#yandex.cloud.mdb.v1.BackupRetentionPolicy). ||
|#

## yandex.cloud.mdb.v1.BackupRetentionPolicy {#yandex.cloud.mdb.v1.BackupRetentionPolicy}

```json
{
  "policy_id": "string",
  "cluster_id": "string",
  "policy_name": "string",
  "created_at": "google.protobuf.Timestamp",
  "cron": {
    "day_of_month": "string",
    "month": "string",
    "day_of_week": "string"
  },
  "retain_for_days": "int64",
  "description": "string"
}
```

Message to describe a retention policy for cluster backups.

#|
||Field | Description ||
|| policy_id | **string**

Required field. Required. Policy ID. ||
|| cluster_id | **string**

Required field. Cluster ID.

The maximum string length in characters is 50. ||
|| policy_name | **string**

Required field. Required. Policy name. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| cron | **[CronTab](#yandex.cloud.mdb.v1.CronTab)**

CronTab schedule. ||
|| retain_for_days | **int64**

Retention duration. ||
|| description | **string**

Human-readable description. ||
|#

## CronTab {#yandex.cloud.mdb.v1.CronTab}

Message to describe a crontab schedule.

#|
||Field | Description ||
|| day_of_month | **string**

Day of month in cron format. Valid values: 1-31, *, ranges (1-15), steps (*/2, 1-15/3), lists (1,15,28).
Defaults to "*". ||
|| month | **string**

Month in cron format. Valid values: 1-12, *, ranges (1-6), steps (*/3), lists (1,6,12).
Defaults to "*". ||
|| day_of_week | **string**

Day of week in cron format. Valid values: 0-7 (0 and 7 both mean Sunday), *, ranges (1-5), steps (0-6/2), lists (1,3,5).
Defaults to "*". ||
|#