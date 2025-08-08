---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/images/{imageId}
    method: get
    path:
      type: object
      properties:
        imageId:
          description: |-
            **string**
            Required field. ID of the Docker image resource to return.
            To get the Docker image ID use a [ImageService.List](/docs/container-registry/api-ref/Image/list#List) request.
          type: string
      required:
        - imageId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Image/get.md
---

# Container Registry API, REST: Image.Get

Returns the specified Image resource.

To get the list of available Image resources, make a [List](/docs/container-registry/api-ref/Image/list#List) request.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/images/{imageId}
```

## Path parameters

#|
||Field | Description ||
|| imageId | **string**

Required field. ID of the Docker image resource to return.

To get the Docker image ID use a [ImageService.List](/docs/container-registry/api-ref/Image/list#List) request. ||
|#

## Response {#yandex.cloud.containerregistry.v1.Image}

**HTTP Code: 200 - OK**

```json
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