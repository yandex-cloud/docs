---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/TargetGroup/addTargets.md
---

# Application Load Balancer API, gRPC: TargetGroupService.AddTargets {#AddTargets}

Adds targets to the specified target group.

## gRPC request

**rpc AddTargets ([AddTargetsRequest](#yandex.cloud.apploadbalancer.v1.AddTargetsRequest)) returns ([operation.Operation](/docs/application-load-balancer/api-ref/grpc/HttpRouter/get#yandex.cloud.apploadbalancer.v1.HeaderModification.operation))**

## AddTargetsRequest {#yandex.cloud.apploadbalancer.v1.AddTargetsRequest}

```json
{
  "targetGroupId": "string",
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

Required field. ID of the target group to add targets to.

To get the target group ID, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/grpc/TargetGroup/list#List) request. ||
|| targets[] | **[Target](#yandex.cloud.apploadbalancer.v1.Target)**

List of targets to add to the target group. ||
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
|| metadata | **[AddTargetsMetadata](#yandex.cloud.apploadbalancer.v1.AddTargetsMetadata)**

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

## AddTargetsMetadata {#yandex.cloud.apploadbalancer.v1.AddTargetsMetadata}

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the target group that the targets are being added to. ||
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