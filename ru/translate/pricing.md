---
title: Правила тарификации для {{ translate-full-name }}
description: В статье содержатся правила тарификации сервиса {{ translate-name }}.
editable: false
---

# Правила тарификации для {{ translate-name }}



{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Из чего складывается стоимость использования {{ translate-short-name }} {#rules}


### Использование перевода и определения языка текста {#rules-translate-detect}

Стоимость использования {{ translate-full-name }} рассчитывается, исходя из суммарного количества символов, которые были отправлены в запросах на перевод и определение языка текста за календарный месяц ([Отчетный период](../billing/concepts/reporting-period.md)). При этом [запросы на перевод](operations/translate.md) тарифицируются только как перевод текста. Определение языка оригинала, если он не указан явно в запросе на перевод, входит в стоимость перевода. Определение языка тарифицируется, если выполнен отдельный [запрос на определение языка](operations/detect.md) .

{% include [pricing-symbol-count](../_includes/pricing-symbol-count.md) %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Перевод и определение языка текста {#prices-translate-detect}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/translate/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/translate/kzt.md) %}

{% endlist %}



