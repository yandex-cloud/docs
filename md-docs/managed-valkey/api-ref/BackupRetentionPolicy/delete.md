# Managed Service for Redis API, REST: BackupRetentionPolicy.Delete

Delete retention policy.

## HTTP request

```
DELETE https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/retention_policies/{policyId}
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. Unique identifier for the `BackupRetentionPolicy`. ||
|| clusterId | **string**

Required field. ID of the Redis cluster.
To get the Redis cluster ID use a [ClusterService.List](../../../managed-redis/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.DeleteBackupRetentionPolicyResponse}

**HTTP Code: 200 - OK**