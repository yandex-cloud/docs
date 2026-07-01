---
title: Правила тарификации для {{ cdn-full-name }}
description: В статье содержатся правила тарификации сервиса {{ cdn-full-name }}.
editable: false
---

# Правила тарификации для {{ cdn-full-name }}

{% note warning %}


С 1 июля 2026 года действует новая модель тарификации {{ cdn-name }}.



{% endnote %}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        icon: _assets/icons/calculator.svg
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=e95a12e787e7#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        icon: _assets/icons/circle-ruble.svg
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2rse5n40m8h0bu8jqa
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Акции и free tier
        text: Гранты, специальные условия и программы поддержки
        icon: _assets/icons/flame.svg
        urlTitle: Акции и free tier
        url: https://yandex.cloud/ru/all-offers
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




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



