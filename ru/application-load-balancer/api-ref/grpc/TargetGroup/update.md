---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/TargetGroup/update.md
---

# Application Load Balancer API, gRPC: TargetGroupService.Update {#Update}

Updates the specified target group.

## gRPC request

**rpc Update ([UpdateTargetGroupRequest](#yandex.cloud.apploadbalancer.v1.UpdateTargetGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateTargetGroupRequest {#yandex.cloud.apploadbalancer.v1.UpdateTargetGroupRequest}

```json
{
  "targetGroupId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string",
  "targets": [
    {
      // Includes only one of the fields `ipAddress`
      "ipAddress": "string",
      // end of the list of possible fields
      "subnetId": "string",
      "privateIpv4Address": "bool"
    }
  ]
}
```

#|
||Field | Description ||
|| targetGroupId | **string**

Required field. ID of the target group to update.

To get the target group ID, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/grpc/TargetGroup/list#List) request. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the target group should be updated. ||
|| name | **string**

New name for the target group.
The name must be unique within the folder. ||
|| description | **string**

New description of the target group. ||
|| labels | **string**

Target group labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels).

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [TargetGroupService.Get](/docs/application-load-balancer/api-ref/grpc/TargetGroup/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| targets[] | **[Target](#yandex.cloud.apploadbalancer.v1.Target)**

New list of targets in the target group.

Existing list of targets is completely replaced by the specified list, so if you just want to add or remove
a target, make a [TargetGroupService.AddTargets](/docs/application-load-balancer/api-ref/grpc/TargetGroup/addTargets#AddTargets) request or a [TargetGroupService.RemoveTargets](/docs/application-load-balancer/api-ref/grpc/TargetGroup/removeTargets#RemoveTargets) request. ||
|#

## Target {#yandex.cloud.apploadbalancer.v1.Target}

A target resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| ipAddress | **string**

IP address of the target.

Includes only one of the fields `ipAddress`.

Reference to the target. As of now, targets must only be referred to by their IP addresses. ||
|| subnetId | **string**

ID of the subnet that the target is connected to. ||
|| privateIpv4Address | **bool**

If set, will not require `subnet_id` to validate the target.
Instead, the address should belong to one of the following ranges:
10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Only one of `subnet_id` or `private_ipv4_address` should be set. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "targetGroupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "description": "string",
    "folderId": "string",
    "labels": "string",
    "targets": [
      {
        // Includes only one of the fields `ipAddress`
        "ipAddress": "string",
        // end of the list of possible fields
        "subnetId": "string",
        "privateIpv4Address": "bool"
      }
    ],
    "createdAt": "google.protobuf.Timestamp"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateTargetGroupMetadata](#yandex.cloud.apploadbalancer.v1.UpdateTargetGroupMetadata)**

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
|| response | **[TargetGroup](#yandex.cloud.apploadbalancer.v1.TargetGroup)**

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

## UpdateTargetGroupMetadata {#yandex.cloud.apploadbalancer.v1.UpdateTargetGroupMetadata}

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the target group that is being updated. ||
|#

## TargetGroup {#yandex.cloud.apploadbalancer.v1.TargetGroup}

A target group resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| id | **string**

ID of the target group. Generated at creation time. ||
|| name | **string**

Name of the target group. The name is unique within the folder. ||
|| description | **string**

Description of the target group. ||
|| folderId | **string**

ID of the folder that the target group belongs to. ||
|| labels | **string**

Target group labels as `key:value` pairs.
For details about the concept, see [documentation](/docs/overview/concepts/services#labels). ||
|| targets[] | **[Target](#yandex.cloud.apploadbalancer.v1.Target2)**

List of targets in the target group. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#

## Target {#yandex.cloud.apploadbalancer.v1.Target2}

A target resource.
For details about the concept, see [documentation](/docs/application-load-balancer/concepts/target-group).

#|
||Field | Description ||
|| ipAddress | **string**

IP address of the target.

Includes only one of the fields `ipAddress`.

Reference to the target. As of now, targets must only be referred to by their IP addresses. ||
|| subnetId | **string**

ID of the subnet that the target is connected to. ||
|| privateIpv4Address | **bool**

If set, will not require `subnet_id` to validate the target.
Instead, the address should belong to one of the following ranges:
10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
Only one of `subnet_id` or `private_ipv4_address` should be set. ||
|#