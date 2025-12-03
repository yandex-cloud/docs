---
title: '{{ baremetal-full-name }} pricing policy'
description: This article covers the {{ baremetal-name }} pricing policy.
editable: false
---

# {{ baremetal-full-name }} pricing policy



{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

In {{ baremetal-name }}, you pay for renting a server of a [certain configuration](concepts/server-configurations.md). A rented server is billable for the entire rent period, whether it is on or off.

The available number of servers of a certain configuration is indicated in the [calculator](https://yandex.cloud/en/prices) on the {{ yandex-cloud }} website and in the [management console]({{ link-console-main }}) when selecting a server.

The monthly prices are based on 720 hours per month.

## Prices for the Russia region {#prices}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The funds are debited **monthly**, irrespective of the rent period.

All prices are per month.



{% include [usd-servers.md](../_pricing/baremetal/usd-servers.md) %}


#### Prices for promo configurations {#promo}

##### Reduced prices since 27.11.2025 until 19.12.2025 {#27-11-19-12-2025}

You can rent servers with these configuration options until December 19, 2025, or as long as they are available. The price is valid once you complete the purchase and for the entire period of use. You can use the servers you rented at a discounted price until you cancel your rent on your own. Once you cancel, you will not be able to get a server at a discounted price again.



{% include [usd-servers.md](../_pricing/baremetal/promo/2025-black-friday/usd-servers-promo.md) %}


##### Promo code Yandex Scale 2025 {#scale2025}

Promo configurations can be rented until October 24, 2025, or while supplies last. Promo configuration prices are valid until 11:59 PM on December 31, 2025.



{% include [usd-servers.md](../_pricing/baremetal/promo/2025-yandex-scale/usd-servers-promo.md) %}


{% note info %}

[Quarantined](./concepts/servers.md#quarantine) servers are free of charge. However, if a server is not restored for further use during the quarantine, the time it spent in quarantine will be included in the paid lease term.

{% endnote %}

### Dedicated public subnets {#public-subnets}



{% include [usd-subnets](../_pricing/baremetal/usd-subnets.md) %}


^1^ The price per month is provided for reference only, assuming a 720-hour (30-day) month. The price per hour is used in {{ billing-name }} calculations.



### Connecting a bandwidth package for a public network {#bandwidth-package}

_Data size_ is a billing unit equal to the amount of traffic transmitted within a day. Per-day prices are calculated based on 24 hours.

{% include [public-net-bandwidth-restrictions](../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

{% note info %}

To request a bandwidth package of 100 TB, contact [support]({{ link-console-support }}).

{% endnote %}

Available now:




{% include [usd-bandwidth-restrictions](../_pricing/baremetal/usd-bandwidth.md) %}


### {{ baremetal-full-name }} network traffic billing when communicating with other {{ yandex-cloud }} services {#traffic-pricing-pecs}

#### {{ vpc-full-name }} {#vpc-traffic}

{% include [bms-vpc-traffic](../_includes/baremetal/bms-vpc-traffic.md) %}

#### {{ objstorage-full-name }} {#storage-traffic}

{% include [bms-s3-free-traffic](../_includes/baremetal/bms-s3-free-traffic.md) %}

#### {{ backup-full-name }} {#backup-traffic}

{% include [bms-backup-free-traffic](../_includes/baremetal/bms-backup-free-traffic.md) %}