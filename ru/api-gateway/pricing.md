---
title: Правила тарификации для {{ api-gw-full-name }}
description: В статье содержатся правила тарификации сервиса {{ api-gw-name }}.
editable: false
---

# Правила тарификации для {{ api-gw-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ api-gw-name }} {#rules}

В рамках сервиса {{ api-gw-name }} тарифицируется количество запросов к созданным API-шлюзам и исходящий трафик. 

{% note warning %}

{{ api-gw-name }} обрабатывает только запросы по протоколу HTTPS. Сервис автоматически перенаправляет все запросы к API-шлюзам по протоколу HTTP на их HTTPS-версии. 

{% endnote %}

### Формула расчета стоимости {#price-formula}

{% include [prices-difference](../_includes/prices-difference.md) %}


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  Стоимость в месяц = {{ sku|RUB|api-gateway.requests.v1|pricingRate.0.1|string }} × Количество миллионов запросов

- Стоимость в тенге {#prices-kzt}

  Стоимость в месяц = {{ sku|KZT|api-gateway.requests.v1|pricingRate.0.1|string }} × Количество миллионов запросов

{% endlist %}



{% include [not-charged-gateway.md](../_includes/pricing/price-formula/not-charged-gateway.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Пример расчета стоимости API-шлюза {#price-example}

{% include [prices-example](../_includes/api-gateway/prices-example.md) %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|api-gateway }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
