# Все методы

HTTP API Yandex Query доступен по адресу [https://api.yandex-query.cloud.yandex.net/api/fq/v1](https://api.yandex-query.cloud.yandex.net/api/fq/v1).

Спецификация Open API 3.0 доступна по адресу [https://api.yandex-query.cloud.yandex.net/resources/v1/openapi.yaml](https://api.yandex-query.cloud.yandex.net/resources/v1/openapi.yaml).

При использовании HTTP API необходимо [аутентифицироваться](../auth.md), указав для этого [обязательные заголовки](../index.md#mandatory-headers). Кроме того, можно задать [необязательные заголовки](../index.md#optional-headers) для настройки исполнения запросов. При работе с HTTP API могут возвращаться [ошибки](../index.md#errors).

Методы HTTP API Yandex Query:

| Название | Описание |
| --- | --- |
| [create-query](create-query.md) | Создает запрос и начинает его выполнение |
| [get-query](get-query.md) | Возвращает информацию о запросе |
| [get-query-status](get-query-status.md) | Возвращает информацию о статусе выполнения запроса |
| [stop-query](stop-query.md) | Останавливает выполнение запроса |
| [get-query-results](get-query-results.md) | Возвращает результат выполнения запроса |