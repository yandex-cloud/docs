---
title: Image search in {{ search-api-name }}
description: On this page, you will learn how to use {{ search-api-full-name }} to send image search queries and get search results.
---

# Image search

With {{ search-api-full-name }}, you can search for images through the [Yandex Images](https://yandex.ru/images) index either by [text description](#search-by-text-query) or [image](#search-by-image). The search parameters, together with your search query or source image, should be provided in the request body. Depending on search type, {{ search-api-name }} returns its response as an [XML](#xml-response-format) or [JSON](#json-response-format) document.

## Searching by text description {#search-by-text-query}

To [search](../operations/search-images.md) by text description, provide your search parameters in the [request body](#request-body-format) and get your search result in [XML format](#xml-response-format).

### Request body format {#request-body-format}

{% include [rest-grpc-fields-differ](../../_includes/search-api/rest-grpc-fields-differ.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  {% include [http-body-imagesearch](../../_includes/search-api/http-body-imagesearch.md) %}

  Description of fields:

  {% include [http-body-params-imagesearch](../../_includes/search-api/http-body-params-imagesearch.md) %}

- gRPC API {#grpc-api}

  {% include [grpc-body-imagesearch](../../_includes/search-api/grpc-body-imagesearch.md) %}

  Description of fields:

  {% include [grpc-body-params-imagesearch](../../_includes/search-api/grpc-body-params-imagesearch.md) %}

{% endlist %}

### XML response format {#xml-response-format}

In response to a text search query, {{ search-api }} returns a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded [XML](https://en.wikipedia.org/wiki/XML) file with search results.

The XML file consists of [request](#request-el) (with summarized information about the request parameters) and [response](#response-el) (with search query processing results) grouping tags.

#### Response example {#response-example}



```xml
<?xml version="1.0" encoding="utf-8"?>
<yandexsearch version="1.0">
  <request>
    <query>kittens</query>
    <page>0</page>
    <sortby order="descending" priority="no">rlv</sortby>
    <maxpassages>1</maxpassages>
    <groupings>
      <groupby attr="ii" mode="deep" groups-on-page="1" docs-in-group="1" curcateg="-1"/>
    </groupings>
  </request>
  <response date="20250530T143927">
    <reqid>1748615967169172-2797787793510975009-balancer-l7leveler-kubr-yp-vla-257-BAL</reqid>
    <found priority="phrase">6558</found>
    <found priority="strict">6558</found>
    <found priority="all">6558</found>
    <found-human>3 thsd. answers found</found-human>
    <is-local>no</is-local>
    <results>
      <grouping attr="ii" mode="deep" groups-on-page="20" docs-in-group="1" curcateg="-1">
        <page first="1" last="20">0</page>
        <group>
          <categ attr="ii" id="2606553042332394200"/>
          <doccount>1</doccount>
          <relevance priority="all"/>
          <doc id="Z493B41CD68505D32">
            <relevance priority="all"/>
            <url>https://***.*****.**/wp-content/uploads/2015/08/three-kittens.jpg</url>
            <domain>***.*****.**</domain>
            <modtime>20191126T135649</modtime>
            <size>0</size>
            <charset>utf-8</charset>
            <image-properties>
              <id>082c71c2963a0b5859ac6de15743c7d661c76f4b-4665500-images-thumbs</id>
              <shard>0</shard>
              <thumbnail-link>http://avatars.mds.yandex.net/i?id=082c71c2963a0b5859ac6de15743c7d661c76f4b-4665500-images-thumbs</thumbnail-link>
              <thumbnail-width>320</thumbnail-width>
              <thumbnail-height>320</thumbnail-height>
              <original-width>1374</original-width>
              <original-height>1374</original-height>
              <html-link>****************.com/category/enforcement/page/4/</html-link>
              <image-link>****************.com/wp-content/uploads/2015/06/kittens1</image-link>
              <file-size>130963</file-size>
              <mime-type>jpg</mime-type>
            </image-properties>
            <mime-type>text/html</mime-type>
            <properties/>
          </doc>
        </group>
        <found priority="phrase">2348</found>
        <found priority="strict">2348</found>
        <found priority="all">2348</found>
        <found-docs priority="phrase">2348</found-docs>
        <found-docs priority="strict">2348</found-docs>
        <found-docs priority="all">2348</found-docs>
        <found-docs-human>found 1 thsd. answers</found-docs-human>
      </grouping>
    </results>
  </response>
</yandexsearch>
```


#### request section {#request-el}

The `request` group provides aggregate information about request parameters. It may be missing if there are errors in the response.

#|
|| **Request group tags** | **Description** | **Attributes** ||
|| query | Search query text | None ||
|| page | Number of returned search results page. Page numbering starts from zero (`0` stands for page one). | None ||
|| sortby | 
Result sorting parameters. Service tag, takes the `rlv` value: sorting by relevance.
| 
* `order`: Sorting order. Service attribute, takes the `descending` value (reverse sorting order).
* `priority`: Service attribute. Takes the `no` value.
||
|| maxpassages | Maximum number of text snippets generated for each image. Service tag, takes the `1` value. | None||
|| groupings | 
Grouping tag.

It contains grouping parameters in the `groupby` tag. 
| None ||
|| groupby | Parameters for grouping the search results. | 
* `attr`: Service attribute, takes the `ii` value.
* `mode`: Grouping method. Service attribute, takes the `deep` value.
* `groups-on-page`: Maximum number of search result groups per page.
* `docs-in-group`: Maximum number of images per group. Service attribute, takes the `1` value.
* `curcateg`: Service attribute. Takes the `-1` value.
||
|#

#### response section {#response-el}

Search query processing results. Contains the `date` attribute for query date and time ([UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time)) in `<year><month><day>T<hour><minute><second>` format.

Consists of the following sections:

* [General search results info](#basic-search-info).
* [results section](#results-block).

##### General search results info {#basic-search-info}

#|
|| **General search results info tags** | **Description** | **Attributes** ||
|| error |
Error description 

Used only if a search query is handled incorrectly (e.g., if the query is empty or parameters are incorrect).

In some cases, it is mutually exclusive with other tags of the `response` grouping tag.
| `code`: Error [code](../reference/error-codes.md). ||
|| reqid | Unique query ID | None ||
|| found | Estimated number of images found based on the query.
| 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`
||
|| found-human | A string in the language matching the selected [search type](#request-body-format). It shows the number of found images and related information. | None ||
|#


##### results section {#results-block}

This is an optional section. It is present if results are found for the query.

#|
|| **results section tags** | **Description** | **Attributes** ||
|| results | Grouping tag. Child tags contain information about search parameters and found images. | None ||
|| grouping | 
Grouping tag. Child tags contain information about search parameters and found images.

| 
Attributes reflect the grouping rules for found images.

* `attr`: Service attribute, takes the `ii` value.
* `mode`: Grouping method. Service attribute, takes the `deep` value.
* `groups-on-page`: Maximum number of search result groups per page.
* `docs-in-group`: Maximum number of images per group. Service attribute, takes the `1` value.
* `curcateg`: Service attribute. Takes the `-1` value.
||
|| page | Number of returned search results page. Page numbering starts from zero (`0` stands for page one).
| 
* `first`: Sequence number of the first search results group displayed on the page.
* `last`: Sequence number of the last search results group displayed on the page.
||
|| group | 
Grouping tag.

Each `group` tag contains information about one group of images. As each image group contains only one image, the tag provides information about one image.
| None
||
|| categ | Description of the found image. | 
* `attr`: Grouping name. Same as the `attr` attribute value under the `groupby` tag in the `request` element.
* `id`: ID of the image host.
||
|| doccount | Service tag. | None ||
|| relevance | Service tag. | `priority`: Service attribute. ||
|| doc | 
Grouping tag.

Each `doc` tag contains information about one found image.

| `id`: Unique ID of the found image.
||
|| relevance | Service tag. | `priority`: Service attribute. ||
|| url | Image address. | None ||
|| domain | Domain hosting the document containing the image. | None ||
|| modtime | Image modification date and time (UTC) in `<year><month><day>T<hour><minute><second>` format. | None ||
|| size | Image size in bytes. | None ||
|| charset | Encoding of the document containing the image. | None ||
|| image-properties | 
Grouping tag.

Contains the image properties information to include in search results.

| None
||
|| id | Image thumbnail ID. | None ||
|| shard | Number of the shard containing the image information. | None ||
|| thumbnail-link | Image thumbnail address. | None ||
|| thumbnail-width | Image thumbnail width in pixels. | None ||
|| thumbnail-height | Image thumbnail height in pixels. | None ||
|| original-width | Width of the source (original) image. | None ||
|| original-height | Height of the source (original) image. | None ||
|| html-link | Image page address. | None ||
|| image-link | Image address. | None ||
|| file-size | Image size in bytes. | None ||
|| mime-type | Image format (JPG, GIF, or PNG). | None ||
|| mime-type | Format of the document containing the image. | None ||
|| found | Estimated number of generated groups. | 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`
||
|| found-docs | 
Estimated number of images found based on the query.

It is a more accurate estimate compared to the value provided in the `found` tag of the [general search results info](#basic-search-info) section.

| 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`
||
|| found-docs-human | 
A string in the language matching the selected [search type](#request-body-format). It shows the number of found images and related information.

The value being provided must be used when generating search results.

| None
||
|#

## Searching by image {#search-by-image}

To [search](../operations/search-images-by-pic.md) by image, provide the image and your search parameters in the [request body](#request-body-by-pic) and get your search result in [JSON](#json-response-format) format.

### Request body format {#request-body-by-pic}

{% include [rest-grpc-fields-differ](../../_includes/search-api/rest-grpc-fields-differ.md) %}

{% list tabs group=instructions %}

- REST API {#api}

  {% include [http-body-image-bypic-search](../../_includes/search-api/http-body-image-bypic-search.md) %}

  Description of fields:

  {% include [http-body-params-image-bypic-search](../../_includes/search-api/http-body-params-image-bypic-search.md) %}

- gRPC API {#grpc-api}

  {% include [grpc-body-image-bypic-search](../../_includes/search-api/grpc-body-image-bypic-search.md) %}

  Description of fields:

  {% include [grpc-body-params-image-bypic-search](../../_includes/search-api/grpc-body-params-image-bypic-search.md) %}

{% endlist %}

### JSON response format {#json-response-format}

In response to a query by image, {{ search-api }} returns a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded [JSON](https://en.wikipedia.org/wiki/JSON) file with the search results.

#### Response example {#json-response-example}

{% list tabs group=instructions %}

- REST API {#api}

  ```json
  {
    "images": [
      {
        "url": "https://cs10.pikabu.ru/post_img/2019/10/29/8/og_og_1572352646221687176.jpg",
        "format": "IMAGE_FORMAT_JPEG",
        "width": "570",
        "height": "960",
        "passage": "This Pin was discovered by Some Dude.",
        "host": "www.pinterest.com",
        "pageTitle": "How to enrich your cute cats' life? Cute cats, Indoor cat, Cats",
        "pageUrl": "https://www.pinterest.com/pin/how-to-enrich-your-cute-cats-life--703194929319013467/"
      },
      ...
    ],
    "page": "3",
    "maxPage": "37",
    "id": "1716254/_KnCt2T9gLh4z8SSv8nVqQ7277"
  }
  ```

  Description of fields:

  * `images`: Array of objects with information about found images:

      * `url`: Image URL.
      * `format`: Image format:
      
          * `IMAGE_FORMAT_JPEG`: [JPG](https://en.wikipedia.org/wiki/JPEG)
          * `IMAGE_FORMAT_GIF`: [GIF](https://en.wikipedia.org/wiki/GIF)
          * `IMAGE_FORMAT_PNG`: [PNG](https://en.wikipedia.org/wiki/PNG) format.
      * `width`: Image width in [pixels](https://en.wikipedia.org/wiki/Pixel).
      * `height`: Image height in pixels.
      * `passage`: Text snippet describing the image.
      * `host`: Domain hosting the document containing the image.
      * `pageTitle`: Image page title.
      * `pageUrl`: Image page URL.
  * `page`: Current search results page number.
  * `maxPage`: Last search results page number.
  * `id`: Source image [CBIR](https://en.wikipedia.org/wiki/Content-based_image_retrieval) ID.

- gRPC API {#grpc-api}

  ```json
  {
    "images": [
      {
        "url": "https://cs10.pikabu.ru/post_img/2019/10/29/8/og_og_1572352646221687176.jpg",
        "format": "IMAGE_FORMAT_JPEG",
        "width": "570",
        "height": "960",
        "passage": "This Pin was discovered by Some Dude.",
        "host": "www.pinterest.com",
        "page_title": "How to enrich your cute cats' life? Cute cats, Indoor cat, Cats",
        "page_url": "https://www.pinterest.com/pin/how-to-enrich-your-cute-cats-life--703194929319013467/"
      },
      ...
    ],
    "page": "3",
    "max_page": "37",
    "id": "1716254/_KnCt2T9gLh4z8SSv8nVqQ7277"
  }
  ```

  Description of fields:

  * `images`: Array of objects with information about found images:

      * `url`: Image URL.
      * `format`: Image format:
      
          * `IMAGE_FORMAT_JPEG`: [JPG](https://en.wikipedia.org/wiki/JPEG)
          * `IMAGE_FORMAT_GIF`: [GIF](https://en.wikipedia.org/wiki/GIF)
          * `IMAGE_FORMAT_PNG`: [PNG](https://en.wikipedia.org/wiki/PNG) format.
      * `width`: Image width in [pixels](https://en.wikipedia.org/wiki/Pixel).
      * `height`: Image height in pixels.
      * `passage`: Text snippet describing the image.
      * `host`: Domain hosting the document containing the image.
      * `page_title`: Image page title.
      * `page_url`: Image page URL.
  * `page`: Current search results page number.
  * `max_page`: Last search results page number.
  * `id`: Source image [CBIR](https://en.wikipedia.org/wiki/Content-based_image_retrieval) ID.

{% endlist %}

#### See also {#see-also}

* [{#T}](../operations/search-images.md)
* [{#T}](../operations/search-images-by-pic.md)
* [{#T}](../api-ref/authentication.md)