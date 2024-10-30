---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/LifecyclePolicy/listDryRunResultAffectedImages.md
---

# Container Registry API, gRPC: LifecyclePolicyService.ListDryRunResultAffectedImages {#ListDryRunResultAffectedImages}

Retrieves the list of the affected images.

## gRPC request

**rpc ListDryRunResultAffectedImages ([ListDryRunLifecyclePolicyResultAffectedImagesRequest](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest)) returns ([ListDryRunLifecyclePolicyResultAffectedImagesResponse](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse))**

## ListDryRunLifecyclePolicyResultAffectedImagesRequest {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest}

```json
{
  "dryRunLifecyclePolicyResultId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| dryRunLifecyclePolicyResultId | **string**

Required field. ID of the dry run result of the lifecycle policy ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDryRunLifecyclePolicyResultAffectedImagesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDryRunLifecyclePolicyResultAffectedImagesResponse.nextPageToken](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters affected images listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/grpc/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| orderBy | **string**

Sorting the list by [LifecyclePolicy.name](/docs/container-registry/api-ref/grpc/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) and [LifecyclePolicy.createdAt](/docs/container-registry/api-ref/grpc/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) fields.
The default sorting order is ascending. ||
|#

## ListDryRunLifecyclePolicyResultAffectedImagesResponse {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse}

```json
{
  "affectedImages": [
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