---
editable: false
---

# Compute Cloud Instance Groups API, gRPC: InstanceGroupService.DeleteInstances

Delete instances from the instance group.

## gRPC request

**rpc DeleteInstances ([DeleteInstancesRequest](#yandex.cloud.compute.v1.instancegroup.DeleteInstancesRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DeleteInstancesRequest {#yandex.cloud.compute.v1.instancegroup.DeleteInstancesRequest}

```json
{
  "instance_group_id": "string",
  "managed_instance_ids": [
    "string"
  ],
  "create_another": "bool"
}
```

#|
||Field | Description ||
|| instance_group_id | **string**

Required field. ID of the instance group that the instances are being deleted from.
To get the ID of the instance group, use the [InstanceGroupService.List](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| managed_instance_ids[] | **string**

IDs of the instances to delete. Instances will be deleted along with all dependent resources.
Only IDs from the ManagedInstance.id field are allowed, not ManagedInstance.instance_id.
The length of each element must be less than or equal to 50.
The number of elements must be greater than or equal to 1. ||
|| create_another | **bool**

If set to true, the target size of instance group will not be reduced and
a new instance will be created instead of the deleted one. By default, the target size of instance group
will be reduced by the specified number of instance IDs. ||
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