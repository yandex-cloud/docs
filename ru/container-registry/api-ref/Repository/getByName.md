---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/repositories/{repositoryName}:byName
    method: get
    path:
      type: object
      properties:
        repositoryName:
          description: |-
            **string**
            Required field. Name of the Repository resource to return.
            To get the repository name use a [RepositoryService.List](/docs/container-registry/api-ref/Repository/list#List) request.
          pattern: '[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))*'
          type: string
      required:
        - repositoryName
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Repository/getByName.md
---

# Container Registry API, REST: Repository.GetByName

Returns the specified Repository resource.

To get the list of available Repository resources, make a [List](/docs/container-registry/api-ref/Repository/list#List) request.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/repositories/{repositoryName}:byName
```

## Path parameters

#|
||Field | Description ||
|| repositoryName | **string**

Required field. Name of the Repository resource to return.

To get the repository name use a [RepositoryService.List](/docs/container-registry/api-ref/Repository/list#List) request. ||
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