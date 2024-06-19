Услуга | Цена за 1 млн значений, <br>вкл. НДС
----- | -----
| Запись значений метрик через {{ prometheus-name }} Remote API<br/>(до 50 млн значений) | {{ sku|RUB|monitoring.prometheus.point.remote_api.write|string }} |
| Запись значений метрик через {{ prometheus-name }} Remote API<br/>(от 50 млн до 10 млрд значений) | {{ sku|RUB|monitoring.prometheus.point.remote_api.write|pricingRate.50|string }} |
| Запись значений метрик через {{ prometheus-name }} Remote API<br/>(сверх 10 млрд значений) | {{ sku|RUB|monitoring.prometheus.point.remote_api.write|pricingRate.10000|string }} |
| Чтение значений метрик через {{ prometheus-name }} Remote API | {{ sku|RUB|monitoring.prometheus.point.remote_api.read|string }} |
