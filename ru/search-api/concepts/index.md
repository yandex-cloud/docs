# О сервисе {{ search-api-full-name }}

Сервис {{ search-api-full-name }} предоставляет доступ к русскому, турецкому и мировому типам поиска. Выбор требуемого типа поиска выполняется на этапе [регистрации](../operations/registration.md). Вы можете изменить тип поиска после регистрации.

От типа поиска зависит _формула ранжирования_, в соответствии с которой сортируются результаты поиска, и _поисковая база_ — набор документов, по которому выполняется поиск.

## Запрос результатов поиска

{{ search-api }} поддерживает методы отправки поисковых запросов [GET](get-request.md) и [POST](post-request.md). [Формат ответа](response.md) для этих методов совпадает.

## Лицензионное соглашение {#license}

Дополнительно к правилам использования {{ yandex-cloud }} для каждого типа поиска действует собственное лицензионное соглашение. 

| {{ ui-key.yacloud.component.ip-address-form.label_field-search-type }} | Лицензионное соглашение |
|---|---|
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` | [https://legal.yandex.ru/xml](https://legal.yandex.ru/xml/) |
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}` | [https://legal.yandex.com.tr/xml](https://legal.yandex.com.tr/xml/) ||
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}` | [https://legal.yandex.com/xml](https://legal.yandex.com/xml) ||