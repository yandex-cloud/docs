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

Если несколько [Docker-образов](concepts/artifacts/docker.md) в одном реестре используют одни и те же слои, хранение каждого переиспользуемого слоя повторно не тарифицируется. Уникальность слоя определяется по его [хешу](concepts/artifacts/docker.md#version).

{% endnote %}

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|cloud_registry }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

