---
title: '{{ cloud-desktop-full-name }} pricing policy'
description: This article provides the {{ cloud-desktop-name }} pricing policy.
editable: false
---

# {{ cloud-desktop-full-name }} pricing policy



## What goes into the cost of using {{ cloud-desktop-name }} {#rules}

The {{ cloud-desktop-name }} usage cost is based on:

* Computing resources:
  * Number of vCPUs.
  * Amount of RAM.
* Disk type and size.
* Amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly prices are based on 720 hours per month.

### Using computing resources {#use-resources}

The cost of allocated computing resources is calculated based on how long the desktops were used: from when they get the `CREATING` (if creating) or `STARTING` (if starting) status until they are completely stopped. You are not charged for the time during which the desktops were stopped.

A desktop starts automatically once it is created.

### Using disks {#use-storage}

You are charged for disks whether the desktops are running or not.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Computing resources {#prices-desktop-resources}

{% list tabs group=pricing %}

- Prices in RUB {#prices-rub}

  {% include [rub-desktop-resources.md](../_pricing/cloud-desktop/rub-desktop-resources.md) %}

- Prices in KZT {#prices-kzt}

  {% include [kzt-desktop-resources.md](../_pricing/cloud-desktop/kzt-desktop-resources.md) %}

{% endlist %}

### Disks {#prices-storage}

{% list tabs group=pricing %}

- Prices in RUB {#prices-rub}

  {% include [rub-storage.md](../_pricing/cloud-desktop/rub-storage.md) %}

- Prices in KZT {#prices-kzt}

  {% include [kzt-storage.md](../_pricing/cloud-desktop/kzt-storage.md) %}

{% endlist %}

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

## Cost calculation example {#price-example}

Here is an example of calculating the cost of using {{ cloud-desktop-name }} for one month, for a group of 10 desktops with the following configuration:

* Computing resources: 2 x 50% vCPUs and 2 GB of RAM.
* Boot disk: 50 GB SSD.
* Working disk: 30 GB HDD.
* Total operating time of all desktops over the month: 1,000 hours.



{% include [usd-cloud-desktop](../_pricing_examples/cloud-desktop/usd.md) %}


