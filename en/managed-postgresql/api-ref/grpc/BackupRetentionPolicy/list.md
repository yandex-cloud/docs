---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/BackupRetentionPolicy/list.md
---

# Managed Service for PostgreSQL API, gRPC: BackupRetentionPolicyService.List

List all retention policies.

## gRPC request

**rpc List ([ListBackupRetentionPoliciesRequest](#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesRequest)) returns ([ListBackupRetentionPoliciesResponse](#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse))**

## ListBackupRetentionPoliciesRequest {#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListBackupRetentionPoliciesResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListBackupRetentionPoliciesResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse) returned by the previous list request. ||
|#

## ListBackupRetentionPoliciesResponse {#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse}

```json
{
  "policies": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| policies[] | **[BackupRetentionPolicy](#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy)**

List of [BackupRetentionPolicy](#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy) associated with the cluster. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBackupRetentionPoliciesRequest.page_size](#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesRequest), use the `next_page_token` as the value
for the [ListBackupRetentionPoliciesRequest.page_token](#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
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
|| cron | **[CronTab](#yandex.cloud.mdb.postgresql.v1.CronTab)**

CronTab schedule. ||
|| retain_for_days | **int64**

Retention duration. ||
|| description | **string**

Human-readable description. ||
|#

## CronTab {#yandex.cloud.mdb.postgresql.v1.CronTab}

Message to describe a crontab schedule.

#|
||Field | Description ||
|| day_of_month | **string** ||
|| month | **string** ||
|| day_of_week | **string** ||
|#