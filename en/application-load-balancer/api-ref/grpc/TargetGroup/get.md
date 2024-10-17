---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/TargetGroup/get.md
---

# Application Load Balancer API, gRPC: TargetGroupService.Get {#Get}

Returns the specified target group.

To get the list of all available target groups, make a [List](/docs/application-load-balancer/api-ref/grpc/TargetGroup/list#List) request.

## gRPC request

**rpc Get ([GetTargetGroupRequest](#yandex.cloud.apploadbalancer.v1.GetTargetGroupRequest)) returns ([TargetGroup](#yandex.cloud.apploadbalancer.v1.TargetGroup))**

## GetTargetGroupRequest {#yandex.cloud.apploadbalancer.v1.GetTargetGroupRequest}

```json
{
  "targetGroupId": "string"
}
```

#|
||Field | Description ||
|| targetGroupId | **string**

Required field. ID of the target group to return.

To get the target group ID, make a [TargetGroupService.List](/docs/application-load-balancer/api-ref/grpc/TargetGroup/list#List) request. ||
|#

## TargetGroup {#yandex.cloud.apploadbalancer.v1.TargetGroup}

```json
{
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
```

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
|| targets[] | **[Target](#yandex.cloud.apploadbalancer.v1.Target)**

List of targets in the target group. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
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