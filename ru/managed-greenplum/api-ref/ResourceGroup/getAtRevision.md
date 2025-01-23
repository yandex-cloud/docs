---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/ResourceGroup/getAtRevision.md
---

# Managed Service for Greenplum® API, REST: ResourceGroup.GetAtRevision

Returns the specified resource group at revision.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/resource_groups/at_rev
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum cluster. ||
|#

## Query parameters {#yandex.cloud.mdb.greenplum.v1.GetResourceGroupAtRevisionRequest}

#|
||Field | Description ||
|| revision | **string** (int64)

Cluster revision ||
|| resourceGroupName | **string**

Required field.  ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.ResourceGroup}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "isUserDefined": "boolean",
  "concurrency": "string",
  "cpuRateLimit": "string",
  "memoryLimit": "string",
  "memorySharedQuota": "string",
  "memorySpillRatio": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| isUserDefined | **boolean** ||
|| concurrency | **string** (int64)

References to CONCURRENCY from gp resource group parameter ||
|| cpuRateLimit | **string** (int64)

References to CPU_RATE_LIMIT from gp resource group parameter ||
|| memoryLimit | **string** (int64)

References to MEMORY_LIMIT from gp resource group parameter ||
|| memorySharedQuota | **string** (int64)

References to MEMORY_SHARED_QUOTA from gp resource group parameter ||
|| memorySpillRatio | **string** (int64)

References to MEMORY_SPILL_RATIO from gp resource group parameter ||
|#