---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopGroup/get.md
---

# Cloud Desktop API, gRPC: DesktopGroupService.Get

Returns the specified desktop group resource.

To get the list of available desktop groups, make a [List](/docs/cloud-desktop/api-ref/grpc/DesktopGroup/list#List) request.

## gRPC request

**rpc Get ([GetDesktopGroupRequest](#yandex.cloud.clouddesktop.v1.api.GetDesktopGroupRequest)) returns ([DesktopGroup](#yandex.cloud.clouddesktop.v1.api.DesktopGroup))**

## GetDesktopGroupRequest {#yandex.cloud.clouddesktop.v1.api.GetDesktopGroupRequest}

```json
{
  "desktop_group_id": "string"
}
```

#|
||Field | Description ||
|| desktop_group_id | **string**

Required field. ID of the desktop group resource to return.

To get the desktop group ID use a [DesktopGroupService.List](/docs/cloud-desktop/api-ref/grpc/DesktopGroup/list#List) request. ||
|#

## DesktopGroup {#yandex.cloud.clouddesktop.v1.api.DesktopGroup}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "status": "Status",
  "name": "string",
  "description": "string",
  "resources_spec": {
    "memory": "int64",
    "cores": "int64",
    "core_fraction": "int64"
  },
  "network_interface_spec": {
    "network_id": "string",
    "subnet_ids": [
      "string"
    ]
  },
  "labels": "map<string, string>"
}
```

A desktop group resource.

#|
||Field | Description ||
|| id | **string**

Desktop group ID. ||
|| folder_id | **string**

ID of the folder that the desktop group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

Status of the desktop group.

- `STATUS_UNSPECIFIED`
- `CREATING`: Desktop group is being created.
- `ACTIVE`: Desktop group is ready to use.
- `DELETING`: Desktop group is being deleted. ||
|| name | **string**

Name of the desktop group. ||
|| description | **string**

Description of the desktop group. ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)**

Resource specification of the desktop group. ||
|| network_interface_spec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec)**

Network interface specification of the desktop group. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop group. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

RAM volume, in bytes. ||
|| cores | **int64**

Number of CPU cores. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec}

#|
||Field | Description ||
|| network_id | **string**

Required field. ID of the network interface specification. ||
|| subnet_ids[] | **string**

List of subnet IDs. ||
|#