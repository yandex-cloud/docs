[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Метрики](../metrics/overview.md) > [Справочник метрик](index.md) > AI Studio

# Метрики Yandex AI Studio


В этом разделе описаны метрики сервиса [AI Studio](https://aistudio.yandex.ru/docs/ru/), поставляемые в Monium Metrics.

Имя метрики записывается в метку `name`.

Общие метки для всех метрик функциональности [MCP Hub](https://aistudio.yandex.ru/docs/ru//ai-studio/concepts/mcp-hub/index) сервиса AI Studio:

Метка | Значение
----|----
service | Идентификатор сервиса: `serverless-mcp-gateway`
mcp_gateway_id | Идентификатор [MCP-сервера](https://aistudio.yandex.ru/docs/ru//ai-studio/concepts/mcp-hub/index#servers)


Метрики сервиса:

#|
|| **Имя**
**Тип, единицы измерения** |
**Описание**
**Метки**
||
|| `requests_completed_per_second`
`DGAUGE`, запросы/с |
Количество завершившихся запросов к MCP-серверу в секунду.
Метки:
* _request_type_ — тип запроса.
* _error_code_ — ошибка, если есть. ||
|| `requests_received_per_second`
`DGAUGE`, запросы/с |
Количество запросов к MCP-серверу в секунду.
Метка:
* _request_type_ — тип запроса. ||
|| `sessions_active_count`
`DGAUGE`, штуки |
Количество открытых сессий с MCP-сервером. ||
|| `sessions_closed_per_second`
`DGAUGE`, запросы/с |
Количество закрытий сессий с MCP-сервером в секунду. ||
|| `sessions_duration_milliseconds`
`IGAUGE`, миллисекунды |
Продолжительность сессии с MCP-сервером.
Метка:
* _bin_ — бакеты гистограммы. ||
|| `sessions_init_requests_per_second`
`DGAUGE`, запросы/с |
Количество запросов на инициализацию сессий с MCP-сервером в секунду.
Метка:
* _error_code_ — ошибка, если есть. ||
|| `tool_call_duration_milliseconds`
`IGAUGE`, миллисекунды |
Продолжительность выполнения запроса к инструменту MCP-сервера.
Метка:
* _bin_ — бакеты гистограммы. ||
|#