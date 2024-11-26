---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Repository/getByName.md
---

# Container Registry API, gRPC: RepositoryService.GetByName

Returns the specified Repository resource.

To get the list of available Repository resources, make a [List](/docs/container-registry/api-ref/grpc/Repository/list#List) request.

## gRPC request

**rpc GetByName ([GetRepositoryByNameRequest](#yandex.cloud.containerregistry.v1.GetRepositoryByNameRequest)) returns ([Repository](#yandex.cloud.containerregistry.v1.Repository))**

## GetRepositoryByNameRequest {#yandex.cloud.containerregistry.v1.GetRepositoryByNameRequest}

```json
{
  "repository_name": "string"
}
```

#|
||Field | Description ||
|| repository_name | **string**

Required field. Name of the Repository resource to return.

To get the repository name use a [RepositoryService.List](/docs/container-registry/api-ref/grpc/Repository/list#List) request. ||
|#

## Repository {#yandex.cloud.containerregistry.v1.Repository}

```json
{
  "name": "string",
  "id": "string"
}
```

A Repository resource. For more information, see [Repository](/docs/container-registry/concepts/repository).

#|
||Field | Description ||
|| name | **string**

Name of the repository.
The name is unique within the registry. ||
|| id | **string**

Output only. ID of the repository. ||
|#