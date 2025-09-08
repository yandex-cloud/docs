---
title: Правила тарификации для {{ cloud-registry-full-name }}
description: В статье содержатся правила тарификации сервиса {{ cloud-registry-name }}.
editable: false
---

# Правила тарификации для {{ cloud-registry-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

## Из чего складывается стоимость использования {{ cloud-registry-name }} {#rules}

Расчет стоимости использования {{ cloud-registry-name }} учитывает:
* Объем хранилища, занятый данными.
* Объем исходящего трафика.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Использование хранилища {#rules-storage}

Использование хранилища измеряется в ГБ в час. Объемом хранимых в течение месяца данных считается среднее значение за месяц, согласно данным, гранулированным посекундно. Минимальная единица тарификации — час хранения 1 МБ данных.

{% note warning %}

Если несколько [Docker-образов](concepts/docker-image.md) в одном реестре используют одни и те же слои, хранение каждого переиспользуемого слоя повторно не тарифицируется. Уникальность слоя определяется по его [хешу](concepts/docker-image.md#version).

{% endnote %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% note warning %}

Цены действуют с 15 сентября 2025 года.

{% endnote %}

### Хранение данных {#prices-storage}


{% list tabs group=pricing %}

- Цены в рублях {#prices-rub}

  {% include [rub.md](../_pricing/cloud-registry/rub.md) %}

- Цены в тенге {#prices-kzt}

  {% include [kzt.md](../_pricing/cloud-registry/kzt.md) %}

{% endlist %}



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

