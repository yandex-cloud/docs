# Чтение метрик

Читать метрики, записанные в {{ managed-prometheus-name }}, можно одним из следующих способов:

* Добавить запросы к метрикам {{ prometheus-name }} в [{{ monitoring-name }}](monitoring.md).
* [Подключить](grafana.md) {{ managed-prometheus-name }} к существующей инсталляции {{ grafana-name }} при помощи [{{ prometheus-name }} data source](https://grafana.com/docs/grafana/latest/datasources/prometheus/) и использовать {{ promql-name }} в качестве языка запросов.
* Воспользоваться [HTTP API](https://prometheus.io/docs/prometheus/latest/querying/api/#expression-queries) для выполнения запросов на языке {{ promql-name }}.
* Настроить существующую инсталляцию {{ prometheus-name }} на [чтение](remote-read.md) метрик по протоколу [Remote Read](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#remote_read).

_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation см. на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._