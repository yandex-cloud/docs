## Сервис {{ monitoring-full-name }} {#monitoring}

Все метрики сервиса [{{ monitoring-name }}](../../../monitoring/) имеют общую метку `service=monitoring`.

Имя метрики<br/>Тип, единицы измерения | Описание<br/>Метки
-------------------------------------- | ------------------
`api.http.requests_count_per_second`<br/>`RATE`, запросы/с | Количество запросов в секунду к {{ monitoring-full-name }} API. <br/>Метки:<br/>- *method* – метод {{ monitoring-full-name }} API, к которому выполняются запросы. Например, `/v2/prometheusMetrics`.
`api.http.errors_count_per_second`, <br/>`RATE`, запросы/с | Количество ошибочных запросов в секунду к {{ monitoring-full-name }} API. <br/>Метки:<br/>- *method* – метод {{ monitoring-full-name }} API, к которому выполняются запросы. Например, `/v2/prometheusMetrics`.
