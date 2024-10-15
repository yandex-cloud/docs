**Пример 1**

Стоимость пользования сервисом {{ monitoring-short-name }} в течение 30 дней при записи 20 метрик с частотой **1 значение в минуту** через {{ monitoring-short-name }} API:

> 20 × 1 × (60 × 24 × 30) = 864&nbsp;000 значений = 0,864 млн значений
> 0,864 × {{ sku|KZT|monitoring.point.write|string }} = {% calc [currency=KZT] 0,864 × {{ sku|KZT|monitoring.point.write|number }} %} = {% calc [currency=KZT] round((0,864 × {{ sku|KZT|monitoring.point.write|number }}) × 100) / 100 %}
> 
> Итого: {% calc [currency=KZT] round((0,864 × {{ sku|KZT|monitoring.point.write|number }}) × 100) / 100 %}

Где:

* 20 — количество метрик.
* 1 — количество записанных значений в минуту.
* (60 × 24 × 30) — количество минут в 30 днях.
* {{ sku|KZT|monitoring.point.write|string }} — стоимость записи 1 млн значений (до 50 млн значений).

**Пример 2**

Стоимость пользования сервисом {{ monitoring-short-name }} в течение 30 дней при записи 20 метрик с частотой **1 значение в секунду** через {{ monitoring-short-name }} API:

> 20 × 1 × (60 × 60 × 24 × 30) = 51&nbsp;840&nbsp;000 значений = 51,84 млн значений
> 50 × {{ sku|KZT|monitoring.point.write|string }} + (51,84 - 50) × {{ sku|KZT|monitoring.point.write|pricingRate.50|string }} = {% calc [currency=KZT] round((50 × {{ sku|KZT|monitoring.point.write|number }} + (51,84 - 50) × {{ sku|KZT|monitoring.point.write|pricingRate.50|number }}) × 100) / 100 %}
> 
> Итого: {% calc [currency=KZT] round((50 × {{ sku|KZT|monitoring.point.write|number }} + (51,84 - 50) × {{ sku|KZT|monitoring.point.write|pricingRate.50|number }}) × 100) / 100 %}

Где:

* 20 — количество метрик.
* 1 — количество записанных значений в секунду.
* (60 × 60 × 24 × 30) — количество секунд в 30 днях.
* {{ sku|KZT|monitoring.point.write|string }} — стоимость записи 1 млн значений (до 50 млн значений).
* {{ sku|KZT|monitoring.point.write|pricingRate.50|string }} — стоимость записи 1 млн значений (сверх 50 млн значений).

**Пример 3**

Стоимость экспорта 100 метрик из {{ monitoring-short-name }} в собственную инсталляцию системы мониторинга {{ prometheus-name }} с периодом сбора **15 секунд** в течение 30 дней через {{ monitoring-short-name }} API:

> 100 × (60 / 15) × (60 × 24 × 30) = 17&nbsp;280&nbsp;000 значений = 17,28 млн значений
> 17,28 × {{ sku|KZT|monitoring.point.prometheus.export|string }} = {% calc [currency=KZT] round((17,28 × {{ sku|KZT|monitoring.point.prometheus.export|number }}) × 100) / 100 %}
> 
> Итого: {% calc [currency=KZT] round((17,28 × {{ sku|KZT|monitoring.point.prometheus.export|number }}) × 100) / 100 %}

Где:

* 100 — количество метрик.
* (60 / 15) — количество считанных значений в минуту.
* (60 × 24 × 30) — количество минут в 30 днях.
* {{ sku|KZT|monitoring.point.prometheus.export|string }} — стоимость чтения 1 млн значений (до 50 млн значений).