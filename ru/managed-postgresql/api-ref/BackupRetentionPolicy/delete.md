---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/retention_policies/{policyId}
    method: delete
    path:
      type: object
      properties:
        policyId:
          description: |-
            **string**
            Unique identifier for the [BackupRetentionPolicy](/docs/managed-postgresql/api-ref/BackupRetentionPolicy/list#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy).
          type: string
        clusterId:
          description: |-
            **string**
            Required field. ID of the PostgreSQL cluster.
            To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/postgresql/v1/api-ref/BackupRetentionPolicy/delete.md
---

# Managed Service for PostgreSQL API, REST: BackupRetentionPolicy.Delete

Delete retention policy.

## HTTP request

```
DELETE https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/{clusterId}/retention_policies/{policyId}
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. Unique identifier for the [BackupRetentionPolicy](/docs/managed-postgresql/api-ref/BackupRetentionPolicy/list#yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicy). ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/Cluster/list#List) request. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse}

**HTTP Code: 200 - OK**