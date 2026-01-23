---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/resource_groups
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/ResourceGroup/list.md
---

# Managed Service for Greenplum® API, REST: ResourceGroup.List

List all resource group

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/resource_groups
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.ListResourceGroupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "resourceGroups": [
    {
      "name": "string",
      "isUserDefined": "boolean",
      "concurrency": "string",
      "cpuRateLimit": "string",
      "memoryLimit": "string",
      "memorySharedQuota": "string",
      "memorySpillRatio": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| resourceGroups[] | **[ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup)** ||
|#

## ResourceGroup {#yandex.cloud.mdb.greenplum.v1.ResourceGroup}

#|
||Field | Description ||
|| name | **string**

Required field.

The string length in characters must be 3-200. Value must match the regular expression ``` ^[^\|/*?.,;'<>]+$ ```. ||
|| isUserDefined | **boolean** ||
|| concurrency | **string** (int64)

References to CONCURRENCY from gp resource group parameter

The minimum value is 0. ||
|| cpuRateLimit | **string** (int64)

References to CPU_RATE_LIMIT from gp resource group parameter

Acceptable values are 1 to 100, inclusive. ||
|| memoryLimit | **string** (int64)

References to MEMORY_LIMIT from gp resource group parameter

Acceptable values are 0 to 100, inclusive. ||
|| memorySharedQuota | **string** (int64)

References to MEMORY_SHARED_QUOTA from gp resource group parameter

Acceptable values are 0 to 100, inclusive. ||
|| memorySpillRatio | **string** (int64)

References to MEMORY_SPILL_RATIO from gp resource group parameter

Acceptable values are 0 to 100, inclusive. ||
|#