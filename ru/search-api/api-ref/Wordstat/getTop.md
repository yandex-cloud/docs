---
editable: false
apiPlayground:
  - url: https://searchapi.{{ api-host }}/v2/wordstat/topRequests
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
        numPhrases:
          description: |-
            **string** (int64)
            Number of the phrases in the response.
            Acceptable values are 1 to 2000, inclusive.
          type: string
          format: int64
        regions:
          description: |-
            **string**
            A list of IDs of the regions a query was made from.
            The maximum number of elements is 100.
          type: array
          items:
            type: string
        devices:
          description: |-
            **enum** (Device)
            A list of device types a query was made from.
            The maximum number of elements is 3.
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
---

# Web Search API, REST: Wordstat.GetTop

The method returns the last 30 days data about popular queries containing the specified keyword and queries that are similar to the specified one.

## HTTP request

```
POST https://searchapi.{{ api-host }}/v2/wordstat/topRequests
```

## Body parameters {#yandex.cloud.searchapi.v2.GetTopRequest}

```json
{
  "phrase": "string",
  "numPhrases": "string",
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

Required field. Keyword

The maximum string length in characters is 400. ||
|| numPhrases | **string** (int64)

Number of the phrases in the response.

Acceptable values are 1 to 2000, inclusive. ||
|| regions[] | **string**

A list of IDs of the regions a query was made from.

The maximum number of elements is 100. ||
|| devices[] | **enum** (Device)

A list of device types a query was made from.

The maximum number of elements is 3.

- `DEVICE_ALL`: All devices.
- `DEVICE_DESKTOP`: Desktop computers.
- `DEVICE_PHONE`: Phones.
- `DEVICE_TABLET`: Tablets. ||
|| folderId | **string**

ID of the folder.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.searchapi.v2.GetTopResponse}

**HTTP Code: 200 - OK**

```json
{
  "totalCount": "string",
  "results": [
    {
      "phrase": "string",
      "count": "string"
    }
  ],
  "associations": [
    {
      "phrase": "string",
      "count": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| totalCount | **string** (int64)

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
|| count | **string** (int64)

Number of queries made. ||
|#