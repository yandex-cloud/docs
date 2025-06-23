---
title: XML response format for image search in {{ search-api-full-name }}
description: This article describes the XML format of a response returned by {{ search-api-name }} for an image search query.
noIndex: true
---

# Image search response format

In response to an image search query, {{ search-api }} returns a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded XML file with the search results.

XML files consist of the [request](#request-el) (aggregate information on search query parameters) and [response](#response-el) (search query handling results) grouping tags.

Currently, image search is only available for queries made via the API v1.

Below is the general structure of the resulting XML document with examples of values.

## Response structure {#response-format}

```xml
<?xml version="1.0" encoding="utf-8"?>
<yandexsearch version="1.0">
<request>
   <query>cats</query>
   <page>2</page>
   <sortby order="descending" priority="no">rlv</sortby>
   <maxpassages>1</maxpassages>
   <groupings>
      <groupby attr="ii" mode="deep" groups-on-page="1" docs-in-group="1" curcateg="-1"/>
   </groupings>
</request>
<response date="20240414T091102">
   <reqid>1713085862371215-3284531111984749627-balancer-l7leveler-kubr-yp-vla-25-BAL</reqid>
   <found priority="phrase">11132</found>
   <found priority="strict">11132</found>
   <found priority="all">11132</found>
   <found-human>11 thousand results found</found-human>
   <results>
      <grouping attr="ii" mode="deep" groups-on-page="1" docs-in-group="1" curcateg="-1">
         <page first="1" last="1">2</page>
         <group>
            <categ attr="ii" id="3166497932182189502"/>
            <doccount>1</doccount>
            <relevance priority="all"/>
            <doc id="Z37E83657D25C5DED">
               <relevance priority="all"/>
               <url>https://***.*****.**/big3/989/426616-Kycb.jpg</url>
               <domain>***.*****.**</domain>
               <modtime>20170920T100608</modtime>
               <size>0</size>
               <charset>utf-8</charset>
               <image-properties>
                  <id>63966cd66b86c8e11bf80c4c7dc5e431c5cd1b5d-8971534-images-thumbs</id>
                  <shard>0</shard>
                  <thumbnail-link>http://avatars.mds.yandex.net/i?id=63966cd66b86c8e11bf80c4c7dc5e431c5cd1b5d-8971534-images-thumbs</thumbnail-link>
                  <thumbnail-width>480</thumbnail-width>
                  <thumbnail-height>272</thumbnail-height>
                  <original-width>480</original-width>
                  <original-height>272</original-height>
                  <html-link>https://****.*********.ru/download/kot-kotyara-usy-lapy-hvost-2399/480x272/</html-link>
                  <image-link>https://****.*********.ru/original/480x272/8/d3/kot-kotyara-usy-lapy-hvost-2399.jpg</image-link>
                  <file-size>57435</file-size>
                  <mime-type>jpg</mime-type>
               </image-properties>
               <mime-type>text/html</mime-type>
               <properties/>
            </doc>
         </group>
         <found priority="phrase">8432</found>
         <found priority="strict">8432</found>
         <found priority="all">8432</found>
         <found-docs priority="phrase">8432</found-docs>
         <found-docs priority="strict">8432</found-docs>
         <found-docs priority="all">8432</found-docs>
         <found-docs-human>8 thousand results found</found-docs-human>
      </grouping>
   </results>
</response>
</yandexsearch>
```


## Response parameters {#response-parameters}

The `request` group provides aggregate information about request parameters. It may be missing if there are errors in the response.

### request {#request-el}

#|
|| **Request group tags** | **Description** | **Attributes** ||
|| query | Search query text | None ||
|| page | Number of returned search results page. Page numbering starts from zero (`0` stands for page 1). | None ||
|| sortby | 
Result sorting parameters. Service tag, takes the `rlv` value: sorting by relevance.
| 
* `order`: Sorting order. Service attribute, takes the `descending` value (direct sorting order).
* `priority`: Service attribute. Takes the `no` value.
||
|| maxpassages | Maximum number of text snippets generated for image. Service tag, takes the `1` value. | None||
|| groupings | 
Grouping tag.

It contains grouping parameters in the `groupby` tag. 
| None ||
|| groupby | Parameters for grouping the search results. | 
* `attr`: Service attribute, takes the `ii` value.
* `mode`: Grouping method. Service attribute, takes the `deep` value.
* `groups-on-page`: Maximum number of search result groups that can be returned per page. If the attribute is not specified, the default value is `20`.
* `docs-in-group`: Maximum number of images that can be returned per group. Service attribute, takes the `1` value.
* `curcateg`: Service attribute. Takes the `-1` value.
||
|#

### response {#response-el}

Results of processing the search query, information about which is provided in the [request](#request-el) tag.

It contains the `date` attribute with the query date and time (UTC) in `<year><month><day>T<hour><minute><second>` format.

This group consists of the following sections:

* [General search results info](#basic-search-info)
* [`results` section](#results-block)

#### General search results info {#basic-search-info}

The table below lists the tags of the general search results info section.

#|
|| **General search results info tags** | **Description** | **Attributes** ||
|| error |
Error description 

Used only if a search query is handled incorrectly (e.g., if the query is empty or parameters are incorrect).

In some cases, it is mutually exclusive with other tags of the `response` grouping tag.
| `code`: Error [code](../reference/error-codes.md). ||
|| reqid | Unique query ID | None ||
|| found | Estimated number of images found for the query.
| 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`
||
|| found-human | String in the language according to the selected [search type](../operations/workaround.md). Contains information about the number of found images and related information. | None ||
|#


#### results section {#results-block}

Optional. It is present if results are found for the query.

The table below lists the tags for this section.

#|
|| **`results` section tags** | **Description** | **Attributes** ||
|| results | Grouping tag. Child tags contain information about search parameters and found images. | None ||
|| grouping | 

Grouping tag. Child tags contain information about search parameters and found images.

| 
Attributes reflect the grouping rules for images.

* `attr`: Service attribute, takes the `ii` value.
* `mode`: Grouping method. Service attribute, takes the `deep` value.
* `groups-on-page`: Maximum number of search result groups that can be returned per page. If not specified, the default value is `20`.
* `docs-in-group`: Maximum number of images that can be returned per group. Service attribute, takes the `1` value.
* `curcateg`: Service attribute. Takes the `-1` value.
||
|| page | Number of returned search results page. Page numbering starts from zero (`0` stands for page 1).
| 
* `first`: Sequence number of the first search results group displayed on the page.
* `last`: Sequence number of the last search results group displayed on the page.
||
|| group | 
Grouping tag.

Each `group` tag contains information about one group of found images. Since each group of images contains one image, the tag provides information about one image.
| None
||
|| categ | Description of the found image | 
* `attr`: Grouping name. Same as the `attr` attribute value under the `groupby` tag in the `request` element.
* `id`: ID of the image host.
||
|| doccount | Service tag | None ||
|| relevance | Service tag | `priority`: Service attribute. ||
|| doc | 
Grouping tag.

Each `doc` tag contains information about one of the found images.

| `id`: Unique ID of the found image
||
|| relevance | Service tag | `priority`: Service attribute. ||
|| url | Image address | None ||
|| domain | Domain that hosts the document containing the image | None ||
|| modtime | Image modification date and time (UTC) in `<year><month><day>T<hour><minute><second>` format | None ||
|| size | Image size in bytes | None ||
|| charset | Encoding of the document containing the image | None ||
|| image-properties | 
Grouping tag.

Contains information about the image properties to include in search results.

| None
||
|| id | Image thumbnail ID | None ||
|| shard | Number of the shard containing the image information | None ||
|| thumbnail-link | Image thumbnail address | None ||
|| thumbnail-width | Width of the image thumbnail in pixels | None ||
|| thumbnail-height | Height of the image thumbnail in pixels | None ||
|| original-width | Width of the source (original) image | None ||
|| original-height | Height of the source (original) image | None ||
|| html-link | Image page address | None ||
|| image-link | Image address | None ||
|| file-size | Image size in bytes | None ||
|| mime-type | Image format (JPG, GIF, or PNG) | None ||
|| mime-type | Format of the document containing the image | None ||
|| found | Estimate of the number of generated groups | 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`
||
|| found-docs | 

Estimated number of images found for the query.

It is a more accurate estimate compared to the value provided in the `found` tag of the [general search results info](#basic-search-info) section.

| 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`.
||
|| found-docs-human | 
A string in the language matching the selected [search type](../operations/workaround.md). Contains information about the number of found images and related information.

The value being provided must be used when generating search results.

| None
||
|#

#### See also {#see-also}

* [{#T}](./pic-search.md)
* [{#T}](../operations/searching.md)