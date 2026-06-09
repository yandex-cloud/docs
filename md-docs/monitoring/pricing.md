# Правила тарификации для {{ monitoring-full-name }}

Чтобы рассчитать стоимость использования сервиса, ознакомьтесь с тарифами в этом разделе.

Цены на продукты сервиса также доступны в [Прайс-листе](https://yandex.cloud/ru/price-list).


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Из чего складывается стоимость использования {{ monitoring-short-name }} {#rules}

На данный момент в рамках сервиса {{ monitoring-short-name }} тарифицируется запись пользовательских метрик через [{{ monitoring-short-name }} API](api-ref/index.md) и запись любых метрик через [{{ prometheus-name }} Remote API](operations/prometheus/index.md), а также чтение любых метрик через [{{ monitoring-short-name }} API](api-ref/index.md).

Запись значений метрик ресурсов {{ yandex-cloud }} и чтение метрик через {{ prometheus-name }} Remote API не тарифицируются.

Особенности тарификации:
* После записи или чтения первых 50 млн значений через {{ monitoring-short-name }} API стоимость записи снижается. См. [Цены для региона Россия](#prices).
* Запись метрик ресурсов {{ yandex-cloud }}, собираемых автоматически, не тарифицируется.
* Чтение метрик при помощи интерфейса {{ monitoring-short-name }} и при помощи консоли {{ yandex-cloud }} не тарифицируется.
* Входящий и исходящий трафик в {{ monitoring-short-name }} не тарифицируются.

### Пример расчета стоимости {#example}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

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

- Расчет в тенге {#prices-kzt}

  **Пример 1**
  
  Стоимость пользования сервисом {{ monitoring-short-name }} в течение 30 дней при записи 20 метрик с частотой **1 значение в минуту** через {{ monitoring-short-name }} API:
  
  > 20 × 1 × (60 × 24 × 30) = 864&nbsp;000 значений = 0,864 млн значений
  > 0,864 × 1,63 = {% calc [currency=KZT] 0,864 × 1,63 %} = {% calc [currency=KZT] round((0,864 × 1,63) × 100) / 100 %}
  > 
  > Итого: {% calc [currency=KZT] round((0,864 × 1,63) × 100) / 100 %}
  
  Где:
  
  * 20 — количество метрик.
  * 1 — количество записанных значений в минуту.
  * (60 × 24 × 30) — количество минут в 30 днях.
  * 1,63 — стоимость записи 1 млн значений.
  
  **Пример 2**
  
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

{% endlist %}







## Цены для региона Россия {#prices}



{% note info %}

Цены на ресурсы {{ yandex-cloud }} в разных регионах различаются. Подробнее о доступных регионах см. [{#T}](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта см. [{#T}](../billing/quickstart/index.md).

{% endnote %}

Минимальная единица тарификации — 1 значение метрики. Стоимость округляется до копейки, тиына или цента.


Например, стоимость записи первых 86 400 значений составит `(86 400 значений / 1 млн) × {{ sku|RUB|monitoring.point.write|string }} = {% calc [currency=RUB] 86400 / 1000000 × {{ sku|RUB|monitoring.point.write|number }} %}` и будет округлена до `{% calc [currency=RUB] round((86400 / 1000000 × {{ sku|RUB|monitoring.point.write|number }}) × 100 ) / 100 %}`. При этом стоимость записи 87 000 значений составит `(87 000 значений / 1 млн) × {{ sku|RUB|monitoring.point.write|string }} = {% calc [currency=RUB] 87000 / 1000000 × {{ sku|RUB|monitoring.point.write|number }} %}` и будет округлена до `{% calc [currency=RUB] round((87000 / 1000000 × {{ sku|RUB|monitoring.point.write|number }}) × 100 ) / 100 %}`. Где `{{ sku|RUB|monitoring.point.write|string }}` — цена за 1 млн значений (при записи до 50 млн значений).

| Услуга | Цена | Ед. тарификации | Действует с | Действует до |
| ------ | ---- | --------------- | ----------- | ------------ |





_© 2025 Linux Foundation. Все права защищены. Linux Foundation зарегистрировала товарные знаки и использует товарные знаки. Список товарных знаков Linux Foundation см. на странице [Trademark Usage](https://www.linuxfoundation.org/legal/trademark-usage)._