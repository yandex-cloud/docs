Услуга | Цена за 1 млн значений, <br>вкл. НДС
----- | -----
| Чтение значений любых метрик через API<br/>(до 50 млн значений) | {{ sku|ILS|monitoring.point.dgauge.read|string }} |
| Чтение значений любых метрик через API<br/>(сверх 50 млн значений) | {{ sku|ILS|monitoring.point.dgauge.read|pricingRate.50|string }} |
| Запись значений пользовательских метрик через API<br/>(до 50 млн значений) | {{ sku|ILS|monitoring.point.dgauge.write|string }} |
| Запись значений пользовательских метрик через API<br/>(сверх 50 млн значений) | {{ sku|ILS|monitoring.point.dgauge.write|pricingRate.50|string }} |
| Запись значений метрик ресурсов {{ yandex-cloud }} | {{ sku|ILS|monitoring.point.dgauge.store|string }} |