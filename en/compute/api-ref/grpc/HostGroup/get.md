---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/HostGroup/get.md
---

# Compute Cloud API, gRPC: HostGroupService.Get

Returns the specified host group.

## gRPC request

**rpc Get ([GetHostGroupRequest](#yandex.cloud.compute.v1.GetHostGroupRequest)) returns ([HostGroup](#yandex.cloud.compute.v1.HostGroup))**

## GetHostGroupRequest {#yandex.cloud.compute.v1.GetHostGroupRequest}

```json
{
  "host_group_id": "string"
}
```

#|
||Field | Description ||
|| host_group_id | **string**

Required field. ID of the host group to return.
To get the host group ID, use [HostGroupService.List](/docs/compute/api-ref/grpc/HostGroup/list#List) request. ||
|#

## HostGroup {#yandex.cloud.compute.v1.HostGroup}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "zone_id": "string",
  "status": "Status",
  "type_id": "string",
  "maintenance_policy": "MaintenancePolicy",
  "scale_policy": {
    // Includes only one of the fields `fixed_scale`
    "fixed_scale": {
      "size": "int64"
    }
    // end of the list of possible fields
  }
}
```

Represents group of dedicated hosts

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| folder_id | **string**

ID of the folder that the group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the group. The name is unique within the folder. ||
|| description | **string**

Description of the group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

Availability zone where all dedicated hosts are allocated. ||
|| status | enum **Status**

Status of the group.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `UPDATING`
- `DELETING` ||
|| type_id | **string**

ID of host type. Resources provided by each host of the group. ||
|| maintenance_policy | enum **MaintenancePolicy**

Behaviour on maintenance events.

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.compute.v1.ScalePolicy)**

Scale policy. Only fixed number of hosts are supported at this moment. ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.ScalePolicy}

#|
||Field | Description ||
|| fixed_scale | **[FixedScale](#yandex.cloud.compute.v1.ScalePolicy.FixedScale)**

Includes only one of the fields `fixed_scale`. ||
|#

## FixedScale {#yandex.cloud.compute.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **int64** ||
|#