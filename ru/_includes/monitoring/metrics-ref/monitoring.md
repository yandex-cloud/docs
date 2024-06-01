Имя метрики пишется в метку `name`.

Все метрики сервиса [{{ monitoring-name }}](../../../monitoring/) имеют общую метку `service=monitoring`. Метрики могут поступать от {{ monitoring-short-name }} API и {{ managed-prometheus-name }} API.

## {{ monitoring-short-name }} API

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
-------------------------------------- | ------------------
`api.http.requests_count_per_second`<br/>`RATE`, запросы/с | Количество запросов в секунду к {{ monitoring-full-name }} API. <br/>Метки:<br/>- *method* – метод {{ monitoring-full-name }} API, к которому выполняются запросы. Например, `/v2/prometheusMetrics`.
`api.http.errors_count_per_second`, <br/>`RATE`, запросы/с | Количество ошибочных запросов в секунду к {{ monitoring-full-name }} API. <br/>Метки:<br/>- *method* – метод {{ monitoring-full-name }} API, к которому выполняются запросы. Например, `/v2/prometheusMetrics`.

## {{ managed-prometheus-name }} API

Общие метки для всех метрик:

Метка | Значение
--- | ---
method | метод {{ managed-prometheus-name }} API, к которому выполняются запросы. Например, `/api/v1/write`.
workspace_id | воркспейс {{ managed-prometheus-name }}, к данным которого выполняются запросы.

Метрики:

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
-------------------------------------- | ------------------
`api.prometheus.requests_count_per_second`, <br/>`RATE`, запросы/с | Количество запросов в секунду к {{ managed-prometheus-name }} API.
`api.prometheus.errors_count_per_second`, <br/>`RATE`, запросы/с | Количество ошибочных запросов в секунду к {{ managed-prometheus-name }} API.
`api.prometheus.statuses_per_second`, <br/>`RATE`, запросы/с | Статусы выполнения запросов в секунду к {{ managed-prometheus-name }} API.<br/>Дополнительная метка *code* – код статуса HTTP. Например, `200`.