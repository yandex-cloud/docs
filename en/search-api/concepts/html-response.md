---
title: HTML format of a {{ search-api-full-name }} response for a text query
description: This article describes the HTML format of a response returned by {{ search-api-name }} for a text search query.
---

# HTML format of a text search response

In response to a text search query, {{ search-api-name }} can return an HTML file with search results. This file is identical to the HTML page of the corresponding search results on the [Yandex Search]({{ link-yandex }}) home page.

Currently, you can get an HTML response only to queries submitted via the [API v1](./index.md#api-v1).

Currently, response in HTML format is only available for queries made via the [API v1](./index.md#api-v1).

A query result in HTML format contains more data than the result of a similar query in [XML format](./response.md): the HTML result includes ads, quick responses, and other elements which may appear in search results. The HTML response format is regularly updated together with the format of Yandex Search results.

See the [example](https://{{ s3-storage-host-doc-files }}/search-api-html-result-example.html) of HTML search results.

{% note info %}

You can get a maximum of 1,000 search results per search query. Depending on the [docs-in-group](post-request.md#post-docs-in-group) attribute value, each result may contain one to three documents. The maximum number of search results pages depends on the number of groups of documents per page, which is defined by the [groups-on-page](post-request.md#post-groups-on-page) attribute. For example, if the `groups-on-page` attribute is set to `10`, a maximum of 100 pages with search results can be generated.

{% endnote %}