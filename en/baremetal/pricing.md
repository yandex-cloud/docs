---
title: '{{ baremetal-full-name }} pricing policy'
description: This article covers the {{ baremetal-name }} pricing policy.
editable: false
---

# {{ baremetal-full-name }} pricing policy

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Price calculator
        text: Calculate the cost of the service based on your needs
        icon: _assets/icons/calculator.svg
        urlTitle: Price calculator
        url: https://yandex.cloud/en/prices?state=d1451a543898#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Price list
        text: Current prices of all our services
        icon: _assets/icons/circle-ruble.svg
        urlTitle: Price list
        url: https://yandex.cloud/en/price-list?services=dn2jfbheag6vvls7oplt
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

In {{ baremetal-name }}, you pay for renting a server of a [certain configuration](concepts/server-configurations.md). A rented server is billable for the entire rent period, whether it is on or off.

{% note warning %}

You cannot cancel server rental during the selected rent term. The server remains billable for the entire prepaid period, regardless of the payment method and procedure for debiting funds. You can [cancel](../baremetal/operations/servers/server-lease-cancel.md) automatic rent renewal; in this case, your server will run until the end of the paid period and then be deleted.

{% endnote %}

You can look up how many servers of particular configurations are available in the [calculator](https://yandex.cloud/en/prices) on the {{ yandex-cloud }} website and in the [management console]({{ link-console-main }}) when selecting a server.

## Prices for the Russia region {#prices}

All prices are per month.

### Cost of stock server configurations {#standard}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The cost may depend on the [rent period](../baremetal/concepts/servers.md#server-lease).

The debiting procedure depends on the payment method:

* If there is a credit/debit card linked to the billing account, money is debited **daily** regardless of the rent period. The month's total equals the cost of the selected rent period.
* For businesses operating on an invoicing basis, the invoice is generated **once a month** regardless of the rent period.



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
    currency="USD"
  />
</MDX>


### Cost of custom server configurations {#custom}

The final cost of a custom configuration depends on the server components you select.

{% cut "Component prices" %}



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
    currency="USD"
  />
</MDX>


{% endcut %}

#### Server configurations at reduced prices {#promo}

##### Reduced prices from 09/03/2026 to 30/04/2026 {#09-03-17-04-2026}

You can rent servers with these configuration options until April 30, 2026, or as long as they are available. The price is valid once you complete the purchase and for the entire period of use. You can use the servers you rented at a discounted price until you cancel your rent on your own. Once you cancel, you will not be able to get a server at a discounted price again.



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
    currency="USD"
  />
</MDX>


##### Reduced prices from 27/11/2025 to 29/12/2025 {#27-11-19-12-2025}

You can rent servers with these configuration options until December 29, 2025, or as long as they are available. The price is valid once you complete the purchase and for the entire period of use. You can use the servers you rented at a discounted price until you cancel your rent on your own. Once you cancel, you will not be able to get a server at a discounted price again.



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
    currency="USD"
  />
</MDX>


##### Reduced prices from 24/09/2025 to 24/10/2025 as part of Yandex Scale 2025 {#scale2025}

The price is valid from the moment of purchase until 11:59 p.m. on 31/12/2025.



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
    currency="USD"
  />
</MDX>


### Dedicated public subnets {#public-subnets}



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
    currency="USD"
  />
</MDX>


### Connecting a bandwidth package for a public network {#bandwidth-package}

_Data size_ is a billing unit equal to the amount of traffic transmitted within a day. Per-day prices are calculated based on 24 hours.

{% include [public-net-bandwidth-restrictions](../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

{% note info %}

To request a bandwidth package of 100 TB, contact [support]({{ link-console-support }}).

{% endnote %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.data.data-100tb.1sec }}'
    ]}
    installationCode="ru"
    currency="USD"
  />
</MDX>


### Announcing a PI prefix (BYOIP) {#byoip}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal }}']}
    skuIds={[
      '{{ pc|baremetal.server.bms-publicannounce-pi-prefix-any.1-month }}'
    ]}
    installationCode="ru"
    currency="USD"
  />
</MDX>


### {{ baremetal-full-name }} network traffic billing when communicating with other {{ yandex-cloud }} services {#traffic-pricing-pecs}

#### {{ vpc-full-name }} {#vpc-traffic}

{% include [bms-vpc-traffic](../_includes/baremetal/bms-vpc-traffic.md) %}

#### {{ objstorage-full-name }} {#storage-traffic}

{% include [bms-s3-free-traffic](../_includes/baremetal/bms-s3-free-traffic.md) %}

#### {{ backup-full-name }} {#backup-traffic}

{% include [bms-backup-free-traffic](../_includes/baremetal/bms-backup-free-traffic.md) %}






