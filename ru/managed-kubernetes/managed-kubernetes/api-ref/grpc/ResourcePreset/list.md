---
editable: false
sourcePath: en/_api-ref-grpc/k8s/v1/managed-kubernetes/api-ref/grpc/ResourcePreset/list.md
---

# Managed Services for Kubernetes API, gRPC: ResourcePresetService.List

Retrieves the list of available ResourcePreset resources.

## gRPC request

**rpc List ([ListResourcePresetsRequest](#yandex.cloud.k8s.v1.ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#yandex.cloud.k8s.v1.ListResourcePresetsResponse))**

## ListResourcePresetsRequest {#yandex.cloud.k8s.v1.ListResourcePresetsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListResourcePresetsResponse.next_page_token](#yandex.cloud.k8s.v1.ListResourcePresetsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListResourcePresetsResponse.next_page_token](#yandex.cloud.k8s.v1.ListResourcePresetsResponse)
returned by a previous list request. ||
|#

## ListResourcePresetsResponse {#yandex.cloud.k8s.v1.ListResourcePresetsResponse}

```json
{
  "resource_presets": [
    {
      "id": "string",
      "cores": "int64",
      "core_fraction": "int64",
      "memory": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| resource_presets[] | **[ResourcePreset](#yandex.cloud.k8s.v1.ResourcePreset)**

List of ResourcePreset resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListResourcePresetsRequest.page_size](#yandex.cloud.k8s.v1.ListResourcePresetsRequest), use the `next_page_token` as the value
for the [ListResourcePresetsRequest.page_token](#yandex.cloud.k8s.v1.ListResourcePresetsRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## ResourcePreset {#yandex.cloud.k8s.v1.ResourcePreset}

A ResourcePreset resource for describing hardware configuration presets.

#|
||Field | Description ||
|| id | **string**

Human-readable ID of the preset. ||
|| cores | **int64**

Number of CPU cores for an instance created with the preset. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the possibility to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| memory | **int64**

RAM volume for an instance created with the preset, in bytes. ||
|#