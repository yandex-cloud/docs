Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ mtr-name }}: 

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-trino`
cluster_id | Идентификатор кластера
component | Тип компонента: `coordinator`

## Метрики сервиса {#managed-trino-metrics}

#|
|| **Имя**

**Тип, единицы измерения** | **Описание** ||
|| `trino_memory_discoverynodemanager_activenodecount.gauge`<br/>`DGAUGE`, штуки | Количество хостов кластера. ||
|| `trino_memory_clustermemorymanager_totalavailableprocessors.gauge`<br/>`DGAUGE`, штуки | Количество доступных CPU. ||
|| `trino_memory_clustermemorypool_freedistributedbytes.gauge`<br/>`DGAUGE`, гигабайты | Объем свободной памяти кластера. ||
|| `trino_execution_querymanager_queries_in_progress.gauge`<br/>`DGAUGE`, штуки | Запросы (выполняющиеся).

Дополнительная метка `status` может принимать следующие значения:
* **Running** — выполняется хотя бы одна часть плана запроса.
* **Queued** — запрос принят и ожидает выполнения.
* **Progressing** — запрос выполняется, и его ничто не блокирует.
* **Finishing** — выполнение запроса завершается. ||
|| `trino_execution_querymanager_queries_totalcount.gauge`<br/>`DGAUGE`, штуки | Запросы (по статусу).

Дополнительная метка `status` может принимать следующие значения:
* **Submitted** — принятые запросы.
* **Started** — выполняемые запросы.
* **Failed** — запросы, выполнение которых завершилось ошибкой.
* **Completed** — завершенные запросы, в том числе те, выполнение которых завершилось ошибкой.
* **Canceled** — запросы, выполнение которых отменил пользователь.
* **Abandoned** — запросы, результаты выполнения которых остались невостребованными. ||
|| `trino_execution_querymanager_failures_totalcount.gauge`<br/>`DGAUGE`, штуки | Количество ошибок.

Дополнительная метка `error` может принимать следующие значения:
* **UserError** — ошибки на стороне пользователя.
* **Internal** — ошибки на стороне сервера.
* **InsufficientResources** — ошибки, вызванные недостатком ресурсов.
* **External** — внешние ошибки. ||
|| `trino_execution_querymanager_execution_time_oneminute.gauge`<br/>`DGAUGE`, миллисекунды | Процентиль времени выполнения запросов с окном в одну минуту.

Дополнительная метка `quantile` может принимать следующие значения:
* **0.50**.
* **0.75**.
* **0.90**.
* **0.95**.
* **0.99**. ||
|#
