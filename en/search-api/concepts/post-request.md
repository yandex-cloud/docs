---
title: POST requests via {{ search-api-full-name }}'s API v1
description: This article describes the specificities and format of POST requests when accessing {{ search-api-name }} via API v1.
---

# POST requests

With the {{ search-api-name }} API v1, you can run requests with preset parameters to the Yandex search database. You can submit search parameters to the service as an HTTP request using the POST method. {{ search-api-name }} will return a response as an [XML](./response.md) or [HTML](./html-response.md) document.

{% include [text-search-intro](../../_includes/search-api/text-search-intro.md) %}

## Request format {#post-request-format}

{% note warning %}

If you have any special characters in the parameter values provided in the request body, replace them with the respective escaped sequences based on the XML encoding. For example, use `&amp;` for ampersand (`&`).

{% endnote %}

The URL of your request to {{ search-api-name }} and the list of supported parameters will be different depending on the format you want the result in: XML or HTML.

{% list tabs group=search_api_request %}

- XML {#xml}

  ```httpget
  https://yandex.<domain>/search/xml
    ? [folderid=<folder_ID>]
    & [filter=<filtering_type>]
    & [lr=<search_region_ID>]
    & [l10n=<notification_language>]
  ```

- HTML {#html}

  ```httpget
  https://yandex.<domain>/search/xml/html
    ? [folderid=<folder_ID>]
    & [filter=<filtering_type>]
    & [lr=<search_region_ID>]
  ```

{% endlist %}

### Request parameters {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

[Provide](../operations/auth.md) the API key value in the `Authorization` header in the following format:

```yaml
Authorization: Api-Key <API_key>
```

{% include [filter](../../_includes/search-api/filter.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

## Request body format {#post-request-body}

{% include [xml-html-fields-differ-notice](../../_includes/search-api/xml-html-fields-differ-notice.md) %}

```xml
<?xml version="1.0" encoding="<XML_file_encoding>"?>
<request>
<!--Grouping tag-->
  <query>
     <!--Search query text-->
  </query>
  <sortby order="<!--Sorting order of documents-->">
     <!--Search result sorting type-->
  </sortby>
  <groupings>
    <!--Grouping parameters in child tags-->
    <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="1" />
  </groupings>
  <maxpassages>
    <!--Maximum number of passages-->
  </maxpassages>
  <page>
    <!--Number of the requested search results page-->
  </page>
</request>
```

## Request body parameters {#post-body-parameters}

### Grouping tag: <request> {#request}

The `<request>` grouping tag integrates all contents of the request body. Child tags contain search query parameters.

{% include [query](../../_includes/search-api/query.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

{% include [passages](../../_includes/search-api/passages.md) %}

{% include [page](../../_includes/search-api/page.md) %}

#### Grouping tag: <groupings> {#groupings}

The `groupings` grouping tag integrates the result grouping parameters.

##### Groupby result grouping {#groupby}

{% include [groupby-description](../../_includes/search-api/groupby-description.md) %}

Possible `groupby` parameters:

{% include [groupby-description](../../_includes/search-api/groupby-parameters.md) %}

## POST request example {#example-post-request}

The URL and request body presented below return the fifth page of search results for the `<table>` query. The results are sorted by the document editing time, from the newest to the oldest. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Search region: Novosibirsk Oblast. The **Family search** filter is applied to the search results. The results are grouped by domain. Each group contains three documents, and the number of groups returned per page is 10. The maximum number of passages per document is 2. {{ search-api-full-name }} returns a UTF-8 encoded XML file.

The URL of your request to {{ search-api-name }} and the list of supported parameters will be different depending on the format you want the result in: XML or HTML.

{% list tabs group=search_api_request %}

- XML {#xml}

  ```httpget
  https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&filter=strict&lr=11316&l10n=ru
  ```

- HTML {#html}

  ```httpget
  https://yandex.ru/search/xml/html?folderid=b1gt6g8ht345********&filter=strict&lr=11316
  ```

{% endlist %}

Request body:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<request>
  <query><table></query>
  <sortby order="descending">tm</sortby>
  <maxpassages>2</maxpassages>
  <page>4</page>
  <groupings>
    <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="3" />
  </groupings>
</request>
```

#### See also {#see-also}

* [{#T}](./response.md)
* [{#T}](./html-response.md)
* [{#T}](../operations/searching.md)