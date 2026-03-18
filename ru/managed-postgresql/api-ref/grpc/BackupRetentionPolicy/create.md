---
editable: false
---

# Managed Service for PostgreSQL API, gRPC: BackupRetentionPolicyService.Create

Add a new retention policy.

## gRPC request

**rpc Create ([CreateBackupRetentionPolicyRequest](#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyRequest)) returns ([CreateBackupRetentionPolicyResponse](#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyResponse))**

## CreateBackupRetentionPolicyRequest {#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyRequest}

```json
{
  "cluster_id": "string",
  "cron": {
    "day_of_month": "string",
    "month": "string",
    "day_of_week": "string"
  },
  "retain_for_days": "int64",
  "description": "string",
  "policy_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|| cron | **[CronTab](#yandex.cloud.mdb.postgresql.v1.CronTab)**

CronTab schedule. ||
|| retain_for_days | **int64**

Retention duration. ||
|| description | **string**

Policy description. ||
|| policy_name | **string**

Required field. Required. Policy name. ||
|#

## CronTab {#yandex.cloud.mdb.postgresql.v1.CronTab}

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

## CreateBackupRetentionPolicyResponse {#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyResponse}

```json
{
  "policy": {
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
}
```

#|
||Field | Description ||
|| policy | **[BackupRetentionPolicy](#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy)**

Newly created [BackupRetentionPolicy](#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy). ||
|#

## BackupRetentionPolicy {#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy}

Message to describe a retention policy for cluster backups.

#|
||Field | Description ||
|| policy_id | **string**

Required field. Required. Policy ID. ||
|| cluster_id | **string**

Required field. PostgreSQL cluster ID.

The maximum string length in characters is 50. ||
|| policy_name | **string**

Required field. Required. Policy name. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| cron | **[CronTab](#yandex.cloud.mdb.postgresql.v1.CronTab2)**

CronTab schedule. ||
|| retain_for_days | **int64**

Retention duration. ||
|| description | **string**

Human-readable description. ||
|#

## CronTab {#yandex.cloud.mdb.postgresql.v1.CronTab2}

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