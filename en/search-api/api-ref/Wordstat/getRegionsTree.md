---
editable: false
apiPlayground:
  - url: https://searchapi.{{ api-host }}/v2/wordstat/getRegionsTree
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder.
          type: string
      additionalProperties: false
    definitions: null
---

# Web Search API, REST: Wordstat.GetRegionsTree

The method method returns a tree of Wordstat-supported regions.

## HTTP request

```
POST https://searchapi.{{ api-host }}/v2/wordstat/getRegionsTree
```

## Body parameters {#yandex.cloud.searchapi.v2.GetRegionsTreeRequest}

```json
{
  "folderId": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder. ||
|#

## Response {#yandex.cloud.searchapi.v2.GetRegionsTreeResponse}

**HTTP Code: 200 - OK**

```json
{
  "regions": [
    {
      "id": "string",
      "label": "string",
      "children": [
        "object"
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