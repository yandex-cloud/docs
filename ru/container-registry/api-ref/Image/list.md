---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Image/list.md
---

# Container Registry API, REST: Image.List

Retrieves the list of Image resources in the specified registry or repository.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/images
```

## Query parameters {#yandex.cloud.containerregistry.v1.ListImagesRequest}

#|
||Field | Description ||
|| registryId | **string**

ID of the registry to list Docker images in.

`registryId` is ignored if a `ListImagesRequest.repositoryName` is specified in the request.

To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/Registry/list#List) request. ||
|| repositoryName | **string**

Name of the repository to list Docker images in.

To get the repository name use a [RepositoryService.List](/docs/container-registry/api-ref/Repository/list#List) request. ||
|| folderId | **string**

ID of the folder to list Docker images in.

`folderId` is ignored if a `ListImagesRequest.repositoryName` or a `ListImagesRequest.registryId` are specified in the request.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListImagesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListImagesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListImagesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListImagesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Image.name](#yandex.cloud.containerregistry.v1.Image) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be a maximum of 256 characters long and match the regular expression `[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))`. ||
|| orderBy | **string** ||
|#

## Response {#yandex.cloud.containerregistry.v1.ListImagesResponse}

**HTTP Code: 200 - OK**

```json
{
  "images": [
    {
      "id": "string",
      "name": "string",
      "digest": "string",
      "compressedSize": "string",
      "config": {
        "id": "string",
        "digest": "string",
        "size": "string",
        "urls": [
          "string"
        ]
      },
      "layers": [
        {
          "id": "string",
          "digest": "string",
          "size": "string",
          "urls": [
            "string"
          ]
        }
      ],
      "tags": [
        "string"
      ],
      "createdAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.containerregistry.v1.Image)**

List of Image resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListImagesRequest.pageSize](#yandex.cloud.containerregistry.v1.ListImagesRequest), use
the `nextPageToken` as the value
for the [ListImagesRequest.pageToken](#yandex.cloud.containerregistry.v1.ListImagesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Image {#yandex.cloud.containerregistry.v1.Image}

An Image resource. For more information, see [Docker image](/docs/container-registry/concepts/docker-image).

#|
||Field | Description ||
|| id | **string**

Output only. ID of the Docker image. ||
|| name | **string**

Name of the Docker image.
The name is unique within the registry. ||
|| digest | **string**

Content-addressable identifier of the Docker image. ||
|| compressedSize | **string** (int64)

Compressed size of the Docker image, specified in bytes. ||
|| config | **[Blob](#yandex.cloud.containerregistry.v1.Blob)**

Configuration of the Docker image. ||
|| layers[] | **[Blob](#yandex.cloud.containerregistry.v1.Blob)**

Layers of the Docker image. ||
|| tags[] | **string**

Tags of the Docker image.

Each tag is unique within the repository. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Blob {#yandex.cloud.containerregistry.v1.Blob}

A Blob resource.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the blob. ||
|| digest | **string**

Content-addressable identifier of the blob. ||
|| size | **string** (int64)

Size of the blob, specified in bytes. ||
|| urls[] | **string**

List of blob urls. ||
|#