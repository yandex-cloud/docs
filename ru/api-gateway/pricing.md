---
title: Правила тарификации для {{ api-gw-full-name }}
description: В статье содержатся правила тарификации сервиса {{ api-gw-name }}.
editable: false
---

# Правила тарификации для {{ api-gw-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## Из чего складывается стоимость использования {{ api-gw-name }} {#rules}

В рамках сервиса {{ api-gw-name }} тарифицируется количество запросов к созданным API-шлюзам и исходящий трафик. 

{% note warning %}

{{ api-gw-name }} обрабатывает только запросы по протоколу HTTPS. Сервис автоматически перенаправляет все запросы к API-шлюзам по протоколу HTTP на их HTTPS-версии. 

{% endnote %}

### Формула расчета стоимости {#price-formula}


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

### Запросы к API-шлюзам {#request}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/api-gateway/rub.md) %}
  
  Оплачивается фактическое количество вызовов.

  > Например, 10 000 вызовов сверх нетарифицируемого объема стоят {% calc [currency=RUB] {{ sku|RUB|api-gateway.requests.v1|pricingRate.0.1|number }} / 100 %}, если 1 миллион запросов стоит {{ sku|RUB|api-gateway.requests.v1|pricingRate.0.1|string }}.

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/api-gateway/kzt.md) %}
  
  Оплачивается фактическое количество вызовов.

  > Например, 10 000 вызовов сверх нетарифицируемого объема стоят {% calc [currency=KZT] {{ sku|KZT|api-gateway.requests.v1|pricingRate.0.1|number }} / 100 %}, если 1 миллион запросов стоит {{ sku|KZT|api-gateway.requests.v1|pricingRate.0.1|string }}.

{% endlist %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
