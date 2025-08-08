---
editable: false
apiPlayground:
  - url: https://searchapi.{{ api-host }}/v2/image/search
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        query:
          description: |-
            **[SearchQuery](/docs/searchapi/api-ref/ImageSearch/search#yandex.cloud.searchapi.v2.SearchQuery)**
            Required field. Search query.
          $ref: '#/definitions/SearchQuery'
        imageSpec:
          description: |-
            **[ImageSpec](/docs/searchapi/api-ref/ImageSearch/search#yandex.cloud.searchapi.v2.ImageSpec)**
            Searching for images with a particular size, orientation, format or color.
          $ref: '#/definitions/ImageSpec'
        site:
          description: |-
            **string**
            Searching for images on a particular website only.
          type: string
        docsOnPage:
          description: |-
            **string** (int64)
            Number of results per search result page.
          type: string
          format: int64
        folderId:
          description: |-
            **string**
            ID of the folder.
          type: string
        userAgent:
          description: |-
            **string**
            User-Agent request header value.
          type: string
      required:
        - query
      additionalProperties: false
    definitions:
      SearchQuery:
        type: object
        properties:
          searchType:
            description: |-
              **enum** (SearchType)
              Required field. Search type that determines the domain name that will be used for the search queries.
              - `SEARCH_TYPE_UNSPECIFIED`
              - `SEARCH_TYPE_RU`: Russian search type (default), yandex.ru search domain name will be used.
              - `SEARCH_TYPE_TR`: Turkish search type, yandex.tr search domain name will be used.
              - `SEARCH_TYPE_COM`: International search type, yandex.com search domain name will be used.
              - `SEARCH_TYPE_KK`: Kazakh search type, yandex.kz search domain name will be used.
              - `SEARCH_TYPE_BE`: Belarusian search type, yandex.by search domain name will be used.
              - `SEARCH_TYPE_UZ`: Uzbek search type, yandex.uz search domain name will be used.
            type: string
            enum:
              - SEARCH_TYPE_UNSPECIFIED
              - SEARCH_TYPE_RU
              - SEARCH_TYPE_TR
              - SEARCH_TYPE_COM
              - SEARCH_TYPE_KK
              - SEARCH_TYPE_BE
              - SEARCH_TYPE_UZ
          queryText:
            description: |-
              **string**
              Required field. Search query text
            type: string
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
          page:
            description: |-
              **string** (int64)
              The number of a requested page with search results
            type: string
            format: int64
          fixTypoMode:
            description: |-
              **enum** (FixTypoMode)
              Typos autocorrections mode
              - `FIX_TYPO_MODE_UNSPECIFIED`
              - `FIX_TYPO_MODE_ON`: Automatically correct typos (default value).
              - `FIX_TYPO_MODE_OFF`: Autocorrection is off.
            type: string
            enum:
              - FIX_TYPO_MODE_UNSPECIFIED
              - FIX_TYPO_MODE_ON
              - FIX_TYPO_MODE_OFF
        required:
          - searchType
          - queryText
      ImageSpec:
        type: object
        properties:
          format:
            description: |-
              **enum** (ImageFormat)
              Searching for images in a particular format.
              - `IMAGE_FORMAT_UNSPECIFIED`
              - `IMAGE_FORMAT_JPEG`: JPG format.
              - `IMAGE_FORMAT_GIF`: GIF format.
              - `IMAGE_FORMAT_PNG`: PNG format.
            type: string
            enum:
              - IMAGE_FORMAT_UNSPECIFIED
              - IMAGE_FORMAT_JPEG
              - IMAGE_FORMAT_GIF
              - IMAGE_FORMAT_PNG
          size:
            description: |-
              **enum** (ImageSize)
              Searching for images of a particular size.
              - `IMAGE_SIZE_UNSPECIFIED`
              - `IMAGE_SIZE_ENORMOUS`: Very large images (larger than 1,600 × 1,200 pixels).
              - `IMAGE_SIZE_LARGE`: Large images (from 800 × 600 to 1,600 × 1,200 pixels).
              - `IMAGE_SIZE_MEDIUM`: Medium images (from 150 × 150 to 800 × 600 pixels).
              - `IMAGE_SIZE_SMALL`: Small images (from 32 × 32 to 150 × 150 pixels).
              - `IMAGE_SIZE_TINY`: Icons (up to 32 × 32 pixels).
              - `IMAGE_SIZE_WALLPAPER`: Desktop wallpapers.
            type: string
            enum:
              - IMAGE_SIZE_UNSPECIFIED
              - IMAGE_SIZE_ENORMOUS
              - IMAGE_SIZE_LARGE
              - IMAGE_SIZE_MEDIUM
              - IMAGE_SIZE_SMALL
              - IMAGE_SIZE_TINY
              - IMAGE_SIZE_WALLPAPER
          orientation:
            description: |-
              **enum** (ImageOrientation)
              Searching for images with a particular orientation.
              - `IMAGE_ORIENTATION_UNSPECIFIED`
              - `IMAGE_ORIENTATION_VERTICAL`: Horizontal orientation.
              - `IMAGE_ORIENTATION_HORIZONTAL`: Vertical orientation.
              - `IMAGE_ORIENTATION_SQUARE`: Square aspect ratio.
            type: string
            enum:
              - IMAGE_ORIENTATION_UNSPECIFIED
              - IMAGE_ORIENTATION_VERTICAL
              - IMAGE_ORIENTATION_HORIZONTAL
              - IMAGE_ORIENTATION_SQUARE
          color:
            description: |-
              **enum** (ImageColor)
              Searching for images containing a particular color.
              - `IMAGE_COLOR_UNSPECIFIED`
              - `IMAGE_COLOR_COLOR`: Color images.
              - `IMAGE_COLOR_GRAYSCALE`: Black and white images.
              - `IMAGE_COLOR_RED`: Red is the main color of the image.
              - `IMAGE_COLOR_ORANGE`: Orange is the main color of the image.
              - `IMAGE_COLOR_YELLOW`: Yellow is the main color of the image.
              - `IMAGE_COLOR_GREEN`: Green is the main color of the image.
              - `IMAGE_COLOR_CYAN`: Cyan is the main color of the image.
              - `IMAGE_COLOR_BLUE`: Blue is the main color of the image.
              - `IMAGE_COLOR_VIOLET`: Violet is the main color of the image.
              - `IMAGE_COLOR_WHITE`: White is the main color of the image.
              - `IMAGE_COLOR_BLACK`: Black is the main color of the image.
            type: string
            enum:
              - IMAGE_COLOR_UNSPECIFIED
              - IMAGE_COLOR_COLOR
              - IMAGE_COLOR_GRAYSCALE
              - IMAGE_COLOR_RED
              - IMAGE_COLOR_ORANGE
              - IMAGE_COLOR_YELLOW
              - IMAGE_COLOR_GREEN
              - IMAGE_COLOR_CYAN
              - IMAGE_COLOR_BLUE
              - IMAGE_COLOR_VIOLET
              - IMAGE_COLOR_WHITE
              - IMAGE_COLOR_BLACK
sourcePath: en/_api-ref/searchapi/v2/api-ref/ImageSearch/search.md
---

# Web Search API, REST: ImageSearch.Search

## HTTP request

```
POST https://searchapi.{{ api-host }}/v2/image/search
```

## Body parameters {#yandex.cloud.searchapi.v2.ImageSearchRequest}

```json
{
  "query": {
    "searchType": "string",
    "queryText": "string",
    "familyMode": "string",
    "page": "string",
    "fixTypoMode": "string"
  },
  "imageSpec": {
    "format": "string",
    "size": "string",
    "orientation": "string",
    "color": "string"
  },
  "site": "string",
  "docsOnPage": "string",
  "folderId": "string",
  "userAgent": "string"
}
```

#|
||Field | Description ||
|| query | **[SearchQuery](#yandex.cloud.searchapi.v2.SearchQuery)**

Required field. Search query. ||
|| imageSpec | **[ImageSpec](#yandex.cloud.searchapi.v2.ImageSpec)**

Searching for images with a particular size, orientation, format or color. ||
|| site | **string**

Searching for images on a particular website only. ||
|| docsOnPage | **string** (int64)

Number of results per search result page. ||
|| folderId | **string**

ID of the folder. ||
|| userAgent | **string**

User-Agent request header value. ||
|#

## SearchQuery {#yandex.cloud.searchapi.v2.SearchQuery}

#|
||Field | Description ||
|| searchType | **enum** (SearchType)

Required field. Search type that determines the domain name that will be used for the search queries.

- `SEARCH_TYPE_UNSPECIFIED`
- `SEARCH_TYPE_RU`: Russian search type (default), yandex.ru search domain name will be used.
- `SEARCH_TYPE_TR`: Turkish search type, yandex.tr search domain name will be used.
- `SEARCH_TYPE_COM`: International search type, yandex.com search domain name will be used.
- `SEARCH_TYPE_KK`: Kazakh search type, yandex.kz search domain name will be used.
- `SEARCH_TYPE_BE`: Belarusian search type, yandex.by search domain name will be used.
- `SEARCH_TYPE_UZ`: Uzbek search type, yandex.uz search domain name will be used. ||
|| queryText | **string**

Required field. Search query text ||
|| familyMode | **enum** (FamilyMode)

Rule for filtering search results and determines whether any documents should be excluded.

- `FAMILY_MODE_UNSPECIFIED`
- `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
- `FAMILY_MODE_MODERATE`: Moderate filter (default value). Documents of the Adult category are excluded from search results
unless a query is explicitly made for searching resources of this category.
- `FAMILY_MODE_STRICT`: Regardless of a search query, documents of the Adult category
and those with profanity are excluded from search results. ||
|| page | **string** (int64)

The number of a requested page with search results ||
|| fixTypoMode | **enum** (FixTypoMode)

Typos autocorrections mode

- `FIX_TYPO_MODE_UNSPECIFIED`
- `FIX_TYPO_MODE_ON`: Automatically correct typos (default value).
- `FIX_TYPO_MODE_OFF`: Autocorrection is off. ||
|#

## ImageSpec {#yandex.cloud.searchapi.v2.ImageSpec}

#|
||Field | Description ||
|| format | **enum** (ImageFormat)

Searching for images in a particular format.

- `IMAGE_FORMAT_UNSPECIFIED`
- `IMAGE_FORMAT_JPEG`: JPG format.
- `IMAGE_FORMAT_GIF`: GIF format.
- `IMAGE_FORMAT_PNG`: PNG format. ||
|| size | **enum** (ImageSize)

Searching for images of a particular size.

- `IMAGE_SIZE_UNSPECIFIED`
- `IMAGE_SIZE_ENORMOUS`: Very large images (larger than 1,600 × 1,200 pixels).
- `IMAGE_SIZE_LARGE`: Large images (from 800 × 600 to 1,600 × 1,200 pixels).
- `IMAGE_SIZE_MEDIUM`: Medium images (from 150 × 150 to 800 × 600 pixels).
- `IMAGE_SIZE_SMALL`: Small images (from 32 × 32 to 150 × 150 pixels).
- `IMAGE_SIZE_TINY`: Icons (up to 32 × 32 pixels).
- `IMAGE_SIZE_WALLPAPER`: Desktop wallpapers. ||
|| orientation | **enum** (ImageOrientation)

Searching for images with a particular orientation.

- `IMAGE_ORIENTATION_UNSPECIFIED`
- `IMAGE_ORIENTATION_VERTICAL`: Horizontal orientation.
- `IMAGE_ORIENTATION_HORIZONTAL`: Vertical orientation.
- `IMAGE_ORIENTATION_SQUARE`: Square aspect ratio. ||
|| color | **enum** (ImageColor)

Searching for images containing a particular color.

- `IMAGE_COLOR_UNSPECIFIED`
- `IMAGE_COLOR_COLOR`: Color images.
- `IMAGE_COLOR_GRAYSCALE`: Black and white images.
- `IMAGE_COLOR_RED`: Red is the main color of the image.
- `IMAGE_COLOR_ORANGE`: Orange is the main color of the image.
- `IMAGE_COLOR_YELLOW`: Yellow is the main color of the image.
- `IMAGE_COLOR_GREEN`: Green is the main color of the image.
- `IMAGE_COLOR_CYAN`: Cyan is the main color of the image.
- `IMAGE_COLOR_BLUE`: Blue is the main color of the image.
- `IMAGE_COLOR_VIOLET`: Violet is the main color of the image.
- `IMAGE_COLOR_WHITE`: White is the main color of the image.
- `IMAGE_COLOR_BLACK`: Black is the main color of the image. ||
|#

## Response {#yandex.cloud.searchapi.v2.ImageSearchResponse}

**HTTP Code: 200 - OK**

```json
{
  "rawData": "string"
}
```

#|
||Field | Description ||
|| rawData | **string** (bytes)

Required field. Search results in XML format. ||
|#