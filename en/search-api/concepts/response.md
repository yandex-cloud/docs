# Text search response format

In response to a text search query, {{ search-api }} returns an XML file encoded in [UTF-8](https://en.wikipedia.org/wiki/UTF-8) containing the search results.

{% note alert %}

You can get a maximum of 1,000 search results per search query. Depending on the [docs-in-group](post-request.md#post-docs-in-group) attribute value, each result may contain one to three documents. The maximum number of search results pages depends on the number of groups of documents per page, which is defined by the [groups-on-page](post-request.md#post-groups-on-page) attribute. For example, if the `groups-on-page` attribute is set to `10`, a maximum of 100 pages with search results can be generated.

{% endnote %}

Files consist of grouping tags such as [request](#request-el) (aggregate information on search query parameters) and [response](#response-el) (search query handling results).

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
   <error code="15">No matches found for your search query</error>
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
               <title>&quot;<hlword>Yandex</hlword>&quot; is a search engine and a web portal</title>
               <headline>Search accross the internet based on the user region.</headline>
               <modtime>20060814T040000</modtime>
               <size>26938</size>
               <charset>utf-8</charset>
               <passages>
                  <passage><hlword>Yandex</hlword> is a search engine that can, at your request,...</passage>
               </passages>
               <properties>
                   <_PassagesType>0</_PassagesType>
                   <lang>ru</lang>
               </properties>
               <mime-type>text/html</mime-type>
               <saved-copy-url>https://hghltd.yandex.net/yandbtm?text=yandex&url=https%3A%2F%2Fwww.yandex.ru%2F&fmode=inject&mime=html&l10n=ru&sign=e3737561fc3d1105967d1ce6********&keyno=0</saved-copy-url>
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
|| **`request` group tags** | **Description** | **Attributes** ||
|| query | Text of the sent search query | N/A ||
|| page | Number of the returned page with search results. Page numbering starts from zero (the `0` value stands for page 1). | N/A ||
|| sortby |
Result sorting parameters. The possible values include:

* `rlv`: By relevance.
* `tm`: By document update time.
|
* `order`: Sorting order. The default value is `descending`. When sorting by update time, the parameter may take the `ascending` value.
* `priority`: This is a service attribute set to `no`.
||
|| maxpassages | Maximum number of passages that can be provided per search result | N/A||
|| groupings |

Contains grouping parameters in the `groupby` tag
| N/A ||
|| groupby | Parameters for grouping found search results |
* `mode`: [Grouping method](post-request.md#groupby).
* `attr`: Service attribute.
* `groups-on-page`: Maximum number of groups that can be returned per page with search results.
* `docs-in-group`: Maximum number of documents that can be returned per group. Any group may contain fewer documents than set by this parameter.
* `curcateg`: Service attribute which takes the `-1` value.
||
|#

The example below shows the contents of the `request` grouping tag returned in response to a query:

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

* [General information about search results](#basic-search-info)
* [`misspell / reask` section](#misspell-block)
* [`results` section](#results-block)

#### General information about search results {#basic-search-info}

The table below lists the tags used in the appropriate section.

#|
|| **Tags for general information about search results** | **Description** | **Attributes** ||
|| error |
Error description.

Used only if a search query is handled incorrectly (e.g., if the query is empty or parameters are incorrect).

In some cases, the tag is mutually exclusive with other tags of the `response` grouping tag.
| `code`: Error [code](../reference/error-codes.md) ||
|| reqid | Unique ID of the request | N/A ||
|| found | Estimated number of documents found in response to the query
|
`priority`: Service attribute. The possible values include:

* `phrase`
* `strict`
* `all`
||
|| found-human | String in the language matching the selected [search type](../operations/registration.md). It shows the number of found documents and contains related information. | N/A ||
|#

#### misspell / reask {#misspell-block}

This section is optional and is only used if a typo is detected (`misspell`) or fixed (`reask`) in the query.

The table below lists the tags for this section.

#|
|| **Misspell / reask section tags** | **Description** | **Attributes** ||
|| misspell |
This is a grouping tag.

It contains information about a possible typo in the search query.
| Missing ||
|| reask |
This is a grouping tag.

It contains information about a fix made in the original query before searching for documents.
| Missing
||
|| rule |
Type of error detected in the query.

The possible values include:

* `Misspell`: Typo
* `KeyboardLayout`: Incorrect keyboard layout
* `Volapyuk`: Query is made in Russian transliterated into English. It is used if `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }} (yandex.ru)` is selected for [search type](../operations/registration.md#search-type).
| Missing
||
|| source-text |
Source query text.

The `hlword` tag is added to a fragment of a search query that might contain an error.
| Missing
||
|| text-to-show |
This tag is optional and used only for the `reask` grouping tag.

It contains the fixed search query text. In most cases, it matches the value provided in the [text](#text) tag.
| Missing
||
|| text | Fixed search query text | N/A ||
|#

#### results {#results-block}

This section is optional and only used if any results are found for a query.

The table below lists the tags for this section.

#|
|| **Results section tags** | **Description** | **Attributes**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ||
|| results | This is a grouping tag. Child tags contain information about search parameters and found documents. | N/A ||
|| grouping |

This is a grouping tag. Child tags contain information about search parameters and found documents.

|
The following attributes show rules for grouping the found documents:

* `mode`: [Grouping method](post-request.md#groupby).
* `attr`: Service attribute that depends on the `mode` attribute value.
* `groups-on-page`: Number of groups returned per page with search results.
* `docs-in-group`: Number of documents returned per group.
* `curcateg`: Service attribute which takes the `-1` value.
||
|| found | Estimate of the number of created groups |
`priority`: Service attribute. The possible values include:

* `phrase`
* `strict`
* `all`
||
|| found-docs |

Estimate of the number of documents found in response to the query.

It is a more accurate estimate as compared to the value provided in the `found` tag of the [general information about search results](#basic-search-info).

|
`priority`: Service attribute. The possible values include:

* `phrase`
* `strict`
* `all`
||
|| found-docs-human |

{% include [response-el-found-human-description](../../_includes/search-api/found-human-description.md) %}

The value being provided must be used when generating search results.

| Missing
||
|| page | Number of the returned page with search results. Page numbering starts from zero (the `0` value stands for page 1).
|
* `first`: Number of the first group with search results displayed on the page.
* `last`: Number of the last group with search results displayed on the page.
||
|| group |
This is a grouping tag.

Each `group` tag contains information about the found document group.
| Missing
||
|| categ | Identification data of the group of found documents.
|
* `attr`: Service attribute that must match the value [provided in the request](post-request.md#post-attr).
* `name`: Unique group ID.
||
|| doccount |
Estimate of the number of documents used to create the group.

Documents that qualify to be included into the group are ranked based on the query conditions provided in the `sortby` parameter. Depending on the [docs-in-group](post-request.md#post-docs-in-group) parameter value, from one to three of the first documents are included into the group.
| Missing
||
|| relevance | This is a service parameter. | `priority`: Service attribute. ||
|| doc |
This is a grouping tag.

Each `doc` tag contains information about the found document.

Depending on the [docs-in-group](post-request.md#post-docs-in-group) parameter value, each group may contain from one to three of the `doc` grouping tags.

| `id`: Unique ID of the found document.
||
|| url | URL of the found document | N/A ||
|| domain | Domain where the found document is hosted | N/A ||
|| title |
Title of the found document.

Words included in the search query are highlighted with the `hlword` tag.
| Missing
||
|| headline |
This is an optional tag that stands for document annotation.

It is generated using the `meta` HTML tag with the `name` attribute set to the `description` value.
| Missing
||
|| modtime |
Date and time of document update in the following format:

```no-highlight
<year><month><day>T<hour><minute><second>
```

{% note warning %}

This tag is optional and may be missing in some cases.

{% endnote %}

| Missing
||
|| size | Size of the found document, in bytes | N/A ||
|| charset | Encoding of the found document | N/A ||
|| passages | Grouping tag with a list of document passages | N/A ||
|| passage |
Passage with a document annotation.

Words included in the search query are highlighted with the `hlword` tag.

The maximum number of passages provided in a single `passages` tag depends on the search query `maxpassages` parameter value.
| Missing
||
|| mime-type | Document type according to [RFC2046](http://tools.ietf.org/html/rfc2046) | N/A ||
|| properties | Grouping tag with document properties | N/A ||
|| _PassagesType |
Passage type. The possible values include:

* `0`: Regular passage (made of the document text).
* `1`: Passage based on the link text. Used if the document is found via a link.

| Missing
||
|| lang |
This tag is optional.

It determines the document language.

| Missing
||
|| saved-copy-url | URL of the saved document copy | N/A ||
|#

#### See also {#see-also}

* [{#T}](./get-request.md)
* [{#T}](./post-request.md)
* [{#T}](../operations/searching.md)