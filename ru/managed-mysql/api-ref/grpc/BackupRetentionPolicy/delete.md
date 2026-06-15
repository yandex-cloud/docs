---
editable: false
---

# Managed Service for MySQL API, gRPC: BackupRetentionPolicyService.Delete

Delete retention policy.

## gRPC request

**rpc Delete ([DeleteBackupRetentionPolicyRequest](#yandex.cloud.mdb.mysql.v1.DeleteBackupRetentionPolicyRequest)) returns ([DeleteBackupRetentionPolicyResponse](#yandex.cloud.mdb.mysql.v1.DeleteBackupRetentionPolicyResponse))**

## DeleteBackupRetentionPolicyRequest {#yandex.cloud.mdb.mysql.v1.DeleteBackupRetentionPolicyRequest}

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

Required field. ID of the MySQL cluster.
To get the MySQL cluster ID use a [ClusterService.List](/docs/managed-mysql/api-ref/grpc/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## DeleteBackupRetentionPolicyResponse {#yandex.cloud.mdb.mysql.v1.DeleteBackupRetentionPolicyResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#