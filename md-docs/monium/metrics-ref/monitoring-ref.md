# Метрики Monium Metrics

В этом разделе описаны метрики сервиса Monium Metrics, поставляемые в него.

Имя метрики пишется в метку `name`.

Все метрики сервиса [Monium Metrics](../../monitoring/index.md) имеют общую метку `service=monitoring`. Метрики могут поступать от Monium Metrics API и Yandex Managed Service for Prometheus® API.

## Monium Metrics API

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
-------------------------------------- | ------------------
`api.http.requests_count_per_second`<br/>`RATE`, запросы/с | Количество запросов в секунду к Monium Metrics API. <br/>Метки:<br/>- *method* – метод Monium Metrics API, к которому выполняются запросы. Например, `/v2/prometheusMetrics`.
`api.http.errors_count_per_second`, <br/>`RATE`, запросы/с | Количество ошибочных запросов в секунду к Monium Metrics API. <br/>Метки:<br/>- *method* – метод Monium Metrics API, к которому выполняются запросы. Например, `/v2/prometheusMetrics`.

## Yandex Managed Service for Prometheus® API

Общие метки для всех метрик:

Метка | Значение
--- | ---
method | метод Yandex Managed Service for Prometheus® API, к которому выполняются запросы. Например, `/api/v1/write`.
workspace_id | воркспейс Yandex Managed Service for Prometheus®, к данным которого выполняются запросы.

Метрики:

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
-------------------------------------- | ------------------
`api.prometheus.requests_count_per_second`, <br/>`RATE`, запросы/с | Количество запросов в секунду к Yandex Managed Service for Prometheus® API.
`api.prometheus.errors_count_per_second`, <br/>`RATE`, запросы/с | Количество ошибочных запросов в секунду к Yandex Managed Service for Prometheus® API.
`api.prometheus.statuses_per_second`, <br/>`RATE`, запросы/с | Статусы выполнения запросов в секунду к Yandex Managed Service for Prometheus® API.<br/>Дополнительная метка *code* – код статуса HTTP. Например, `200`.

_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation смотрите на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._