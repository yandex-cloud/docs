---
editable: false
---

# Network Load Balancer API, gRPC: TargetGroupService.Create

Creates a target group in the specified folder and adds the specified targets to it.

## gRPC request

**rpc Create ([CreateTargetGroupRequest](#yandex.cloud.loadbalancer.v1.CreateTargetGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateTargetGroupRequest {#yandex.cloud.loadbalancer.v1.CreateTargetGroupRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "region_id": "string",
  "targets": [
    {
      "subnet_id": "string",
      "address": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list target groups in.
To get the folder ID, use a [TargetGroupService.List](/docs/network-load-balancer/api-ref/grpc/TargetGroup/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the target group.
The name must be unique within the folder.
The value must match the regular expression: ```|[a-z][-a-z0-9]{1,61}[a-z0-9]```. ||
|| description | **string**

Description of the target group.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs.
Each map key must match the regular expression: `[a-z][-_0-9a-z]*`.
Each map value must match the regular expression: `[-_0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| region_id | **string**

ID of the availability zone where the target group resides.
The length must be less than or equal to 50. ||
|| targets[] | **[Target](#yandex.cloud.loadbalancer.v1.Target)**

List of targets within the target group. ||
|#

## Target {#yandex.cloud.loadbalancer.v1.Target}

A Target resource. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| subnet_id | **string**

ID of the subnet that targets are connected to.
All targets in the target group must be connected to the same subnet within a single availability zone.
The length must be less than or equal to 50. ||
|| address | **string**

IP address of the target. ||
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