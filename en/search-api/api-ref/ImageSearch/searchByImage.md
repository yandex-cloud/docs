---
editable: false
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
  "page": "string"
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