---
editable: false
sourcePath: en/_api-ref-grpc/resourcemanager/v1/api-ref/grpc/Folder/get.md
---

# Resource Manager API, gRPC: FolderService.Get {#Get}

Returns the specified Folder resource.

To get the list of available Folder resources, make a [List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

## gRPC request

**rpc Get ([GetFolderRequest](#yandex.cloud.resourcemanager.v1.GetFolderRequest)) returns ([Folder](#yandex.cloud.resourcemanager.v1.Folder))**

## GetFolderRequest {#yandex.cloud.resourcemanager.v1.GetFolderRequest}

```json
{
  "folderId": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the Folder resource to return.
To get the folder ID, use a [FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|#

## Folder {#yandex.cloud.resourcemanager.v1.Folder}

```json
{
  "id": "string",
  "cloudId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "status": "Status"
}
```

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