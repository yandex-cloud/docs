Чтобы воспользоваться поиском, при [регистрации в сервисе](../../search-api/operations/registration.md) укажите список IP-адресов, с которых будут выполняться запросы к сервису, и выберите нужный тип поиска. В зависимости от выбранного типа поиска указывайте в запросе подходящее имя домена:
* `yandex.ru` — для типа поиска `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}`;
* `yandex.com.tr` — для типа поиска `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}`;
* `yandex.com` — для типа поиска `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}`.

Для выполнения запросов необходим [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../search-api/security/index.md#search-api-executor) `search-api.executor` и созданный для него [API-ключ](../../iam/concepts/authorization/api-key.md).