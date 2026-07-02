[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for PostgreSQL](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [BackupRetentionPolicy](index.md) > Delete

# Managed Service for PostgreSQL API, REST: BackupRetentionPolicy.Delete

Delete retention policy.

## HTTP request

```
DELETE https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/{clusterId}/retention_policies/{policyId}
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. Unique identifier for the [BackupRetentionPolicy](list.md#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy). ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse}

**HTTP Code: 200 - OK**