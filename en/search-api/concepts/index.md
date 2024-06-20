# About {{ search-api-full-name }}

{{ search-api-full-name }} allows you to automatically send requests to the Yandex search database and get responses in XML format. The service is tailored for developers and webmasters.

With {{ search-api-name }}, you can easily implement the search feature on individual websites, groups of websites, or across the internet, or create an application with built-in search features. Additionally, it offers features to monitor website ranking for specific queries in Yandex search results.

{{ search-api }} text search supports the [GET](get-request.md) and [POST](post-request.md) methods for sending search queries. They have the same [response format](response.md). {{ search-api }} [image search](./pic-search.md) only supports the GET method for sending search queries.

You can also use text search together with [{{ yagpt-name }}](../../foundation-models/concepts/yandexgpt/index.md) generative AI to get a concise and clear [generative response](./generative-response.md) to a user query. To generate such a response, the model analyzes the relevant text search results retrieved by {{ search-api-name }} from your company's websites. This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage and available upon request. To get access, fill out [this form](#contact-form).

With {{ search-api-name }}, you can get default search results and those optimized for [mobile devices](../operations/mobile.md).

Apart from various text search options, {{ search-api-name }} allows you to [search for images](pic-search.md) based on a text query.

When [signing up](../operations/workaround.md) for {{ search-api-name }}, you need to select one of the three available types of text search: `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}`, `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}`, or `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}`. The search type determines the search result _ranking formula_ and the _search database_, i.e., the documents covered by the search. Once signed up, you will be able to change the selected search type.


