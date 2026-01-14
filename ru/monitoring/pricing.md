---
title: Правила тарификации для {{ monitoring-full-name }}
description: В статье содержатся правила тарификации сервиса {{ monitoring-name }}.
editable: false
---

# Правила тарификации для {{ monitoring-full-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ monitoring-short-name }} {#rules}

На данный момент в рамках сервиса {{ monitoring-short-name }} тарифицируется запись пользовательских метрик через [{{ monitoring-short-name }} API](api-ref/index.md) и запись любых метрик через [{{ prometheus-name }} Remote API](operations/prometheus/index.md), а также чтение любых метрик через [{{ monitoring-short-name }} API](api-ref/index.md).

Запись значений метрик ресурсов {{ yandex-cloud }} и чтение метрик через {{ prometheus-name }} Remote API не тарифицируются.

Особенности тарификации:
* После записи или чтения первых 50 млн значений через {{ monitoring-short-name }} API стоимость записи снижается. См. [Цены для региона Россия](#prices).
* Запись метрик ресурсов {{ yandex-cloud }}, собираемых автоматически, не тарифицируется.
* Чтение метрик при помощи интерфейса {{ monitoring-short-name }} и при помощи консоли {{ yandex-cloud }} не тарифицируется.
* Входящий и исходящий трафик в {{ monitoring-short-name }} не тарифицируются.

### Пример расчета стоимости {#example}

{% include [prices-difference](../_includes/prices-difference.md) %}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-example](../_pricing_examples/monitoring/rub-example.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-example](../_pricing_examples/monitoring/kzt-example.md) %}

{% endlist %}







## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Минимальная единица тарификации — 1 значение метрики. Стоимость округляется до копейки, тиына или цента.


{% include [rub-api-example](../_pricing_examples/monitoring/rub-api-example.md) %}

<MDX>
  <PriceList
    serviceIds={['{{ pcs|monitoring }}']}
    excludeSkuIds={['{{ pc|monitoring.alerts.notifications.sms }}', '{{ pc|monitoring.alerts.notifications.phone }}', '{{ pc|monitoring.prometheus.point.remote_api.read }}', '{{ pc|monitoring.point.ui.read }}', '{{ pc|monitoring.metrics.stored }}', '{{ pc|monitoring.point.sp.write }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>





{% include [trademark](../_includes/monitoring/trademark.md) %}
