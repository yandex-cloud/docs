---
editable: false
apiPlayground:
  - url: https://searchapi.{{ api-host }}/v2/wordstat/regions
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        phrase:
          description: |-
            **string**
            Required field. Keyword
            The maximum string length in characters is 400.
          type: string
        region:
          description: |-
            **enum** (Region)
            Show query distribution only by city, only by region, or everywhere.
            - `REGION_ALL`: Show distribution everywhere.
            - `REGION_CITIES`: Show distribution by cities.
            - `REGION_REGIONS`: Show distribution by regions.
          type: string
          enum:
            - REGION_UNSPECIFIED
            - REGION_ALL
            - REGION_CITIES
            - REGION_REGIONS
        devices:
          description: |-
            **enum** (Device)
            A list of device types a query was made from.
            - `DEVICE_ALL`: All devices.
            - `DEVICE_DESKTOP`: Desktop computers.
            - `DEVICE_PHONE`: Phones.
            - `DEVICE_TABLET`: Tablets.
          type: array
          items:
            type: string
            enum:
              - DEVICE_UNSPECIFIED
              - DEVICE_ALL
              - DEVICE_DESKTOP
              - DEVICE_PHONE
              - DEVICE_TABLET
        folderId:
          description: |-
            **string**
            ID of the folder.
            The maximum string length in characters is 50.
          type: string
      required:
        - phrase
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/searchapi/v2/api-ref/Wordstat/getRegionsDistribution.md
---

# Web Search API, REST: Wordstat.GetRegionsDistribution

Not implemented.
The method returns the distribution of the number of queries containing the given keyword globally by region for the last 30 days.

## HTTP request

```
POST https://searchapi.{{ api-host }}/v2/wordstat/regions
```

## Body parameters {#yandex.cloud.searchapi.v2.GetRegionsDistributionRequest}

```json
{
  "phrase": "string",
  "region": "string",
  "devices": [
    "string"
  ],
  "folderId": "string"
}
```

#|
||Field | Description ||
|| phrase | **string**

Required field. Keyword

The maximum string length in characters is 400. ||
|| region | **enum** (Region)

Show query distribution only by city, only by region, or everywhere.

- `REGION_ALL`: Show distribution everywhere.
- `REGION_CITIES`: Show distribution by cities.
- `REGION_REGIONS`: Show distribution by regions. ||
|| devices[] | **enum** (Device)

A list of device types a query was made from.

- `DEVICE_ALL`: All devices.
- `DEVICE_DESKTOP`: Desktop computers.
- `DEVICE_PHONE`: Phones.
- `DEVICE_TABLET`: Tablets. ||
|| folderId | **string**

ID of the folder.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.searchapi.v2.GetRegionsDistributionResponse}

**HTTP Code: 200 - OK**

```json
{
  "results": [
    {
      "region": "string",
      "count": "string",
      "share": "string",
      "affinityIndex": "string"
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

Region ID ||
|| count | **string** (int64)

Number of queries containing the given keyword. ||
|| share | **string**

The share of the number of such queries from the total number of queries to Yandex in the region. ||
|| affinityIndex | **string**

The ratio between the share of the selected queries in the region and their share across the country. ||
|#