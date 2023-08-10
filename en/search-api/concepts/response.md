# Response format

In response to a search query, {{ search-api }} returns a UTF-8 encoded XML file with search results.

{% note alert %}

Up to 1,000 search results can be returned per search query. Depending on the [docs-in-group](post-request.md#post-docs-in-group) attribute value, each result may contain one to three documents. The maximum number of pages with search results depends on the number of groups of documents returned per page (the [groups-on-page](post-request.md#post-groups-on-page) attribute value). If the provided `groups-on-page` attribute is set to `10`, a maximum of 100 pages with search results can be generated.

{% endnote %}

Files consist of grouping tags such as [request](#request) (aggregate information on search query parameters) and [response](#response-el) (search query handling results).

Below is a general structure of a resulting XML document with sample values.

{% note warning %}

It is given for informative purposes only and contains mutually exclusive elements.

{% endnote %}

## Response format {#response-format}

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
   <error code="15">Sorry, there are no results for this search</error>
   <reqid>1348828873568466-1289158387737177180255457-3-011-XML</reqid>
   <found priority="phrase">206775197</found>
   <found priority="strict">206775197</found>
   <found priority="all">206775197</found>
   <found-human>207 mln responses found</found-human>
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
         <found-docs-human>193 mln responses found</found-docs-human>
         <page first="1" last="10">0</page>
         <group>
            <categ attr="d" name="UngroupVital223.ru" />
            <doccount>34</doccount>
            <relevance priority="all" />
            <doc id="ZD831E1113BCFDD95">
               <relevance priority="phrase" />
               <url>https://www.yandex.ru/</url>
               <domain>www.yandex.ru</domain>
               <title>&quot;<hlword>Yandex</hlword>&quot; is a search engine and web portal</title>
               <headline>Search across the internet based on the user region.</headline>
               <modtime>20060814T040000</modtime>
               <size>26938</size>
               <charset>utf-8</charset>
               <passages>
                  <passage><hlword>Yandex</hlword> is a search engine that can, by your request,...</passage>
               </passages>
               <properties>
                   <_PassagesType>0</_PassagesType>
                   <lang>ru</lang>
               </properties>
               <mime-type>text/html</mime-type>
               <saved-copy-url>https://hghltd.yandex.net/yandbtm?text=yandex&amp;url=https%3A%2F%2Fwww.yandex.ru%2F&amp;fmode=inject&amp;mime=html&amp;l10n=ru&amp;sign=e3737561fc3d1105967d1ce619dbd3c7&amp;keyno=0</saved-copy-url>
            </doc>
         </group>
      </grouping>
   </results>
</response>
</yandexsearch>
```


## Response parameters {#response-parameters}

Aggregate information about request parameters. May be missing if there are errors in the response.

The `request` tags are described in the table below.

#|
|| **Request group tags** | **Description** | **Attributes** ||
|| query | Text of the search query sent | Missing. ||
|| page | Number of the returned page with search results. Page numbering starts from zero (the first page corresponds to the `0` value). | Missing. ||
|| sortby |
Result sorting parameters. Possible values:

* `rlv`: By relevance.
* `tm`: By document update time.
|
* `order`: Sorting order. By default, `descending` (direct). When sorting by update time, the parameter may take the `ascending` value (reverse).
* `priority`: Service. Set to "no".
||
|| maxpassages | Maximum number of passages that can be provided per search result | Missing.||
|| groupings |
Grouping

Contains grouping parameters in the [groupby](#request-groupby) tag
| Missing. ||
|| groupby | Parameters for grouping search results found |
* `mode`: [Grouping method](post-request.md#post-mode).
* `attr`: Service attribute.
* `groups-on-page`: Maximum number of groups that can be returned per page with search results.
* `docs-in-group`: Maximum number of documents that can be returned per group. Any group may contain less documents than set by this parameter.
* `curcateg`: Service attribute. Set to `-1`.
||
|#

The example below shows the contents of the `request` grouping tag returned in response to a query:

```http
https://yandex.com.tr/search/xml?l10n=en&user=xml-search-user&key=03.79031114:b631r9j587dkl4jko987hgg7bn2kl8a2&query=%22has%20sample%20applications%20for%20the%20most%20popular%20programming%22&sortby=tm&maxpassages=2&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=1
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


## response {#response-el}

Results of handling the search query information on which is given in the [request](#request_params) child tags.

Contains the `date` attribute with the query date and time (UTC) in `<year><month><day>T<hour><minute><second>` format.

It consists of the following sections:

* [General information about search results](#basic-search-info).
* [Misspell / reask section](#misspell-block).
* [Results section](#results-block).

### General information about search results {#basic-search-info}

Tags of the section with general information about search results are given in the table below.

#|
|| **Tags of general information about search results** | **Description** | **Attributes** ||
|| error |
Error description.

Only present if a search query is handled incorrectly (e.g., if the query is empty or parameters are incorrect).

In some cases, the tag is mutually exclusive with other tags of the `response` grouping tag.
| `code`: Error [code](../reference/error-codes.md). ||
|| reqid | Unique ID of the request | Missing. ||
|| found | An estimate of the number of documents found in response to the query
|
`priority`: Service. Possible values:

* `Phrase`
* `Strict`
* `All`
||
|| found-human | A string in the language matching the selected [search type](../operations/registration.md). It shows the number of found documents and contains related information | Missing. ||
|#

### Misspell / reask section {#misspell-block}

Optional. Present if a typo is detected (`misspell`) or fixed (`reask`) in the query.

The section tags are given in the table below.

#|
|| **Misspell / reask section tags** | **Description** | **Attributes** ||
|| misspell |
Grouping.

Contains information about a possible typo in the search query.
| Missing. ||
|| reask |
Grouping.

Contains information about a fix made in the original query before searching for documents.
| Missing.
||
|| rule |
Type of error detected in the query.

Possible values:

* `Misspell`: Typo.
* `KeyboardLayout`: Incorrect keyboard layout.
* `Volapyuk`: Query is made with Russian transliterated into English. Used if the <q>Russian (yandex.ru)</q> value is selected as the [search type](../operations/registration.md#search-type).
| Missing.
||
|| source-text |
Source query text.

Fragment of a search query that might contain an error is selected with the `hlword` tag.
| Missing.
||
|| text-to-show |
Optional (only for the `reask` grouping tag).

Contains the fixed search query text. In most cases, it matches the value provided in the [text](#text) tag.
| Missing.
||
|| text | Fixed search query text | Missing.||
|#

### Results section {#results-block}

Optional. Present if any results are found for a query.

The section tags are given in the table below.

#|
|| **Results section tags** | **Description** | **Attributes**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||
|| results | Grouping. Child tags contain information about search parameters and documents found | Missing. ||
|| grouping |

Grouping. Child tags contain information about search parameters and documents found.

|
Attributes show rules for grouping the documents found.

* `mode`: [Grouping method](post-request.md#post-mode).
* `attr`: Service attribute. Depends on the mode attribute value.
* `groups-on-page`: Number of groups returned per page with search results.
* `docs-in-group`: Number of documents returned per group.
* `curcateg`: Service attribute. Set to `-1`.
||
|| found | An estimate of the number of created groups |
`priority`: Service. Possible values:

* `Phrase`
* `Strict`
* `All`
||
|| found-docs |

An estimate of the number of documents found in response to the query.

It is a more accurate estimate as compared to the value provided in the `found` tag of the section with [general information about search results](#basic-search-info).

|
`priority`: Service. Possible values:

* `Phrase`
* `Strict`
* `All`
||
|| found-docs-human |

{% include [response-el-found-human-description](../../_includes/search-api/found-human-description.md) %}

The provided value must be used when generating search results.

| Missing.
||
|| page | Number of the returned page with search results. Page numbering starts from zero (the first page corresponds to the `0` value).
|
* `first`: Sequence number of the first group with search results displayed on the page.
* `last`: Sequence number of the last group with search results displayed on the page.
||
|| group |
Grouping.

Each `group` tag contains information about the document group found.
| Missing.
||
|| categ | Identification data of the group of documents found.
|
* `attr`: Service attribute. It must match the value [provided in the request](post-request.md#post-attr).
* `name`: Unique group ID.
||
|| doccount |
An estimate of the number of documents used to create the group.

Documents that may be included in the group are ranked based on the query criteria (the `sortby` parameter). Depending on the [docs-in-group](post-request.md#post-docs-in-group) parameter value, from one to three of the first documents are included in the group.
| Missing.
||
|| relevance | Service | `priority`: Service. ||
|| doc |
Grouping.

Each `doc` tag contains information about the document found.

Depending on the [docs-in-group](post-request.md#post-docs-in-group) parameter value, each group may contain from one to three of the `doc` grouping tags.

| `id`: Unique ID of the document found.
||
|| url | URL of the document found | Missing. ||
|| domain | Domain where the found document is hosted | Missing. ||
|| title |
Title of the document found.

Words included in the search query are selected with the `hlword` tag.
| Missing.
||
|| headline |
Optional. Document annotation.

Generated using the `meta` HTML tag with the `name` attribute set to the `description` value.
| Missing.
||
|| modtime |
Date and time of document update in the format:

```no-highlight
<year><month><day>T<hour><minute><second>
```

{% note warning %}

The tag is optional and may be missing in some cases.

{% endnote %}

| Missing.
||
|| size | Size of the found document in bytes | Missing. ||
|| charset | Encoding of the found document | Missing. ||
|| passages | Grouping tag with a list of document passages | Missing. ||
|| passage |
Passage with a document annotation.

Words included in the search query are selected with the `hlword` tag.

The maximum number of passages provided in a single `passages` tag depends on the search query `maxpassages` parameter value.
| Missing.
||
|| mime-type | Document type according to [RFC2046](http://tools.ietf.org/html/rfc2046) | Missing. ||
|| properties | Grouping tag with document properties | Missing. ||
|| _PassagesType |
Passage type. Possible values:

* `0`: Standard passage (made of the document text).
* `1`: Passage based on the link text. Used if the document is found via a link.

| Missing.
||
|| lang |
Optional.

Document language.

| Missing.
||
|| saved-copy-url | URL of the saved document copy | Missing. ||
|#
