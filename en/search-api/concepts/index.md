---
title: '{{ search-api-full-name }} description and features'
description: From this section you will learn what {{ search-api-name }} is, what tools and features it provides, and what challenges it can be up to.
---

# About {{ search-api-full-name }}

With {{ search-api-full-name }}, you can automatically submit queries to the Yandex search database and get your search results. The service is tailored for developers and webmasters.

With {{ search-api-name }}, you can easily implement the search feature on individual websites, groups of websites, or across the internet, or create an application with built-in search features. Additionally, it offers features to monitor website ranking for specific queries in Yandex search results.

{{ search-api-name }} provides two interfaces for queries: API v1 and API v2.

## API v1 {#api-v1}

[API v1](./get-request.md) is a Yandex XML compatible interface. It allows you to [run](../operations/searching.md) text queries using the [GET](../concepts/get-request.md) and [POST](../concepts/post-request.md) methods and get your results in [XML](./response.md) or [HTML](./html-response.md) format in synchronous mode.

With {{ search-api-name }} API v1, you can choose between default search and search optimized for [mobile devices](../operations/mobile.md).

In addition to various text search options, API v1 allows you to search for images based on a text query. [Image search](./pic-search.md) only supports the GET method for queries.

To use the API v1 interface, you must [register](../operations/workaround.md) in {{ search-api-name }}:
* Make a list of trusted IP addresses you are going to use to submit search queries.
* Select one of the three available text search types:

    * `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}`
    * `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}`
    * `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}`

    The search type determines the search result _ranking formula_ and the _search database_, i.e., the documents covered by the search.
    
After registration, you can change your search type and trusted IP addresses at any time.

## API v2 {#api-v2}

[API v2](../operations/web-search.md) is an interface natively integrated into the [{{ yandex-cloud }} ecosystem](../../overview/concepts/services.md). It allows you to run text queries using the `POST` method and get your results in [XML](./response.md) or [HTML](./html-response.md) format in [synchronous](../operations/web-search-sync.md) or [deferred](../operations/web-search.md) (asynchronous) mode.

With API v2, you set the search type directly in the [body](./web-search.md#parameters) of each query. You do not need to [register](../operations/workaround.md#registration) in {{ search-api-full-name }} or specify trusted IP addresses when using API v2.

With {{ search-api-name }} v2, you can choose between default search and search optimized for [mobile devices](../operations/v2-mobile.md).

You can also use API v2 for text search in combination with [{{ yagpt-name }}](../../foundation-models/concepts/yandexgpt/index.md) generative features. This gets you a single concise and coherent [generative response](./generative-response.md) to produce which the neural network analyzes the relevant results of the {{ search-api-name }}'s text search across websites.

