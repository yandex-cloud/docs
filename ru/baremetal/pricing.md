---
title: Правила тарификации для {{ baremetal-full-name }}
description: В статье содержатся правила тарификации сервиса {{ baremetal-name }}.
editable: false
---

# Правила тарификации для {{ baremetal-full-name }}

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
        url: https://yandex.cloud/ru/prices?state=19a1a419e01b#calculator
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
        url: https://yandex.cloud/ru/price-list?services=dn2jfbheag6vvls7oplt
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

В сервисе {{ baremetal-name }} оплачивается срок аренды сервера [определенной конфигурации](concepts/server-configurations.md). Арендованный сервер тарифицируется в течение всего периода аренды, независимо от того, включен он или выключен.

{% note warning %}

Прервать аренду сервера в течение выбранного периода аренды нельзя. Сервер тарифицируется за весь оплаченный период независимо от способа оплаты и порядка списания средств. Вы можете [отказаться](../baremetal/operations/servers/server-lease-cancel.md) от автоматического продления аренды — в этом случае сервер проработает до конца оплаченного периода, а затем будет удален.

{% endnote %}

Доступное количество серверов определенной конфигурации указано в [калькуляторе](https://yandex.cloud/ru/prices) на сайте {{ yandex-cloud }} и в [консоли управления]({{ link-console-main }}) при выборе сервера.

## Цены для региона Россия {#prices}

Все цены указаны за 1 месяц.

### Стоимость готовых конфигураций серверов {#standard}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Стоимость может зависеть от [периода аренды](../baremetal/concepts/servers.md#server-lease).

Порядок списания средств зависит от способа оплаты:

* Если к платежному аккаунту привязана банковская карта, списания происходят **ежедневно** независимо от периода аренды. Общая сумма за месяц равна стоимости выбранного периода аренды.
* Для юридических лиц, работающих с оплатой по счету, счет формируется **раз в месяц** независимо от периода аренды.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.ba-i103-s-10g.1-day }}',
      '{{ pc|baremetal.server.ba-i103-s-10g.1-month }}',
      '{{ pc|baremetal.server.ba-i103-s-10g.3-month }}',
      '{{ pc|baremetal.server.ba-i103-s-10g.6-month }}',
      '{{ pc|baremetal.server.ba-i103-s-10g.12-month }}',
      '{{ pc|baremetal.server.ba-i106-sh-10g.1-day }}',
      '{{ pc|baremetal.server.ba-i106-sh-10g.1-month }}',
      '{{ pc|baremetal.server.ba-i106-sh-10g.3-month }}',
      '{{ pc|baremetal.server.ba-i106-sh-10g.6-month }}',
      '{{ pc|baremetal.server.ba-i106-sh-10g.12-month }}',
      '{{ pc|baremetal.server.ba-i111-8s-10g.1-day }}',
      '{{ pc|baremetal.server.ba-i111-8s-10g.1-month }}',
      '{{ pc|baremetal.server.ba-i111-8s-10g.3-month }}',
      '{{ pc|baremetal.server.ba-i111-8s-10g.6-month }}',
      '{{ pc|baremetal.server.ba-i111-8s-10g.12-month }}',
      '{{ pc|baremetal.server.ba-i200-h.1-day }}',
      '{{ pc|baremetal.server.ba-i200-h.1-month }}',
      '{{ pc|baremetal.server.ba-i200-h.3-month }}',
      '{{ pc|baremetal.server.ba-i200-h.6-month }}',
      '{{ pc|baremetal.server.ba-i200-h.12-month }}',
      '{{ pc|baremetal.server.ba-i201-h.1-day }}',
      '{{ pc|baremetal.server.ba-i201-h.1-month }}',
      '{{ pc|baremetal.server.ba-i201-h.3-month }}',
      '{{ pc|baremetal.server.ba-i201-h.6-month }}',
      '{{ pc|baremetal.server.ba-i201-h.12-month }}',
      '{{ pc|baremetal.server.ba-i202-s.1-day }}',
      '{{ pc|baremetal.server.ba-i202-s.1-month }}',
      '{{ pc|baremetal.server.ba-i202-s.3-month }}',
      '{{ pc|baremetal.server.ba-i202-s.6-month }}',
      '{{ pc|baremetal.server.ba-i202-s.12-month }}',
      '{{ pc|baremetal.server.ba-i203-s-10g.1-day }}',
      '{{ pc|baremetal.server.ba-i203-s-10g.1-month }}',
      '{{ pc|baremetal.server.ba-i203-s-10g.3-month }}',
      '{{ pc|baremetal.server.ba-i203-s-10g.6-month }}',
      '{{ pc|baremetal.server.ba-i203-s-10g.12-month }}',
      '{{ pc|baremetal.server.ba-i204-sh.1-day }}',
      '{{ pc|baremetal.server.ba-i204-sh.1-month }}',
      '{{ pc|baremetal.server.ba-i204-sh.3-month }}',
      '{{ pc|baremetal.server.ba-i204-sh.6-month }}',
      '{{ pc|baremetal.server.ba-i204-sh.12-month }}',
      '{{ pc|baremetal.server.ba-i205-sh.1-day }}',
      '{{ pc|baremetal.server.ba-i205-sh.1-month }}',
      '{{ pc|baremetal.server.ba-i205-sh.3-month }}',
      '{{ pc|baremetal.server.ba-i205-sh.6-month }}',
      '{{ pc|baremetal.server.ba-i205-sh.12-month }}',
      '{{ pc|baremetal.server.ba-i206-sh-10g.1-day }}',
      '{{ pc|baremetal.server.ba-i206-sh-10g.1-month }}',
      '{{ pc|baremetal.server.ba-i206-sh-10g.3-month }}',
      '{{ pc|baremetal.server.ba-i206-sh-10g.6-month }}',
      '{{ pc|baremetal.server.ba-i206-sh-10g.12-month }}',
      '{{ pc|baremetal.server.ba-i207-h.1-day }}',
      '{{ pc|baremetal.server.ba-i207-h.1-month }}',
      '{{ pc|baremetal.server.ba-i207-h.3-month }}',
      '{{ pc|baremetal.server.ba-i207-h.6-month }}',
      '{{ pc|baremetal.server.ba-i207-h.12-month }}',
      '{{ pc|baremetal.server.ba-i208-s-10g.1-day }}',
      '{{ pc|baremetal.server.ba-i208-s-10g.1-month }}',
      '{{ pc|baremetal.server.ba-i208-s-10g.3-month }}',
      '{{ pc|baremetal.server.ba-i208-s-10g.6-month }}',
      '{{ pc|baremetal.server.ba-i208-s-10g.12-month }}',
      '{{ pc|baremetal.server.ba-i209-ss-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i209-ss-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i209-ss-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i209-ss-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i209-ss-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i211-8s-10g.1-day }}',
      '{{ pc|baremetal.server.ba-i211-8s-10g.1-month }}',
      '{{ pc|baremetal.server.ba-i211-8s-10g.3-month }}',
      '{{ pc|baremetal.server.ba-i211-8s-10g.6-month }}',
      '{{ pc|baremetal.server.ba-i211-8s-10g.12-month }}',
      '{{ pc|baremetal.server.ba-i217-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i217-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i217-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i217-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i217-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i218-s.1-day }}',
      '{{ pc|baremetal.server.ba-i218-s.1-month }}',
      '{{ pc|baremetal.server.ba-i218-s.3-month }}',
      '{{ pc|baremetal.server.ba-i218-s.6-month }}',
      '{{ pc|baremetal.server.ba-i218-s.12-month }}',
      '{{ pc|baremetal.server.ba-i303-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i303-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i303-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i303-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i303-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i304-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i304-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i304-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i304-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i304-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i305-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i305-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i305-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i305-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i305-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i306-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i306-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i306-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i306-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i306-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i307-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i307-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i307-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i307-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i307-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i308-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i308-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i308-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i308-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i308-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i309-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i309-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i309-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i309-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i309-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i310-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.ba-i310-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.ba-i310-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.ba-i310-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.ba-i310-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.ba-i311-s.1-day }}',
      '{{ pc|baremetal.server.ba-i311-s.1-month }}',
      '{{ pc|baremetal.server.ba-i311-s.3-month }}',
      '{{ pc|baremetal.server.ba-i311-s.6-month }}',
      '{{ pc|baremetal.server.ba-i311-s.12-month }}',
      '{{ pc|baremetal.server.ba-i407-s-10g.1-day }}',
      '{{ pc|baremetal.server.ba-i407-s-10g.1-month }}',
      '{{ pc|baremetal.server.ba-i407-s-10g.3-month }}',
      '{{ pc|baremetal.server.ba-i407-s-10g.6-month }}',
      '{{ pc|baremetal.server.ba-i407-s-10g.12-month }}',
      '{{ pc|baremetal.server.ba-i501-h-25g.1-day }}',
      '{{ pc|baremetal.server.ba-i501-h-25g.1-month }}',
      '{{ pc|baremetal.server.ba-i501-h-25g.3-month }}',
      '{{ pc|baremetal.server.ba-i501-h-25g.6-month }}',
      '{{ pc|baremetal.server.ba-i501-h-25g.12-month }}',
      '{{ pc|baremetal.server.ba-i506-nh-25g.1-day }}',
      '{{ pc|baremetal.server.ba-i506-nh-25g.1-month }}',
      '{{ pc|baremetal.server.ba-i506-nh-25g.3-month }}',
      '{{ pc|baremetal.server.ba-i506-nh-25g.6-month }}',
      '{{ pc|baremetal.server.ba-i506-nh-25g.12-month }}',
      '{{ pc|baremetal.server.ba-i507-nh-2x25g.1-day }}',
      '{{ pc|baremetal.server.ba-i507-nh-2x25g.1-month }}',
      '{{ pc|baremetal.server.ba-i507-nh-2x25g.3-month }}',
      '{{ pc|baremetal.server.ba-i507-nh-2x25g.6-month }}',
      '{{ pc|baremetal.server.ba-i507-nh-2x25g.12-month }}',
      '{{ pc|baremetal.server.ba-i511-nh-25g.1-day }}',
      '{{ pc|baremetal.server.ba-i511-nh-25g.1-month }}',
      '{{ pc|baremetal.server.ba-i511-nh-25g.3-month }}',
      '{{ pc|baremetal.server.ba-i511-nh-25g.6-month }}',
      '{{ pc|baremetal.server.ba-i511-nh-25g.12-month }}',
      '{{ pc|baremetal.server.ba-i512-nh-2x25g.1-day }}',
      '{{ pc|baremetal.server.ba-i512-nh-2x25g.1-month }}',
      '{{ pc|baremetal.server.ba-i512-nh-2x25g.3-month }}',
      '{{ pc|baremetal.server.ba-i512-nh-2x25g.6-month }}',
      '{{ pc|baremetal.server.ba-i512-nh-2x25g.12-month }}',
      '{{ pc|baremetal.server.ba-i523-nh-2x25g.1-day }}',
      '{{ pc|baremetal.server.ba-i523-nh-2x25g.1-month }}',
      '{{ pc|baremetal.server.ba-i523-nh-2x25g.3-month }}',
      '{{ pc|baremetal.server.ba-i523-nh-2x25g.6-month }}',
      '{{ pc|baremetal.server.ba-i523-nh-2x25g.12-month }}',
      '{{ pc|baremetal.server.ba-a612-n-25g.1-day }}',
      '{{ pc|baremetal.server.ba-a612-n-25g.1-month }}',
      '{{ pc|baremetal.server.ba-a612-n-25g.3-month }}',
      '{{ pc|baremetal.server.ba-a612-n-25g.6-month }}',
      '{{ pc|baremetal.server.ba-a612-n-25g.12-month }}',
      '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.1-day }}',
      '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.1-month }}',
      '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.3-month }}',
      '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.6-month }}',
      '{{ pc|baremetal.server.ba-a702-6n-4h-2x25g.12-month }}',
      '{{ pc|baremetal.server.ba-a704-4n-2x25g.1-day }}',
      '{{ pc|baremetal.server.ba-a704-4n-2x25g.1-month }}',
      '{{ pc|baremetal.server.ba-a704-4n-2x25g.3-month }}',
      '{{ pc|baremetal.server.ba-a704-4n-2x25g.6-month }}',
      '{{ pc|baremetal.server.ba-a704-4n-2x25g.12-month }}',
      '{{ pc|baremetal.server.ha-i302-s-10g.1-day }}',
      '{{ pc|baremetal.server.ha-i302-s-10g.1-month }}',
      '{{ pc|baremetal.server.ha-i302-s-10g.3-month }}',
      '{{ pc|baremetal.server.ha-i302-s-10g.6-month }}',
      '{{ pc|baremetal.server.ha-i302-s-10g.12-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.1-day }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.1-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.3-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.6-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4.12-month }}',
      '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.1-day }}',
      '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.1-month }}',
      '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.3-month }}',
      '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.6-month }}',
      '{{ pc|baremetal.server.ha-a701-6n-4h-2x25g.12-month }}',
      '{{ pc|baremetal.server.ha-a703-4n-2x25g.1-day }}',
      '{{ pc|baremetal.server.ha-a703-4n-2x25g.1-month }}',
      '{{ pc|baremetal.server.ha-a703-4n-2x25g.3-month }}',
      '{{ pc|baremetal.server.ha-a703-4n-2x25g.6-month }}',
      '{{ pc|baremetal.server.ha-a703-4n-2x25g.12-month }}',
      '{{ pc|baremetal.server.la-i100-h.1-day }}',
      '{{ pc|baremetal.server.la-i100-h.1-month }}',
      '{{ pc|baremetal.server.la-i100-h.3-month }}',
      '{{ pc|baremetal.server.la-i100-h.6-month }}',
      '{{ pc|baremetal.server.la-i100-h.12-month }}',
      '{{ pc|baremetal.server.la-i101-h.1-day }}',
      '{{ pc|baremetal.server.la-i101-h.1-month }}',
      '{{ pc|baremetal.server.la-i101-h.3-month }}',
      '{{ pc|baremetal.server.la-i101-h.6-month }}',
      '{{ pc|baremetal.server.la-i101-h.12-month }}',
      '{{ pc|baremetal.server.la-i102-s.1-day }}',
      '{{ pc|baremetal.server.la-i102-s.1-month }}',
      '{{ pc|baremetal.server.la-i102-s.3-month }}',
      '{{ pc|baremetal.server.la-i102-s.6-month }}',
      '{{ pc|baremetal.server.la-i102-s.12-month }}',
      '{{ pc|baremetal.server.la-i104-sh.1-day }}',
      '{{ pc|baremetal.server.la-i104-sh.1-month }}',
      '{{ pc|baremetal.server.la-i104-sh.3-month }}',
      '{{ pc|baremetal.server.la-i104-sh.6-month }}',
      '{{ pc|baremetal.server.la-i104-sh.12-month }}',
      '{{ pc|baremetal.server.la-i105-sh.1-day }}',
      '{{ pc|baremetal.server.la-i105-sh.1-month }}',
      '{{ pc|baremetal.server.la-i105-sh.3-month }}',
      '{{ pc|baremetal.server.la-i105-sh.6-month }}',
      '{{ pc|baremetal.server.la-i105-sh.12-month }}',
      '{{ pc|baremetal.server.la-i107-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.la-i107-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.la-i107-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.la-i107-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.la-i107-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.la-i108-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.la-i108-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.la-i108-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.la-i108-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.la-i108-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.la-i109-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.la-i109-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.la-i109-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.la-i109-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.la-i109-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.la-i110-s-1_10g.1-day }}',
      '{{ pc|baremetal.server.la-i110-s-1_10g.1-month }}',
      '{{ pc|baremetal.server.la-i110-s-1_10g.3-month }}',
      '{{ pc|baremetal.server.la-i110-s-1_10g.6-month }}',
      '{{ pc|baremetal.server.la-i110-s-1_10g.12-month }}',
      '{{ pc|baremetal.server.la-i113-s.1-day }}',
      '{{ pc|baremetal.server.la-i113-s.1-month }}',
      '{{ pc|baremetal.server.la-i113-s.3-month }}',
      '{{ pc|baremetal.server.la-i113-s.6-month }}',
      '{{ pc|baremetal.server.la-i113-s.12-month }}',
      '{{ pc|baremetal.server.la-i114-s.1-day }}',
      '{{ pc|baremetal.server.la-i114-s.1-month }}',
      '{{ pc|baremetal.server.la-i114-s.3-month }}',
      '{{ pc|baremetal.server.la-i114-s.6-month }}',
      '{{ pc|baremetal.server.la-i114-s.12-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Стоимость своих конфигураций серверов {#custom}

