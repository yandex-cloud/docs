---
title: Правила тарификации для {{ serverless-containers-full-name }}
description: В статье содержатся правила тарификации сервиса {{ serverless-containers-name }}.
editable: false
---

# Правила тарификации для {{ serverless-containers-name }}

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
        url: https://yandex.cloud/ru/prices?state=82a0fa0c0f6f#calculator
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
        url: https://yandex.cloud/ru/price-list?services=dn2qu7ck7veplf4kmbuh
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

## Из чего складывается стоимость использования {{ serverless-containers-name }} {#rules}

В рамках сервиса {{ serverless-containers-name }} тарифицируется количество вызовов контейнеров, вычислительные ресурсы, выделенные для выполнения приложения, время простоя [подготовленных экземпляров](concepts/container.md#provisioned-instances) и исходящий трафик.

При тарификации вычислительных ресурсов учитывается количество ядер процессора (vCPU), [уровень производительности ядра](../compute/concepts/performance-levels.md), объем памяти, выделенный для приложения, и время выполнения приложения:

* Количество ядер, указанное при создании ревизии, измеряется в vCPU и является положительным вещественным числом.
* Уровень производительности ядра, указанный при создании ревизии, измеряется в процентах.
* Объем памяти, указанный при создании ревизии, измеряется в ГБ.
* Суммарное время работы контейнера измеряется в часах, и округляется в большую сторону до ближайшего значения, кратного 100 мс.

{% note warning %}

Тарифицируются только вызовы контейнера, которые привели к запуску приложения.

{% endnote %}

### Формула расчета стоимости {#formula}


{% list tabs group=pricing %}

- Стоимость в рублях {#prices-rub}

  {% include [rub-formula](../_pricing_examples/serverless-containers/rub-formula.md) %}

- Стоимость в тенге {#prices-kzt}

  {% include [kzt-formula](../_pricing_examples/serverless-containers/kzt-formula.md) %}

{% endlist %}



{% include [not-charged-sc.md](../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Примеры расчета стоимости {#example}

Пример расчета стоимости контейнера, у которого:

* **Объем памяти, указанный при создании ревизии**: 2 ГБ.
* **Количество ядер**: 20% vCPU.
* **Количество вызовов контейнера**: 3 000 000.
* **Время выполнения при каждом вызове**: 150 мс.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-example-20pct](../_pricing_examples/serverless-containers/rub-example-20pct.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-example-20pct](../_pricing_examples/serverless-containers/kzt-example-20pct.md) %}

{% endlist %}



Пример расчета стоимости контейнера, у которого:

* **Объем памяти, указанный при создании ревизии**: 2 ГБ.
* **Количество ядер**: 100% vCPU.
* **Количество вызовов контейнера**: 3 000 000.
* **Время выполнения при каждом вызове**: 150 мс.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-example-100pct](../_pricing_examples/serverless-containers/rub-example-100pct.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-example-100pct](../_pricing_examples/serverless-containers/kzt-example-100pct.md) %}

{% endlist %}



## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|serverless-containers }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

