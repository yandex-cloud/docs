---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/ResourceGroup/update.md
---

# Managed Service for Greenplum® API, gRPC: ResourceGroupService.Update

Update resource group

## gRPC request

**rpc Update ([UpdateResourceGroupRequest](#yandex.cloud.mdb.greenplum.v1.UpdateResourceGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateResourceGroupRequest {#yandex.cloud.mdb.greenplum.v1.UpdateResourceGroupRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "resource_group": {
    "name": "string",
    "is_user_defined": "google.protobuf.BoolValue",
    "concurrency": "google.protobuf.Int64Value",
    "cpu_rate_limit": "google.protobuf.Int64Value",
    "memory_limit": "google.protobuf.Int64Value",
    "memory_shared_quota": "google.protobuf.Int64Value",
    "memory_spill_ratio": "google.protobuf.Int64Value"
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field.  ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)** ||
|| resource_group | **[ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup)** ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "resource_group_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "is_user_defined": "google.protobuf.BoolValue",
    "concurrency": "google.protobuf.Int64Value",
    "cpu_rate_limit": "google.protobuf.Int64Value",
    "memory_limit": "google.protobuf.Int64Value",
    "memory_shared_quota": "google.protobuf.Int64Value",
    "memory_spill_ratio": "google.protobuf.Int64Value"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateResourceGroupMetadata](#yandex.cloud.mdb.greenplum.v1.UpdateResourceGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup2)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateResourceGroupMetadata {#yandex.cloud.mdb.greenplum.v1.UpdateResourceGroupMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

Required field.  ||
|| resource_group_name | **string**

Required field.  ||
|#

## ResourceGroup {#yandex.cloud.mdb.greenplum.v1.ResourceGroup2}

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