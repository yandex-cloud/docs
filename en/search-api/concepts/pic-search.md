---
title: "{{ search-api-name }} image search"
description: "On this page, you will learn how to use {{ search-api-name }} to send image search queries and receive search results in XML format."
---

# GET requests

{{ search-api-name }} allows you to search for images using the [Yandex Images](https://yandex.ru/images) index with set parameters and get search results in XML format. You can transmit search parameters to the service in an HTTP request using the GET method. {{ search-api-name }} generates a [response](./pic-response.md) as an XML document.

{% include [text-search-intro](../../_includes/search-api/text-search-intro.md) %}

## Request format {#get-request-format}

```httpget
https://yandex.<domain>/images-xml
  ? [folderid=<folder_ID>]
  & [apikey=<API_key>]
  & [text=<search_query_text>]
  & [groupby=<result_grouping_settings>]
  & [p=<page_number>]
  & [fyandex=<family_search_filter>]
  & [site=<website_domain_name>]
  & [itype=<image_format>]
  & [iorient=<image_orientation_type>]
  & [isize=<image_size>]
  & [icolor=<image_color>]
```

### Request parameters {#parameters}

* `folderid`: [Folder ID](../../resource-manager/operations/folder/get-id.md) of the service account you will use to send requests. This is a required parameter.
* `apikey`: Service account [API key](../../iam/concepts/authorization/api-key.md). This is a required parameter.
* `text`: Search query text, e.g., `funny+cats`. This is a required parameter.

   {% note warning %}

   Special characters provided as parameter values should be replaced with the respective escaped sequences based on percent-encoding. For example, use `%3D` instead of the equals sign (`=`), and `+` instead of a space.

   {% endnote %}

* `groupby`: Result grouping settings. The `groups-on-page` parameter sets the number of result groups displayed per search results page. This is an optional parameter. If the parameter is not specified, the default value is `20`. One result group contains one document.
   For example, to display five result groups per page, specify `groupby=attr=ii.groups-on-page=5`.

* `p`: Number of the requested search results page. Page numbering starts from zero (the `0` value stands for page 1). This is an optional parameter. By default, the first page with search results is returned.
* `fyandex`: Using the **Family search** filter when generating a search response. This is an optional parameter. If the parameter is not set, the filter is not used. The possible values include:
   * `0`: **Family Search** filter disabled.
   * `1`: **Family Search** filter enabled.
* `site`: Searching for images only on the specified website. For example, to search only the `somepics.ru` website, specify `site=somepics.ru`. This is an optional parameter. If the parameter is not set, the search is performed on all websites in the search base.
* `itype`: Searching for images in a specified format. This is an optional parameter. If the parameter is not set, the search is performed for images in all formats. The possible values include:
   * `jpg`: Searching for images in [JPG](https://en.wikipedia.org/wiki/JPEG) format.
   * `gif`: Searching for images in [GIF](https://en.wikipedia.org/wiki/GIF) format.
   * `png`: Searching for images in [PNG](https://en.wikipedia.org/wiki/JPEG) format.

* `iorient`: Searching for images with a specified image orientation. This is an optional parameter. If the parameter is not set, the search is performed for images with any image orientation. The possible values include:
   * `horizontal`: Searching for images with the horizontal image orientation.
   * `vertical`: Searching for images with the vertical image orientation.
   * `square`: Searching for images with equal sides (square).

* `isize`: Searching for images of a specified size. This is an optional parameter. If the parameter is not set, the search is performed for images of all sizes. The possible values include:
   * `enormous`: Searching for very large images (larger than 1600 × 1200 pixels).
   * `large`: Searching for large images (from 800 × 600 to 1600 × 1200 pixels).
   * `medium`: Searching for medium images (from 150 × 150 to 800 × 600 pixels).
   * `small`: Searching for small images (from 32 × 32 to 150 × 150 pixels).
   * `tiny`: Searching for icons (up to 32 × 32 pixels).
   * `wallpaper`: Searching for desktop wallpapers.

* `icolor`: Searching for images with a specified color. This is an optional parameter. If the parameter is not set, the search is performed for images with any colors. The possible values include:
   * `gray`: Black and white
   * `color`: Colored
   * `red`: Red
   * `orange`: Orange
   * `yellow`: Yellow
   * `green`: Green
   * `cyan`: Cyan
   * `blue`: Blue
   * `violet`: Violet
   * `white`: White
   * `black`: Black

### Search query example {#sample-request}

The following query will return the third page of image search results for the `funny cats` query. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). The service will return results for medium-sized color images found on `somepics.ru` in JPG format with the horizontal image orientation. The **Family search** filter will be applied to the search results. The page will contain three groups of search results.

```html
https://yandex.ru/images-xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&text=funny+cats&groupby=attr=ii.groups-on-page=3&p=2&fyandex=1&site=somepics.ru&itype=jpg&iorient=horizontal&isize=medium&icolor=color
```

#### See also {#see-also}

* [{#T}](./pic-response.md)
* [{#T}](../operations/searching.md)
