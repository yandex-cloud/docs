---
title: Правила тарификации для {{ search-api-full-name }}
description: В статье содержатся правила тарификации сервиса {{ search-api-name }}.
editable: false
---

# Правила тарификации для {{ search-api-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## Из чего складывается стоимость использования {{ search-api-name }} {#rules}

Стоимость использования {{ search-api-name }} рассчитывается, исходя из количества инициированных поисковых запросов за календарный месяц ([Отчетный период](../billing/concepts/reporting-period.md)).

На стадии [Preview](../overview/concepts/launch-stages.md) [отложенные запросы](concepts/web-search.md) не тарифицируются.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Уровень нетарифицированного потребления (free tier) для каждого пользователя составляет 1000 запросов в месяц в ночные часы^1^ с 00:00:00 по 07:59:59. Запросы, превышающие эти значения, оплачиваются по следующим тарифам.


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include notitle [rub.md](../_pricing/search-api/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include notitle[kzt](../_pricing/search-api/kzt.md) %}

{% endlist %}



Для всех новых пользователей сервиса действует квота в 30 000 запросов в месяц (1000 запросов в день). Подробнее об ограничениях см. в разделе [Квоты и лимиты](concepts/limits.md). Для изменения значений квот обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

^1^ Время указано в часовом поясе [UTC+3](https://ru.wikipedia.org/wiki/UTC%2B3:00).
