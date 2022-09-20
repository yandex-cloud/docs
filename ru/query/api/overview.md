# Все методы

HTTP API {{ yq-full-name }} доступно по адресу [api.yandex-query.cloud.yandex.net](https://api.yandex-query.cloud.yandex.net/api/fq/v1).

{% if yq_api_version>0.1 %}
, Open API спецификация доступна по адресу
[https://yq-api.cloud.yandex.ru/swagger](https://yq-api.cloud.yandex.ru/swagger).
{% endif %}

{% include [!](../_includes/api-common.md) %}

HTTP API {{ yq-full-name }} предоставляет следующие методы:

|Название|Описание|
|---|---|
|[create-query](create-query.md)|Создает запрос и начинает его выполнение|
|[get-query](get-query.md)|Возвращает информацию о запросе|
|[get-query-status](get-query-status.md)|Возвращает информацию о состоянии выполнения запроса|
|[stop-query](stop-query.md)|Останавливает выполнение запроса|
|[get-query-results](get-query-results.md)|Возвращает результаты выполнения запроса|