---
editable: false
---

# Managed Service for Greenplum® API, gRPC: ResourceGroupService.GetAtRevision

Returns the specified resource group at revision.

## gRPC request

**rpc GetAtRevision ([GetResourceGroupAtRevisionRequest](#yandex.cloud.mdb.greenplum.v1.GetResourceGroupAtRevisionRequest)) returns ([ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup))**

## GetResourceGroupAtRevisionRequest {#yandex.cloud.mdb.greenplum.v1.GetResourceGroupAtRevisionRequest}

```json
{
  "cluster_id": "string",
  "revision": "int64",
  "resource_group_name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Greenplum cluster.

The maximum string length in characters is 50. ||
|| revision | **int64**

Cluster revision

Value must be greater than 0. ||
|| resource_group_name | **string**

Required field.

The string length in characters must be 3-200. Value must match the regular expression ``` ^[^\|/*?.,;'<>]+$ ```. ||
|#

## ResourceGroup {#yandex.cloud.mdb.greenplum.v1.ResourceGroup}

```json
{
  "name": "string",
  "is_user_defined": "google.protobuf.BoolValue",
  "concurrency": "google.protobuf.Int64Value",
  "cpu_rate_limit": "google.protobuf.Int64Value",
  "memory_limit": "google.protobuf.Int64Value",
  "memory_shared_quota": "google.protobuf.Int64Value",
  "memory_spill_ratio": "google.protobuf.Int64Value"
}
```

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
|#