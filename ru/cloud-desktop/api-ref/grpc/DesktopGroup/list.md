---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopGroup/list.md
---

# Cloud Desktop API, gRPC: DesktopGroupService.List

Retrieves the list of desktop group resources.

## gRPC request

**rpc List ([ListDesktopGroupsRequest](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest)) returns ([ListDesktopGroupsResponse](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse))**

## ListDesktopGroupsRequest {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list desktop groups in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListDesktopGroupsResponse.next_page_token](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDesktopGroupsResponse.next_page_token](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [DesktopGroup.name](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. Value or a list of values to compare against the values of the field. ||
|| order_by | **string**

Sorting the list by [DesktopGroup.name](#yandex.cloud.clouddesktop.v1.api.DesktopGroup), [DesktopGroup.created_at](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) and [DesktopGroup.status](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) fields.
The default sorting order is ascending. ||
|#

## ListDesktopGroupsResponse {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse}

```json
{
  "desktop_groups": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| desktop_groups[] | **[DesktopGroup](#yandex.cloud.clouddesktop.v1.api.DesktopGroup)**

List of desktop groups. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDesktopGroupsRequest.page_size](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest), use
the `next_page_token` as the value
for the [ListDesktopGroupsRequest.page_token](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
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
|| resources_spec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)**

Resource specification of the desktop group. ||
|| network_interface_spec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec)**

Network interface specification of the desktop group. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop group. ||
|| boot_disk_spec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Boot disk specification of the desktop group. ||
|| data_disk_spec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Data disk specification of the desktop group. ||
|| group_config | **[DesktopGroupConfiguration](#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration)**

Desktop group configuration. ||
|| auto_update_policy | **[AutoUpdatePolicy](#yandex.cloud.clouddesktop.v1.api.AutoUpdatePolicy)**

Includes only one of the fields `auto_update_policy`, `manual_update_policy`.

Desktop group update policy. ||
|| manual_update_policy | **[ManualUpdatePolicy](#yandex.cloud.clouddesktop.v1.api.ManualUpdatePolicy)**

Includes only one of the fields `auto_update_policy`, `manual_update_policy`.

Desktop group update policy. ||
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