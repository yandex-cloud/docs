---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults/{dryRunLifecyclePolicyResultId}:affectedImages
    method: get
    path:
      type: object
      properties:
        dryRunLifecyclePolicyResultId:
          description: |-
            **string**
            Required field. ID of the dry run result of the lifecycle policy
          type: string
      required:
        - dryRunLifecyclePolicyResultId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns a [ListDryRunLifecyclePolicyResultAffectedImagesResponse.nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListDryRunLifecyclePolicyResultAffectedImagesResponse.nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResultAffectedImages#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters affected images listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting the list by [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) and [LifecyclePolicy.createdAt](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) fields.
            The default sorting order is ascending.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/LifecyclePolicy/listDryRunResultAffectedImages.md
---

# Container Registry API, REST: LifecyclePolicy.ListDryRunResultAffectedImages

Retrieves the list of the affected images.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults/{dryRunLifecyclePolicyResultId}:affectedImages
```

## Path parameters

#|
||Field | Description ||
|| dryRunLifecyclePolicyResultId | **string**

Required field. ID of the dry run result of the lifecycle policy ||
|#

## Query parameters {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDryRunLifecyclePolicyResultAffectedImagesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDryRunLifecyclePolicyResultAffectedImagesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters affected images listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| orderBy | **string**

Sorting the list by [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) and [LifecyclePolicy.createdAt](/docs/container-registry/api-ref/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) fields.
The default sorting order is ascending. ||
|#

## Response {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse}

**HTTP Code: 200 - OK**

```json
{
  "affectedImages": [
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
|| affectedImages[] | **[Image](#yandex.cloud.containerregistry.v1.Image)**

List of affected images. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDryRunLifecyclePolicyResultAffectedImagesRequest.pageSize](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest), use `next_page_token` as the value
for the [ListDryRunLifecyclePolicyResultAffectedImagesRequest.pageToken](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
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