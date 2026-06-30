---
title: Правила тарификации для {{ cdn-full-name }}
description: В статье содержатся правила тарификации сервиса {{ cdn-full-name }}.
editable: false
---

# Правила тарификации для {{ cdn-full-name }}

{% note warning %}


С 1 июля 2026 года действует новая модель тарификации {{ cdn-name }}.



{% endnote %}


{% note tip %}

Чтобы рассчитать стоимость использования сервиса, воспользуйтесь [калькулятором](https://yandex.cloud/ru/prices?state=a1555aa1718c#calculator) на сайте {{ yandex-cloud }} или ознакомьтесь с тарифами в этом разделе.

{% endnote %}



{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [vat](../_includes/vat.md) %}

При расчете стоимости использования {{ cdn-name }} учитываются:
* Количество [CDN-ресурсов](./concepts/resource.md).
* Объем исходящего трафика, превышающего 150 ГБ бесплатного объема в месяц для каждого ресурса, за каждый 1 ГБ. 

    При удалении ресурса, оставшийся бесплатный трафик обнуляется. Передача трафика между ресурсами невозможна.

    Учитывается исходящий трафик с CDN-серверов, в том числе запрошенный с пользовательских ресурсов сервисов {{ yandex-cloud }}, например с [виртуальных машин](../compute/concepts/vm.md) {{ compute-full-name }}. Входящий трафик, поступающий на CDN-серверы от сервисов и ресурсов {{ yandex-cloud }} и из интернета, не тарифицируется.

* Количество запросов к CDN-ресурсам, превышающее бесплатный порог в 100 000 000 запросов в месяц, за каждые 100 000 запросов.
* Платные функции, включенные для ресурсов: [экранирование источников](concepts/origins-shielding.md), [выгрузка логов](./concepts/logs.md) и [выделенная IP-адресация](./concepts/dedicated-ip-addressing.md).


## Цены для региона Россия {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

В день включения [экранирования источников](concepts/origins-shielding.md) или [выгрузки логов](concepts/logs.md) списывается плата за полный месяц. Далее плата взимается первого числа каждого следующего месяца.

При [подключении выделенной IP-адресации](operations/resources/dedicated-ip-addressing.md) вы можете выбрать схему оплаты:

* За каждый [CDN-ресурс](concepts/resource.md) отдельно. Выгодно, если CDN-ресурсов немного или выделенная IP-адресация нужна только для некоторых из них.
* За все CDN-ресурсы [платежного аккаунта](../billing/concepts/billing-account.md). Выгодно, если выделенная IP-адресация нужна для множества CDN-ресурсов.

{% include [pricing-for-dedicated-ip.md](../_includes/cdn/pricing-for-dedicated-ip.md) %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|cdn }}']}
    installationCode="ru"
    currency="RUB"
  />
</MDX>




