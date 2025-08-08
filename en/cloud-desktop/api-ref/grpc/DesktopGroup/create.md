---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopGroup/create.md
---

# Cloud Desktop API, gRPC: DesktopGroupService.Create

Creates desktop group in the specified folder.

## gRPC request

**rpc Create ([CreateDesktopGroupRequest](#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateDesktopGroupRequest {#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupRequest}

```json
{
  "folder_id": "string",
  "desktop_image_id": "string",
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
  "boot_disk_spec": {
    "type": "Type",
    "size": "int64"
  },
  "data_disk_spec": {
    "type": "Type",
    "size": "int64"
  },
  "group_config": {
    "min_ready_desktops": "int64",
    "max_desktops_amount": "int64",
    "desktop_type": "DesktopType",
    "members": [
      {
        "id": "string",
        "type": "string"
      }
    ]
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a DesktopGroup in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| desktop_image_id | **string**

Required field. An image used to create a desktop boot disk ||
|| name | **string**

Name of the DesktopGroup.
The name must be unique within the folder. ||
|| description | **string**

Description of the DesktopGroup. ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)**

Resource specification of the desktop group. ||
|| network_interface_spec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec)**

Network interface specification of the desktop group. ||
|| boot_disk_spec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Boot disk specification of the desktop group. ||
|| data_disk_spec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Data disk specification of the desktop group. ||
|| group_config | **[DesktopGroupConfiguration](#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration)**

Configuration of the desktop group. ||
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

## DiskSpec {#yandex.cloud.clouddesktop.v1.api.DiskSpec}

Disk specificaton.

#|
||Field | Description ||
|| type | enum **Type**

Required field. Type of disk.

- `TYPE_UNSPECIFIED`: Disk type is not specified.
- `HDD`: HDD disk type.
- `SSD`: SSD disk type. ||
|| size | **int64**

Size of disk. ||
|#

## DesktopGroupConfiguration {#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration}

#|
||Field | Description ||
|| min_ready_desktops | **int64**

Minimum number of ready desktops. ||
|| max_desktops_amount | **int64**

Maximum number of desktops. ||
|| desktop_type | enum **DesktopType**

Type of the desktop.

- `DESKTOP_TYPE_UNSPECIFIED`
- `PERSISTENT`
- `NON_PERSISTENT` ||
|| members[] | **[Subject](#yandex.cloud.access.Subject)**

List of members of the desktop group. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.

It can contain one of the following values:
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given <id>. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given <id>. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/grpc/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). ||
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
    "desktop_group_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
    "labels": "map<string, string>",
    "boot_disk_spec": {
      "type": "Type",
      "size": "int64"
    },
    "data_disk_spec": {
      "type": "Type",
      "size": "int64"
    },
    "group_config": {
      "min_ready_desktops": "int64",
      "max_desktops_amount": "int64",
      "desktop_type": "DesktopType",
      "members": [
        {
          "id": "string",
          "type": "string"
        }
      ]
    },
    // Includes only one of the fields `auto_update_policy`, `manual_update_policy`
    "auto_update_policy": "AutoUpdatePolicy",
    "manual_update_policy": "ManualUpdatePolicy"
    // end of the list of possible fields
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
|| desktop_group_id | **string**

ID of the desktop group that is being created. ||
|#

## DesktopGroup {#yandex.cloud.clouddesktop.v1.api.DesktopGroup}

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
|| resources_spec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec2)**

Resource specification of the desktop group. ||
|| network_interface_spec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec2)**

Network interface specification of the desktop group. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop group. ||
|| boot_disk_spec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec2)**

Boot disk specification of the desktop group. ||
|| data_disk_spec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec2)**

Data disk specification of the desktop group. ||
|| group_config | **[DesktopGroupConfiguration](#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration2)**

Desktop group configuration. ||
|| auto_update_policy | **[AutoUpdatePolicy](#yandex.cloud.clouddesktop.v1.api.AutoUpdatePolicy)**

Includes only one of the fields `auto_update_policy`, `manual_update_policy`.

Desktop group update policy. ||
|| manual_update_policy | **[ManualUpdatePolicy](#yandex.cloud.clouddesktop.v1.api.ManualUpdatePolicy)**

Includes only one of the fields `auto_update_policy`, `manual_update_policy`.

Desktop group update policy. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec2}

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

## NetworkInterfaceSpec {#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec2}

#|
||Field | Description ||
|| network_id | **string**

Required field. ID of the network interface specification. ||
|| subnet_ids[] | **string**

List of subnet IDs. ||
|#

## DiskSpec {#yandex.cloud.clouddesktop.v1.api.DiskSpec2}

Disk specificaton.

#|
||Field | Description ||
|| type | enum **Type**

Required field. Type of disk.

- `TYPE_UNSPECIFIED`: Disk type is not specified.
- `HDD`: HDD disk type.
- `SSD`: SSD disk type. ||
|| size | **int64**

Size of disk. ||
|#

## DesktopGroupConfiguration {#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration2}

#|
||Field | Description ||
|| min_ready_desktops | **int64**

Minimum number of ready desktops. ||
|| max_desktops_amount | **int64**

Maximum number of desktops. ||
|| desktop_type | enum **DesktopType**

Type of the desktop.

- `DESKTOP_TYPE_UNSPECIFIED`
- `PERSISTENT`
- `NON_PERSISTENT` ||
|| members[] | **[Subject](#yandex.cloud.access.Subject2)**

List of members of the desktop group. ||
|#

## Subject {#yandex.cloud.access.Subject2}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.

It can contain one of the following values:
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given <id>. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given <id>. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/grpc/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). ||
|#

## AutoUpdatePolicy {#yandex.cloud.clouddesktop.v1.api.AutoUpdatePolicy}

#|
||Field | Description ||
|| Empty | > ||
|#

## ManualUpdatePolicy {#yandex.cloud.clouddesktop.v1.api.ManualUpdatePolicy}

#|
||Field | Description ||
|| Empty | > ||
|#