---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/HostGroup/create.md
---

# Compute Cloud API, gRPC: HostGroupService.Create

Creates a host group in the specified folder.

## gRPC request

**rpc Create ([CreateHostGroupRequest](#yandex.cloud.compute.v1.CreateHostGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateHostGroupRequest {#yandex.cloud.compute.v1.CreateHostGroupRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "zone_id": "string",
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

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a host group in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

Required field. Availability zone where all dedicated hosts will be allocated. ||
|| type_id | **string**

Required field. ID of host type. Resources provided by each host of the group. ||
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
    "host_group_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
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
|| metadata | **[CreateHostGroupMetadata](#yandex.cloud.compute.v1.CreateHostGroupMetadata)**

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
|| response | **[HostGroup](#yandex.cloud.compute.v1.HostGroup)**

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

## CreateHostGroupMetadata {#yandex.cloud.compute.v1.CreateHostGroupMetadata}

#|
||Field | Description ||
|| host_group_id | **string**

ID of the host group that is being created. ||
|#

## HostGroup {#yandex.cloud.compute.v1.HostGroup}

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
|| labels | **object** (map<**string**, **string**>)

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
|| scale_policy | **[ScalePolicy](#yandex.cloud.compute.v1.ScalePolicy2)**

Scale policy. Only fixed number of hosts are supported at this moment. ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.ScalePolicy2}

#|
||Field | Description ||
|| fixed_scale | **[FixedScale](#yandex.cloud.compute.v1.ScalePolicy.FixedScale2)**

Includes only one of the fields `fixed_scale`. ||
|#

## FixedScale {#yandex.cloud.compute.v1.ScalePolicy.FixedScale2}

#|
||Field | Description ||
|| size | **int64** ||
|#