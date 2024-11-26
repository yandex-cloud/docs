---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/LifecyclePolicy/listDryRunResultAffectedImages.md
---

# Container Registry API, gRPC: LifecyclePolicyService.ListDryRunResultAffectedImages

Retrieves the list of the affected images.

## gRPC request

**rpc ListDryRunResultAffectedImages ([ListDryRunLifecyclePolicyResultAffectedImagesRequest](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest)) returns ([ListDryRunLifecyclePolicyResultAffectedImagesResponse](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse))**

## ListDryRunLifecyclePolicyResultAffectedImagesRequest {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest}

```json
{
  "dry_run_lifecycle_policy_result_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| dry_run_lifecycle_policy_result_id | **string**

Required field. ID of the dry run result of the lifecycle policy ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDryRunLifecyclePolicyResultAffectedImagesResponse.next_page_token](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDryRunLifecyclePolicyResultAffectedImagesResponse.next_page_token](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters affected images listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/grpc/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| order_by | **string**

Sorting the list by [LifecyclePolicy.name](/docs/container-registry/api-ref/grpc/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) and [LifecyclePolicy.created_at](/docs/container-registry/api-ref/grpc/LifecyclePolicy/get#yandex.cloud.containerregistry.v1.LifecyclePolicy) fields.
The default sorting order is ascending. ||
|#

## ListDryRunLifecyclePolicyResultAffectedImagesResponse {#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesResponse}

```json
{
  "affected_images": [
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
|| affected_images[] | **[Image](#yandex.cloud.containerregistry.v1.Image)**

List of affected images. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDryRunLifecyclePolicyResultAffectedImagesRequest.page_size](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest), use `next_page_token` as the value
for the [ListDryRunLifecyclePolicyResultAffectedImagesRequest.page_token](#yandex.cloud.containerregistry.v1.ListDryRunLifecyclePolicyResultAffectedImagesRequest) parameter in the next list request.

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