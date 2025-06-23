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

Чтение метрик через {{ prometheus-name }} Remote API пока не тарифицируется.

Особенности тарификации:
* После записи или чтения первых 50 млн значений через {{ monitoring-short-name }} API стоимость записи снижается. См. [Цены для региона Россия](#prices).
* Запись метрик ресурсов {{ yandex-cloud }}, собираемых автоматически, не тарифицируется.
* Чтение метрик при помощи интерфейса {{ monitoring-short-name }} и при помощи консоли {{ yandex-cloud }} не тарифицируется.
* Входящий и исходящий трафик в {{ monitoring-short-name }} не тарифицируются.

### Пример расчета стоимости {#example}


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-example](../_pricing_examples/monitoring/rub-example.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-example](../_pricing_examples/monitoring/kzt-example.md) %}

{% endlist %}







## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



### {{ monitoring-short-name }} API {#monitoring-api}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  Минимальная единица тарификации — 1 значение метрики. Стоимость округляется до копейки.

  {% include [rub-api-example](../_pricing_examples/monitoring/rub-api-example.md) %}

  {% include [rub.md](../_pricing/monitoring/rub.md) %}

- Цены в тенге {#prices-kzt}

  Минимальная единица тарификации — 1 значение метрики. Стоимость округляется до тиына.

  {% include [kzt-api-example](../_pricing_examples/monitoring/kzt-api-example.md) %}

  {% include [kzt.md](../_pricing/monitoring/kzt.md) %}

{% endlist %}




### {{ prometheus-name }} Remote API {#prometheus-remote-api}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-prometheus.md](../_pricing/monitoring/rub-prometheus.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-prometheus.md](../_pricing/monitoring/kzt-prometheus.md) %}

{% endlist %}




{% include [trademark](../_includes/monitoring/trademark.md) %}
