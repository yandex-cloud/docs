---
editable: false
apiPlayground:
  - url: https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/search
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            id of organization
          type: string
        spaceId:
          description: |-
            **string**
            id of space
          type: string
        connectionId:
          description: |-
            **string**
            id of connection
          type: string
        projectId:
          description: |-
            **string**
            id of project
          type: string
        filters:
          description: |-
            **[Filter](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.Filter)**
            metadata keys filters (user and system)
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  anyMatch:
                    description: |-
                      **[AnyMatchFilter](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.AnyMatchFilter)**
                      find talk matched by any text filters
                      Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`.
                    $ref: '#/definitions/AnyMatchFilter'
                  intRange:
                    description: |-
                      **[IntRangeFilter](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.IntRangeFilter)**
                      find talks with value from int range
                      Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`.
                    $ref: '#/definitions/IntRangeFilter'
                  doubleRange:
                    description: |-
                      **[DoubleRangeFilter](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.DoubleRangeFilter)**
                      find talks with value from double range
                      Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`.
                    $ref: '#/definitions/DoubleRangeFilter'
                  dateRange:
                    description: |-
                      **[DateRangeFilter](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.DateRangeFilter)**
                      find talks with value from date range
                      Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`.
                    $ref: '#/definitions/DateRangeFilter'
                  durationRange:
                    description: |-
                      **[DurationRangeFilter](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.DurationRangeFilter)**
                      find talks with value from duration range
                      Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`.
                    $ref: '#/definitions/DurationRangeFilter'
                  booleanMatch:
                    description: |-
                      **[BooleanFilter](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.BooleanFilter)**
                      find talks with value equals boolean
                      Includes only one of the fields `anyMatch`, `intRange`, `doubleRange`, `dateRange`, `durationRange`, `booleanMatch`.
                    $ref: '#/definitions/BooleanFilter'
        query:
          description: |-
            **[Query](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.Query)**
            Full-text search query
          $ref: '#/definitions/Query'
        pageSize:
          description: |-
            **string** (int64)
            page size, from 1 to 1000, default 100
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            next page token, if page is not first
          type: string
        sortData:
          description: |-
            **[SortData](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.SortData)**
            talks sorting options
          $ref: '#/definitions/SortData'
      additionalProperties: false
    definitions:
      AnyMatchFilter:
        type: object
        properties:
          values:
            description: |-
              **string**
              values list to match with "OR" operator
            type: array
            items:
              type: string
      BoundsInclusive:
        type: object
        properties:
          fromInclusive:
            description: |-
              **boolean**
              include from bound
            type: boolean
          toInclusive:
            description: |-
              **boolean**
              include to bound
            type: boolean
      IntRangeFilter:
        type: object
        properties:
          fromValue:
            description: '**string** (int64)'
            type: string
            format: int64
          toValue:
            description: '**string** (int64)'
            type: string
            format: int64
          boundsInclusive:
            description: '**[BoundsInclusive](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.BoundsInclusive)**'
            $ref: '#/definitions/BoundsInclusive'
      DoubleRangeFilter:
        type: object
        properties:
          fromValue:
            description: '**number** (double)'
            type: number
            format: double
          toValue:
            description: '**number** (double)'
            type: number
            format: double
          boundsInclusive:
            description: '**[BoundsInclusive](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.BoundsInclusive)**'
            $ref: '#/definitions/BoundsInclusive'
      DateRangeFilter:
        type: object
        properties:
          fromValue:
            description: |-
              **string** (date-time)
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          toValue:
            description: |-
              **string** (date-time)
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          boundsInclusive:
            description: '**[BoundsInclusive](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.BoundsInclusive)**'
            $ref: '#/definitions/BoundsInclusive'
      DurationRangeFilter:
        type: object
        properties:
          fromValue:
            description: '**string** (duration)'
            type: string
            format: duration
          toValue:
            description: '**string** (duration)'
            type: string
            format: duration
          boundsInclusive:
            description: '**[BoundsInclusive](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.BoundsInclusive)**'
            $ref: '#/definitions/BoundsInclusive'
      BooleanFilter:
        type: object
        properties:
          value:
            description: '**boolean**'
            type: boolean
      Query:
        type: object
        properties:
          text:
            description: '**string**'
            type: string
          inverse:
            description: |-
              **boolean**
              should or should NOT match
            type: boolean
          channelNumber:
            description: |-
              **string** (int64)
              id of channel to search ("1", "2", ..., any channel if not set)
            type: string
            format: int64
      SortField:
        type: object
        properties:
          field:
            description: |-
              **string**
              sorting key
            type: string
          order:
            description: |-
              **enum** (SortOrder)
              sorting order by current `field`
              - `SORT_ORDER_UNSPECIFIED`
              - `SORT_ORDER_ASC`
              - `SORT_ORDER_DESC`
            type: string
            enum:
              - SORT_ORDER_UNSPECIFIED
              - SORT_ORDER_ASC
              - SORT_ORDER_DESC
          position:
            description: |-
              **string** (int64)
              number of field in comparing order (sort by key1 (position = 0), then key2 (position = 1), then key3...)
            type: string
            format: int64
      SortData:
        type: object
        properties:
          fields:
            description: '**[SortField](/docs/speechsense/api-ref/Talk/search#yandex.cloud.speechsense.v1.SortField)**'
            type: array
            items:
              $ref: '#/definitions/SortField'
sourcePath: en/_api-ref/speechsense/v1/api-ref/Talk/search.md
---

# Talk Analytics API, REST: Talk.Search

rpc for searching talks. will return ids only

## HTTP request

```
POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/search
```

## Body parameters {#yandex.cloud.speechsense.v1.SearchTalkRequest}

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
        "fromValue": "string",
        "toValue": "string",
        "boundsInclusive": {
          "fromInclusive": "boolean",
          "toInclusive": "boolean"
        }
      },
      "doubleRange": {
        "fromValue": "number",
        "toValue": "number",
        "boundsInclusive": {
          "fromInclusive": "boolean",
          "toInclusive": "boolean"
        }
      },
      "dateRange": {
        "fromValue": "string",
        "toValue": "string",
        "boundsInclusive": {
          "fromInclusive": "boolean",
          "toInclusive": "boolean"
        }
      },
      "durationRange": {
        "fromValue": "string",
        "toValue": "string",
        "boundsInclusive": {
          "fromInclusive": "boolean",
          "toInclusive": "boolean"
        }
      },
      "booleanMatch": {
        "value": "boolean"
      },
      // end of the list of possible fields
      "inverse": "boolean",
      "channelNumber": "string"
    }
  ],
  "query": {
    "text": "string",
    "inverse": "boolean",
    "channelNumber": "string"
  },
  "pageSize": "string",
  "pageToken": "string",
  "sortData": {
    "fields": [
      {
        "field": "string",
        "order": "string",
        "position": "string"
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
|| pageSize | **string** (int64)

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
|| inverse | **boolean** ||
|| channelNumber | **string** (int64)

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
|| fromValue | **string** (int64) ||
|| toValue | **string** (int64) ||
|| boundsInclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## BoundsInclusive {#yandex.cloud.speechsense.v1.BoundsInclusive}

indicates whether to include range boundaries

#|
||Field | Description ||
|| fromInclusive | **boolean**

include from bound ||
|| toInclusive | **boolean**

include to bound ||
|#

## DoubleRangeFilter {#yandex.cloud.speechsense.v1.DoubleRangeFilter}

#|
||Field | Description ||
|| fromValue | **number** (double) ||
|| toValue | **number** (double) ||
|| boundsInclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## DateRangeFilter {#yandex.cloud.speechsense.v1.DateRangeFilter}

#|
||Field | Description ||
|| fromValue | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toValue | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| boundsInclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## DurationRangeFilter {#yandex.cloud.speechsense.v1.DurationRangeFilter}

#|
||Field | Description ||
|| fromValue | **string** (duration) ||
|| toValue | **string** (duration) ||
|| boundsInclusive | **[BoundsInclusive](#yandex.cloud.speechsense.v1.BoundsInclusive)** ||
|#

## BooleanFilter {#yandex.cloud.speechsense.v1.BooleanFilter}

#|
||Field | Description ||
|| value | **boolean** ||
|#

## Query {#yandex.cloud.speechsense.v1.Query}

#|
||Field | Description ||
|| text | **string** ||
|| inverse | **boolean**

should or should NOT match ||
|| channelNumber | **string** (int64)

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
|| order | **enum** (SortOrder)

sorting order by current `field`

- `SORT_ORDER_UNSPECIFIED`
- `SORT_ORDER_ASC`
- `SORT_ORDER_DESC` ||
|| position | **string** (int64)

number of field in comparing order (sort by key1 (position = 0), then key2 (position = 1), then key3...) ||
|#

## Response {#yandex.cloud.speechsense.v1.SearchTalkResponse}

**HTTP Code: 200 - OK**

```json
{
  "talkIds": [
    "string"
  ],
  "talksCount": "string",
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| talkIds[] | **string**

page results entries ||
|| talksCount | **string** (int64)

total documents matched ||
|| nextPageToken | **string**

page token for next request ||
|#