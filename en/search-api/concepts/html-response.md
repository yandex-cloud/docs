---
title: HTML format of {{ search-api-full-name }}'s response to a text query
description: This article describes the HTML format of {{ search-api }}'s response to a text search query.
---

# HTML format of response to a text search query

In response to a text search query, {{ search-api }} can return an HTML file with search results identical to the HTML page with the same search results you get on the [Yandex Search]({{ link-yandex }}) home page.

{% note alert %}

You can get a maximum of 1,000 search results per search query. Depending on the [docs-in-group](post-request.md#post-docs-in-group) attribute value, each result may contain one to three documents. The maximum number of search results pages depends on the number of groups of documents per page, which is defined by the [groups-on-page](post-request.md#post-groups-on-page) attribute. For example, if the `groups-on-page` attribute is set to `10`, a maximum of 100 pages with search results can be generated.

{% endnote %}