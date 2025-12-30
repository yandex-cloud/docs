---
title: Правила тарификации для {{ yq-full-name }}
description: В статье содержатся правила тарификации сервиса {{ yq-name }}.
editable: false
---

# Правила тарификации для {{ yq-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

В {{ yq-full-name }} тарифицируется объем считанных из источников данных при исполнении запросов. Если данные считываются из нескольких источников, их объем суммируется.

## Цены для региона Россия {#prices}

{% include [prices-nds-note](../_includes/prices-nds-note.md) %}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|yq }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




Отдельные условия:

* Если исполнение запроса было прервано по любой системной причине, то исполнение такого запроса не тарифицируется.
* Если исполнение запроса было остановлено пользователем, то применяется тарификация по объему считанных данных к моменту остановки запроса.
* Если при выполнении запроса общий объем считанных данных составит менее 10 МБ, то объем будет округлен до 10 МБ.

## Примеры расчета стоимости {#examples}

{% include [prices-difference](../_includes/prices-difference.md) %}

Все примеры ниже приведены без учета уровня бесплатного потребления.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-query](../_pricing_examples/query/rub-query.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-query](../_pricing_examples/query/kzt-query.md) %}

{% endlist %}



## Оплата за использованные ресурсы смежных систем {#cloud-systems}

Использованные ресурсы смежных систем хранения и передачи данных, используемые в запросах {{ yq-full-name }}, оплачиваются отдельно.

|Ресурс|Описание|
|---|---|
|Чтение и запись данных в {{ objstorage-full-name }}|[Тарифы](../storage/pricing.md)|
|Чтение и запись данных в {{ yds-full-name }}|[Тарифы](../data-streams/pricing.md)|

