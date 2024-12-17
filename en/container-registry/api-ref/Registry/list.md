---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Registry/list.md
---

# Container Registry API, REST: Registry.List

Retrieves the list of Registry resources in the specified folder.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/registries
```

## Query parameters {#yandex.cloud.containerregistry.v1.ListRegistriesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list registries in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRegistriesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListRegistriesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListRegistriesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListRegistriesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Registry.name](#yandex.cloud.containerregistry.v1.Registry) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.containerregistry.v1.ListRegistriesResponse}

**HTTP Code: 200 - OK**

```json
{
  "registries": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "status": "string",
      "createdAt": "string",
      "labels": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| registries[] | **[Registry](#yandex.cloud.containerregistry.v1.Registry)**

List of Registry resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRegistriesRequest.pageSize](#yandex.cloud.containerregistry.v1.ListRegistriesRequest), use
the `nextPageToken` as the value
for the [ListRegistriesRequest.pageToken](#yandex.cloud.containerregistry.v1.ListRegistriesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Registry {#yandex.cloud.containerregistry.v1.Registry}

A Registry resource. For more information, see the [Registry](/docs/container-registry/concepts/registry) section of the documentation.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the registry. ||
|| folderId | **string**

ID of the folder that the registry belongs to. ||
|| name | **string**

Name of the registry. ||
|| status | **enum** (Status)

Output only. Status of the registry.

- `STATUS_UNSPECIFIED`
- `CREATING`: Registry is being created.
- `ACTIVE`: Registry is ready to use.
- `DELETING`: Registry is being deleted. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|#