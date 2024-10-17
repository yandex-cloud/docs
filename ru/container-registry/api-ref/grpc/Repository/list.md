---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Repository/list.md
---

# Container Registry API, gRPC: RepositoryService.List {#List}

Retrieves the list of Repository resources in the specified registry.

## gRPC request

**rpc List ([ListRepositoriesRequest](#yandex.cloud.containerregistry.v1.ListRepositoriesRequest)) returns ([ListRepositoriesResponse](#yandex.cloud.containerregistry.v1.ListRepositoriesResponse))**

## ListRepositoriesRequest {#yandex.cloud.containerregistry.v1.ListRepositoriesRequest}

```json
{
  "registryId": "string",
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| registryId | **string**

ID of the registry to list repositories in.

To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/grpc/Registry/list#List) request. ||
|| folderId | **string**

ID of the folder to list registries in.

`folderId` is ignored if a [ListImagesRequest.registryId](/docs/container-registry/api-ref/grpc/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest) is specified in the request.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRepositoriesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListRepositoriesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListRepositoriesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListRepositoriesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Repository.name](#yandex.cloud.containerregistry.v1.Repository) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| orderBy | **string** ||
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
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| repositories[] | **[Repository](#yandex.cloud.containerregistry.v1.Repository)**

List of Repository resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRepositoriesRequest.pageSize](#yandex.cloud.containerregistry.v1.ListRepositoriesRequest), use
the `nextPageToken` as the value
for the [ListRepositoriesRequest.pageToken](#yandex.cloud.containerregistry.v1.ListRepositoriesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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