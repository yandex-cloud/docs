---
title: Правила тарификации для {{ vision-name }}
description: В этой статье описаны правила тарификации {{ vision-short-name }}.
editable: false
---

# Правила тарификации для {{ vision-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ vision-short-name }} {#rules}

Сервис {{ vision-name }} позволяет распознавать текст на изображениях.

Каждый выполненный запрос на распознавание изображения для любой из [моделей распознавания](concepts/ocr/index.md#models) — одна _единица тарификации_:

* Если в запросе передано несколько изображений или файл PDF состоит из нескольких страниц, каждое изображение или каждая страница будет тарифицироваться отдельно.
* Если вы запросили дважды распознать текст для одного изображения — это будет две единицы тарификации. Это полезно, если текст [на языках из разных языковых моделей](./concepts/ocr/supported-languages.md), например на арабском и иврите.
* Учитывается только выполненный анализ. С вас не снимут деньги, если сервер не работал или вы задали неправильную конфигурацию в запросе.

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/vision/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt](../_pricing/vision/kzt.md) %}

{% endlist %}


