---
editable: false
sourcePath: en/_api-ref-grpc/ydb/v1/api-ref/grpc/ResourcePreset/list.md
---

# Managed Service for YDB API, gRPC: ResourcePresetService.List

Returns the list of available resource presets.

## gRPC request

**rpc List ([ListResourcePresetsRequest](#yandex.cloud.ydb.v1.ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#yandex.cloud.ydb.v1.ListResourcePresetsResponse))**

## ListResourcePresetsRequest {#yandex.cloud.ydb.v1.ListResourcePresetsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListResourcePresets requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListResourcePresets
request to get the next page of results. ||
|#

## ListResourcePresetsResponse {#yandex.cloud.ydb.v1.ListResourcePresetsResponse}

```json
{
  "resource_presets": [
    {
      "id": "string",
      "cores": "int64",
      "memory": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| resource_presets[] | **[ResourcePreset](#yandex.cloud.ydb.v1.ResourcePreset)**

Requested list of resource presets. ||
|| next_page_token | **string**

This token allows you to get the next page of results for ListResourcePresets requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListResourcePresets request. Subsequent ListResourcePresets
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## ResourcePreset {#yandex.cloud.ydb.v1.ResourcePreset}

#|
||Field | Description ||
|| id | **string** ||
|| cores | **int64** ||
|| memory | **int64** ||
|#