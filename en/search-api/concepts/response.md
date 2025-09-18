---
title: XML format of {{ search-api-full-name }}'s response to a text query
description: This article describes the XML format of {{ search-api-name }}'s response to a text search query.
---

# XML format of response to a text search query

{% include [empty-response-notice](../../_includes/search-api/empty-response-notice.md) %}

In response to a text search query, {{ search-api-name }} can return a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded XML file with search results. The service returns an XML response for text queries processed both via [API v2](./index.md#api-v2) and API v1.

{% include [api-v1](../../_includes/search-api/api-v1.md) %}

You can get a maximum of 1,000 search results per search query. Depending on the docs-in-group attribute value, each result may contain one to three documents. The maximum number of search results pages depends on the number of groups of documents per page, which is defined by the groups-on-page attribute. For example, if the `groups-on-page` attribute is set to `10`, a maximum of 100 pages with search results can be generated.

XML files consist of the [request](#request-el) (aggregate information on search query parameters) and [response](#response-el) (search query handling results) grouping tags.

Below is the general structure of the resulting XML document with examples of values.

{% note warning %}

This structure is provided for information purposes only and contains mutually exclusive elements.

{% endnote %}

## Response structure {#response-format}

```xml
<?xml version="1.0" encoding="utf-8"?>
<yandexsearch version="1.0">
<request>
   <query>yandex</query>
   <page>0</page>
   <sortby order="descending" priority="no">rlv</sortby>
   <maxpassages>2</maxpassages>
   <groupings>
      <groupby  attr="d" mode="deep" groups-on-page="10" docs-in-group="3" curcateg="-1" />
   </groupings>
</request>
<response date="20120928T103130">
   <error code="15">No results found for your word combination</error>
   <reqid>1348828873568466-1289158387737177180255457-3-011-XML</reqid>
   <found priority="phrase">206775197</found>
   <found priority="strict">206775197</found>
   <found priority="all">206775197</found>
   <found-human>207 million results found</found-human>
   <misspell>
      <rule>Misspell</rule>
      <source-text>yande<hlword>xx</hlword></source-text>
      <text>yandex</text>
   </misspell>
   <reask>
      <rule>Misspell</rule>
      <source-text><hlword>yn</hlword>dex</source-text>
      <text-to-show>yandex</text-to-show>
      <text>yandex</text>
   </reask>
   <results>
      <grouping attr="d" mode="deep" groups-on-page="10" docs-in-group="3" curcateg="-1">
         <found priority="phrase">45094</found>
         <found priority="strict">45094</found>
         <found priority="all">45094</found>
         <found-docs priority="phrase">192685602</found-docs>
         <found-docs priority="strict">192685602</found-docs>
         <found-docs priority="all">192685602</found-docs>
         <found-docs-human>193 million results found</found-docs-human>
         <page first="1" last="10">0</page>
         <group>
            <categ attr="d" name="UngroupVital223.ru" />
            <doccount>34</doccount>
            <relevance priority="all" />
            <doc id="ZD831E1113BCFDD95">
               <relevance priority="phrase" />
               <url>https://www.yandex.ru/</url>
               <domain>www.yandex.ru</domain>
               <title><hlword>Yandex</hlword>: search engine and internet portal</title>
               <headline>Internet-wide search based on the user's region.</headline>
               <modtime>20060814T040000</modtime>
               <size>26938</size>
               <charset>utf-8</charset>
               <passages>
                  <passage><hlword>Yandex</hlword> is a search engine responding to your query with...</passage>
               </passages>
               <properties>
                   <_PassagesType>0</_PassagesType>
                   <lang>ru</lang>
               </properties>
               <mime-type>text/html</mime-type>
               <saved-copy-url>https://hghltd.yandex.net/yandbtm?text=yandex&amp;url=https%3A%2F%2Fwww.yandex.ru%2F&amp;fmode=inject&amp;mime=html&amp;l10n=ru&amp;sign=e3737561fc3d1105967d1ce6********&amp;keyno=0</saved-copy-url>
            </doc>
         </group>
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
|| page | Number of returned search results page. Page numbering starts from zero (`0` stands for page one). | None ||
|| sortby | 
Result sorting parameters. The possible values are:

* `rlv`: By relevance.
* `tm`: By document update time.
| 
* `order`: Sorting order. The default value is `descending` (forward sorting). When sorting by update time, the parameter may take the `ascending` value (reverse sorting).
* `priority`: Service attribute. Takes the `no` value.
||
|| maxpassages | Maximum number of passages per search result. | None||
|| groupings | 
Grouping tag

It contains grouping parameters in the `groupby` tag.
| None ||
|| groupby | Parameters for grouping the search results. | 
* `mode`: Grouping method.
* `attr`: Service attribute.
* `groups-on-page`: Maximum number of groups that can be returned per page.
* `docs-in-group`: Maximum number of documents per group. Any group may contain fewer documents than set by this parameter.
* `curcateg`: Service attribute which takes the `-1` value.
||
|#

The example below shows the contents of the `request` grouping tag returned in response to a request:

```http
https://yandex.com.tr/search/xml?l10n=en&user=xml-search-user&key=03.79031114:b631r9j587dkl4jko987hgg7********&query=%22has%20sample%20applications%20for%20the%20most%20popular%20programming%22&sortby=tm&maxpassages=2&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=1
```

```xml
<request>
  <query>"has sample applications for the most popular programming"</query>
  <page>1</page>
  <sortby order="descending" priority="no">tm</sortby>
  <maxpassages>2</maxpassages>
  <groupings>
    <groupby attr="d" mode="deep" groups-on-page="5" docs-in-group="3" curcateg="-1"/>
  </groupings>
</request>
```


### response {#response-el}

This group has the results of handling the search query, the information on which is provided in the [request](#request_params) child tags.

It contains the `date` attribute with the query date and time (UTC) in `<year><month><day>T<hour><minute><second>` format.

This group consists of the following sections:

* [General search results info](#basic-search-info)
* [`misspell / reask` section](#misspell-block)
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
|| reqid | Unique request ID | None ||
|| found | Estimated number of documents found for the request.
| 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`.
||
|| found-human | String in the language according to the selected search type. It shows the number of found documents and contains related information. | None ||
|#

#### `misspell / reask` section {#misspell-block}

Optional. It is present if a typo is detected (`misspell`) or fixed (`reask`) in the query.

The table below lists the tags for this section.

#|
|| **`misspell` / `reask` section tags** | **Description** | **Attributes** ||
|| misspell | 
This is a grouping tag.

It contains information about a possible typo in the search query.
| None ||
|| reask | 
This is a grouping tag.

It contains information about a fix made in the original query before searching for documents.
| None
||
|| rule | 
Type of error found in the query.

The possible values are:

* `Misspell`: Typo.
* `KeyboardLayout`: Incorrect keyboard layout.
* `Volapyuk`: Query is made in Russian but transliterated into English. It is used if **{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}** (`yandex.ru`) is selected as the search type.
| None
||
|| source-text | 
Source query text.

The search query fragment presumably containing an error is highlighted with the `hlword` tag.
| None
||
|| text-to-show | 
Optional (only for the `reask` grouping tag).

Contains the fixed search query text. In most cases, it matches the value provided in the [text](#text) tag.
| None
||
|| text | Fixed search query text.  | None||
|#

#### `results` section {#results-block}

Optional. It is present if results are found for the query.

The table below lists the tags for this section.

#|
|| **`results` section tags** | **Description** | **Attributes** ||
|| results | This is a grouping tag. Child tags contain information about search parameters and found documents. | None ||
|| grouping | 

This is a grouping tag. Child tags contain information about search parameters and found documents.

| 
Attributes reflect the grouping rules for documents.

* `mode`: Grouping method.
* `attr`: Service attribute. Depends on the `mode` attribute value.
* `groups-on-page`: Number of groups returned per search results page.
* `docs-in-group`: Number of documents returned per group.
* `curcateg`: Service attribute. Takes the `-1` value.
||
|| found | Estimated number of generated groups. | 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`.
||
|| found-docs | 

Estimated number of documents found for the query.

It is a more accurate estimate compared to the value provided in the `found` tag of the [general search results info](#basic-search-info) section.

| 
`priority`: Service attribute. The possible values are:

* `phrase`
* `strict`
* `all`.
||
|| found-docs-human | 

{% include [response-el-found-human-description](../../_includes/search-api/found-human-description.md) %}

The value being provided must be used when generating search results.

| None
||
|| page | Number of returned search results page. Page numbering starts from zero (`0` stands for page one).
| 
* `first`: Sequence number of the first search results group displayed on the page.
* `last`: Sequence number of the last search results group displayed on the page.
||
|| group | 
This is a grouping tag.

Each `group` tag contains information about a found document group.
| None
||
|| categ | Identification data of the group of found documents.
| 
* `attr`: Service attribute. Must match the value provided in the request.
* `name`: Unique group ID.
||
|| doccount | 
Estimated number of documents used to create the group.

Documents that qualify for inclusion in the group are ranked based on the query criteria provided in the `sortby` parameter. Depending on the docs-in-group parameter value, from one to three of the first documents are included into the group.
| None
||
|| relevance | This is a service tag. | `priority`: Service attribute. ||
|| doc | 
This is a grouping tag.

Each `doc` tag contains information about a found document.

Depending on the docs-in-group parameter value, each group can contain from one to three `doc` grouping tags.

| `id`: Unique ID of the found document.
||
|| url | URL of the found document. | None ||
|| domain | Domain hosting the found document. | None ||
|| title | 
Title of the found document.

Words included in the search query are highlighted with the `hlword` tag.
| None
||
|| headline | 
Optional. Document annotation.

It is generated using the `meta` HTML tag with the `name` attribute set to `description`.
| None
||
|| modtime | 
Document update date and time in the following format:

```no-highlight
<year><month><day>T<hour><minute><second>
```

{% note warning %}

This tag is optional and may be missing in some cases.

{% endnote %}

| None 
||
|| size | Size of the found document, in bytes. | None ||
|| charset | Encoding of the found document. | None ||
|| passages | Grouping tag with a list of document's passages. | None ||
|| passage | 
Passage with annotation to the document.

Words included in the search query are highlighted with the `hlword` tag.

The maximum number of passages provided in a single `passages` tag depends on the search query's `maxpassages` value.
| None
||
|| mime-type | Document type according to [RFC2046](http://tools.ietf.org/html/rfc2046) | None ||
|| properties | Grouping tag with document properties. | None ||
|| _PassagesType | 
Passage type. The possible values are:

* `0`: Regular passage (derived from the document text).
* `1`: Passage based on the link text. Used if the document is found via a link.

| None
||
|| lang | 
Optional.

It determines the document language.

| None
||
|| saved-copy-url | URL of the saved document copy. | None ||
|#

#### See also {#see-also}

* [{#T}](../operations/web-search-sync.md)
* [{#T}](../operations/web-search.md)
* [{#T}](./web-search.md)
