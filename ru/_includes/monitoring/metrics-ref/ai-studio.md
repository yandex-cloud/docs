Имя метрики записывается в метку `name`.

## Метрики {{ mcp-hub-name }} {#mcp-hub}

Общие метки для всех метрик функциональности [{{ mcp-hub-name }}]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index) сервиса {{ ai-studio-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `serverless-mcp-gateway`
mcp_gateway_id | Идентификатор [MCP-сервера]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index#servers)


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

## Метрики {{ sw-full-name }} {#workflows}

Общая метка для всех метрик {{ sw-name }}: `workflow` — идентификатор рабочего процесса.

Имя метрики<br>Тип, единицы измерения | Описание<br>Метки
--- | ---
`step_completed_per_second`<br>`DGAUGE`, шаги/с | Количество завершенных шагов в секунду.<br>Метка `step` — имя шага.
`step_failed_per_second`<br>`DGAUGE`, шаги/с | Количество шагов в секунду, завершившихся с ошибкой.<br>Метки:<ul><li>`step` — имя шага.</li><li>`error_code` — код ошибки.</li></ul>
`step_inflight_count`<br>`DGAUGE`, шаги | Количество шагов в процессе выполнения в данный момент.<br>Метка `step` — имя шага.
`step_started_per_second`<br>`DGAUGE`, шаги/с | Количество запущенных шагов в секунду.<br>Метка `step` — имя шага.
`step_time_milliseconds`<br>`DGAUGE`, миллисекунды | Время выполнения шага.<br>Метки:<ul><li>`bin` — бакеты гистограммы.</li><li>`step` — имя шага.</li></ul>
`step_time_milliseconds_count`<br>`DGAUGE`, количество шагов | Общее количество измерений времени выполнения шагов.<br>Метка `step` — имя шага.
`step_time_milliseconds_sum`<br>`DGAUGE`, миллисекунды | Суммарное время выполнения всех шагов.<br>Метка `step` — имя шага.
`workflow_completed_per_second`<br>`DGAUGE`, рабочие процессы/с | Количество завершенных рабочих процессов в секунду.
`workflow_failed_per_second`<br>`DGAUGE`, рабочие процессы/с | Количество рабочих процессов в секунду, завершившихся с ошибкой.<br>Метка `error_code` — код ошибки.
`workflow_inflight_count`<br>`DGAUGE`, рабочие процессы | Количество рабочих процессов в процессе выполнения в данный момент.
`workflow_scheduled_per_second`<br>`DGAUGE`, рабочие процессы/с | Количество рабочих процессов, запланированных в секунду.
`workflow_started_per_second`<br>`DGAUGE`, рабочие процессы/с | Количество рабочих процессов, начатых в секунду.
`workflow_time_milliseconds`<br>`DGAUGE`, миллисекунды | Время выполнения одного рабочего процесса.<br>Метка `bin` — бакеты гистограммы.
`workflow_time_milliseconds_count`<br>`DGAUGE`, штуки | Общее количество измерений времени выполнения рабочих процессов.
`workflow_time_milliseconds_sum`<br>`DGAUGE`, миллисекунды | Суммарное время выполнения всех рабочих процессов.
