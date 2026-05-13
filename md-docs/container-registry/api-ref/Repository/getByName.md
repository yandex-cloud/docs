# Container Registry API, REST: Repository.GetByName

Returns the specified Repository resource.

To get the list of available Repository resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/repositories/{repositoryName}:byName
```

## Path parameters

#|
||Field | Description ||
|| repositoryName | **string**

Required field. Name of the Repository resource to return.

To get the repository name use a [RepositoryService.List](list.md#List) request.

Value must match the regular expression ` [a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `. ||
|#

## Response {#yandex.cloud.containerregistry.v1.Repository}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "id": "string"
}
```

A Repository resource. For more information, see [Repository](../../concepts/repository.md).

#|
||Field | Description ||
|| name | **string**

Name of the repository.
The name is unique within the registry. ||
|| id | **string**

Output only. ID of the repository. ||
|#