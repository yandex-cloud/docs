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



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Запись данных {#data-ingested}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-data-ingested.md](../_pricing/logging/rub-data-ingested.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-data-ingested.md](../_pricing/logging/kzt-data-ingested.md) %}

{% endlist %}




### Хранение данных {#storage}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub-storage.md](../_pricing/logging/rub-storage.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt-storage.md](../_pricing/logging/kzt-storage.md) %}

{% endlist %}




Если вы не израсходовали нетарифицируемый объем услуг до конца календарного месяца, остаток обнуляется.
