---
editable: false
sourcePath: en/_api-ref-grpc/resourcemanager/v1/api-ref/grpc/Folder/list.md
---

# Resource Manager API, gRPC: FolderService.List

Retrieves the list of Folder resources in the specified cloud.

## gRPC request

**rpc List ([ListFoldersRequest](#yandex.cloud.resourcemanager.v1.ListFoldersRequest)) returns ([ListFoldersResponse](#yandex.cloud.resourcemanager.v1.ListFoldersResponse))**

## ListFoldersRequest {#yandex.cloud.resourcemanager.v1.ListFoldersRequest}

```json
{
  "cloud_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

Required field. ID of the cloud to list folders in.
To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListFoldersResponse.next_page_token](#yandex.cloud.resourcemanager.v1.ListFoldersResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token`
to the [ListFoldersResponse.next_page_token](#yandex.cloud.resourcemanager.v1.ListFoldersResponse)
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
      "cloud_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "status": "Status"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| folders[] | **[Folder](#yandex.cloud.resourcemanager.v1.Folder)**

List of Folder resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFoldersRequest.page_size](#yandex.cloud.resourcemanager.v1.ListFoldersRequest), use
the `next_page_token` as the value
for the [ListFoldersRequest.page_token](#yandex.cloud.resourcemanager.v1.ListFoldersRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Folder {#yandex.cloud.resourcemanager.v1.Folder}

A Folder resource. For more information, see [Folder](/docs/resource-manager/concepts/resources-hierarchy#folder).

#|
||Field | Description ||
|| id | **string**

ID of the folder. ||
|| cloud_id | **string**

ID of the cloud that the folder belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the folder.
The name is unique within the cloud. 3-63 characters long. ||
|| description | **string**

Description of the folder. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| status | enum **Status**

Status of the folder.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The folder is active.
- `DELETING`: The folder is being deleted.
- `PENDING_DELETION`: Stopping folder resources and waiting for the deletion start timestamp. ||
|#