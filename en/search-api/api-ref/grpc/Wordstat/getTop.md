---
editable: false
sourcePath: en/_api-ref-grpc/searchapi/v2/api-ref/grpc/Wordstat/getTop.md
---

# Web Search API, gRPC: WordstatService.GetTop

Not implemented.
The method returns the last 30 days data about popular queries containing the specified keyword and queries that are similar to the specified one.

## gRPC request

**rpc GetTop ([GetTopRequest](#yandex.cloud.searchapi.v2.GetTopRequest)) returns ([GetTopResponse](#yandex.cloud.searchapi.v2.GetTopResponse))**

## GetTopRequest {#yandex.cloud.searchapi.v2.GetTopRequest}

```json
{
  "phrase": "string",
  "num_phrases": "int64",
  "regions": [
    "string"
  ],
  "devices": [
    "Device"
  ],
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| phrase | **string**

Required field. Keyword ||
|| num_phrases | **int64**

Number of the phrases in the response. ||
|| regions[] | **string**

A list of IDs of the regions a query was made from. ||
|| devices[] | enum **Device**

A list of device types a query was made from.

- `DEVICE_UNSPECIFIED`
- `DEVICE_ALL`: All devices.
- `DEVICE_DESKTOP`: Desktop computers.
- `DEVICE_PHONE`: Phones.
- `DEVICE_TABLET`: Tablets. ||
|| folder_id | **string**

ID of the folder. ||
|#

## GetTopResponse {#yandex.cloud.searchapi.v2.GetTopResponse}

```json
{
  "total_count": "int64",
  "results": [
    {
      "phrase": "string",
      "count": "int64"
    }
  ],
  "associations": [
    {
      "phrase": "string",
      "count": "int64"
    }
  ]
}
```

#|
||Field | Description ||
|| total_count | **int64**

Total number of the queries that contain all the keywords, regardless of their order. ||
|| results[] | **[PhraseInfo](#yandex.cloud.searchapi.v2.GetTopResponse.PhraseInfo)**

Results. ||
|| associations[] | **[PhraseInfo](#yandex.cloud.searchapi.v2.GetTopResponse.PhraseInfo)**

Queries that are similar to the specified one. ||
|#

## PhraseInfo {#yandex.cloud.searchapi.v2.GetTopResponse.PhraseInfo}

#|
||Field | Description ||
|| phrase | **string**

Keyword. ||
|| count | **int64**

Number of queries made. ||
|#