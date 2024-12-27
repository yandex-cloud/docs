---
title: HTML format of {{ search-api-full-name }}'s response to a text query
description: This article describes the HTML format of {{ search-api-name }}'s response to a text search query.
---

# HTML format of response to a text search query

In response to a text search query, {{ search-api-name }} can return an HTML file with search results. The returned HTML file is identical to the HTML page with the same search results you get on the [Yandex Search]({{ link-yandex }}) home page in [incognito mode](https://en.wikipedia.org/wiki/Private_browsing).

A query result in HTML format contains more data than the result of a similar query in [XML format](./response.md): the HTML result includes ads, quick responses, and other elements which may appear in search results. The HTML response format is regularly updated together with the format of Yandex Search results.

The service returns an HTML response for text queries processed both via [API v1](./index.md#api-v1) and [API v2](./index.md#api-v2).

See the [example](https://{{ s3-storage-host-doc-files }}/search-api-html-result-example.html) of HTML search results.

{% note info %}

You can get a maximum of 1,000 search results per search query. Depending on the [docs-in-group](post-request.md#post-docs-in-group) attribute value, each result may contain one to three documents. The maximum number of search results pages depends on the number of groups of documents per page, which is defined by the [groups-on-page](post-request.md#post-groups-on-page) attribute. For example, if the `groups-on-page` attribute is set to `10`, a maximum of 100 pages with search results can be generated.

{% endnote %}