Итоговая стоимость своей конфигурации зависит от выбранных компонентов сервера.

{% cut "Цены на компоненты" %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal_custom }}']}
    skuIds={[
      '{{ pc|baremetal.component.bms-4-body.1-month }}',
      '{{ pc|baremetal.component.bms-4-body.6-month }}',
      '{{ pc|baremetal.component.bms-4-body.12-month }}',
      '{{ pc|baremetal.component.bms-5-body.1-month }}',
      '{{ pc|baremetal.component.bms-5-body.6-month }}',
      '{{ pc|baremetal.component.bms-5-body.12-month }}',
      '{{ pc|baremetal.server.bms-1027r-body.1-month }}',
      '{{ pc|baremetal.server.bms-1027r-body.6-month }}',
      '{{ pc|baremetal.server.bms-1027r-body.12-month }}',
      '{{ pc|baremetal.component.bms-1029p-body.1-month }}',
      '{{ pc|baremetal.component.bms-1029p-body.3-month }}',
      '{{ pc|baremetal.component.bms-1029p-body.6-month }}',
      '{{ pc|baremetal.component.bms-1029p-body.12-month }}',
      '{{ pc|baremetal.component.bms-6017r-1p-body.1-month }}',
      '{{ pc|baremetal.component.bms-6017r-1p-body.3-month }}',
      '{{ pc|baremetal.component.bms-6017r-1p-body.6-month }}',
      '{{ pc|baremetal.component.bms-6017r-1p-body.12-month }}',
      '{{ pc|baremetal.component.bms-6017r-2p-body.1-month }}',
      '{{ pc|baremetal.component.bms-6017r-2p-body.3-month }}',
      '{{ pc|baremetal.component.bms-6017r-2p-body.6-month }}',
      '{{ pc|baremetal.component.bms-6017r-2p-body.12-month }}',
      '{{ pc|baremetal.component.bms-6018r-body.1-month }}',
      '{{ pc|baremetal.component.bms-6018r-body.3-month }}',
      '{{ pc|baremetal.component.bms-6018r-body.6-month }}',
      '{{ pc|baremetal.component.bms-6018r-body.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-9374f.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-9374f.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-9374f.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-9654.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-9654.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-9654.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-a74f3.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-a74f3.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-a74f3.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7663.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7663.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7663.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7702.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7702.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7702.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7713.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7713.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-a7713.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6338.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6338.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6338.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6354.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6354.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6354.12-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2650v2.1-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2650v2.6-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2650v2.12-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2667v2.1-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2667v2.6-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2667v2.12-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2660.1-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2660.6-month }}',
      '{{ pc|baremetal.server.bms-cpu-ie5-2660.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-ie5-2660v4.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-ie5-2660v4.3-month }}',
      '{{ pc|baremetal.component.bms-cpu-ie5-2660v4.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-ie5-2660v4.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-ie5-2683v4.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-ie5-2683v4.3-month }}',
      '{{ pc|baremetal.component.bms-cpu-ie5-2683v4.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-ie5-2683v4.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6230.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6230.3-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6230.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6230.12-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6230r.1-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6230r.3-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6230r.6-month }}',
      '{{ pc|baremetal.component.bms-cpu-i6230r.12-month }}',
      '{{ pc|baremetal.component.bms-disk-h10t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-h10t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-h10t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-h18t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-h18t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-h18t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-h24t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-h24t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-h24t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-h2t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-h2t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-h2t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-h4t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-h4t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-h4t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-h6t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-h6t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-h6t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-h8t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-h8t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-h8t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-n1.9t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-n1.9t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-n1.9t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-n15t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-n15t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-n15t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-n3.2t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-n3.2t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-n3.2t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-n3.8t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-n3.8t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-n3.8t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-n30t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-n30t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-n30t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-n6.4t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-n6.4t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-n6.4t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-n7.6t.1-month }}',
      '{{ pc|baremetal.component.bms-disk-n7.6t.6-month }}',
      '{{ pc|baremetal.component.bms-disk-n7.6t.12-month }}',
      '{{ pc|baremetal.component.bms-disk-n960g.1-month }}',
      '{{ pc|baremetal.component.bms-disk-n960g.6-month }}',
      '{{ pc|baremetal.component.bms-disk-n960g.12-month }}',
      '{{ pc|baremetal.server.bms-disk-s0.9t.1-month }}',
      '{{ pc|baremetal.server.bms-disk-s0.9t.6-month }}',
      '{{ pc|baremetal.server.bms-disk-s0.9t.12-month }}',
      '{{ pc|baremetal.server.bms-disk-s1.9t.1-month }}',
      '{{ pc|baremetal.server.bms-disk-s1.9t.6-month }}',
      '{{ pc|baremetal.server.bms-disk-s1.9t.12-month }}',
      '{{ pc|baremetal.server.bms-disk-s3.8t.1-month }}',
      '{{ pc|baremetal.server.bms-disk-s3.8t.6-month }}',
      '{{ pc|baremetal.server.bms-disk-s3.8t.12-month }}',
      '{{ pc|baremetal.server.bms-disk-s7.6t.1-month }}',
      '{{ pc|baremetal.server.bms-disk-s7.6t.6-month }}',
      '{{ pc|baremetal.server.bms-disk-s7.6t.12-month }}',
      '{{ pc|baremetal.server.bms-net-1_10g.1-month }}',
      '{{ pc|baremetal.server.bms-net-1_10g.6-month }}',
      '{{ pc|baremetal.server.bms-net-1_10g.12-month }}',
      '{{ pc|baremetal.server.bms-net-2p1g.1-month }}',
      '{{ pc|baremetal.server.bms-net-2p1g.6-month }}',
      '{{ pc|baremetal.server.bms-net-2p1g.12-month }}',
      '{{ pc|baremetal.server.bms-net-2p10g.1-month }}',
      '{{ pc|baremetal.server.bms-net-2p10g.6-month }}',
      '{{ pc|baremetal.server.bms-net-2p10g.12-month }}',
      '{{ pc|baremetal.server.bms-net-2x2p10g.1-month }}',
      '{{ pc|baremetal.server.bms-net-2x2p10g.6-month }}',
      '{{ pc|baremetal.server.bms-net-2x2p10g.12-month }}',
      '{{ pc|baremetal.component.bms-net-2p25g.1-month }}',
      '{{ pc|baremetal.component.bms-net-2p25g.6-month }}',
      '{{ pc|baremetal.component.bms-net-2p25g.12-month }}',
      '{{ pc|baremetal.server.bms-net-2p25g-mclag.1-month }}',
      '{{ pc|baremetal.server.bms-net-2p25g-mclag.6-month }}',
      '{{ pc|baremetal.server.bms-net-2p25g-mclag.12-month }}',
      '{{ pc|baremetal.server.bms-ram3-32.1-month }}',
      '{{ pc|baremetal.server.bms-ram3-32.6-month }}',
      '{{ pc|baremetal.server.bms-ram3-32.12-month }}',
      '{{ pc|baremetal.server.bms-ram3-64.1-month }}',
      '{{ pc|baremetal.server.bms-ram3-64.6-month }}',
      '{{ pc|baremetal.server.bms-ram3-64.12-month }}',
      '{{ pc|baremetal.server.bms-ram3-128.1-month }}',
      '{{ pc|baremetal.server.bms-ram3-128.6-month }}',
      '{{ pc|baremetal.server.bms-ram3-128.12-month }}',
      '{{ pc|baremetal.server.bms-ram3-256.1-month }}',
      '{{ pc|baremetal.server.bms-ram3-256.6-month }}',
      '{{ pc|baremetal.server.bms-ram3-256.12-month }}',
      '{{ pc|baremetal.component.bms-ram3-512.1-month }}',
      '{{ pc|baremetal.component.bms-ram3-512.3-month }}',
      '{{ pc|baremetal.component.bms-ram3-512.6-month }}',
      '{{ pc|baremetal.component.bms-ram3-512.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-16.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-16.3-month }}',
      '{{ pc|baremetal.component.bms-ram4-16.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-16.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-32.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-32.3-month }}',
      '{{ pc|baremetal.component.bms-ram4-32.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-32.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-64.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-64.3-month }}',
      '{{ pc|baremetal.component.bms-ram4-64.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-64.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-1024.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-1024.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-1024.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-128.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-128.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-128.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-1536.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-1536.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-1536.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-256.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-256.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-256.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-384.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-384.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-384.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-512.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-512.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-512.12-month }}',
      '{{ pc|baremetal.component.bms-ram4-768.1-month }}',
      '{{ pc|baremetal.component.bms-ram4-768.6-month }}',
      '{{ pc|baremetal.component.bms-ram4-768.12-month }}',
      '{{ pc|baremetal.component.bms-ram5-1024.1-month }}',
      '{{ pc|baremetal.component.bms-ram5-1024.6-month }}',
      '{{ pc|baremetal.component.bms-ram5-1024.12-month }}',
      '{{ pc|baremetal.component.bms-ram5-1152.1-month }}',
      '{{ pc|baremetal.component.bms-ram5-1152.6-month }}',
      '{{ pc|baremetal.component.bms-ram5-1152.12-month }}',
      '{{ pc|baremetal.component.bms-ram5-1536.1-month }}',
      '{{ pc|baremetal.component.bms-ram5-1536.6-month }}',
      '{{ pc|baremetal.component.bms-ram5-1536.12-month }}',
      '{{ pc|baremetal.component.bms-ram5-2304.1-month }}',
      '{{ pc|baremetal.component.bms-ram5-2304.6-month }}',
      '{{ pc|baremetal.component.bms-ram5-2304.12-month }}',
      '{{ pc|baremetal.component.bms-ram5-768.1-month }}',
      '{{ pc|baremetal.component.bms-ram5-768.6-month }}',
      '{{ pc|baremetal.component.bms-ram5-768.12-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



{% endcut %}

#### Конфигурации серверов по сниженным ценам {#promo}

##### Сниженные цены с 09.03.2026 до 30.04.2026 {#09-03-17-04-2026}

Арендовать данные конфигурации можно до 30.04.2026 или пока они есть в наличии. Цена действительна с момента приобретения на весь срок использования. Вы можете использовать арендованные по сниженной цене серверы до тех пор, пока самостоятельно не отмените их аренду. Получить повторно сервер по сниженной цене нельзя.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.bf261-i502.1-day }}',
      '{{ pc|baremetal.server.bf261-i502.1-month }}',
      '{{ pc|baremetal.server.bf261-i502.3-month }}',
      '{{ pc|baremetal.server.bf261-i502.6-month }}',
      '{{ pc|baremetal.server.bf261-i502.12-month }}',
      '{{ pc|baremetal.server.bf261-i203.1-day }}',
      '{{ pc|baremetal.server.bf261-i203.1-month }}',
      '{{ pc|baremetal.server.bf261-i203.3-month }}',
      '{{ pc|baremetal.server.bf261-i203.6-month }}',
      '{{ pc|baremetal.server.bf261-i203.12-month }}',
      '{{ pc|baremetal.server.bf261-i206.1-day }}',
      '{{ pc|baremetal.server.bf261-i206.1-month }}',
      '{{ pc|baremetal.server.bf261-i206.3-month }}',
      '{{ pc|baremetal.server.bf261-i206.6-month }}',
      '{{ pc|baremetal.server.bf261-i206.12-month }}',
      '{{ pc|baremetal.server.bf261-i208.1-day }}',
      '{{ pc|baremetal.server.bf261-i208.1-month }}',
      '{{ pc|baremetal.server.bf261-i208.3-month }}',
      '{{ pc|baremetal.server.bf261-i208.6-month }}',
      '{{ pc|baremetal.server.bf261-i208.12-month }}',
      '{{ pc|baremetal.server.bf261-i302.1-day }}',
      '{{ pc|baremetal.server.bf261-i302.1-month }}',
      '{{ pc|baremetal.server.bf261-i302.3-month }}',
      '{{ pc|baremetal.server.bf261-i302.6-month }}',
      '{{ pc|baremetal.server.bf261-i302.12-month }}',
      '{{ pc|baremetal.server.bf261-i216.1-day }}',
      '{{ pc|baremetal.server.bf261-i216.1-month }}',
      '{{ pc|baremetal.server.bf261-i216.3-month }}',
      '{{ pc|baremetal.server.bf261-i216.6-month }}',
      '{{ pc|baremetal.server.bf261-i216.12-month }}',
      '{{ pc|baremetal.server.bf261-i215.1-day }}',
      '{{ pc|baremetal.server.bf261-i215.1-month }}',
      '{{ pc|baremetal.server.bf261-i215.3-month }}',
      '{{ pc|baremetal.server.bf261-i215.6-month }}',
      '{{ pc|baremetal.server.bf261-i215.12-month }}',
      '{{ pc|baremetal.server.bf261-i209.1-day }}',
      '{{ pc|baremetal.server.bf261-i209.1-month }}',
      '{{ pc|baremetal.server.bf261-i209.3-month }}',
      '{{ pc|baremetal.server.bf261-i209.6-month }}',
      '{{ pc|baremetal.server.bf261-i209.12-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



