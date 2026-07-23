---
title: '{{ postbox-full-name }} pricing policy'
description: This article covers the {{ postbox-name }} pricing policy.
editable: false
---

# {{ postbox-name }} pricing policy

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children: []
:::


::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 6
    children:
      - type: basic-card
        title: Price calculator
        text: Calculate the cost of the service based on your needs
        icon: ../_assets/console-icons/calculator.svg
        urlTitle: Price calculator
        url: https://yandex.cloud/en/prices?state=1579cc7605a5#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Price list
        text: Current prices of all our services
        icon: ../_assets/console-icons/circle-ruble.svg
        urlTitle: Price list
        url: https://yandex.cloud/en/price-list?services=dn2h92g8s9qofi6iu1gp
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




{{ postbox-name }} cost depends on the number of sent emails per month. All emails accepted for sending are charged, regardless of whether they have been actually delivered. If one email is sent to multiple recipients, the number of outbound emails is the same as the number of such recipients.

{% note info %}

By default, {{ postbox-name }} has quotas (e.g., on the number of emails you send), which you can increase by submitting a support request. Read more in [{#T}](concepts/limits.md).

{% endnote %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [not-charged-postbox.md](../_includes/pricing/price-formula/not-charged-postbox.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## Cost calculation example {#price-example}

Calculating cost of 65,500 emails per month:



{% include [usd](../_pricing_examples/postbox/usd.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|postbox }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% note info %}

If you want to send over 100,000,000 emails per month, contact [support]({{ link-console-support }}) or your account manager for special terms.

{% endnote %}

