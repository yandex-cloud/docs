---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/BackupRetentionPolicy/create.md
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
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
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
|| day_of_month | **string** ||
|| month | **string** ||
|| day_of_week | **string** ||
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

Required field. PostgreSQL cluster ID. ||
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
|| day_of_month | **string** ||
|| month | **string** ||
|| day_of_week | **string** ||
|#