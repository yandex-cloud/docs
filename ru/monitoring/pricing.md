---
title: "Правила тарификации для {{ monitoring-full-name }}"
description: "В статье содержатся правила тарификации сервиса {{ monitoring-name }}."
editable: false
---

# Правила тарификации для {{ monitoring-full-name }}

## Из чего складывается стоимость использования {{ monitoring-short-name }} {#rules}

На данный момент в рамках сервиса {{ monitoring-short-name }} тарифицируется запись пользовательских метрик через [{{ monitoring-short-name }} API](api-ref/index.md) и запись любых метрик через [{{ prometheus-name }} Remote API](operations/prometheus/index.md), а также чтение любых метрик через [{{ monitoring-short-name }} API](api-ref/index.md).

Чтение метрик через {{ prometheus-name }} Remote API пока не тарифицируется.

Особенности тарификации:
* После записи или чтения первых 50 млн значений через {{ monitoring-short-name }} API стоимость записи снижается. См. [{#T}](#prices).
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

  Например, стоимость записи первых 86 400 значений составит `(86 400 значений / 1 млн) × 9,8 ₽ = 0,8467 ₽` и будет округлена до `0,85 ₽`. При этом стоимость записи 87 000 значений составит `(87 000 значений / 1 млн) × 9,8 ₽ = 0,8526 ₽` и будет округлена до `0,85 ₽`. Где `9,80 ₽` — цена за 1 млн значений (при записи до 50 млн значений).

  {% include [rub.md](../_pricing/monitoring/rub.md) %}

- Цены в тенге {#prices-kzt}

  Минимальная единица тарификации — 1 значение метрики. Стоимость округляется до тиына.

  Например, стоимость записи первых 86 500 значений составит `(86 500 значений / 1 млн) × 49,00 ₸ = 4,2385 ₸` и будет округлена до `4,24 ₸`. При этом стоимость записи 86 600 значений составит `(86 600 значений / 1 млн) × 49,00 ₸ = 4,2434 ₸` и будет округлена до `4,24 ₸`. Где `49,00 ₸` — цена за 1 млн значений (при записи до 50 млн значений).

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
