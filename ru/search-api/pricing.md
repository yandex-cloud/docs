---
title: Правила тарификации для {{ search-api-full-name }}
description: В статье содержатся правила тарификации сервиса {{ search-api-name }}.
editable: false
---

# Правила тарификации для {{ search-api-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ search-api-name }} {#rules}

Стоимость использования {{ search-api-name }} рассчитывается, исходя из количества инициированных поисковых запросов за календарный месяц ([Отчетный период](../billing/concepts/reporting-period.md)).

Функциональность {{ wordstat-name }} на [стадии Preview](../overview/concepts/launch-stages.md) не тарифицируется.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

В ночные часы с 00:00:00 по 07:59:59 [UTC+3](https://ru.wikipedia.org/wiki/UTC%2B3:00) для некоторых типов запросов действуют льготные тарифы.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub](../_pricing/search-api/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle [kzt](../_pricing/search-api/kzt.md) %}

{% endlist %}



Для пользователей сервиса действуют квоты. Подробнее об ограничениях см. в разделе [Квоты и лимиты](concepts/limits.md). Для изменения значений квот обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

## Примеры расчета стоимости {#price-example}

{% include [prices-difference](../_includes/prices-difference.md) %}

Стоимость использования {{ search-api-name }} для инициированных поисковых запросов через [API v2](./concepts/index.md#api-v2) со следующими параметрами:

* **Количество синхронных запросов в дневное время, отправленных за месяц**: 250 000.
* **Количество отложенных запросов в дневное время, отправленных за месяц**: 50 000.
* **Количество синхронных запросов с генеративным ответом, отправленных за месяц**: 10 000.


{% list tabs group=pricing %}

- Расчет в рублях {#prices-rub}

  {% include [rub-api-v2](../_pricing_examples/search-api/rub-api-v2.md) %}

- Расчет в тенге {#prices-kzt}

  {% include [kzt-api-v2](../_pricing_examples/search-api/kzt-api-v2.md) %}

{% endlist %}


