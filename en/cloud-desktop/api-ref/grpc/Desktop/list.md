---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/Desktop/list.md
---

# Cloud Desktop API, gRPC: DesktopService.List {#List}

Retrieves the list of desktop resources.

## gRPC request

**rpc List ([ListDesktopsRequest](#yandex.cloud.clouddesktop.v1.api.ListDesktopsRequest)) returns ([ListDesktopsResponse](#yandex.cloud.clouddesktop.v1.api.ListDesktopsResponse))**

## ListDesktopsRequest {#yandex.cloud.clouddesktop.v1.api.ListDesktopsRequest}

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

Required field. ID of the folder to create a DesktopGroup in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListDesktopsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListDesktopsResponse.nextPageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Desktop.name](#yandex.cloud.clouddesktop.v1.api.Desktop) field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. Value or a list of values to compare against the values of the field. ||
|| orderBy | **string**

Sorting the list by [Desktop.name](#yandex.cloud.clouddesktop.v1.api.Desktop), [Desktop.createdAt](#yandex.cloud.clouddesktop.v1.api.Desktop) and [Desktop.status](#yandex.cloud.clouddesktop.v1.api.Desktop) fields.
The default sorting order is ascending. ||
|#

## ListDesktopsResponse {#yandex.cloud.clouddesktop.v1.api.ListDesktopsResponse}

```json
{
  "desktops": [
    {
      "id": "string",
      "folderId": "string",
      "desktopGroupId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "status": "Status",
      "name": "string",
      "resources": {
        "memory": "int64",
        "cores": "int64",
        "coreFraction": "int64"
      },
      "networkInterfaces": [
        {
          "networkId": "string",
          "subnetId": "string"
        }
      ],
      "users": [
        {
          "subjectId": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| desktops[] | **[Desktop](#yandex.cloud.clouddesktop.v1.api.Desktop)**

List of desktops. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDesktopsRequest.pageSize](#yandex.cloud.clouddesktop.v1.api.ListDesktopsRequest), use
the `nextPageToken` as the value
for the [ListDesktopsRequest.pageToken](#yandex.cloud.clouddesktop.v1.api.ListDesktopsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Desktop {#yandex.cloud.clouddesktop.v1.api.Desktop}

A desktop resource.

#|
||Field | Description ||
|| id | **string**

Desktop ID. ||
|| folderId | **string**

ID of the folder that the desktop belongs to. ||
|| desktopGroupId | **string**

ID of the desktop group that the desktop belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

Status of the desktop.

- `STATUS_UNSPECIFIED`
- `CREATING`: Desktop is being created.
- `ACTIVE`: Desktop is ready to use.
- `DELETING`: Desktop is being deleted. ||
|| name | **string**

Name of the desktop. ||
|| resources | **[Resources](#yandex.cloud.clouddesktop.v1.api.Resources)**

Resources of the desktop. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.clouddesktop.v1.api.NetworkInterface)** ||
|| users[] | **[User](#yandex.cloud.clouddesktop.v1.api.User)** ||
|#

## Resources {#yandex.cloud.clouddesktop.v1.api.Resources}

#|
||Field | Description ||
|| memory | **int64** ||
|| cores | **int64** ||
|| coreFraction | **int64** ||
|#

## NetworkInterface {#yandex.cloud.clouddesktop.v1.api.NetworkInterface}

#|
||Field | Description ||
|| networkId | **string**

Required field.  ||
|| subnetId | **string**

Required field.  ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subjectId | **string**

Required field. Identity of the access binding. ||
|#