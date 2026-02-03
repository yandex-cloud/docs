---
title: '{{ search-api-full-name }} description and features'
description: From this section you will learn what {{ search-api-name }} is, what tools and features it provides, and what challenges it can be up to.
---

# About {{ search-api-full-name }}

With {{ search-api-full-name }}, you can automatically submit queries to the Yandex search database and get your search results. The service is tailored for developers and webmasters.

With {{ search-api-name }}, you can easily implement the search feature on individual websites, groups of websites, or across the internet, or create an application with built-in search features. Additionally, it offers features to monitor website ranking for specific queries in Yandex search results. This is a flexible [text](./web-search.md) and [image](./image-search.md) search tool, where you can customize search parameters, optimize results for specific devices, select the output format, and get search query statistics and change dynamics by regions of Russia.

In {{ search-api-name }}, you can run queries in synchronous and deferred (asynchronous) modes. In synchronous mode, you will get the results immediately once your query is processed. In synchronous mode, you will get a response with minimum delay, but not instantly: processing takes some time. In asynchronous mode, in response to a query, you will get the [`Operation` object](../../api-design-guide/concepts/operation.md) with the ID of the operation in progress. You can use this ID to find out the query status and later get the result.


## API {#api-v2}

[API](../operations/web-search.md) is an interface natively integrated into the [{{ yandex-cloud }} ecosystem](../../overview/concepts/services.md). API is designed based on the gRPC mechanism and allows sending text queries using gRPC calls or the `POST` method in [synchronous](../operations/web-search-sync.md) and [deferred](../operations/web-search.md) modes. You can get the result in [XML](./response.md) or [HTML](./html-response.md) formats. Search results are generated in default format or optimized for [mobile devices](../operations/v2-mobile.md).

With the API, you can use text queries to [search](../operations/search-images.md) for images. [Image search](image-search.md) is only available in synchronous mode.

You can also use the API for text search in combination [{{ yagpt-name }}](../../ai-studio/concepts/generation/index.md)'s generative features. This gives you a single concise and coherent [generative response](./generative-response.md) to generate which the neural network analyzes relevant {{ search-api-name }} text search results across websites.

Another feature of {{ search-api-name }} is [{{ wordstat-name }}](./wordstat.md), a tool that gives you statistics on Yandex search queries. {{ wordstat-name }} is available via the API, in synchronous mode only. The web version of the tool is available on the [Wordstat website](https://wordstat.yandex.ru/).

With API, you set the search type directly in the [body](./web-search.md#parameters) of each query. You need a {{ yandex-cloud }} [user](../../iam/concepts/users/accounts.md) or [service](../../iam/concepts/users/service-accounts.md) account and [authentication data](../api-ref/authentication.md) to send queries. You do not need to specify trusted IP addresses when using API.

## {{ ml-sdk-full-name }} {#sdk}

{{ ai-studio-full-name }} provides [{{ ml-sdk-full-name }}](../../ai-studio/sdk/index.md), a library of tools and code examples for Python development. {{ ml-sdk-name }} employs a standardized method of working with {{ search-api-name }} and simplifies integration with other {{ ai-studio-full-name }} services.

The {{ ml-sdk-name }} library implements the synchronous and asynchronous Python interfaces based on gRPC API calls of {{ search-api-name }} and [{{ ai-studio-name }}](../../ai-studio/index.yaml) services. For the full list of supported functions, library source code, and use cases, visit [this GitHub repository](https://github.com/yandex-cloud/yandex-cloud-ml-sdk).

For more information about {{ ml-sdk-full-name }}, see [this {{ ai-studio-name }} guide](../../ai-studio/sdk/index.md).