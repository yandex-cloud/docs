---
title: Правила тарификации для {{ metadata-hub-full-name }}
description: В статье содержатся правила тарификации сервиса {{ metadata-hub-name }}.
editable: false
---

# Правила тарификации для {{ metadata-hub-full-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 6
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: ../_assets/console-icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=e093287099a9#calculator
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
        url: https://yandex.cloud/ru/price-list?services=dn2rnt6lkfbauucwnfby
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


Использование {{ connection-manager-name }}, {{ schema-registry-name }} и {{ data-catalog-name }} не тарифицируется. За потребление других ресурсов {{ yandex-cloud }}, которые вы используете в процессе работы с этими сервисами (например, сервисов управляемых баз данных или [{{ lockbox-name }}](../lockbox/pricing.md)), взимается плата в соответствии с их [тарифами]({{ link-cloud-calculator }}).


{% include [vat](../_includes/vat.md) %}

## Тарификация кластеров {{ metastore-full-name }} {#metastore}

{% note info %}

Приведенные правила тарификации действуют с 22 сентября 2025 года.

{% endnote %}

При работе с {{ metastore-full-name }} вы оплачиваете вычислительные ресурсы кластера. Стоимость начисляется за каждую минуту работы кластера. Минимальная единица тарификации — минута (например, стоимость 1,5 минуты работы кластера равна стоимости 2 минут).

Остановленный кластер (статус `Stopped`) не тарифицируется.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Цены для региона Россия {#metastore-prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|metadatahub }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




{% include [metastore-trademark](../_includes/metadata-hub/metastore-trademark.md) %}
