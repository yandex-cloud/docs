[Документация Yandex Cloud](../../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [ResourceGroup](index.md) > Create

# Managed Service for Greenplum® API, gRPC: ResourceGroupService.Create

Creates resource group

## gRPC request

**rpc Create ([CreateResourceGroupRequest](#yandex.cloud.mdb.greenplum.v1.CreateResourceGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateResourceGroupRequest {#yandex.cloud.mdb.greenplum.v1.CreateResourceGroupRequest}

```json
{
  "cluster_id": "string",
  "resource_group": {
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
    "min_cost": "google.protobuf.Int64Value"
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field.

The maximum string length in characters is 50. ||
|| resource_group | **[ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup)** ||
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
    "memory_spill_ratio": "google.protobuf.Int64Value",
    "cpu_max_percent": "google.protobuf.Int64Value",
    "cpu_weight": "google.protobuf.Int64Value",
    "memory_quota": "google.protobuf.Int64Value",
    "min_cost": "google.protobuf.Int64Value"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[CreateResourceGroupMetadata](#yandex.cloud.mdb.greenplum.v1.CreateResourceGroupMetadata)**

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

## CreateResourceGroupMetadata {#yandex.cloud.mdb.greenplum.v1.CreateResourceGroupMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

Required field.

The maximum string length in characters is 50. ||
|| resource_group_name | **string**

Required field.

The string length in characters must be 3-200. Value must match the regular expression ``` ^[^\|/*?.,;'<>]+$ ```. ||
|#

## ResourceGroup {#yandex.cloud.mdb.greenplum.v1.ResourceGroup2}

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
|#