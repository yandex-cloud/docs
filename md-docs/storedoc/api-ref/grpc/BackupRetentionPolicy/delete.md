[Документация Yandex Cloud](../../../../index.md) > [Yandex StoreDoc](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [BackupRetentionPolicy](index.md) > Delete

# Managed Service for MongoDB API, gRPC: BackupRetentionPolicyService.Delete

Delete retention policy.

## gRPC request

**rpc Delete ([DeleteBackupRetentionPolicyRequest](#yandex.cloud.mdb.mongodb.v1.DeleteBackupRetentionPolicyRequest)) returns ([DeleteBackupRetentionPolicyResponse](#yandex.cloud.mdb.mongodb.v1.DeleteBackupRetentionPolicyResponse))**

## DeleteBackupRetentionPolicyRequest {#yandex.cloud.mdb.mongodb.v1.DeleteBackupRetentionPolicyRequest}

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

Required field. ID of the MongoDB cluster.
To get the MongoDB cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## DeleteBackupRetentionPolicyResponse {#yandex.cloud.mdb.mongodb.v1.DeleteBackupRetentionPolicyResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#