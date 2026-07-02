[Документация Yandex Cloud](../../index.md) > [Yandex Monitoring](../index.md) > [Справочник метрик](index.md) > Monitoring

# Метрики Yandex Monitoring

В этом разделе описаны метрики сервиса Monitoring, поставляемые в него.

Имя метрики пишется в метку `name`.

Все метрики сервиса [Monitoring](../index.md) имеют общую метку `service=monitoring`. Метрики могут поступать от Monitoring API и Yandex Managed Service for Prometheus® API.

## Monitoring API

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
-------------------------------------- | ------------------
`api.http.requests_count_per_second`<br/>`RATE`, запросы/с | Количество запросов в секунду к Yandex Monitoring API. <br/>Метки:<br/>- *method* – метод Yandex Monitoring API, к которому выполняются запросы. Например, `/v2/prometheusMetrics`.
`api.http.errors_count_per_second`, <br/>`RATE`, запросы/с | Количество ошибочных запросов в секунду к Yandex Monitoring API. <br/>Метки:<br/>- *method* – метод Yandex Monitoring API, к которому выполняются запросы. Например, `/v2/prometheusMetrics`.

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

_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation приведен на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._