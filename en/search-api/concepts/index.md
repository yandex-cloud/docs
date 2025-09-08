---
title: '{{ search-api-full-name }} description and features'
description: From this section you will learn what {{ search-api-name }} is, what tools and features it provides, and what challenges it can be up to.
---

# About {{ search-api-full-name }}

With {{ search-api-full-name }}, you can automatically submit queries to the Yandex search database and get your search results. The service is tailored for developers and webmasters.

With {{ search-api-name }}, you can easily implement the search feature on individual websites, groups of websites, or across the internet, or create an application with built-in search features. Additionally, it offers features to monitor website ranking for specific queries in Yandex search results. {{ search-api-name }} enables [text](./web-search.md) and [image](./image-search.md) search, where you can customize search parameters, optimize results for specific devices, and select the output format. 

In {{ search-api-name }}, you can run queries in synchronous and deferred (asynchronous) modes. In synchronous mode, you will get the results immediately once your query is processed. In synchronous mode, you will get a response with minimum delay, but not instantly: processing takes some time. In asynchronous mode, in response to a query, you will get the [`Operation` object](../../api-design-guide/concepts/operation.md) with the ID of the operation in progress. You can use this ID to find out the query status and later get the result.

{{ search-api-name }} provides two interfaces for queries: API v2 and API v1. 

## API v2 {#api-v2}

[API v2](../operations/web-search.md) is an interface natively integrated into the [{{ yandex-cloud }} ecosystem](../../overview/concepts/services.md). API v2 is designed based on the gRPC mechanism and allows sending text queries using gRPC calls or the `POST` method in [synchronous](../operations/web-search-sync.md) and [deferred](../operations/web-search.md) modes. You can get the result in [XML](./response.md) or [HTML](./html-response.md) formats. Search results are generated in default format or optimized for [mobile devices](../operations/v2-mobile.md).

With the API v2 interface, you can use text queries to [search](../operations/search-images.md) for images. [Image search](image-search.md) is only available in synchronous mode.

You can also use API v2 for text search in combination with [{{ yagpt-name }}](../../foundation-models/concepts/generation/index.md) generative features. This gets you a single concise and coherent [generative response](./generative-response.md) to produce which the neural network analyzes the relevant results of the {{ search-api-name }}'s text search across websites.

With API v2, you set the search type directly in the [body](./web-search.md#parameters) of each query. You need a {{ yandex-cloud }} [user](../../iam/concepts/users/accounts.md) or [service](../../iam/concepts/users/service-accounts.md) account and [authentication data](../api-ref/authentication.md) to send queries. You do not need to specify trusted IP addresses when using API v2.

## API v1 {#api-v1}

{% include [api-v1](../../_includes/search-api/api-v1.md) %}

API v1 is a Yandex XML compatible interface. API v1 allows you to [run](../operations/searching.md) text queries using the GET and POST methods and get your results in XML or HTML format. Only synchronous mode is supported.

With {{ search-api-name }} API v1, you can choose between default search and search optimized for mobile devices. You can also use API v1 to search for images based on a text query. Image database search is only available via the `GET` method.
