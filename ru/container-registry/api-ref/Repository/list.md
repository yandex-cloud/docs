---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/repositories
    method: get
    path: null
    query:
      type: object
      properties:
        registryId:
          description: |-
            **string**
            ID of the registry to list repositories in.
            To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/Registry/list#List) request.
          type: string
        folderId:
          description: |-
            **string**
            ID of the folder to list registries in.
            `folderId` is ignored if a [ListImagesRequest.registryId](/docs/container-registry/api-ref/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest) is specified in the request.
            To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListRepositoriesResponse.nextPageToken](/docs/container-registry/api-ref/Repository/list#yandex.cloud.containerregistry.v1.ListRepositoriesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListRepositoriesResponse.nextPageToken](/docs/container-registry/api-ref/Repository/list#yandex.cloud.containerregistry.v1.ListRepositoriesResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [Repository.name](/docs/container-registry/api-ref/Repository/get#yandex.cloud.containerregistry.v1.Repository) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
        orderBy:
          description: '**string**'
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Repository/list.md
---

# Container Registry API, REST: Repository.List

Retrieves the list of Repository resources in the specified registry.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/repositories
```

## Query parameters {#yandex.cloud.containerregistry.v1.ListRepositoriesRequest}

#|
||Field | Description ||
|| registryId | **string**

ID of the registry to list repositories in.

To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/Registry/list#List) request. ||
|| folderId | **string**

ID of the folder to list registries in.

`folderId` is ignored if a [ListImagesRequest.registryId](/docs/container-registry/api-ref/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest) is specified in the request.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

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

## Response {#yandex.cloud.containerregistry.v1.ListRepositoriesResponse}

**HTTP Code: 200 - OK**

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