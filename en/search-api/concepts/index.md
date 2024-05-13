# About {{ search-api-full-name }}

{{ search-api-full-name }} allows you to automatically send requests to the Yandex search database and get responses in XML format. The service is tailored for developers and webmasters.

With {{ search-api-name }}, you can easily implement the search feature on individual websites, groups of websites, or across the internet, or create an application with built-in search features. Additionally, it offers features to monitor website ranking for specific queries in Yandex search results.

{{ search-api }} text search supports the [GET](get-request.md) and [POST](post-request.md) methods for sending search queries. They have the same [response format](response.md). {{ search-api }} [image search](./pic-search.md) only supports the GET method for sending search queries.

When [signing up](../operations/registration.md) for {{ search-api-name }}, you need to select one of the three available types of text search: `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}`, `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}`, or `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}`. The search type determines the search result _ranking formula_ and the _search database_, i.e., the documents covered by the search. Once signed up, you will be able to change the selected search type.

With {{ search-api-name }}, you can get default search results and those optimized for [mobile devices](../operations/mobile.md).

