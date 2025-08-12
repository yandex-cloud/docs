---
title: Правила тарификации для {{ cloud-desktop-full-name }}
description: В статье содержатся правила тарификации сервиса {{ cloud-desktop-name }}.
editable: false
---

# Правила тарификации для {{ cloud-desktop-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ cloud-desktop-name }} {#rules}

Расчет стоимости использования {{ cloud-desktop-name }} учитывает:

* Вычислительные ресурсы:
  * количество ядер (vCPU);
  * объем памяти (RAM).
* Тип и объем диска.
* Объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

Цены за месяц использования формируются из расчета 720 часов в месяц.

### Использование вычислительных ресурсов {#use-resources}

Стоимость выделенных вычислительных ресурсов рассчитывается за время использования рабочих столов, начиная с перехода в статус `CREATING` (при создании) или `STARTING` (при запуске) и до полной остановки. Время, которое рабочие столы были выключены, не тарифицируется.

Рабочий стол запускается автоматически после создания.

### Использование дисков {#use-storage}

Диски тарифицируются независимо от того, запущены рабочие столы или нет.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Вычислительные ресурсы {#prices-desktop-resources}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-desktop-resources.md](../_pricing/cloud-desktop/rub-desktop-resources.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-desktop-resources.md](../_pricing/cloud-desktop/kzt-desktop-resources.md) %}

{% endlist %}



### Диски {#prices-storage}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage.md](../_pricing/cloud-desktop/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage.md](../_pricing/cloud-desktop/kzt-storage.md) %}

{% endlist %}



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



