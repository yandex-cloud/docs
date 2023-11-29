# About {{ search-api-full-name }}

{{ search-api-full-name }} provides access to the Russian, Turkish, and international search types. The required search type is selected at the [registration](../operations/registration.md) stage. You can change the search type after registration.

With {{ search-api-full-name }}, you can get default search results and those optimized for [mobile devices](../operations/mobile.md).

The search type determines the search result _ranking formula_ and the _search database_, i.e., the documents that are searched through.

## Request for search results

{{ search-api }} supports [GET](get-request.md) and [POST](post-request.md) methods for sending search queries. They have the same [response format](response.md).

## Service Terms of Use and License Agreement {#license}

In addition to the {{ yandex-cloud }} Terms of Use, the following Terms of Use apply to {{ search-api-name }}:

* [{{ search-api-full-name }} Terms of Use](https://yandex.ru/legal/cloud_terms_search_api) for residents of Russia or Kazakhstan
* [{{ search-api-full-name }} Terms of Use](https://yandex.com/legal/cloud_terms_search_api) for non-residents of Russia and Kazakhstan

Individual license agreements for each type of search are valid until October 31, 2023, and only apply to users who started using Yandex.XML before September 12, 2023.

| {{ ui-key.yacloud.component.ip-address-form.label_field-search-type }} | License agreement |
|---|---|
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` | [https://legal.yandex.ru/xml](https://legal.yandex.ru/xml/) |
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}` | [https://legal.yandex.com.tr/xml](https://legal.yandex.com.tr/xml/) |
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}` | [https://legal.yandex.com/xml](https://legal.yandex.com/xml) |