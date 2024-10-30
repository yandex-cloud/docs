---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopGroup/create.md
---

# Cloud Desktop API, gRPC: DesktopGroupService.Create {#Create}

Creates desktop group in the specified folder.

## gRPC request

**rpc Create ([CreateDesktopGroupRequest](#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateDesktopGroupRequest {#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupRequest}

```json
{
  "folderId": "string",
  "desktopImageId": "string",
  "name": "string",
  "description": "string",
  "resourcesSpec": {
    "memory": "int64",
    "cores": "int64",
    "coreFraction": "int64"
  },
  "networkInterfaceSpec": {
    "networkId": "string",
    "subnetIds": [
      "string"
    ]
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a DesktopGroup in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| desktopImageId | **string**

Required field. An image used to create a desktop boot disk ||
|| name | **string**

Name of the DesktopGroup.
The name must be unique within the folder. ||
|| description | **string**

Description of the DesktopGroup. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)**

Resource specification of the desktop group. ||
|| networkInterfaceSpec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec)**

Network interface specification of the desktop group. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

RAM volume, in bytes. ||
|| cores | **int64**

Number of CPU cores. ||
|| coreFraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec}

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network interface specification. ||
|| subnetIds[] | **string**

List of subnet IDs. ||
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
    "desktopGroupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "status": "Status",
    "name": "string",
    "description": "string",
    "resourcesSpec": {
      "memory": "int64",
      "cores": "int64",
      "coreFraction": "int64"
    },
    "networkInterfaceSpec": {
      "networkId": "string",
      "subnetIds": [
        "string"
      ]
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateDesktopGroupMetadata](#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupMetadata)**

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
|| response | **[DesktopGroup](#yandex.cloud.clouddesktop.v1.api.DesktopGroup)**

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

## CreateDesktopGroupMetadata {#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupMetadata}

#|
||Field | Description ||
|| desktopGroupId | **string**

ID of the desktop group that is being created. ||
|#

## DesktopGroup {#yandex.cloud.clouddesktop.v1.api.DesktopGroup}

A desktop group resource.

#|
||Field | Description ||
|| id | **string**

Desktop group ID. ||
|| folderId | **string**

ID of the folder that the desktop group belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec2)**

Resource specification of the desktop group. ||
|| networkInterfaceSpec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec2)**

Network interface specification of the desktop group. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec2}

#|
||Field | Description ||
|| memory | **int64**

RAM volume, in bytes. ||
|| cores | **int64**

Number of CPU cores. ||
|| coreFraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec2}

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network interface specification. ||
|| subnetIds[] | **string**

List of subnet IDs. ||
|#