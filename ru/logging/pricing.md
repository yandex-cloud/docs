---
title: Правила тарификации для {{ cloud-logging-full-name }}
description: В статье содержатся правила тарификации сервиса {{ cloud-logging-name }}.
editable: false
---

# Правила тарификации для {{ cloud-logging-name }}

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ cloud-logging-name }} {#rules}

В рамках сервиса {{ cloud-logging-name }} тарифицируются объем записываемых данных и время их хранения.

Цены за месяц использования формируются из расчета 720 часов в месяц.


## Цены для региона Россия {#prices}




{% include [prices-nds-note](../_includes/prices-nds-note.md) %}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|logging }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>





Если вы не израсходовали нетарифицируемый объем услуг до конца календарного месяца, остаток обнуляется.
