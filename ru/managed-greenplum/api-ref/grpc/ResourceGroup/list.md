---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/ResourceGroup/list.md
---

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

Required field.  ||
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
      "memory_spill_ratio": "google.protobuf.Int64Value"
    }
  ]
}
```

#|
||Field | Description ||
|| resource_groups[] | **[ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup)** ||
|#

## ResourceGroup {#yandex.cloud.mdb.greenplum.v1.ResourceGroup}

#|
||Field | Description ||
|| name | **string**

Required field.  ||
|| is_user_defined | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)** ||
|| concurrency | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to CONCURRENCY from gp resource group parameter ||
|| cpu_rate_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to CPU_RATE_LIMIT from gp resource group parameter ||
|| memory_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to MEMORY_LIMIT from gp resource group parameter ||
|| memory_shared_quota | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to MEMORY_SHARED_QUOTA from gp resource group parameter ||
|| memory_spill_ratio | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

References to MEMORY_SPILL_RATIO from gp resource group parameter ||
|#