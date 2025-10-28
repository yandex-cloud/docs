# Мониторинг и логирование

## Статистика {#stats}

{% note info %}

Для обработчиков типа **{{ ui-key.yacloud.alb.label_listener-type-stream }}** сбор статистики отдельных HTTP-запросов не производится.

{% endnote %}

Статистика работы балансировщика автоматически записывается в метрики сервиса [{{ monitoring-full-name }}](../../monitoring/). Доступны следующие дашборды и показатели:

* **HTTP-статистика**:

  * **RPS** — количество запросов к балансировщику в секунду (requests per second).
  * **4XX**, **5XX** — количество ответов балансировщика с HTTP-кодами 4XX и 5XX и [соответствующими им gRPC-кодами](../../api-design-guide/concepts/errors.md#error-list) в секунду.
  * **Request size** — суммарный объем запросов к балансировщику в секунду.
  * **Response size** — суммарный объем ответов балансировщика в секунду.
  * **Latency** — задержка ответа (время от получения балансировщиком первого байта запроса до отправки последнего байта ответа), от 50-го до 99-го перцентиля.

* **Статистика масштабирования**:

  * **Active connections** — количество активных соединений.
  * **Connections per second** — количество соединений в секунду.
  * **Requests per second** — количество запросов в секунду.
  * **Bytes per second** — объем обрабатываемых данных в секунду.

Полный список метрик, передаваемых в {{ monitoring-full-name }}, представлен в [справочнике](../metrics.md).

В {{ alb-name }} доступна обобщенная статистика балансировщика. В {{ monitoring-name }} можно смотреть статистику с разбивкой по ресурсам, привязанным к балансировщику (HTTP-роутерам, виртуальным хостам, маршрутам и т. д.), а также [создавать алерты](../../monitoring/operations/alert/create-alert.md).

Инструкции по просмотру статистики см. в разделе [{#T}](../operations/application-load-balancer-get-stats.md).

## Логирование {#logging}

Вы можете [настроить](../operations/application-load-balancer-manage-logs.md) поставку логов балансировщика в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

Подробности о просмотре логов см. в [{#T}](../operations/application-load-balancer-get-logs.md).

Значение заголовка [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For) (XFF) передается в логи в соответствии со стандартом [RFC 7239](https://datatracker.ietf.org/doc/html/rfc7239). Полный список сохраняемых параметров представлен в [справочнике логов](../logs-ref.md). 

Также вы можете [передавать логи балансировщика в БД PostgreSQL](../tutorials/logging.md).

### Правила отбрасывания логов {#discard-logs-rules}

Запись и хранение логов в {{ cloud-logging-name }} тарифицируются согласно [правилам](../../logging/pricing.md#prices) сервиса. Чтобы записывать меньше логов, добавьте правила их отбрасывания.

Доступные правила:

#|
|| **Правило** | **Значение** ||
||**HTTP-коды**
|
* `100` — Continue
* `101` — Switching Protocol
* `102` — Processing
* `200` — OK
* `201` — Created
* `202` — Accepted
* `203` — Non Authoritative Information
* `204` — No Content
* `205` — Reset Content
* `206` — Partial Content
* `207` — Multi-Status
* `300` — Multiple Choices
* `301` — Moved Permanently
* `302` — Found
* `303` — See Other
* `304` — Not Modified
* `305` — Use Proxy
* `307` — Temporary Redirect
* `308` — Permanent Redirect
* `400` — Bad Request
* `401` — Unauthorized
* `402` — Payment Required
* `403` — Forbidden
* `404` — Not Found
* `405` — Method Not Allowed
* `406` — Not Acceptable
* `407` — Proxy Authentication Required
* `408` — Request Timeout
* `409` — Conflict
* `410` — Gone
* `411` — Length Required
* `412` — Precondition Failed
* `413` — Request Entity Too Large
* `414` — Request-URI Too Long
* `415` — Unsupported Media Type
* `416` — Requested Range Not Satisfiable
* `417` — Expectation Failed
* `418` — I'm a teapot
* `419` — Insufficient Space on Resource
* `420` — Method Failure
* `422` — Unprocessable Entity
* `423` — Locked
* `424` — Failed Dependency
* `428` — Precondition Required
* `429` — Too Many Requests
* `431` — Request Header Fields Too Large
* `451` — Unavailable For Legal Reasons
* `500` — Internal Server Error
* `501` — Not Implemented
* `502` — Bad Gateway
* `503` — Service Unavailable
* `504` — Gateway Timeout
* `505` — HTTP Version Not Supported
* `507` — Insufficient Storage
* `511` — Network Authentication Required||
||**Классы HTTP-кодов**
|
* `1XX`
* `2XX`
* `3XX`
* `4XX`
* `5XX`
* `ALL`||
||**gRPC-коды**
|
* `GRPC_OK`
* `GRPC_CANCELLED`
* `GRPC_UNKNOWN`
* `GRPC_INVALID_ARGUMENT`
* `GRPC_DEADLINE_EXCEEDED`
* `GRPC_NOT_FOUND`
* `GRPC_ALREADY_EXISTS`
* `GRPC_PERMISSION_DENIED`
* `GRPC_UNAUTHENTICATED`
* `GRPC_RESOURCE_EXHAUSTED`
* `GRPC_FAILED_PRECONDITION`
* `GRPC_ABORTED`
* `GRPC_OUT_OF_RANGE`
* `GRPC_UNIMPLEMENTED`
* `GRPC_INTERNAL`
* `GRPC_UNAVAILABLE`||
|#

#### См. также {#see-also}

* [{#T}](./function-monitoring.md)
* [{#T}](../operations/application-load-balancer-manage-alerts.md)