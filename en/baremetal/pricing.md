---
title: '{{ baremetal-full-name }} pricing policy'
description: This article covers the {{ baremetal-name }} pricing policy.
editable: false
---

# {{ baremetal-full-name }} pricing policy



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

In {{ baremetal-name }}, you pay for renting a server of a [certain configuration](concepts/server-configurations.md). A rented server is billable for the entire rent period, whether it is on or off.

The monthly prices are based on 720 hours per month.

{% include [public-net-bandwidth-restrictions](../_includes/baremetal/public-net-bandwidth-restrictions.md) %}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



All prices are per month and do not include VAT.

{% include [usd-servers.md](../_pricing/baremetal/usd-servers.md) %}



#### Prices for promo configurations {#promo}

{% note info %}

Prices for promo configurations are valid from 00:00 19/09/2025 to 23:59 31/12/2025.

{% endnote %}



All prices are per month.

{% include [usd-servers.md](../_pricing/baremetal/usd-servers-promo.md) %}


{% note info %}

[Quarantined](./concepts/servers.md#quarantine) servers are free of charge. However, if a server is not restored for further use during the quarantine, the time it spent in quarantine will be included in the paid lease term.

{% endnote %}

### Dedicated public subnets {#public-subnets}

{% note info %}

The prices for dedicated public subnets are effective starting May 15, 2025.

{% endnote %}



{% include [usd-subnets](../_pricing/baremetal/usd-subnets.md) %}


^1^ The price per month is provided for reference only, assuming a 720-hour (30-day) month. The price per hour is used in {{ billing-name }} calculations.



### Connecting a bandwidth package for a public network {#bandwidth-package}

{% note info %}

To request a bandwidth package of 100 TB, contact [support]({{ link-console-support }}).

{% endnote %}

_Data size_ is a billing unit equal to the amount of traffic transmitted within a day. Per-day prices are calculated based on 24 hours.

Available now:




{% include [usd-bandwidth-restrictions](../_pricing/baremetal/usd-bandwidth.md) %}


### {{ baremetal-full-name }} network traffic billing when communicating with other {{ yandex-cloud }} services {#traffic-pricing-pecs}

#### {{ vpc-full-name }} {#vpc-traffic}

{% include [bms-vpc-traffic](../_includes/baremetal/bms-vpc-traffic.md) %}

#### {{ objstorage-full-name }} {#storage-traffic}

{% include [bms-s3-free-traffic](../_includes/baremetal/bms-s3-free-traffic.md) %}

#### {{ backup-full-name }} {#backup-traffic}

{% include [bms-backup-free-traffic](../_includes/baremetal/bms-backup-free-traffic.md) %}