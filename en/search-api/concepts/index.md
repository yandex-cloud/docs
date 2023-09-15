# About {{ search-api-full-name }}

{{ search-api-full-name }} provides access to the Russian, Turkish, and international search types. The required search type is selected at the [registration](../operations/registration.md) stage. You can change the search type after registration.

The search type determines the search result _ranking formula_ and the _search database_, a set of documents a search is made across.

## Request for search results

{{ search-api }} supports [GET](get-request.md) and [POST](post-request.md) methods for sending search queries. They have the same [response format](response.md).

## License agreement {#license}

In addition to the {{ yandex-cloud }} terms of use, each search type has its own license agreement.

| {{ ui-key.yacloud.component.ip-address-form.label_field-search-type }} | License agreement |
|---|---|
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` | [https://legal.yandex.ru/xml](https://legal.yandex.ru/xml/) |
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}` | [https://legal.yandex.com.tr/xml](https://legal.yandex.com.tr/xml/) |
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}` | [https://legal.yandex.com/xml](https://legal.yandex.com/xml) |