##### Сниженные цены с 27.11.2025 до 29.12.2025 {#27-11-19-12-2025}

Арендовать данные конфигурации можно до 29.12.2025 или пока они есть в наличии. Цена действительна с момента приобретения на весь срок использования. Вы можете использовать арендованные по сниженной цене серверы до тех пор, пока самостоятельно не отмените их аренду. Получить повторно сервер по сниженной цене нельзя.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.bf25-i201-h.1-day }}',
      '{{ pc|baremetal.server.bf25-i201-h.1-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.3-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.6-month }}',
      '{{ pc|baremetal.server.bf25-i201-h.12-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i202-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i202-s.12-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i204-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i204-s.12-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.1-day }}',
      '{{ pc|baremetal.server.bf25-i205-s.1-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.3-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.6-month }}',
      '{{ pc|baremetal.server.bf25-i205-s.12-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



##### Сниженные цены с 24.09.2025 по 24.10.2025 по промокодам в рамках Yandex Scale 2025 {#scale2025}

Цена действительна с момента приобретения до 23:59 31.12.2025.


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1-day }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.3-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.6-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.12-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Выделенные публичные подсети {#public-subnets}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.public-network.subnet-31 }}',
      '{{ pc|baremetal.public-network.subnet-29 }}',
      '{{ pc|baremetal.public-network.subnet-28 }}',
      '{{ pc|baremetal.public-network.subnet-27 }}',
      '{{ pc|baremetal.public-network.subnet-26 }}',
      '{{ pc|baremetal.public-network.subnet-25 }}',
      '{{ pc|baremetal.public-network.subnet-24 }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Подключение пакета трафика для публичной сети {#bandwidth-package}

_Объем данных_ — это единица тарификации услуги, которая равна объему трафика, передаваемого в течение суток. Цены за сутки использования формируются из расчета 24 часов.

{% include [public-net-bandwidth-restrictions](../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

{% note info %}

Чтобы запросить пакет данных на 100 ТБ, обратитесь в [техническую поддержку]({{ link-console-support }}).

{% endnote %}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.data.data-100tb.1sec }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Анонсирование префикса PI (BYOIP) {#byoip}


<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.bms-publicannounce-pi-prefix-any.1-month }}'
    ]}
    installationCode="ru"
    currency="RUB"
  />
</MDX>



### Особенности тарификации сетевого трафика в {{ baremetal-full-name }} при взаимодействии с другими сервисами {{ yandex-cloud }} {#traffic-pricing-pecs}

#### {{ vpc-full-name }} {#vpc-traffic}

{% include [bms-vpc-traffic](../_includes/baremetal/bms-vpc-traffic.md) %}

#### {{ objstorage-full-name }} {#storage-traffic}

{% include [bms-s3-free-traffic](../_includes/baremetal/bms-s3-free-traffic.md) %}

#### {{ backup-full-name }} {#backup-traffic}

{% include [bms-backup-free-traffic](../_includes/baremetal/bms-backup-free-traffic.md) %}






