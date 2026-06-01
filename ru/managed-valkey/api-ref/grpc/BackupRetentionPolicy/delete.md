---
editable: false
---

# Managed Service for Redis API, gRPC: BackupRetentionPolicyService.Delete

Delete retention policy.

## gRPC request

**rpc Delete ([DeleteBackupRetentionPolicyRequest](#yandex.cloud.mdb.redis.v1.DeleteBackupRetentionPolicyRequest)) returns ([DeleteBackupRetentionPolicyResponse](#yandex.cloud.mdb.redis.v1.DeleteBackupRetentionPolicyResponse))**

## DeleteBackupRetentionPolicyRequest {#yandex.cloud.mdb.redis.v1.DeleteBackupRetentionPolicyRequest}

```json
{
  "policy_id": "string",
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| policy_id | **string**

Unique identifier for the `BackupRetentionPolicy`. ||
|| cluster_id | **string**

Required field. ID of the Redis cluster.
To get the Redis cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## DeleteBackupRetentionPolicyResponse {#yandex.cloud.mdb.redis.v1.DeleteBackupRetentionPolicyResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#