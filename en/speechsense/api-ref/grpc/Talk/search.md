---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Talk/search.md
---

# Talk Analytics API, gRPC: TalkService.Search {#Search}

rpc for searching talks. will return ids only

## gRPC request

**rpc Search ([SearchTalkRequest](#yandex.cloud.speechsense.v1.SearchTalkRequest)) returns ([SearchTalkResponse](#yandex.cloud.speechsense.v1.SearchTalkResponse))**

## SearchTalkRequest {#yandex.cloud.speechsense.v1.SearchTalkRequest}

```json
{
  "organizationId": "string",
  "spaceId": "string",
  "connectionId": "string",
  "projectId": "string",
  "filters": [
    {
      "key": "string",
      // Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`
      "anyMatch": {
        "values": [
          "string"
        ]
      },
      "intRange": {
        "fromValue": "google.protobuf.Int64Value",
        "toValue": "google.protobuf.Int64Value",
        "boundsInclusive": {
          "fromInclusive": "bool",
          "toInclusive": "bool"
        }
      },
      "doubleRange": {
        "fromValue": "google.protobuf.DoubleValue",
        "toValue": "google.protobuf.DoubleValue",
        "boundsInclusive": {
          "fromInclusive": "bool",
          "toInclusive": "bool"
        }
      },
      "dateRange": {
        "fromValue": "google.protobuf.Timestamp",
        "toValue": "google.protobuf.Timestamp",
        "boundsInclusive": {
          "fromInclusive": "bool",
          "toInclusive": "bool"
        }
      },
      "durationRange": {
        "fromValue": "google.protobuf.Duration",
        "toValue": "google.protobuf.Duration",
        "boundsInclusive": {
          "fromInclusive": "bool",
          "toInclusive": "bool"
        }
      },
      "booleanMatch": {
        "value": "bool"
      },
      // end of the list of possible fields
      "inverse": "bool",
      "channelNumber": "google.protobuf.Int64Value"
    }
  ],
  "query": {
    "text": "string",
    "inverse": "bool",
    "channelNumber": "google.protobuf.Int64Value"
  },
  "pageSize": "int64",
  "pageToken": "string",
  "sortData": {
    "fields": [
      {
        "field": "string",
        "order": "SortOrder",
        "position": "int64"
      }
    ]
  }
}
```

#|
||Field | Description ||
|| organizationId | **string**

id of organization ||
|| spaceId | **string**

id of space ||
|| connectionId | **string**

id of connection ||
|| projectId | **string**

id of project ||
|| filters[] | **[Filter](#yandex.cloud.speechsense.v1.Filter)**

metadata keys filters (user and system) ||
|| query | **[Query](#yandex.cloud.speechsense.v1.Query)**

Full-text search query ||
|| pageSize | **int64**

page size, from 1 to 1000, default 100 ||
|| pageToken | **string**

next page token, if page is not first ||
|| sortData | **[SortData](#yandex.cloud.speechsense.v1.SortData)**

talks sorting options ||
|#

## Filter {#yandex.cloud.speechsense.v1.Filter}

#|
||Field | Description ||
|| key | **string**

metadata key (user.some_key / system.created_at / analysis.speechkit.duration) ||
|| anyMatch | **[AnyMatchFilter](#yandex.cloud.speechsense.v1.AnyMatchFilter)**

find talk matched by any text filters

Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`. ||
|| intRange | **[IntRangeFilter](#yandex.cloud.speechsense.v1.IntRangeFilter)**

find talks with value from int range

Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`. ||
|| doubleRange | **[DoubleRangeFilter](#yandex.cloud.speechsense.v1.DoubleRangeFilter)**

find talks with value from double range

Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`. ||
|| dateRange | **[DateRangeFilter](#yandex.cloud.speechsense.v1.DateRangeFilter)**

find talks with value from date range

Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`. ||
|| durationRange | **[DurationRangeFilter](#yandex.cloud.speechsense.v1.DurationRangeFilter)**

find talks with value from duration range

Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`. ||
|| booleanMatch | **[BooleanFilter](#yandex.cloud.speechsense.v1.BooleanFilter)**

find talks with value equals boolean

Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`. ||
|| inverse | **bool** ||
|| channelNumber | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

channel number to apply filter for, starting with 0. applies to all channels if not specified ||
|#

## AnyMatchFilter {#yandex.cloud.speechsense.v1.AnyMatchFilter}

#|
||Field | Description ||
|| values[] | **string**

values list to match with "OR" operator ||
|#

## IntRangeFilter {#yandex.cloud.speechsense.v1.IntRangeFilter}

#|
||Field | Description ||
|| fromValue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| toValue | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| boundsInclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## BoundsInclusive {#yandex.cloud.speechsense.v1.BoundsInclusive}

indicates whether to include range boundaries

#|
||Field | Description ||
|| fromInclusive | **bool**

include from bound ||
|| toInclusive | **bool**

include to bound ||
|#

## DoubleRangeFilter {#yandex.cloud.speechsense.v1.DoubleRangeFilter}

#|
||Field | Description ||
|| fromValue | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| toValue | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| boundsInclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## DateRangeFilter {#yandex.cloud.speechsense.v1.DateRangeFilter}

#|
||Field | Description ||
|| fromValue | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| toValue | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| boundsInclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## DurationRangeFilter {#yandex.cloud.speechsense.v1.DurationRangeFilter}

#|
||Field | Description ||
|| fromValue | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)** ||
|| toValue | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)** ||
|| boundsInclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## BooleanFilter {#yandex.cloud.speechsense.v1.BooleanFilter}

#|
||Field | Description ||
|| value | **bool** ||
|#

## Query {#yandex.cloud.speechsense.v1.Query}

#|
||Field | Description ||
|| text | **string** ||
|| inverse | **bool**

should or should NOT match ||
|| channelNumber | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

id of channel to search ("1", "2", ..., any channel if not set) ||
|#

## SortData {#yandex.cloud.speechsense.v1.SortData}

#|
||Field | Description ||
|| fields[] | **[SortField](#yandex.cloud.speechsense.v1.SortField)** ||
|#

## SortField {#yandex.cloud.speechsense.v1.SortField}

#|
||Field | Description ||
|| field | **string**

sorting key ||
|| order | enum **SortOrder**

sorting order by current `field`

- `SORT_ORDER_UNSPECIFIED`
- `SORT_ORDER_ASC`
- `SORT_ORDER_DESC` ||
|| position | **int64**

number of field in comparing order (sort by key1 (position = 0), then key2 (position = 1), then key3...) ||
|#

## SearchTalkResponse {#yandex.cloud.speechsense.v1.SearchTalkResponse}

```json
{
  "talkIds": [
    "string"
  ],
  "talksCount": "int64",
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| talkIds[] | **string**

page results entries ||
|| talksCount | **int64**

total documents matched ||
|| nextPageToken | **string**

page token for next request ||
|#