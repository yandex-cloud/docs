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

You can get a maximum of 1,000 search results per search query. You can specify the number of search results per page in the [groupsOnPage](./web-search#parameters) field. For example, if the `groupsOnPage` field is set to `10`, no more than 100 search result pages can be generated, and if the field is set to `50`, no more than 20 pages can be generated. You can set the number of search results per page only in the [API v2](./index.md#api-v2) interface.

{% endnote %}

#### See also {#see-also}

* [{#T}](../operations/web-search-sync.md)
* [{#T}](../operations/web-search.md)
* [{#T}](./web-search.md)