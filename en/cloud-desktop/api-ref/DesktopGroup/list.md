---
editable: false
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/DesktopGroup/list.md
---

# Cloud Desktop API, REST: DesktopGroup.List {#List}

Retrieves the list of desktop group resources.

## HTTP request

```
GET https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups
```

## Query parameters {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list desktop groups in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

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

## Response {#yandex.cloud.clouddesktop.v1.api.ListDesktopGroupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "desktopGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "status": "string",
      "name": "string",
      "description": "string",
      "resourcesSpec": {
        "memory": "string",
        "cores": "string",
        "coreFraction": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

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
|| memory | **string** (int64)

RAM volume, in bytes. ||
|| cores | **string** (int64)

Number of CPU cores. ||
|| coreFraction | **string** (int64)

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