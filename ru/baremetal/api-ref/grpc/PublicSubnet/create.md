---
editable: false
---

# BareMetal API, gRPC: PublicSubnetService.Create

Creates a public subnet in the specified folder.

## gRPC request

**rpc Create ([CreatePublicSubnetRequest](#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreatePublicSubnetRequest {#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetRequest}

```json
{
  // Includes only one of the fields `auto_allocation`, `manual_allocation`
  "auto_allocation": {
    "prefix_length": "int64"
  },
  "manual_allocation": {
    "cidr": "string",
    "public_prefix_pool_id": "string"
  },
  // end of the list of possible fields
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "hardware_pool_ids": [
    "string"
  ],
  "prefix_length": "int64",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| auto_allocation | **[AutoAllocation](#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetRequest.AutoAllocation)**

Automatic CIDR allocation from the system public prefix pool.

Includes only one of the fields `auto_allocation`, `manual_allocation`.

Method for allocating CIDR block to the public subnet. ||
|| manual_allocation | **[ManualAllocation](#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetRequest.ManualAllocation)**

Manual CIDR allocation with explicit CIDR from user's own public prefix pool (BYOIP).

Includes only one of the fields `auto_allocation`, `manual_allocation`.

Method for allocating CIDR block to the public subnet. ||
|| folder_id | **string**

ID of the folder to create a public subnet in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the public subnet.
The name must be unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the public subnet.

The maximum string length in characters is 1024. ||
|| hardware_pool_ids[] | **string**

IDs of the hardware pool that the public subnet belongs to.
To get a list of available hardware pools, use the [HardwarePoolService.List](/docs/baremetal/api-ref/grpc/HardwarePool/list#List) request. ||
|| prefix_length | **int64**

@deprecated
Prefix length of the public subnet CIDR block.

Acceptable values are 1 to 31, inclusive. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## AutoAllocation {#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetRequest.AutoAllocation}

Automatic CIDR allocation configuration.

#|
||Field | Description ||
|| prefix_length | **int64**

Prefix length of the public subnet CIDR block.

Acceptable values are 1 to 31, inclusive. ||
|#

## ManualAllocation {#yandex.cloud.baremetal.v1alpha.CreatePublicSubnetRequest.ManualAllocation}

Manual CIDR allocation configuration.

#|
||Field | Description ||
|| cidr | **string**

CIDR block of the public subnet. Must be within the public prefix pool CIDR block. ||
|| public_prefix_pool_id | **string**

ID of the public prefix pool that the CIDR block belongs to.
To get a list of available public prefix pools, use the [PublicPrefixPoolService.List](/docs/baremetal/api-ref/grpc/PublicPrefixPool/list#List) request. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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