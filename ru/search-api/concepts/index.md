# О сервисе {{ search-api-full-name }}

Сервис {{ search-api-full-name }} предоставляет доступ к русскому, турецкому и мировому типам поиска. Выбор требуемого типа поиска выполняется на этапе [регистрации](../operations/registration.md). Вы можете изменить тип поиска после регистрации.

{{ search-api-full-name }} дает возможность получать результаты поиска по умолчанию и поиска, оптимизированного для [мобильных устройств](../operations/mobile.md). 

От типа поиска зависит _формула ранжирования_, в соответствии с которой сортируются результаты поиска, и _поисковая база_ — набор документов, по которому выполняется поиск.

## Запрос результатов поиска

{{ search-api }} поддерживает методы отправки поисковых запросов [GET](get-request.md) и [POST](post-request.md). [Формат ответа](response.md) для этих методов совпадает.

## Условия использования сервиса и лицензионное соглашение {#license}

Дополнительно к правилам использования {{ yandex-cloud }} действуют условия использования сервиса {{ search-api-name }}:

* [Условия использования сервиса {{ search-api-full-name }}](https://yandex.ru/legal/cloud_terms_search_api) для резидентов Российской Федерации и Республики Казахстан.
* [Условия использования сервиса {{ search-api-full-name }}](https://yandex.com/legal/cloud_terms_search_api) для нерезидентов Российской Федерации и Республики Казахстан.

Собственные лицензионные соглашения для каждого типа поиска действуют до 31 октября 2023 года только в отношении пользователей, которые начали использовать сервис Яндекс.XML до 12 сентября 2023 года.

| {{ ui-key.yacloud.component.ip-address-form.label_field-search-type }} | Лицензионное соглашение |
|---|---|
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` | [https://legal.yandex.ru/xml](https://legal.yandex.ru/xml/) |
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}` | [https://legal.yandex.com.tr/xml](https://legal.yandex.com.tr/xml/) ||
| `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}` | [https://legal.yandex.com/xml](https://legal.yandex.com/xml) ||