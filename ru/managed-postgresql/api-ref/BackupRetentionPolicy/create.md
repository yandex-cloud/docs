---
editable: false
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/BackupRetentionPolicy/create.md
---

# Managed Service for PostgreSQL API, REST: BackupRetentionPolicy.Create

Add a new retention policy.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/retention_policies
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyRequest}

```json
{
  "cron": {
    "dayOfMonth": "string",
    "month": "string",
    "dayOfWeek": "string"
  },
  "retainForDays": "string",
  "description": "string",
  "policyName": "string"
}
```

#|
||Field | Description ||
|| cron | **[CronTab](#yandex.cloud.mdb.postgresql.v1.CronTab)**

CronTab schedule. ||
|| retainForDays | **string** (int64)

Retention duration. ||
|| description | **string**

Policy description. ||
|| policyName | **string**

Required field. Required. Policy name. ||
|#

## CronTab {#yandex.cloud.mdb.postgresql.v1.CronTab}

Message to describe a crontab schedule.

#|
||Field | Description ||
|| dayOfMonth | **string** ||
|| month | **string** ||
|| dayOfWeek | **string** ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyResponse}

**HTTP Code: 200 - OK**

```json
{
  "policy": {
    "policyId": "string",
    "clusterId": "string",
    "policyName": "string",
    "createdAt": "string",
    "cron": {
      "dayOfMonth": "string",
      "month": "string",
      "dayOfWeek": "string"
    },
    "retainForDays": "string",
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
|| policyId | **string**

Required field. Required. Policy ID. ||
|| clusterId | **string**

Required field. PostgreSQL cluster ID. ||
|| policyName | **string**

Required field. Required. Policy name. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cron | **[CronTab](#yandex.cloud.mdb.postgresql.v1.CronTab2)**

CronTab schedule. ||
|| retainForDays | **string** (int64)

Retention duration. ||
|| description | **string**

Human-readable description. ||
|#

## CronTab {#yandex.cloud.mdb.postgresql.v1.CronTab2}

Message to describe a crontab schedule.

#|
||Field | Description ||
|| dayOfMonth | **string** ||
|| month | **string** ||
|| dayOfWeek | **string** ||
|#