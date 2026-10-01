---
title: Правила тарификации для {{ cloud-desktop-full-name }}
description: В статье содержатся правила тарификации сервиса {{ cloud-desktop-name }}.
editable: false
---

# Правила тарификации для {{ cloud-desktop-full-name }}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    indent:
      top: '0'
      bottom: '0'
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        gravityIcon: Calculator
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=3042f36704c0#calculator
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
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn25bk2bcun5eb7kkdq0
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::





{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ cloud-desktop-name }} {#rules}

Расчет стоимости использования {{ cloud-desktop-name }} учитывает:

* Вычислительные ресурсы:
  
  * количество ядер (vCPU);
  * объем памяти (RAM).

* Тип и объем диска.
* Объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование вычислительных ресурсов {#use-resources}

Стоимость выделенных вычислительных ресурсов рассчитывается за время использования рабочих столов, начиная с перехода в статус `CREATING` (при создании) или `STARTING` (при запуске) и до полной остановки. Время, которое рабочие столы были выключены, не тарифицируется.

Рабочий стол запускается автоматически после создания.

### Использование дисков {#use-storage}

Диски тарифицируются независимо от того, запущены рабочие столы или нет.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|cloud_desktop }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

## Пример расчета стоимости {#price-example}

Пример расчета стоимости {{ cloud-desktop-name }} за один месяц для группы из десяти рабочих столов следующей конфигурации:

* Вычислительные ресурсы: 2 × 50% vCPU и 2 ГБ RAM.
* Загрузочный диск: 50 ГБ SSD.
* Рабочий диск: 30 ГБ HDD.
* Общее время работы всех рабочих столов в течение месяца: 1 000 часов.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-cloud-desktop](../_pricing_examples/cloud-desktop/rub.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-cloud-desktop](../_pricing_examples/cloud-desktop/kzt.md) %}

{% endlist %}



