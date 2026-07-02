[Документация Yandex Cloud](../../../index.md) > [Yandex StoreDoc](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [BackupRetentionPolicy](index.md) > Delete

# Managed Service for MongoDB API, REST: BackupRetentionPolicy.Delete

Delete retention policy.

## HTTP request

```
DELETE https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/retention_policies/{policyId}
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. Unique identifier for the `BackupRetentionPolicy`. ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster.
To get the MongoDB cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.DeleteBackupRetentionPolicyResponse}

**HTTP Code: 200 - OK**