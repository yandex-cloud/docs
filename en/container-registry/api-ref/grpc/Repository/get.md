---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Repository/get.md
---

# Container Registry API, gRPC: RepositoryService.Get

Returns the specified Repository resource.

To get the list of available Repository resources, make a [List](/docs/container-registry/api-ref/grpc/Repository/list#List) request.

## gRPC request

**rpc Get ([GetRepositoryRequest](#yandex.cloud.containerregistry.v1.GetRepositoryRequest)) returns ([Repository](#yandex.cloud.containerregistry.v1.Repository))**

## GetRepositoryRequest {#yandex.cloud.containerregistry.v1.GetRepositoryRequest}

```json
{
  "repository_id": "string"
}
```

#|
||Field | Description ||
|| repository_id | **string**

Required field. ID of the Repository resource to return.

To get the repository ID use a [RepositoryService.List](/docs/container-registry/api-ref/grpc/Repository/list#List) request. ||
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