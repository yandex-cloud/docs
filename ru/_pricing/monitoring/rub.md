Услуга | Цена за 1 млн значений, <br>вкл. НДС
----- | -----
| Чтение значений любых метрик через API<br/>(до 50 млн значений) | {{ sku|RUB|monitoring.point.api.read|string }} |
| Чтение значений любых метрик через API<br/>(сверх 50 млн значений) | {{ sku|RUB|monitoring.point.api.read|pricingRate.50|string }} |
| Экспорт значений метрик в формате {{ prometheus-name }} через API<br/>(до 50 млн значений) | {{ sku|RUB|monitoring.point.prometheus.export|string }} |
| Экспорт значений метрик в формате {{ prometheus-name }} через API<br/>(сверх 50 млн значений) | {{ sku|RUB|monitoring.point.prometheus.export|pricingRate.50|string }} |
| Запись значений пользовательских метрик через API<br/>(до 50 млн значений) | {{ sku|RUB|monitoring.point.write|string }} |
| Запись значений пользовательских метрик через API<br/>(сверх 50 млн значений) | {{ sku|RUB|monitoring.point.write|pricingRate.50|string }} |
| Запись значений метрик ресурсов {{ yandex-cloud }} | {{ sku|RUB|monitoring.point.dgauge.store|string }} |