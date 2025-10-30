---
editable: false
sourcePath: en/_api-ref-grpc/searchapi/v2/api-ref/grpc/Wordstat/getRegionsDistribution.md
---

# Web Search API, gRPC: WordstatService.GetRegionsDistribution

The method returns the distribution of the number of queries containing the given keyword globally by region for the last 30 days.

## gRPC request

**rpc GetRegionsDistribution ([GetRegionsDistributionRequest](#yandex.cloud.searchapi.v2.GetRegionsDistributionRequest)) returns ([GetRegionsDistributionResponse](#yandex.cloud.searchapi.v2.GetRegionsDistributionResponse))**

## GetRegionsDistributionRequest {#yandex.cloud.searchapi.v2.GetRegionsDistributionRequest}

```json
{
  "phrase": "string",
  "region": "Region",
  "devices": [
    "Device"
  ]
}
```

#|
||Field | Description ||
|| phrase | **string**

Required field. Keyword ||
|| region | enum **Region**

Show query distribution only by city, only by region, or everywhere.

- `REGION_UNSPECIFIED`
- `REGION_ALL`: Show distribution everywhere.
- `REGION_CITIES`: Show distribution by cities.
- `REGION_REGIONS`: Show distribution by regions. ||
|| devices[] | enum **Device**

A list of device types a query was made from.

- `DEVICE_UNSPECIFIED`
- `DEVICE_ALL`: All devices.
- `DEVICE_DESKTOP`: Desktop computers.
- `DEVICE_PHONE`: Phones.
- `DEVICE_TABLET`: Tablets. ||
|#

## GetRegionsDistributionResponse {#yandex.cloud.searchapi.v2.GetRegionsDistributionResponse}

```json
{
  "results": [
    {
      "region": "string",
      "count": "int64",
      "share": "double",
      "affinity_index": "double"
    }
  ]
}
```

#|
||Field | Description ||
|| results[] | **[RegionInfo](#yandex.cloud.searchapi.v2.GetRegionsDistributionResponse.RegionInfo)**

Results. ||
|#

## RegionInfo {#yandex.cloud.searchapi.v2.GetRegionsDistributionResponse.RegionInfo}

#|
||Field | Description ||
|| region | **string**

region ID ||
|| count | **int64**

Number of queries containing the given keyword. ||
|| share | **double**

The share of the number of such queries from the total number of queries to Yandex in the region. ||
|| affinity_index | **double**

The ratio between the share of the selected queries in the region and their share across the country. ||
|#