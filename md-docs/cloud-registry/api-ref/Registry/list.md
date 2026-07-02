[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Registry](index.md) > List

# Yandex Cloud Registry API, REST: Registry.List

Retrieves the list of Registry resources in the specified folder.

## HTTP request

```
GET https://registry.api.cloud.yandex.net/cloud-registry/v1/registries
```

## Query parameters {#yandex.cloud.cloudregistry.v1.ListRegistriesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list registries in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRegistriesResponse.nextPageToken](#yandex.cloud.cloudregistry.v1.ListRegistriesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 10.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListRegistriesResponse.nextPageToken](#yandex.cloud.cloudregistry.v1.ListRegistriesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.ListRegistriesResponse}

**HTTP Code: 200 - OK**

```json
{
  "registries": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "kind": "string",
      "type": "string",
      "status": "string",
      "labels": "object",
      "properties": "object",
      "createdAt": "string",
      "modifiedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| registries[] | **[Registry](#yandex.cloud.cloudregistry.v1.Registry)**

List of Registry resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRegistriesRequest.pageSize](#yandex.cloud.cloudregistry.v1.ListRegistriesRequest), use
the `nextPageToken` as the value
for the [ListRegistriesRequest.pageToken](#yandex.cloud.cloudregistry.v1.ListRegistriesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Registry {#yandex.cloud.cloudregistry.v1.Registry}

A Registry resource. For more information, see the [Registry](../../concepts/registry.md) section of the documentation.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the registry. ||
|| folderId | **string**

ID of the folder that the registry belongs to. ||
|| name | **string**

Name of the registry. ||
|| description | **string**

Description of the registry. ||
|| kind | **enum** (Kind)

Kind of the registry.

- `MAVEN`: Registry kind is maven.
- `NPM`: Registry kind is npm.
- `DOCKER`: Registry kind is docker.
- `DEBIAN`: Registry kind is debian.
- `NUGET`: Registry kind is nuget.
- `PYPI`: Registry kind is pypi.
- `BINARY`: Regisrty kind is binary.
- `GO`: Registry kind is go. ||
|| type | **enum** (Type)

Type of the registry.

- `LOCAL`: Registry type is local.
- `REMOTE`: Registry type is remote.
- `VIRTUAL`: Registry type is virtual.
- `TRANSITIONAL`: Registry type is transitional. ||
|| status | **enum** (Status)

Output only. Status of the registry.

- `CREATING`: Registry is being created.
- `ACTIVE`: Registry is ready to use.
- `DELETING`: Registry is being deleted. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| properties | **object** (map<**string**, **string**>)

Resource properties as `key:value` pairs. Maximum of 64 per resource. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedAt | **string** (date-time)

Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#