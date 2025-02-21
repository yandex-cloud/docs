---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/BackupRetentionPolicy/delete.md
---

# Managed Service for PostgreSQL API, gRPC: BackupRetentionPolicyService.Delete

Delete retention policy.

## gRPC request

**rpc Delete ([DeleteBackupRetentionPolicyRequest](#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyRequest)) returns ([DeleteBackupRetentionPolicyResponse](#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse))**

## DeleteBackupRetentionPolicyRequest {#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyRequest}

```json
{
  "policy_id": "string",
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| policy_id | **string**

Unique identifier for the [BackupRetentionPolicy](/docs/managed-postgresql/api-ref/grpc/BackupRetentionPolicy/list#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy). ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|#

## DeleteBackupRetentionPolicyResponse {#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#