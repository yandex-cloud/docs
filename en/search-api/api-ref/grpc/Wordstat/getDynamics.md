---
editable: false
sourcePath: en/_api-ref-grpc/searchapi/v2/api-ref/grpc/Wordstat/getDynamics.md
---

# Web Search API, gRPC: WordstatService.GetDynamics

The method returns the frequency of queries over time for a given keyword.

## gRPC request

**rpc GetDynamics ([GetDynamicsRequest](#yandex.cloud.searchapi.v2.GetDynamicsRequest)) returns ([GetDynamicsResponse](#yandex.cloud.searchapi.v2.GetDynamicsResponse))**

## GetDynamicsRequest {#yandex.cloud.searchapi.v2.GetDynamicsRequest}

```json
{
  "phrase": "string",
  "period": "Period",
  "from_date": "google.protobuf.Timestamp",
  "to_date": "google.protobuf.Timestamp",
  "regions": [
    "string"
  ],
  "devices": [
    "Device"
  ]
}
```

#|
||Field | Description ||
|| phrase | **string**

Required field. Keyword. ||
|| period | enum **Period**

Required field. The period of aggregation of the number of queries.

- `PERIOD_UNSPECIFIED`
- `PERIOD_MONTHLY`: Details by month.
- `PERIOD_WEEKLY`: Details by week.
- `PERIOD_DAILY`: Details by day. ||
|| from_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field. The start of the period data is requested for. ||
|| to_date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The end of the period data is requested for. ||
|| regions[] | **string**

A list of IDs of the regions a query was made from. ||
|| devices[] | enum **Device**

A list of device types a query was made from.

- `DEVICE_UNSPECIFIED`
- `DEVICE_ALL`: All devices.
- `DEVICE_DESKTOP`: Desktop computers.
- `DEVICE_PHONE`: Phones.
- `DEVICE_TABLET`: Tablets. ||
|#

## GetDynamicsResponse {#yandex.cloud.searchapi.v2.GetDynamicsResponse}

```json
{
  "results": [
    {
      "date": "google.protobuf.Timestamp",
      "count": "int64",
      "share": "double"
    }
  ]
}
```

#|
||Field | Description ||
|| results[] | **[DynamicsInfo](#yandex.cloud.searchapi.v2.GetDynamicsResponse.DynamicsInfo)**

Results. ||
|#

## DynamicsInfo {#yandex.cloud.searchapi.v2.GetDynamicsResponse.DynamicsInfo}

#|
||Field | Description ||
|| date | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The date ||
|| count | **int64**

Number of queries containing the given keyword ||
|| share | **double**

The share of the number of such queries from the total number of queries to Yandex. ||
|#