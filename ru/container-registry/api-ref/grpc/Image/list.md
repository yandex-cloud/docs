---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Image/list.md
---

# Container Registry API, gRPC: ImageService.List

Retrieves the list of Image resources in the specified registry or repository.

## gRPC request

**rpc List ([ListImagesRequest](#yandex.cloud.containerregistry.v1.ListImagesRequest)) returns ([ListImagesResponse](#yandex.cloud.containerregistry.v1.ListImagesResponse))**

## ListImagesRequest {#yandex.cloud.containerregistry.v1.ListImagesRequest}

```json
{
  "registry_id": "string",
  "repository_name": "string",
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

ID of the registry to list Docker images in.

`registry_id` is ignored if a `ListImagesRequest.repository_name` is specified in the request.

To get the registry ID use a [RegistryService.List](/docs/container-registry/api-ref/grpc/Registry/list#List) request. ||
|| repository_name | **string**

Name of the repository to list Docker images in.

To get the repository name use a [RepositoryService.List](/docs/container-registry/api-ref/grpc/Repository/list#List) request. ||
|| folder_id | **string**

ID of the folder to list Docker images in.

`folder_id` is ignored if a `ListImagesRequest.repository_name` or a `ListImagesRequest.registry_id` are specified in the request.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListImagesResponse.next_page_token](#yandex.cloud.containerregistry.v1.ListImagesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListImagesResponse.next_page_token](#yandex.cloud.containerregistry.v1.ListImagesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Image.name](#yandex.cloud.containerregistry.v1.Image) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be a maximum of 256 characters long and match the regular expression `[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))`. ||
|| order_by | **string** ||
|#

## ListImagesResponse {#yandex.cloud.containerregistry.v1.ListImagesResponse}

```json
{
  "images": [
    {
      "id": "string",
      "name": "string",
      "digest": "string",
      "compressed_size": "int64",
      "config": {
        "id": "string",
        "digest": "string",
        "size": "int64",
        "urls": [
          "string"
        ]
      },
      "layers": [
        {
          "id": "string",
          "digest": "string",
          "size": "int64",
          "urls": [
            "string"
          ]
        }
      ],
      "tags": [
        "string"
      ],
      "created_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.containerregistry.v1.Image)**

List of Image resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListImagesRequest.page_size](#yandex.cloud.containerregistry.v1.ListImagesRequest), use
the `next_page_token` as the value
for the [ListImagesRequest.page_token](#yandex.cloud.containerregistry.v1.ListImagesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
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
|| compressed_size | **int64**

Compressed size of the Docker image, specified in bytes. ||
|| config | **[Blob](#yandex.cloud.containerregistry.v1.Blob)**

Configuration of the Docker image. ||
|| layers[] | **[Blob](#yandex.cloud.containerregistry.v1.Blob)**

Layers of the Docker image. ||
|| tags[] | **string**

Tags of the Docker image.

Each tag is unique within the repository. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|#

## Blob {#yandex.cloud.containerregistry.v1.Blob}

A Blob resource.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the blob. ||
|| digest | **string**

Content-addressable identifier of the blob. ||
|| size | **int64**

Size of the blob, specified in bytes. ||
|| urls[] | **string**

List of blob urls. ||
|#