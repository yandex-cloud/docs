[Документация Yandex Cloud](../../../index.md) > [Yandex Container Registry](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Repository](index.md) > Get

# Container Registry API, REST: Repository.Get

Returns the specified Repository resource.
To get the list of available Repository resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/repositories/{repositoryId}
```

## Path parameters

#|
||Field | Description ||
|| repositoryId | **string**

Required field. ID of the Repository resource to return.
To get the repository ID use a [RepositoryService.List](list.md#List) request.

The maximum string length in characters is 50. ||
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