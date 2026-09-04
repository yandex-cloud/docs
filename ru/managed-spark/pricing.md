---
title: Правила тарификации для {{ msp-full-name }}
description: В статье содержатся правила тарификации сервиса {{ msp-full-name }}.
editable: false
---

# Правила тарификации для {{ msp-full-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        gravityIcon: Calculator
        iconPosition: left
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=ed36e957a49d#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        gravityIcon: CircleRuble
        iconPosition: left
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2pkj6x6txcsqlb72gm
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса {{ msp-full-name }}, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы. За потребление других ресурсов {{ yandex-cloud }}, которые вы используете в процессе работы с сервисом, взимается плата в соответствии с их тарифами.


{% include [vat](../_includes/vat.md) %}

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища.

## Из чего складывается стоимость использования {{ msp-full-name }} {#rules}

При работе с {{ msp-full-name }} вы оплачиваете:

* вычислительные ресурсы компонентов кластера;
* объем исходящего трафика из {{ yandex-cloud }} в интернет.

Стоимость начисляется за каждую минуту работы кластера. Минимальная единица тарификации — минута (например, стоимость 1,5 минуты работы кластера равна стоимости 2 минут).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Пример расчета стоимости кластера {#example}

Стоимость использования кластера со следующими параметрами в течение 30 дней:

* **Системная нода кластера:** потребляет фиксированное количество: 8 vCPU, 8 ГБ RAM.
* **Драйвер**: два экземпляра конфигурации `standard`, [класс хоста](concepts/instance-types.md) `c4-m16`, фиксированное количество: 4 vCPU, 16 ГБ RAM.
* **Исполнитель**: четыре экземпляра конфигурации `standard`, класс хоста `c4-m16`, фиксированное количество: 4 vCPU, 16 ГБ RAM.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-host](../_pricing_examples/managed-spark/rub-host.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-host](../_pricing_examples/managed-spark/kzt-host.md) %}

{% endlist %}





## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|spark }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>





{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

