# Чтение метрик

Читать метрики, записанные в Yandex Managed Service for Prometheus®, можно одним из следующих способов:

* Добавить запросы к метрикам Prometheus в [Monium Metrics](monitoring.md).
* [Подключить](grafana.md) Yandex Managed Service for Prometheus® к существующей инсталляции Grafana при помощи [Prometheus data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) и использовать PromQL в качестве языка запросов.
* Воспользоваться [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries) для выполнения запросов на языке PromQL.
* Настроить существующую инсталляцию Prometheus на [чтение](remote-read.md) метрик по протоколу [Remote Read](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read).

_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation смотрите на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._