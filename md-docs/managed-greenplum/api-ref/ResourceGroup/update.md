# Managed Service for Greenplum® API, REST: ResourceGroup.Update

Update resource group

## HTTP request

```
PATCH https://mdb.api.cloud.yandex.net/managed-greenplum/v1/clusters/{clusterId}/resource_groups
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.greenplum.v1.UpdateResourceGroupRequest}

```json
{
  "updateMask": "string",
  "resourceGroup": {
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
    "minCost": "string",
    "ioLimit": "string"
  }
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| resourceGroup | **[ResourceGroup](#yandex.cloud.mdb.greenplum.v1.ResourceGroup)** ||
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
|| ioLimit | **string** (int64)

References to IO_LIMIT from Apache Cloudberry resource group parameter:
The limit for the maximum read/write disk I/O throughput, and maximum read/write I/O operations per second.
Set the value on a per-tablespace basis. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "resourceGroupName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
    "minCost": "string",
    "ioLimit": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateResourceGroupMetadata](#yandex.cloud.mdb.greenplum.v1.UpdateResourceGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| clusterId | **string**

Required field.

The maximum string length in characters is 50. ||
|| resourceGroupName | **string**

Required field.

The string length in characters must be 3-200. Value must match the regular expression ``` ^[^\|/*?.,;'<>]+$ ```. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
* io_limit

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
|| ioLimit | **string** (int64)

References to IO_LIMIT from Apache Cloudberry resource group parameter:
The limit for the maximum read/write disk I/O throughput, and maximum read/write I/O operations per second.
Set the value on a per-tablespace basis. ||
|#