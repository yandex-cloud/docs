---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopGroup/list.md
---

# Cloud Desktop API, gRPC: DesktopGroupService.List {#List}

Retrieves the list of desktop group resources.

## gRPC request

**rpc List ([ListDesktopGroupsRequest](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest)) returns ([ListDesktopGroupsResponse](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse))**

## ListDesktopGroupsRequest {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list desktop groups in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListDesktopGroupsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListDesktopGroupsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [DesktopGroup.name](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. Value or a list of values to compare against the values of the field. ||
|| orderBy | **string**

Sorting the list by [DesktopGroup.name](#yandex.cloud.clouddesktop.v1.api.DesktopGroup), [DesktopGroup.createdAt](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) and [DesktopGroup.status](#yandex.cloud.clouddesktop.v1.api.DesktopGroup) fields.
The default sorting order is ascending. ||
|#

## ListDesktopGroupsResponse {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse}

```json
{
  "desktopGroups": [
    {
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| desktopGroups[] | **[DesktopGroup](#yandex.cloud.clouddesktop.v1.api.DesktopGroup)**

List of desktop groups. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDesktopGroupsRequest.pageSize](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest), use
the `nextPageToken` as the value
for the [ListDesktopGroupsRequest.pageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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