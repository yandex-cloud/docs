---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Repository/list.md
---

# Container Registry API, gRPC: RepositoryService.List

Retrieves the list of Repository resources in the specified registry.

## gRPC request

**rpc List ([ListRepositoriesRequest](#yandex.cloud.containerregistry.v1.ListRepositoriesRequest)) returns ([ListRepositoriesResponse](#yandex.cloud.containerregistry.v1.ListRepositoriesResponse))**

## ListRepositoriesRequest {#yandex.cloud.containerregistry.v1.ListRepositoriesRequest}

```json
{
  "registry_id": "string",
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

ID of the registry to list repositories in.

To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/grpc/Registry/list#List) request. ||
|| folder_id | **string**

ID of the folder to list registries in.

`folder_id` is ignored if a [ListImagesRequest.registry_id](/docs/container-registry/api-ref/grpc/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest) is specified in the request.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListRepositoriesResponse.next_page_token](#yandex.cloud.containerregistry.v1.ListRepositoriesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListRepositoriesResponse.next_page_token](#yandex.cloud.containerregistry.v1.ListRepositoriesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Repository.name](#yandex.cloud.containerregistry.v1.Repository) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| order_by | **string** ||
|#

## ListRepositoriesResponse {#yandex.cloud.containerregistry.v1.ListRepositoriesResponse}

```json
{
  "repositories": [
    {
      "name": "string",
      "id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| repositories[] | **[Repository](#yandex.cloud.containerregistry.v1.Repository)**

List of Repository resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRepositoriesRequest.page_size](#yandex.cloud.containerregistry.v1.ListRepositoriesRequest), use
the `next_page_token` as the value
for the [ListRepositoriesRequest.page_token](#yandex.cloud.containerregistry.v1.ListRepositoriesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Repository {#yandex.cloud.containerregistry.v1.Repository}

A Repository resource. For more information, see [Repository](/docs/container-registry/concepts/repository).

#|
||Field | Description ||
|| name | **string**

Name of the repository.
The name is unique within the registry. ||
|| id | **string**

Output only. ID of the repository. ||
|#