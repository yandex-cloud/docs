---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/ResourceGroup/getAtRevision.md
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

Required field. ID of the Greenplum cluster. ||
|| revision | **int64**

Cluster revision ||
|| resource_group_name | **string**

Required field.  ||
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