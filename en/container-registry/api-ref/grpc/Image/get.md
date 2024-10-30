---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Image/get.md
---

# Container Registry API, gRPC: ImageService.Get {#Get}

Returns the specified Image resource.

To get the list of available Image resources, make a [List](/docs/container-registry/api-ref/grpc/Image/list#List) request.

## gRPC request

**rpc Get ([GetImageRequest](#yandex.cloud.containerregistry.v1.GetImageRequest)) returns ([Image](#yandex.cloud.containerregistry.v1.Image))**

## GetImageRequest {#yandex.cloud.containerregistry.v1.GetImageRequest}

```json
{
  "imageId": "string"
}
```

#|
||Field | Description ||
|| imageId | **string**

Required field. ID of the Docker image resource to return.

To get the Docker image ID use a [ImageService.List](/docs/container-registry/api-ref/grpc/Image/list#List) request. ||
|#

## Image {#yandex.cloud.containerregistry.v1.Image}

```json
{
  "id": "string",
  "name": "string",
  "digest": "string",
  "compressedSize": "int64",
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
  "createdAt": "google.protobuf.Timestamp"
}
```

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
|| compressedSize | **int64**

Compressed size of the Docker image, specified in bytes. ||
|| config | **[Blob](#yandex.cloud.containerregistry.v1.Blob)**

Configuration of the Docker image. ||
|| layers[] | **[Blob](#yandex.cloud.containerregistry.v1.Blob)**

Layers of the Docker image. ||
|| tags[] | **string**

Tags of the Docker image.

Each tag is unique within the repository. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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