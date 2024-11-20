---
title: GET requests via {{ search-api-full-name }}'s API v1
description: This article describes the specificities and format of GET requests when accessing {{ search-api-name }} via API v1.
---

# GET requests

With {{ search-api-name }}'s API v1, you can run requests with preset parameters to the Yandex search database. You can submit search parameters to the service as an HTTP request using the GET method. {{ search-api-name }} generates a response as an [XML](./response.md) or [HTML](./html-response.md) document.

{% include [text-search-intro](../../_includes/search-api/text-search-intro.md) %}

## Request format {#get-request-format}

{% note warning %}

If you have any special characters in parameter values, replace them with the respective escaped sequences based on percent-encoding. For example, instead of the equals sign (`=`), use `%3D`.

{% endnote %}

The URL of your request to {{ search-api-name }} will be different depending on the format you want to get the result in: XML or HTML.

{% list tabs group=search_api_request %}

- XML {#xml}

  ```httpget
  https://yandex.<domain>/search/xml
    ? [folderid=<folder_ID>]
    & [apikey=<API_key>]
    & [query=<search_query_text>]
    & [lr=<search_region_ID>]
    & [l10n=<notification_language>]
    & [sortby=<sorting_type>]
    & [filter=<filtering_type>]
    & [maxpassages=<number_of_passages>]
    & [groupby=<result_grouping_options>]
    & [page=<page_number>]
  ```

- HTML {#html}

  ```httpget
  https://yandex.<domain>/search/xml/html
    ? [folderid=<folder_ID>]
    & [apikey=<API_key>]
    & [query=<search_query_text>]
    & [lr=<search_region_ID>]
    & [l10n=<notification_language>]
    & [sortby=<sorting_type>]
    & [filter=<filtering_type>]
    & [maxpassages=<number_of_passages>]
    & [groupby=<result_grouping_options>]
    & [page=<page_number>]
  ```

{% endlist %}

### Request parameters {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

{% include [query](../../_includes/search-api/query.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

The format is as follows: `sortby=<sorting_type>.order%3D<sorting_order>`. For example, for reverse sorting by date, use `sortby=tm.order%3Dascending`.

{% include [filter](../../_includes/search-api/filter.md) %}

{% include [passages](../../_includes/search-api/passages.md) %}

#### Rules for grouping results {#groupby}

{% include [groupby-description](../../_includes/search-api/groupby-description.md) %}

Dot-separated parameters are specified in the following format:

```httpget
attr%3D<service_attribute>.mode%3D<grouping_type>.groups-on-page%3D<number_of_groups_per_page>.docs-in-group%3D<number_of_documents_per_group>
```

Where:

{% include [groupby-description](../../_includes/search-api/groupby-parameters.md) %}

{% include [page](../../_includes/search-api/page.md) %}

## GET request example  {#example-get-request}

The request below returns the fifth page of search results for the `<table>` query. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Search region: Novosibirsk Oblast. Notification language: Russian. The **Family search** filter is applied to the search results. The number of passages is three. The results are grouped by domain and sorted by relevance. Each group contains three documents, and the number of groups returned per page is five.

The URL of your request to {{ search-api-name }} will be different depending on the format you want to get the result in: XML or HTML.

{% list tabs group=search_api_request %}

- XML {#xml}

  ```httpget
  https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&l10n=ru&sortby=rlv&filter=strict&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=4
  ```

- HTML {#html}

  ```httpget
  https://yandex.ru/search/xml/html?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&l10n=ru&sortby=rlv&filter=strict&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=4
  ```

{% endlist %}

#### See also {#see-also}

* [{#T}](./response.md)
* [{#T}](./html-response.md)
* [{#T}](../operations/searching.md)