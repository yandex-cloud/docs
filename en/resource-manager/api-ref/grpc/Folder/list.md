---
editable: false
sourcePath: en/_api-ref-grpc/resourcemanager/v1/api-ref/grpc/Folder/list.md
---

# Resource Manager API, gRPC: FolderService.List {#List}

Retrieves the list of Folder resources in the specified cloud.

## gRPC request

**rpc List ([ListFoldersRequest](#yandex.cloud.resourcemanager.v1.ListFoldersRequest)) returns ([ListFoldersResponse](#yandex.cloud.resourcemanager.v1.ListFoldersResponse))**

## ListFoldersRequest {#yandex.cloud.resourcemanager.v1.ListFoldersRequest}

```json
{
  "cloudId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the cloud to list folders in.
To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListFoldersResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListFoldersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListFoldersResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListFoldersResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Folder.name](#yandex.cloud.resourcemanager.v1.Folder) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListFoldersResponse {#yandex.cloud.resourcemanager.v1.ListFoldersResponse}

```json
{
  "folders": [
    {
      "id": "string",
      "cloudId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "status": "Status"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| folders[] | **[Folder](#yandex.cloud.resourcemanager.v1.Folder)**

List of Folder resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFoldersRequest.pageSize](#yandex.cloud.resourcemanager.v1.ListFoldersRequest), use
the `nextPageToken` as the value
for the [ListFoldersRequest.pageToken](#yandex.cloud.resourcemanager.v1.ListFoldersRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Folder {#yandex.cloud.resourcemanager.v1.Folder}

A Folder resource. For more information, see [Folder](/docs/resource-manager/concepts/resources-hierarchy#folder).

#|
||Field | Description ||
|| id | **string**

ID of the folder. ||
|| cloudId | **string**

ID of the cloud that the folder belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the folder.
The name is unique within the cloud. 3-63 characters long. ||
|| description | **string**

Description of the folder. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| status | enum **Status**

Status of the folder.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The folder is active.
- `DELETING`: The folder is being deleted.
- `PENDING_DELETION`: Stopping folder resources and waiting for the deletion start timestamp. ||
|#