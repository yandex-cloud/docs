---
editable: false
---

# Web Search API, gRPC: WordstatService.GetRegionsTree

The method method returns a tree of Wordstat-supported regions.

## gRPC request

**rpc GetRegionsTree ([GetRegionsTreeRequest](#yandex.cloud.searchapi.v2.GetRegionsTreeRequest)) returns ([GetRegionsTreeResponse](#yandex.cloud.searchapi.v2.GetRegionsTreeResponse))**

## GetRegionsTreeRequest {#yandex.cloud.searchapi.v2.GetRegionsTreeRequest}

```json
{
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder. ||
|#

## GetRegionsTreeResponse {#yandex.cloud.searchapi.v2.GetRegionsTreeResponse}

```json
{
  "regions": [
    {
      "id": "string",
      "label": "string",
      "children": [
        "RegionInfo"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| regions[] | **[RegionInfo](#yandex.cloud.searchapi.v2.GetRegionsTreeResponse.RegionInfo)**

Region tree ||
|#

## RegionInfo {#yandex.cloud.searchapi.v2.GetRegionsTreeResponse.RegionInfo}

#|
||Field | Description ||
|| id | **string**

Region ID. ||
|| label | **string**

Region name ||
|| children[] | **[RegionInfo](#yandex.cloud.searchapi.v2.GetRegionsTreeResponse.RegionInfo)**

Child regions. ||
|#