[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for MySQL®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [BackupRetentionPolicy](index.md) > Delete

# Managed Service for MySQL API, REST: BackupRetentionPolicy.Delete

Delete retention policy.

## HTTP request

```
DELETE https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/retention_policies/{policyId}
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. Unique identifier for the `BackupRetentionPolicy`. ||
|| clusterId | **string**

Required field. ID of the MySQL cluster.
To get the MySQL cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.DeleteBackupRetentionPolicyResponse}

**HTTP Code: 200 - OK**