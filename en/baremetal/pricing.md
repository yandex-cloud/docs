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
    serviceIds={['{{ pcs|baremetal }}', '{{ pcs|baremetal_lite }}']}
    excludeSkuIds={[
      '{{ pc|baremetal.server.bms-publicannounce-pi-prefix-any.1-month }}',
      '{{ pc|baremetal.data.data-100tb.1sec }}',
      '{{ pc|baremetal.public-network.ip-address }}',
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
      '{{ pc|baremetal.server.bf261-i209.12-month }}',
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
      '{{ pc|baremetal.server.bf25-i205-s.12-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1-day }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.1-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.3-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.6-month }}',
      '{{ pc|baremetal.server.ha-i502-n-25g-gxl4-p1.12-month }}',
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


### Cost of custom server configurations {#custom}

The final cost of a custom configuration depends on the server components you select.

{% cut "Component prices" %}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|baremetal_custom }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


{% endcut %}

#### Server configurations at reduced prices {#promo}

##### Reduced prices from 9/3/2026 to 30/4/2026 {#09-03-17-04-2026}

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