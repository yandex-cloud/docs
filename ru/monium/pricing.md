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



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Минимальная единица тарификации — 1 значение метрики. Для логов и трейсов тарифицируется объем данных, записанных в {{ monium-logs-name }} и {{ traces-name }}. Минимальная единица тарификации — 1 МБ. Цены указаны для 1 ГБ. Стоимость округляется до копейки, тиына или цента.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|monium }}']}
    excludeSkuIds={['{{ pc|monitoring.alerts.notifications.sms }}', '{{ pc|monitoring.alerts.notifications.phone }}', '{{ pc|monitoring.metrics.stored }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>





### Тарификация телефонных звонков и СМС {#sms-call-prices}

{% note warning %}

Цены действуют с 24 апреля 2026 года.

{% endnote %}

Тарифицируются звонки и СМС, отправляемые в рамках [алертов](concepts/alerting/alert.md) и [политик эскалаций](concepts/alerting/escalations.md). Указаны цены за 1 звонок и 1 СМС.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/monium/rub-sms-call.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/monium/kzt-sms-call.md) %}

{% endlist %}




