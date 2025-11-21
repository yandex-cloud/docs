---
editable: false
apiPlayground:
  - url: https://searchapi.{{ api-host }}/v2/wordstat/dynamics
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        phrase:
          description: |-
            **string**
            Required field. Keyword.
          type: string
        period:
          description: |-
            **enum** (Period)
            Required field. The period of aggregation of the number of queries.
            - `PERIOD_UNSPECIFIED`
            - `PERIOD_MONTHLY`: Details by month.
            - `PERIOD_WEEKLY`: Details by week.
            - `PERIOD_DAILY`: Details by day.
          type: string
          enum:
            - PERIOD_UNSPECIFIED
            - PERIOD_MONTHLY
            - PERIOD_WEEKLY
            - PERIOD_DAILY
        fromDate:
          description: |-
            **string** (date-time)
            Required field. The start of the period data is requested for.
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
        toDate:
          description: |-
            **string** (date-time)
            The end of the period data is requested for.
            String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
            `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
            To work with values in this field, use the APIs described in the
            [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
            In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
          type: string
          format: date-time
        regions:
          description: |-
            **string**
            A list of IDs of the regions a query was made from.
          type: array
          items:
            type: string
        devices:
          description: |-
            **enum** (Device)
            A list of device types a query was made from.
            - `DEVICE_UNSPECIFIED`
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
          type: string
      required:
        - phrase
        - period
        - fromDate
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/searchapi/v2/api-ref/Wordstat/getDynamics.md
---

# Web Search API, REST: Wordstat.GetDynamics

Not implemented.
The method returns the frequency of queries over time for a given keyword.

## HTTP request

```
POST https://searchapi.{{ api-host }}/v2/wordstat/dynamics
```

## Body parameters {#yandex.cloud.searchapi.v2.GetDynamicsRequest}

```json
{
  "phrase": "string",
  "period": "string",
  "fromDate": "string",
  "toDate": "string",
  "regions": [
    "string"
  ],
  "devices": [
    "string"
  ],
  "folderId": "string"
}
```

#|
||Field | Description ||
|| phrase | **string**

Required field. Keyword. ||
|| period | **enum** (Period)

Required field. The period of aggregation of the number of queries.

- `PERIOD_UNSPECIFIED`
- `PERIOD_MONTHLY`: Details by month.
- `PERIOD_WEEKLY`: Details by week.
- `PERIOD_DAILY`: Details by day. ||
|| fromDate | **string** (date-time)

Required field. The start of the period data is requested for.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| toDate | **string** (date-time)

The end of the period data is requested for.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| regions[] | **string**

A list of IDs of the regions a query was made from. ||
|| devices[] | **enum** (Device)

A list of device types a query was made from.

- `DEVICE_UNSPECIFIED`
- `DEVICE_ALL`: All devices.
- `DEVICE_DESKTOP`: Desktop computers.
- `DEVICE_PHONE`: Phones.
- `DEVICE_TABLET`: Tablets. ||
|| folderId | **string**

ID of the folder. ||
|#

## Response {#yandex.cloud.searchapi.v2.GetDynamicsResponse}

**HTTP Code: 200 - OK**

```json
{
  "results": [
    {
      "date": "string",
      "count": "string",
      "share": "string"
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
|| date | **string** (date-time)

The date

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| count | **string** (int64)

Number of queries containing the given keyword ||
|| share | **string**

The share of the number of such queries from the total number of queries to Yandex. ||
|#