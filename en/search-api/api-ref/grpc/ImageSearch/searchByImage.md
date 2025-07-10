---
editable: false
sourcePath: en/_api-ref-grpc/searchapi/v2/api-ref/grpc/ImageSearch/searchByImage.md
---

# Web Search API, gRPC: ImageSearchService.SearchByImage

## gRPC request

**rpc SearchByImage ([ImageSearchByImageRequest](#yandex.cloud.searchapi.v2.ImageSearchByImageRequest)) returns ([ImageSearchByImageResponse](#yandex.cloud.searchapi.v2.ImageSearchByImageResponse))**

## ImageSearchByImageRequest {#yandex.cloud.searchapi.v2.ImageSearchByImageRequest}

```json
{
  "site": "string",
  "folder_id": "string",
  // Includes only one of the fields `url`, `data`, `id`
  "url": "string",
  "data": "bytes",
  "id": "string",
  // end of the list of possible fields
  "page": "int64",
  "family_mode": "FamilyMode"
}
```

#|
||Field | Description ||
|| site | **string**

Restricts the search to the specific website. ||
|| folder_id | **string**

ID of the folder. ||
|| url | **string**

Required field. The image url to use for the search.

Includes only one of the fields `url`, `data`, `id`. ||
|| data | **bytes**

Required field. The image data to use for the search.

Includes only one of the fields `url`, `data`, `id`. ||
|| id | **string**

Required field. CBIR ID of the image to use for the search.

Includes only one of the fields `url`, `data`, `id`. ||
|| page | **int64**

The number of a requested page with search results. ||
|| family_mode | enum **FamilyMode**

Rule for filtering search results and determines whether any documents should be excluded.

- `FAMILY_MODE_UNSPECIFIED`
- `FAMILY_MODE_NONE`: Filtering is disabled. Search results include any documents regardless of their contents.
- `FAMILY_MODE_MODERATE`: Moderate filter (default value). Documents of the Adult category are excluded from search results
unless a query is explicitly made for searching resources of this category.
- `FAMILY_MODE_STRICT`: Regardless of a search query, documents of the Adult category
and those with profanity are excluded from search results. ||
|#

## ImageSearchByImageResponse {#yandex.cloud.searchapi.v2.ImageSearchByImageResponse}

```json
{
  "images": [
    {
      "url": "string",
      "format": "ImageFormat",
      "width": "int64",
      "height": "int64",
      "passage": "string",
      "host": "string",
      "page_title": "string",
      "page_url": "string"
    }
  ],
  "page": "int64",
  "max_page": "int64",
  "id": "string"
}
```

#|
||Field | Description ||
|| images[] | **[ImageInfo](#yandex.cloud.searchapi.v2.ImageSearchByImageResponse.ImageInfo)**

The images found. ||
|| page | **int64**

The number of the page with search results. ||
|| max_page | **int64**

The number of the last page with search results. ||
|| id | **string**

CBIR ID of the image used for the search. ||
|#

## ImageInfo {#yandex.cloud.searchapi.v2.ImageSearchByImageResponse.ImageInfo}

#|
||Field | Description ||
|| url | **string**

Image URL. ||
|| format | enum **ImageFormat**

Image format.

- `IMAGE_FORMAT_UNSPECIFIED`
- `IMAGE_FORMAT_JPEG`: JPG format.
- `IMAGE_FORMAT_GIF`: GIF format.
- `IMAGE_FORMAT_PNG`: PNG format. ||
|| width | **int64**

Image width. ||
|| height | **int64**

Image height. ||
|| passage | **string**

Text passage. ||
|| host | **string**

Document host. ||
|| page_title | **string**

Document title. ||
|| page_url | **string**

Document URL. ||
|#