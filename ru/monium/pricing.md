---
title: Правила тарификации для {{ monium-name }}
description: В статье содержатся правила тарификации платформы {{ monium-name }}.
editable: false
---

# Правила тарификации для {{ monium-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ monium-name }} {#rules}

При использовании сервисов платформы {{ monium-name }} тарифицируется:

* Запись пользовательских метрик через [{{ monium-name }} API](api-ref/index.md).
* Запись любых метрик через [{{ prometheus-name }} Remote API](operations/prometheus/index.md).
* Чтение любых метрик через {{ monium-name }} API.
* Экспорт метрик в формате {{ prometheus-name }} через {{ monium-name }} API.
* Запись данных в {{ monium-logs-name }}.
* Запись данных в {{ traces-name }}.

Запись значений метрик ресурсов {{ yandex-cloud }}, чтение метрик через {{ prometheus-name }} Remote API, чтение логов и трейсов не тарифицируются.

Особенности тарификации:
* После записи или чтения первых 50 млн значений через {{ monium-name }} API стоимость записи снижается. См. [Цены для региона Россия](#prices).
* Запись метрик ресурсов {{ yandex-cloud }}, собираемых автоматически, не тарифицируется.
* Чтение данных при помощи интерфейса {{ monium-name }} и при помощи консоли {{ yandex-cloud }} не тарифицируется.
* Входящий и исходящий трафик в {{ monium-name }} не тарифицируются.

### Пример расчета стоимости метрик {#example}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-example](../_pricing_examples/monitoring/rub-example.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-example](../_pricing_examples/monitoring/kzt-example.md) %}

{% endlist %}






### Пример расчета стоимости логов и трейсов {#example-logs-traces}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-logs-traces-example](../_pricing_examples/monium/rub-logs-traces-example.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-logs-traces-example](../_pricing_examples/monium/kzt-logs-traces-example.md) %}

{% endlist %}







## Цены для региона Россия {#prices}

{% note warning %}

Цены начинают действовать с 4 марта 2026 года.

{% endnote %}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Тарификация метрик {#metrics-prices}

Минимальная единица тарификации для метрик — 1 значение метрики. Стоимость округляется до копейки, тиына или цента.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|monitoring }}']}
    excludeSkuIds={['{{ pc|monitoring.alerts.notifications.sms }}', '{{ pc|monitoring.alerts.notifications.phone }}', '{{ pc|monitoring.prometheus.point.remote_api.read }}', '{{ pc|monitoring.point.ui.read }}', '{{ pc|monitoring.metrics.stored }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




### Тарификация логов и трейсов {#logs-traces-prices}

Для логов и трейсов тарифицируется объем данных, записанных в {{ monium-logs-name }} и {{ traces-name }}. Минимальная единица тарификации — 1 МБ. Цены указаны для 1 ГБ. Стоимость округляется до копейки, тиына или цента.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/monium/rub-logs-traces.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/monium/kzt-logs-traces.md) %}

{% endlist %}



