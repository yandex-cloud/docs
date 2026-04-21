---
title: Правила тарификации для {{ cdn-full-name }}
description: В статье содержатся правила тарификации сервиса {{ cdn-full-name }}.
editable: false
---

# Правила тарификации для {{ cdn-full-name }}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

При расчете стоимости использования {{ cdn-name }} учитываются:
* Объем исходящего трафика с CDN-серверов, в том числе запрошенного с пользовательских ресурсов сервисов {{ yandex-cloud }}, например с [виртуальных машин](../compute/concepts/vm.md) {{ compute-full-name }}. Входящий трафик, поступающий на CDN-серверы от сервисов и ресурсов {{ yandex-cloud }} и из интернета, не тарифицируется.
* Платные функции, включенные для ресурсов: [экранирование источников](concepts/origins-shielding.md) и [выгрузка логов](concepts/logs.md).

## Цены для региона Россия {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

В день включения экранирования источников или выгрузки логов списывается плата за полный месяц. Далее плата взимается первого числа каждого следующего месяца.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|cdn }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




