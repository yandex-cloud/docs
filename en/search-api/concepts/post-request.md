---
title: "POST requests"
description: "This article describes how to use POST requests."
---

# POST requests

{% note warning %}

Special characters provided as parameter values in the request body should be replaced with respective escaped sequences based on XML encoding. For example, instead of ampersand (`&`), one should use `&amp;`.

{% endnote %}

## Request format {#post-request-format}

```httpget
https://yandex.<domain>/search/xml
  ? [folderid=<folder_ID>]
  & [filter=<filtering_type>]
  & [lr=<search_region_ID>]
  & [l10n=<notification_language>]
```

### Request parameters {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

Provide the API key value in the `Authorization` header. Fore more information, see [Authentication in {{ search-api-name }}](../operations/auth.md).

{% include [filter](../../_includes/search-api/filter.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

## Request body format {#post-request-body}

```xml
<?xml version="1.0" encoding="<XML_file_encoding>"?>
<request>
<!--Grouping_tag-->
  <query>
     <!--Search request text-->
  </query>
  <sortby order="<!--document sorting order-->">
     <!--Search results sorting type-->
  </sortby>
  <groupings>
    <!--Grouping parameters in child tags-->
    <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="1" />
  </groupings>
  <maxpassages>
    <!--maximum number of passages-->
  </maxpassages>
  <page>
    <!--Number of requested search results page-->
  </page>
</request>
```

## Request body parameters {#post-body-parameters}

### Grouping tag <request> {#request}

The `<request>` grouping tag groups all contents of the request body. Child tags contain search query parameters.

{% include [query](../../_includes/search-api/query.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

{% include [passages](../../_includes/search-api/passages.md) %}

{% include [page](../../_includes/search-api/page.md) %}

#### Grouping tag <groupings> {#groupings}

The `groupings` tag brings grouping result parameters together.

##### `Groupby` result grouping {#groupby}

{% include [groupby-description](../../_includes/search-api/groupby-description.md) %}

`groupby` may have the following parameters:

{% include [groupby-description](../../_includes/search-api/groupby-parameters.md) %}

## Sample POST request {#example-post-request}

The URL and request body below return the fifth page of search results for the `<table>` request. The results are sorted by the document editing time – from the newest to the oldest. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Search region: Novosibirsk oblast. A family filter has been applied to the search results. The results are grouped by domain. Each group contains three documents, and the number of groups returned per page is 10. The maximum number of passages per document is 2. {{ search-api-full-name }} returns a UTF-8 encoded XML file.

Request URL:

```httpget
https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&filter=strict&lr=11316&l10n=ru
```

Request body:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<request>
  <query><table></query>
  <sortby order="descending">tm</sortby>
  <maxpassages>2</maxpassages>
  <page>5</page>
  <groupings>
    <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="3" />
  </groupings>
</request>
```
