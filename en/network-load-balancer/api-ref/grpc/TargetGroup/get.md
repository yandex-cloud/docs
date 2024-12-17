---
editable: false
sourcePath: en/_api-ref-grpc/loadbalancer/v1/api-ref/grpc/TargetGroup/get.md
---

# Network Load Balancer API, gRPC: TargetGroupService.Get

Returns the specified TargetGroup resource.

## gRPC request

**rpc Get ([GetTargetGroupRequest](#yandex.cloud.loadbalancer.v1.GetTargetGroupRequest)) returns ([TargetGroup](#yandex.cloud.loadbalancer.v1.TargetGroup))**

## GetTargetGroupRequest {#yandex.cloud.loadbalancer.v1.GetTargetGroupRequest}

```json
{
  "target_group_id": "string"
}
```

#|
||Field | Description ||
|| target_group_id | **string**

Required field. ID of the TargetGroup resource to return.
To get the target group ID, use a [TargetGroupService.List](/docs/network-load-balancer/api-ref/grpc/TargetGroup/list#List) request. ||
|#

## TargetGroup {#yandex.cloud.loadbalancer.v1.TargetGroup}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
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

A TargetGroup resource. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| id | **string**

Output only. ID of the target group. ||
|| folder_id | **string**

ID of the folder that the target group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the target group.
The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Description of the target group. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| region_id | **string**

ID of the region where the target group resides. ||
|| targets[] | **[Target](#yandex.cloud.loadbalancer.v1.Target)**

A list of targets in the target group. ||
|#

## Target {#yandex.cloud.loadbalancer.v1.Target}

A Target resource. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| subnet_id | **string**

ID of the subnet that targets are connected to.
All targets in the target group must be connected to the same subnet within a single availability zone. ||
|| address | **string**

IP address of the target. ||
|#