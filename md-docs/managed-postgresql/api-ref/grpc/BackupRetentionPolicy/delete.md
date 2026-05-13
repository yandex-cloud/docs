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

Unique identifier for the [BackupRetentionPolicy](list.md#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy). ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## DeleteBackupRetentionPolicyResponse {#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#