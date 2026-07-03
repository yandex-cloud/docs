---
title: Правила тарификации для {{ api-gw-full-name }}
description: В статье содержатся правила тарификации сервиса {{ api-gw-name }}.
editable: false
---

# Правила тарификации для {{ api-gw-full-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: ../_assets/console-icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=010ed675dad6#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: ../_assets/console-icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn25mc2lq81eqg1ohe4i
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: ../_assets/console-icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::





{% include [vat](../_includes/vat.md) %}

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


<MDX>
  <PriceList
    serviceIds={['{{ pcs|api-gateway }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
