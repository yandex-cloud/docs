---
editable: false
sourcePath: en/_api-ref-grpc/searchapi/v2/api-ref/grpc/ImageSearch/search.md
---

# Web Search API, gRPC: ImageSearchService.Search

## gRPC request

**rpc Search ([ImageSearchRequest](#yandex.cloud.searchapi.v2.ImageSearchRequest)) returns ([ImageSearchResponse](#yandex.cloud.searchapi.v2.ImageSearchResponse))**

## ImageSearchRequest {#yandex.cloud.searchapi.v2.ImageSearchRequest}

```json
{
  "query": {
    "search_type": "SearchType",
    "query_text": "string",
    "family_mode": "FamilyMode",
    "page": "int64",
    "fix_typo_mode": "FixTypoMode"
  },
  "image_spec": {
    "format": "ImageFormat",
    "size": "ImageSize",
    "orientation": "ImageOrientation",
    "color": "ImageColor"
  },
  "site": "string",
  "docs_on_page": "int64",
  "folder_id": "string",
  "user_agent": "string"
}
```

#|
||Field | Description ||
|| query | **[SearchQuery](#yandex.cloud.searchapi.v2.SearchQuery)**

Required field. Search query. ||
|| image_spec | **[ImageSpec](#yandex.cloud.searchapi.v2.ImageSpec)**

Searching for images with a particular size, orientation, format or color. ||
|| site | **string**

Searching for images on a particular website only. ||
|| docs_on_page | **int64**

Number of results per search result page. ||
|| folder_id | **string**

ID of the folder. ||
|| user_agent | **string**

User-Agent request header value. ||
|#

## SearchQuery {#yandex.cloud.searchapi.v2.SearchQuery}

#|
||Field | Description ||
|| search_type | enum **SearchType**

Required field. Search type that determines the domain name that will be used for the search queries.

- `SEARCH_TYPE_UNSPECIFIED`
- `SEARCH_TYPE_RU`: Russian search type (default), yandex.ru search domain name will be used.
- `SEARCH_TYPE_TR`: Turkish search type, yandex.tr search domain name will be used.
- `SEARCH_TYPE_COM`: International search type, yandex.com search domain name will be used.
- `SEARCH_TYPE_KK`: Kazakh search type, yandex.kz search domain name will be used.
- `SEARCH_TYPE_BE`: Belarusian search type, yandex.by search domain name will be used.
- `SEARCH_TYPE_UZ`: Uzbek search type, yandex.uz search domain name will be used. ||
|| query_text | **string**

Required field. Search query text ||
|| family_mode | enum **FamilyMode**

Rule for filtering search results and determines whether any documents should be excluded.

- `FAMILY_MODE_UNSPECIFIED`
- `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
- `FAMILY_MODE_MODERATE`: Moderate filter (default value). Documents of the Adult category are excluded from search results
unless a query is explicitly made for searching resources of this category.
- `FAMILY_MODE_STRICT`: Regardless of a search query, documents of the Adult category
and those with profanity are excluded from search results. ||
|| page | **int64**

The number of a requested page with search results ||
|| fix_typo_mode | enum **FixTypoMode**

Typos autocorrections mode

- `FIX_TYPO_MODE_UNSPECIFIED`
- `FIX_TYPO_MODE_ON`: Automatically correct typos (default value).
- `FIX_TYPO_MODE_OFF`: Autocorrection is off. ||
|#

## ImageSpec {#yandex.cloud.searchapi.v2.ImageSpec}

#|
||Field | Description ||
|| format | enum **ImageFormat**

Searching for images in a particular format.

- `IMAGE_FORMAT_UNSPECIFIED`
- `IMAGE_FORMAT_JPEG`: JPG format.
- `IMAGE_FORMAT_GIF`: GIF format.
- `IMAGE_FORMAT_PNG`: PNG format. ||
|| size | enum **ImageSize**

Searching for images of a particular size.

- `IMAGE_SIZE_UNSPECIFIED`
- `IMAGE_SIZE_ENORMOUS`: Very large images (larger than 1,600 × 1,200 pixels).
- `IMAGE_SIZE_LARGE`: Large images (from 800 × 600 to 1,600 × 1,200 pixels).
- `IMAGE_SIZE_MEDIUM`: Medium images (from 150 × 150 to 800 × 600 pixels).
- `IMAGE_SIZE_SMALL`: Small images (from 32 × 32 to 150 × 150 pixels).
- `IMAGE_SIZE_TINY`: Icons (up to 32 × 32 pixels).
- `IMAGE_SIZE_WALLPAPER`: Desktop wallpapers. ||
|| orientation | enum **ImageOrientation**

Searching for images with a particular orientation.

- `IMAGE_ORIENTATION_UNSPECIFIED`
- `IMAGE_ORIENTATION_VERTICAL`: Horizontal orientation.
- `IMAGE_ORIENTATION_HORIZONTAL`: Vertical orientation.
- `IMAGE_ORIENTATION_SQUARE`: Square aspect ratio. ||
|| color | enum **ImageColor**

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

## ImageSearchResponse {#yandex.cloud.searchapi.v2.ImageSearchResponse}

```json
{
  "raw_data": "bytes"
}
```

#|
||Field | Description ||
|| raw_data | **bytes**

Required field. Search results in XML format. ||
|#