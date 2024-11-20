---
title: '{{ search-api-name }} image search'
description: On this page, you will learn how to use {{ search-api-name }} to submit image search queries and get search results in XML format.
---

# GET requests

{{ search-api-name }} allows you to search for images using the [Yandex Images](https://yandex.ru/images) index with set parameters and get search results in XML format. You submit the search parameters as an HTTP request using the GET method. {{ search-api-name }} generates a [response](./pic-response.md) as an XML document.

Currently, image search is only available for queries received via [API v1](./index.md#api-v1).

{% include [text-search-intro](../../_includes/search-api/text-search-intro.md) %}

## Request format {#get-request-format}

```httpget
https://yandex.<domain>/images-xml
  ? [folderid=<folder_ID>]
  & [apikey=<API_key>]
  & [text=<search_query_text>]
  & [groupby=<result_grouping_options>]
  & [p=<page_number>]
  & [fyandex=<family_search_filter>]
  & [site=<website_domain_name>]
  & [itype=<image_format>]
  & [iorient=<image_orientation>]
  & [isize=<image_size>]
  & [icolor=<image_color>]
```

### Request parameters {#parameters}

* `folderid`: [Folder ID](../../resource-manager/operations/folder/get-id.md) of the service account you will use to submit queries. This is a required parameter.
* `apikey`: Service account [API key](../../iam/concepts/authorization/api-key.md). This is a required parameter.
* `text`: Search query text. e.g., `funny+cats`. This is a required parameter.

    {% note warning %}

    If you have any special characters in parameter values, replace them with the respective escaped sequences based on percent-encoding. For example, use `%3D` instead of the equals sign (`=`), and `+` instead of a space.

    {% endnote %}

* `groupby`: Result grouping settings. The `groups-on-page` parameter sets the number of result groups displayed per search result page. This is an optional parameter. If not specified, the default value is `20`. One result group contains one document.
    For example, to display five result groups per page, specify `groupby=attr=ii.groups-on-page=5`.

* `p`: Number of the requested search result page. Page numbering starts from zero (`0` stands for page 1). This is an optional parameter. By default, the first page with search results is returned.
* `fyandex`: Using the **Family search** filter when generating a search response. This is an optional parameter. If the parameter is not set, the filter is not used. The possible values are:
    * `0`: **Family search** filter disabled.
    * `1`: **Family search** filter enabled.
* `site`: Searching for images on a particular website only. For example, to search only on `somepics.ru`, specify `site=somepics.ru`. This is an optional parameter. If the parameter is not set, the search is performed on all websites in the search base. 
* `itype`: Searching for images in a particular format. This is an optional parameter. If the parameter is not set, the search is performed for images in all formats. The possible values are:
    * `jpg`: Searching for images in [JPG](https://en.wikipedia.org/wiki/JPEG) format.
    * `gif`: Searching for images in [GIF](https://en.wikipedia.org/wiki/GIF) format.
    * `png`: Searching for images in [PNG](https://en.wikipedia.org/wiki/PNG) format.

* `iorient`: Searching for images with a particular orientation. This is an optional parameter. If the parameter is not set, the search is performed for images with any image orientation. The possible values are:
    * `horizontal`: Searching for images with horizontal orientation.
    * `vertical`: Searching for images with vertical orientation.
    * `square`: Searching for images with square aspect ratio.

* `isize`: Searching for images of a particular size. This is an optional parameter. If the parameter is not set, the search is performed for images of all sizes. The possible values are:
    * `enormous`: Searching for very large images (larger than 1,600 × 1,200 pixels).
    * `large`: Searching for large images (from 800 × 600 to 1,600 × 1,200 pixels).
    * `medium`: Searching for medium images (from 150 × 150 to 800 × 600 pixels).
    * `small`: Searching for small images (from 32 × 32 to 150 × 150 pixels).
    * `tiny`: Searching for icons (up to 32 × 32 pixels).
    * `wallpaper`: Searching for desktop wallpapers.

* `icolor`: Searching for images containing a particular color. This is an optional parameter. If the parameter is not set, the search is performed for images with any colors. The possible values are:
    * `gray`: Black and white
    * `color`: Color
    * `red`: Red
    * `orange`: Orange
    * `yellow`: Yellow
    * `green`: Green
    * `cyan`: Cyan
    * `blue`: Blue
    * `violet`: Violet
    * `white`: White
    * `black`: Black

### Example of a search query {#sample-request}

The following request will return the third page of image search results for the `funny cats` query. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). {{ search-api-name }} will return results for medium-sized color images in JPG format with horizontal image orientation found on `somepics.ru`. The **Family search** filter will be applied. The page will contain three groups of search results.

```html
https://yandex.ru/images-xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&text=funny+cats&groupby=attr=ii.groups-on-page=3&p=2&fyandex=1&site=somepics.ru&itype=jpg&iorient=horizontal&isize=medium&icolor=color
```

#### See also {#see-also}

* [{#T}](./pic-response.md)
* [{#T}](../operations/searching.md)
