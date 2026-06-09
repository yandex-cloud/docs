# Managed Service for Greenplum® API, gRPC: ResourceGroupService.List

List all resource group

## gRPC request

**rpc List ([ListResourceGroupsRequest](#yandex.cloud.mdb.greenplum.v1.ListResourceGroupsRequest)) returns ([ListResourceGroupsResponse](#yandex.cloud.mdb.greenplum.v1.ListResourceGroupsResponse))**

## ListResourceGroupsRequest {#yandex.cloud.mdb.greenplum.v1.ListResourceGroupsRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field.

The maximum string length in characters is 50. ||
|#

## ListResourceGroupsResponse {#yandex.cloud.mdb.greenplum.v1.ListResourceGroupsResponse}

```json
{
  "resource_groups": [
    {
      "name": "string",
      "is_user_defined": "google.protobuf.BoolValue",
      "concurrency": "google.protobuf.Int64Value",
      "cpu_rate_limit": "google.protobuf.Int64Value",
      "memory_limit": "google.protobuf.Int64Value",
      "memory_shared_quota": "google.protobuf.Int64Value",
      "memory_spill_ratio": "google.protobuf.Int64Value",
      "cpu_max_percent": "google.protobuf.Int64Value",
      "cpu_weight": "google.protobuf.Int64Value",
      "memory_quota": "google.protobuf.Int64Value",
      "min_cost": "google.protobuf.Int64Value",
      "io_limit": "google.protobuf.Int64Value"
    }
  ]
}
```

#|
||Field | Description ||
|| resource_groups[] | **[ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup)** ||
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
* io_limit

The sets partially overlap (concurrency is common to both). Passing Greenplum-specific
fields to a CloudBerry cluster or vice versa is not rejected at the proto level -
field validation is performed at runtime by the service.

#|
||Field | Description ||
|| name | **string**

Required field.

The string length in characters must be 3-200. Value must match the regular expression ``` ^[^\|/*?.,;'<>]+$ ```. ||
|| is_user_defined | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| concurrency | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to CONCURRENCY from gp resource group parameter

The minimum value is 0. ||
|| cpu_rate_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to CPU_RATE_LIMIT from gp resource group parameter

Acceptable values are 1 to 100, inclusive. ||
|| memory_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to MEMORY_LIMIT from gp resource group parameter

Acceptable values are 0 to 100, inclusive. ||
|| memory_shared_quota | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to MEMORY_SHARED_QUOTA from gp resource group parameter

Acceptable values are 0 to 100, inclusive. ||
|| memory_spill_ratio | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to MEMORY_SPILL_RATIO from gp resource group parameter

Acceptable values are 0 to 100, inclusive. ||
|| cpu_max_percent | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to CPU_MAX_PERCENT from Apache Cloudberry resource group parameter:
The maximum percentage of CPU resources the group can use. ||
|| cpu_weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to CPU_WEIGHT from Apache Cloudberry resource group parameter:
The scheduling priority of the resource group.

Acceptable values are 1 to 500, inclusive. ||
|| memory_quota | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to MEMORY_QUOTA from Apache Cloudberry resource group parameter:
The memory limit (Mb) specified for the resource group. ||
|| min_cost | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to MIN_COST from Apache Cloudberry resource group parameter:
The minimum cost of a query plan to be included in the resource group. ||
|| io_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to IO_LIMIT from Apache Cloudberry resource group parameter:
The limit for the maximum read/write disk I/O throughput, and maximum read/write I/O operations per second.
Set the value on a per-tablespace basis. ||
|#