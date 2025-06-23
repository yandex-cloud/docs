To use the search, when signing up for the service, specify the list of IP addresses you will use to run queries to the service and select the appropriate search type. Based on the selected search type, specify the appropriate domain name in your query:
* `yandex.ru`: For the `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` search type.
* `yandex.com.tr`: For the `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}` search type.
* `yandex.com`: For the `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}` search type.

To run queries, you need a [service account](../../iam/concepts/users/service-accounts.md) with the `search-api.executor` [role](../../search-api/security/index.md#search-api-executor) and an [API key](../../iam/concepts/authorization/api-key.md) created for it.