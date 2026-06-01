---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/retention_policies/{policyId}
    method: delete
    path:
      type: object
      properties:
        policyId:
          description: |-
            **string**
            Unique identifier for the `BackupRetentionPolicy`.
          type: string
        clusterId:
          description: |-
            **string**
            Required field. ID of the MongoDB cluster.
            To get the MongoDB cluster ID use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for MongoDB API, REST: BackupRetentionPolicy.Delete

Delete retention policy.

## HTTP request

```
DELETE https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/retention_policies/{policyId}
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. Unique identifier for the `BackupRetentionPolicy`. ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster.
To get the MongoDB cluster ID use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.DeleteBackupRetentionPolicyResponse}

**HTTP Code: 200 - OK**