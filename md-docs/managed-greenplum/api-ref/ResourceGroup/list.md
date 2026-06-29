# Managed Service for Greenplum® API, REST: ResourceGroup.List

List all resource group

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/{clusterId}/resource_groups
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
      "memorySpillRatio": "string",
      "cpuMaxPercent": "string",
      "cpuWeight": "string",
      "memoryQuota": "string",
      "minCost": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| resourceGroups[] | **[ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup)** ||
|#

## ResourceGroup {#yandex.cloud.mdb.greenplum.v1.ResourceGroup}

ResourceGroup defines a resource group configuration shared between Greenplum and Apache Cloudberry,
but the two engines use different sets of fields.

Greenplum fields:
* concurrency
* cpu_rate_limit
* memory_limit
* memory_shared_quota
* memory_spill_ratio

Apache Cloudberry fields:
* concurrency
* cpu_max_percent
* cpu_weight
* memory_quota
* min_cost

The sets partially overlap (concurrency is common to both). Passing Greenplum-specific
fields to a CloudBerry cluster or vice versa is not rejected at the proto level -
field validation is performed at runtime by the service.

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
|| cpuMaxPercent | **string** (int64)

References to CPU_MAX_PERCENT from Apache Cloudberry resource group parameter:
The maximum percentage of CPU resources the group can use. ||
|| cpuWeight | **string** (int64)

References to CPU_WEIGHT from Apache Cloudberry resource group parameter:
The scheduling priority of the resource group.

Acceptable values are 1 to 500, inclusive. ||
|| memoryQuota | **string** (int64)

References to MEMORY_QUOTA from Apache Cloudberry resource group parameter:
The memory limit (Mb) specified for the resource group. ||
|| minCost | **string** (int64)

References to MIN_COST from Apache Cloudberry resource group parameter:
The minimum cost of a query plan to be included in the resource group. ||
|#