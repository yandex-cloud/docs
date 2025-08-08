---
editable: false
apiPlayground:
  - url: https://searchapi.{{ api-host }}/v2/image/search_by_image
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        site:
          description: |-
            **string**
            Restricts the search to the specific website.
          type: string
        folderId:
          description: |-
            **string**
            ID of the folder.
          type: string
        url:
          description: |-
            **string**
            Required field. The image url to use for the search.
            Includes only one of the fields `url`, `data`, `id`.
          type: string
        data:
          description: |-
            **string** (bytes)
            Required field. The image data to use for the search.
            Includes only one of the fields `url`, `data`, `id`.
          type: string
          format: bytes
        id:
          description: |-
            **string**
            Required field. CBIR ID of the image to use for the search.
            Includes only one of the fields `url`, `data`, `id`.
          type: string
        page:
          description: |-
            **string** (int64)
            The number of a requested page with search results.
          type: string
          format: int64
        familyMode:
          description: |-
            **enum** (FamilyMode)
            Rule for filtering search results and determines whether any documents should be excluded.
            - `FAMILY_MODE_UNSPECIFIED`
            - `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
            - `FAMILY_MODE_MODERATE`: Moderate filter (default value). Documents of the Adult category are excluded from search results
            unless a query is explicitly made for searching resources of this category.
            - `FAMILY_MODE_STRICT`: Regardless of a search query, documents of the Adult category
            and those with profanity are excluded from search results.
          type: string
          enum:
            - FAMILY_MODE_UNSPECIFIED
            - FAMILY_MODE_NONE
            - FAMILY_MODE_MODERATE
            - FAMILY_MODE_STRICT
      required:
        - url
        - data
        - id
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/searchapi/v2/api-ref/ImageSearch/searchByImage.md
---

# Web Search API, REST: ImageSearch.SearchByImage

## HTTP request

```
POST https://searchapi.{{ api-host }}/v2/image/search_by_image
```

## Body parameters {#yandex.cloud.searchapi.v2.ImageSearchByImageRequest}

```json
{
  "site": "string",
  "folderId": "string",
  // Includes only one of the fields `url`, `data`, `id`
  "url": "string",
  "data": "string",
  "id": "string",
  // end of the list of possible fields
  "page": "string",
  "familyMode": "string"
}
```

#|
||Field | Description ||
|| site | **string**

Restricts the search to the specific website. ||
|| folderId | **string**

ID of the folder. ||
|| url | **string**

Required field. The image url to use for the search.

Includes only one of the fields `url`, `data`, `id`. ||
|| data | **string** (bytes)

Required field. The image data to use for the search.

Includes only one of the fields `url`, `data`, `id`. ||
|| id | **string**

Required field. CBIR ID of the image to use for the search.

Includes only one of the fields `url`, `data`, `id`. ||
|| page | **string** (int64)

The number of a requested page with search results. ||
|| familyMode | **enum** (FamilyMode)

Rule for filtering search results and determines whether any documents should be excluded.

- `FAMILY_MODE_UNSPECIFIED`
- `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
- `FAMILY_MODE_MODERATE`: Moderate filter (default value). Documents of the Adult category are excluded from search results
unless a query is explicitly made for searching resources of this category.
- `FAMILY_MODE_STRICT`: Regardless of a search query, documents of the Adult category
and those with profanity are excluded from search results. ||
|#

## Response {#yandex.cloud.searchapi.v2.ImageSearchByImageResponse}

**HTTP Code: 200 - OK**

```json
{
  "images": [
    {
      "url": "string",
      "format": "string",
      "width": "string",
      "height": "string",
      "passage": "string",
      "host": "string",
      "pageTitle": "string",
      "pageUrl": "string"
    }
  ],
  "page": "string",
  "maxPage": "string",
  "id": "string"
}
```

#|
||Field | Description ||
|| images[] | **[ImageInfo](#yandex.cloud.searchapi.v2.ImageSearchByImageResponse.ImageInfo)**

The images found. ||
|| page | **string** (int64)

The number of the page with search results. ||
|| maxPage | **string** (int64)

The number of the last page with search results. ||
|| id | **string**

CBIR ID of the image used for the search. ||
|#

## ImageInfo {#yandex.cloud.searchapi.v2.ImageSearchByImageResponse.ImageInfo}

#|
||Field | Description ||
|| url | **string**

Image URL. ||
|| format | **enum** (ImageFormat)

Image format.

- `IMAGE_FORMAT_UNSPECIFIED`
- `IMAGE_FORMAT_JPEG`: JPG format.
- `IMAGE_FORMAT_GIF`: GIF format.
- `IMAGE_FORMAT_PNG`: PNG format. ||
|| width | **string** (int64)

Image width. ||
|| height | **string** (int64)

Image height. ||
|| passage | **string**

Text passage. ||
|| host | **string**

Document host. ||
|| pageTitle | **string**

Document title. ||
|| pageUrl | **string**

Document URL. ||
|#