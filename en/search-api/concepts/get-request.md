---
title: "GET requests"
description: "This article describes how to use GET requests."
---

# GET requests

{% note warning %}

Special characters provided as parameter values should be replaced with the respective escaped sequences based on percent-encoding. For example, instead of the equals sign (`=`), one should use `%3D`.

{% endnote %}

## Request format {#get-request-format}

```httpget
https://yandex.<domain>/search/xml
  ? [folderid=<folder_ID>]
  & [apikey=<API_key>]
  & [query=<search_query_text>]
  & [lr=<search_region_ID>]
  & [l10n=<notification_language>]
  & [sortby=<sorting_type>]
  & [filter=<filtering_type>]
  & [maxpassages=<passage_count>]
  & [groupby=<result_grouping_parameters>]
  & [page=<page_number>]
```

### Request parameters {#parameters}

{% include [name-and-key](../../_includes/search-api/key.md) %}

{% include [query](../../_includes/search-api/query.md) %}

{% include [lr](../../_includes/search-api/lr.md) %}

{% include [l10n](../../_includes/search-api/l10n.md) %}

{% include [sortby](../../_includes/search-api/sortby.md) %}

The format is as follows: `sortby=<sorting type>.order%3D<sorting order>`. For example, for reverse sorting by date, use `sortby=tm.order%3Dascending`.

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

## Sample GET request {#example-get-request}

The following request returns the fifth page of search results for the `<table>` request. The search type is `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Search region: Novosibirsk oblast. Notification language: Russian. A family filter has been applied to the search results. Number of passages: Three. Results are grouped by domain and sorted by relevance. Each group contains three documents, and the number of groups returned per page is five.

```httpget
https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&l10n=ru&sortby=rlv&filter=strict&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=5
```
