---
editable: false
sourcePath: en/_api-ref-grpc/serverless/containers/v1/containers/api-ref/grpc/Container/list.md
---

# Serverless Containers Service, gRPC: ContainerService.List

Retrieves the list of containers in the specified folder.

## gRPC request

**rpc List ([ListContainersRequest](#yandex.cloud.serverless.containers.v1.ListContainersRequest)) returns ([ListContainersResponse](#yandex.cloud.serverless.containers.v1.ListContainersResponse))**

## ListContainersRequest {#yandex.cloud.serverless.containers.v1.ListContainersRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list containers in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListContainersResponse.next_page_token](#yandex.cloud.serverless.containers.v1.ListContainersResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListContainersResponse.next_page_token](#yandex.cloud.serverless.containers.v1.ListContainersResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters containers listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [Container.name](#yandex.cloud.serverless.containers.v1.Container) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-container"`. ||
|#

## ListContainersResponse {#yandex.cloud.serverless.containers.v1.ListContainersResponse}

```json
{
  "containers": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "url": "string",
      "status": "Status"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| containers[] | **[Container](#yandex.cloud.serverless.containers.v1.Container)**

List of containers in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListContainersRequest.page_size](#yandex.cloud.serverless.containers.v1.ListContainersRequest), use `nextPageToken` as the value
for the [ListContainersRequest.page_token](#yandex.cloud.serverless.containers.v1.ListContainersRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## Container {#yandex.cloud.serverless.containers.v1.Container}

#|
||Field | Description ||
|| id | **string**

ID of the container. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the container belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the container. ||
|| name | **string**

Name of the container. The name is unique within the folder. ||
|| description | **string**

Description of the container. ||
|| labels | **string**

Container labels as `key:value` pairs. ||
|| url | **string**

URL that needs to be requested to call the container. ||
|| status | enum **Status**

Status of the container.

- `STATUS_UNSPECIFIED`
- `CREATING`: Container is being created.
- `ACTIVE`: Container is ready for use.
- `DELETING`: Container is being deleted.
- `ERROR`: Container failed. The only allowed action is delete. ||
|#