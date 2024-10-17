---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Repository/get.md
---

# Container Registry API, REST: Repository.Get {#Get}

Returns the specified Repository resource.

To get the list of available Repository resources, make a [List](/docs/container-registry/api-ref/Repository/list#List) request.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/repositories/{repositoryId}
```

## Path parameters

#|
||Field | Description ||
|| repositoryId | **string**

Required field. ID of the Repository resource to return.

To get the repository ID use a [RepositoryService.List](/docs/container-registry/api-ref/Repository/list#List) request. ||
|#

## Response {#yandex.cloud.containerregistry.v1.Repository}

**HTTP Code: 200 - OK**

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