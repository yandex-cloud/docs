**Пример 1**

Стоимость пользования сервисом {{ monitoring-short-name }} в течение 30 дней при записи 20 метрик с частотой **1 значение в минуту** через {{ monitoring-short-name }} API:

> 20 × 1 × (60 × 24 × 30) = 864&nbsp;000 значений = 0,864 млн значений
> 0,864 × 0,32 = {% calc [currency=RUB] 0,864 × 0,32 %} = {% calc [currency=RUB] round((0,864 × 0,32) × 100) / 100 %}
> 
> Итого: {% calc [currency=RUB] round((0,864 × 0,32) × 100) / 100 %}

Где:

* 20 — количество метрик.
* 1 — количество записанных значений в минуту.
* (60 × 24 × 30) — количество минут в 30 днях.
* 0,32 — стоимость записи 1 млн значений.

**Пример 2**

Стоимость экспорта 100 метрик из {{ monitoring-short-name }} в собственную инсталляцию системы мониторинга {{ prometheus-name }} с периодом сбора **15 секунд** в течение 30 дней через {{ monitoring-short-name }} API:

> 100 × (60 / 15) × (60 × 24 × 30) = 17&nbsp;280&nbsp;000 значений = 17,28 млн значений
> 17,28 × {{ sku|RUB|monitoring.point.prometheus.export|string }} = {% calc [currency=RUB] round((17,28 × {{ sku|RUB|monitoring.point.prometheus.export|number }}) × 100) / 100 %}
> 
> Итого: {% calc [currency=RUB] round((17,28 × {{ sku|RUB|monitoring.point.prometheus.export|number }}) × 100) / 100 %}

Где:

* 100 — количество метрик.
* (60 / 15) — количество считанных значений в минуту.
* (60 × 24 × 30) — количество минут в 30 днях.
* {{ sku|RUB|monitoring.point.prometheus.export|string }} — стоимость чтения 1 млн значений (до 50 млн значений).