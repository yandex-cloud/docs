---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Talk/search.md
---

# Talk Analytics API, gRPC: TalkService.Search

rpc for searching talks. will return ids only

## gRPC request

**rpc Search ([SearchTalkRequest](#yandex.cloud.speechsense.v1.SearchTalkRequest)) returns ([SearchTalkResponse](#yandex.cloud.speechsense.v1.SearchTalkResponse))**

## SearchTalkRequest {#yandex.cloud.speechsense.v1.SearchTalkRequest}

```json
{
  "organization_id": "string",
  "space_id": "string",
  "connection_id": "string",
  "project_id": "string",
  "filters": [
    {
      "key": "string",
      // Includes only one of the fields `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`
      "any_match": {
        "values": [
          "string"
        ]
      },
      "int_range": {
        "from_value": "google.protobuf.Int64Value",
        "to_value": "google.protobuf.Int64Value",
        "bounds_inclusive": {
          "from_inclusive": "bool",
          "to_inclusive": "bool"
        }
      },
      "double_range": {
        "from_value": "google.protobuf.DoubleValue",
        "to_value": "google.protobuf.DoubleValue",
        "bounds_inclusive": {
          "from_inclusive": "bool",
          "to_inclusive": "bool"
        }
      },
      "date_range": {
        "from_value": "google.protobuf.Timestamp",
        "to_value": "google.protobuf.Timestamp",
        "bounds_inclusive": {
          "from_inclusive": "bool",
          "to_inclusive": "bool"
        }
      },
      "duration_range": {
        "from_value": "google.protobuf.Duration",
        "to_value": "google.protobuf.Duration",
        "bounds_inclusive": {
          "from_inclusive": "bool",
          "to_inclusive": "bool"
        }
      },
      "boolean_match": {
        "value": "bool"
      },
      // end of the list of possible fields
      "inverse": "bool",
      "channel_number": "google.protobuf.Int64Value"
    }
  ],
  "query": {
    "text": "string",
    "inverse": "bool",
    "channel_number": "google.protobuf.Int64Value"
  },
  "page_size": "int64",
  "page_token": "string",
  "sort_data": {
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
|| organization_id | **string**

id of organization ||
|| space_id | **string**

id of space ||
|| connection_id | **string**

id of connection ||
|| project_id | **string**

id of project ||
|| filters[] | **[Filter](#yandex.cloud.speechsense.v1.Filter)**

metadata keys filters (user and system) ||
|| query | **[Query](#yandex.cloud.speechsense.v1.Query)**

Full-text search query ||
|| page_size | **int64**

page size, from 1 to 1000, default 100 ||
|| page_token | **string**

next page token, if page is not first ||
|| sort_data | **[SortData](#yandex.cloud.speechsense.v1.SortData)**

talks sorting options ||
|#

## Filter {#yandex.cloud.speechsense.v1.Filter}

#|
||Field | Description ||
|| key | **string**

metadata key (user.some_key / system.created_at / analysis.speechkit.duration) ||
|| any_match | **[AnyMatchFilter](#yandex.cloud.speechsense.v1.AnyMatchFilter)**

find talk matched by any text filters

Includes only one of the fields `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| int_range | **[IntRangeFilter](#yandex.cloud.speechsense.v1.IntRangeFilter)**

find talks with value from int range

Includes only one of the fields `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| double_range | **[DoubleRangeFilter](#yandex.cloud.speechsense.v1.DoubleRangeFilter)**

find talks with value from double range

Includes only one of the fields `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| date_range | **[DateRangeFilter](#yandex.cloud.speechsense.v1.DateRangeFilter)**

find talks with value from date range

Includes only one of the fields `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| duration_range | **[DurationRangeFilter](#yandex.cloud.speechsense.v1.DurationRangeFilter)**

find talks with value from duration range

Includes only one of the fields `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| boolean_match | **[BooleanFilter](#yandex.cloud.speechsense.v1.BooleanFilter)**

find talks with value equals boolean

Includes only one of the fields `any_match`, `int_range`, `double_range`, `date_range`, `duration_range`, `boolean_match`. ||
|| inverse | **bool** ||
|| channel_number | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| from_value | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| to_value | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)** ||
|| bounds_inclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## BoundsInclusive {#yandex.cloud.speechsense.v1.BoundsInclusive}

indicates whether to include range boundaries

#|
||Field | Description ||
|| from_inclusive | **bool**

include from bound ||
|| to_inclusive | **bool**

include to bound ||
|#

## DoubleRangeFilter {#yandex.cloud.speechsense.v1.DoubleRangeFilter}

#|
||Field | Description ||
|| from_value | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| to_value | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)** ||
|| bounds_inclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## DateRangeFilter {#yandex.cloud.speechsense.v1.DateRangeFilter}

#|
||Field | Description ||
|| from_value | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| to_value | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| bounds_inclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## DurationRangeFilter {#yandex.cloud.speechsense.v1.DurationRangeFilter}

#|
||Field | Description ||
|| from_value | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)** ||
|| to_value | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)** ||
|| bounds_inclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
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
|| channel_number | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
  "talk_ids": [
    "string"
  ],
  "talks_count": "int64",
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| talk_ids[] | **string**

page results entries ||
|| talks_count | **int64**

total documents matched ||
|| next_page_token | **string**

page token for next request ||
|#